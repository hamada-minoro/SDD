# Teste de usuário frontend + backend

> Procedimento reutilizável para validar uma spec pela interface, com frontend e backend reais em ambiente de teste, usando navegador controlado pela IA. Complementa `.ai/infraestrutura-testes.md` (ambiente), `plano-teste-usuario.md` (roteiro da spec), `tests.md` (resultado por RN/CA) e `review.md` (conclusão). Não substitui testes automatizados.

## Quando usar

Use quando a spec inclui uma jornada de tela que atravessa frontend e backend, ou quando o desenvolvedor pedir uma validação manual ponta a ponta. O roteiro é opcional para specs sem interface. Planeje a cobertura em `plan.md` e `tasks.md` antes da implementação; execute após a stack e os dados de teste estarem prontos. Uma execução bloqueada pelo ambiente fica pendente, nunca é registrada como aprovação.

## Preparação do projeto (uma vez, revisada quando o ambiente mudar)

1. Preencha `.ai/infraestrutura-testes.md` com comandos reais para subir frontend, APIs e dependências, portas, URLs, health checks, configuração de homologação, restrições de horário, conta de teste e forma de restaurar alterações temporárias. Registre apenas o que foi verificado. Nunca grave valores de segredos ali.
2. Instale a CLI `agent-browser` fora do projeto e execute `agent-browser install` e `agent-browser doctor`. Antes de automatizar, leia `agent-browser skills get core` da versão instalada e, se disponível, a skill `agent-browser` do agente em uso. A CLI não precisa entrar nas dependências do projeto.
3. Use `.ai/specs/template/plano-teste-usuario.md` como base para cada spec com tela. Substitua todos os exemplos por comandos, IDs e resultados esperados do projeto. Não trate comandos de exemplo como fatos verificados.
4. Mantenha `.env` de teste e `evidencias/` fora do Git. O `.ai/.gitignore` deste framework já cobre essas pastas dentro de specs ativas e concluídas. Se outra raiz ou mecanismo versionar os arquivos, confira as regras de exclusão antes de gerar evidências.

## Antes de cada execução

- Confira branch e `git status` de cada projeto envolvido. Preserve mudanças preexistentes.
- Confira runtime, dependências, portas livres e saúde de cada serviço local ou remoto; status esperado e horário de disponibilidade vêm da infraestrutura do projeto. Falha de infraestrutura é bloqueio, não falha da feature.
- Confirme que frontend e APIs usam exclusivamente ambiente de teste/homologação e identidade de teste com permissões adequadas. Se não for possível confirmar o destino, pare antes de autenticar ou gravar.
- Confira os nomes das variáveis exigidas pelo roteiro sem exibir valores. Guarde credenciais em `.ai/specs/NNN-feature/.env` com acesso restrito (`chmod 600` em sistemas compatíveis). Nunca use conta ou dados de produção.
- Defina os dados necessários, quais já existem, quais serão criados, os IDs a rastrear e a forma de limpeza/rollback. Faça backup antes de preparar dados manualmente.
- Identifique ações que gravam ou disparam efeitos externos com 🔒 no roteiro. Uma autorização existente pode cobrir vários passos se os passos e efeitos estiverem explícitos. Antes de uma ação irreversível ou fora do escopo autorizado, peça aprovação específica. Leituras e operações reversíveis já autorizadas pelo pedido podem prosseguir.

## Executar pelo navegador

1. Suba a stack conforme `.ai/infraestrutura-testes.md`, confira health checks e registre versões/comandos relevantes no diário da execução.
2. Inicie uma sessão nomeada do `agent-browser` em modo `--headed` para o desenvolvedor acompanhar, se houver desktop visível. O modo é decidido na abertura da sessão; feche uma sessão headless anterior antes de reabrir. Sem display visível, registre que a execução foi headless. Não prometa uma janela visível quando o ambiente não permite.
3. Faça `snapshot -i` antes de interagir, resolva as referências dos elementos e confirme que cada referência existe antes de `fill` ou `click`. Registre a tela de login antes de preencher segredos. Não tire print de senha, token, dados pessoais reais ou URL assinada.
4. Execute cada passo na ordem do roteiro: ação, resultado literal observado, screenshot seguro e RN/CA cobertos. Confirme mudanças importantes com leitura da API (`GET`) ou outro mecanismo de leitura do backend. Registre apenas campos necessários, mascarados quando cabível; nunca despeje resposta completa ou token.
5. Se um serviço externo bloquear a navegação, um contorno de interface pode ser usado somente se não contornar a regra de negócio testada. Registre o contorno, o motivo e a cobertura que ele deixou de provar. Não manipule estado do backend para simular sucesso.
6. Classifique cada achado como defeito, ambiente, dado de teste ou observação. Registre mensagem exata, passo e evidência. Um defeito novo recebe proposta de spec de correção com o próximo número livre; não é corrigido silenciosamente durante a validação.

Exemplo mínimo de sessão, adaptando a URL e a pasta:

```bash
EV=.ai/specs/NNN-feature/evidencias
B(){ agent-browser --session teste-feature "$@"; }
B --headed open "$TEST_FRONT_URL"
B snapshot -i
B screenshot "$EV/01-tela-inicial.png"
```

Consulte `agent-browser skills get core` para a sintaxe vigente. O `.env` pode ser carregado localmente sem imprimir valores, mas só faça `source` de arquivo confiável; nunca use `set -x`, `echo` de variáveis secretas, logs de rede completos ou prints após preencher credenciais. Não copie tokens para documentação ou saída de ferramenta.

## Registro e retomada

Grave o andamento em `evidencias/00-registro-execucao.md` após cada grupo de passos: data/hora, ambiente, comando de subida, passo, resultado observado, arquivo de evidência, autorização de escrita aplicável, IDs criados e achados. Use uma tabela `Passo | Resultado observado | Evidência | RN/CA | Estado dos dados` por sessão e IDs `F01`, `F02` para falhas, `O01`, `O02` para observações. Nomeie os artefatos em ordem (`01-login.png`, `02-lista.png`); use `.txt` com campos mascarados se um print expuser dados. Logs locais podem conter segredos e ficam só em `evidencias/`, após revisão.

Ao interromper, registre erro, estado da sessão e dos dados e atualize a seção **Onde paramos e como retomar** do roteiro com a próxima ação exata. Na retomada, repita as verificações de ambiente e autenticação, confira o estado por leitura e evite repetir uma gravação já concluída. Se a autorização anterior tinha escopo limitado ou o estado mudou, esclareça o escopo antes da próxima escrita.

## Encerramento e resultado SDD

1. Feche o navegador e os processos iniciados para o teste. Reverta configuração temporária do frontend/backend e confira o diff e o `git status` de cada projeto.
2. Limpe somente dados que este teste criou e cujos IDs estão no diário, dentro da autorização recebida. Se a limpeza precisar de nova autorização, deixe os IDs e o rollback documentados como pendência; nunca apague dados de terceiros.
3. Atualize `tests.md` com o resultado da jornada e de cada RN/CA verificado, incluindo passos bloqueados e links relativos para evidências locais. Atualize `review.md` em uma nova entrada, com critérios cumpridos, lacunas, achados, dados remanescentes e conclusão conforme o contrato SDD.
4. Atualize `.ai/infraestrutura-testes.md` somente com fatos novos verificados sobre o ambiente e a data da verificação. Não transforme uma limitação transitória em regra geral sem evidência.

As evidências ignoradas pelo Git só existem nesta máquina. O resultado essencial precisa estar nos arquivos versionados `tests.md` e `review.md`; links para prints locais não substituem essa descrição. Se a spec for movida para `concluidos/`, mova também a pasta local `evidencias/` quando precisar preservar os links, sem adicionar segredos ao Git.
