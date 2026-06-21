# Prompts — Spec Driven Development

> Biblioteca de prompts prontos para cada fase do fluxo descrito em `README.md` e `INSTRUCTIONS.md`.
>
> Use os prompts na ordem das fases. Substitua qualquer trecho entre `[colchetes]` pelo conteúdo real da sua feature ou pelos caminhos reais dos arquivos no projeto.

---

## 0. Setup — Analisar o projeto e gerar `architecture.md`

Use uma única vez ao instalar o framework `.ai/` em um projeto novo ou já existente, antes de criar qualquer spec. Sem esse passo, `architecture.md` fica genérico e a IA não tem como respeitar os padrões reais do projeto durante o desenvolvimento.

```txt
Antes de criarmos qualquer feature, quero que você analise este projeto por
completo para gerar uma architecture.md robusta.

O arquivo a ser escrito é `.ai/architecture.md` (dentro da pasta `.ai/` do
projeto, não na raiz). Edite o arquivo que já existe nesse caminho — não
crie um architecture.md novo em outro lugar.

Faça uma varredura geral do repositório e identifique:

- o que o projeto faz (propósito, domínio, principais funcionalidades);
- a stack utilizada (linguagens, frameworks, bibliotecas principais);
- a estrutura de pastas e o que cada pasta de alto nível representa;
- os padrões de código existentes (nomenclatura, organização de módulos,
  camadas, convenções);
- como o backend está organizado (se existir);
- como o frontend está organizado (se existir);
- como o banco de dados está estruturado (tabelas, migrations, ORM);
- autenticação e autorização;
- integrações externas, filas, workers, jobs, lambdas ou serviços externos;
- scripts de build, deploy e testes.

Se esta pasta raiz for um monorepo ou contiver múltiplos projetos (ex.:
frontend, backend, lambdas, serviços separados), identifique cada um deles
separadamente: nome, propósito, stack própria, pasta raiz daquele projeto e
como eles se comunicam entre si (API, eventos, fila, etc.). Documente essa
visão de ecossistema antes de detalhar cada projeto individualmente.

Depois da análise, me pergunte:

> Você quer que a próxima feature seja especificada dentro de um fluxo
> específico do ecossistema (ex.: só backend, só frontend, só o serviço X),
> ou prefere deixar em aberto para eu tratar como uma feature geral que pode
> tocar múltiplos projetos?

Não crie spec.md, plan.md ou tasks.md ainda — esta etapa é só de
mapeamento do projeto.

Ao final, gere o conteúdo completo de `.ai/architecture.md`, organizado e
detalhado o suficiente para que qualquer IA consiga, no futuro, planejar e
implementar uma feature respeitando a arquitetura real do projeto.

Além disso, com base no que você encontrou, sugira melhorias para o
`.ai/ai-instructions.md` deste projeto: pontos específicos deste projeto
que a IA deveria saber antes de codar (ex.: convenções específicas,
ferramentas de lint/test obrigatórias, padrões de commit, regras de
revisão, restrições de segurança, serviços que nunca devem ser alterados
sem validação humana, limites entre os projetos do ecossistema etc.).
Pergunte-me quais dessas informações eu quero adicionar antes de gravá-las
na seção "Informações específicas do projeto" desse mesmo arquivo,
`.ai/ai-instructions.md` — não crie um arquivo novo, edite o que já existe
nesse caminho.
```

---

## 1. Iniciar uma feature do zero

Use quando ainda não existe nada — nem spec, nem plano, nem tarefas.

```txt
Vamos desenvolver uma nova funcionalidade seguindo Spec Driven Development.

Quero que você atue como arquiteto de software e engenheiro auxiliar.

Antes de qualquer código, vamos criar e revisar os arquivos:

1. spec.md
2. plan.md
3. tasks.md

Você deve respeitar os arquivos existentes:

- ai-instructions.md
- architecture.md

Fluxo obrigatório:

1. primeiro me ajude a criar a spec.md;
2. depois revise criticamente a spec;
3. depois crie o plan.md;
4. depois crie o tasks.md;
5. somente depois disso poderemos começar a implementação.

Não gere código até eu pedir explicitamente.

Contexto da feature:
[descreva aqui]
```

---

## 2. Prompt para iniciar desenvolvimento

Use na Fase 5, sempre que `spec.md`, `plan.md` e `tasks.md` já estiverem prontos (ou parcialmente prontos) e você quiser que a IA leia tudo, confirme entendimento e só então comece a implementar.

Substitua os caminhos entre `[colchetes]` pelos caminhos reais dos arquivos da feature no seu projeto.

```txt
Você vai atuar como engenheira de software auxiliar, seguindo rigorosamente a
metodologia de Spec Driven Development descrita nos arquivos README.md e
INSTRUCTIONS.md deste projeto.

Antes de qualquer linha de código, você deve ler — nesta ordem exata — os
seguintes arquivos:

1. @ai-instructions.md         
2. @architecture.md             
3. @spec.md                     
4. @plan.md                   
5. @tasks.md                   
6. @build-logs.md              
7. @tests.md
8. @review.md

Esses arquivos são a fonte de verdade do projeto. Você não deve implementar
nada que não esteja amparado por eles.

## Papel de cada arquivo

- ai-instructions.md define como você deve se comportar.
- architecture.md define os limites técnicos do sistema.
- spec.md define o que precisa existir (comportamento, regras, aceite).
- plan.md define como construir tecnicamente.
- tasks.md define a ordem de execução.
- build-logs.md registra decisões já tomadas anteriormente nesta mesma
  feature (se existir, leia para não repetir discussões ou contradizer
  decisões já validadas).
- tests.md registra os testes já escritos e sua cobertura (se existir,
  leia para não duplicar testes nem perder lacunas já identificadas).
- review.md registra validações anteriores da implementação contra a
  spec.md (se existir, leia para saber o que já foi aprovado ou ficou
  pendente).

## Regras obrigatórias

1. Não comece a codar antes de ler todos os arquivos listados acima.
2. Não implemente nada que não esteja descrito na spec.md.
3. Não ignore ou contrarie o architecture.md sem justificar explicitamente
   e pedir validação antes de prosseguir.
4. Siga o plan.md como guia técnico. Se identificar que o plano está
   desatualizado ou incompleto, pare e proponha um ajuste antes de seguir.
5. Implemente seguindo a ordem do tasks.md, tarefa por tarefa, em blocos
   pequenos e revisáveis (ex.: banco de dados → backend → frontend →
   integrações → testes → documentação). No bloco de testes, documente
   cada teste escrito em tests.md (regra/critério cobertos, cenário e
   status).
6. Não amplie o escopo da tarefa. Se identificar uma melhoria fora do
   escopo atual, registre a sugestão separadamente em vez de implementá-la.
7. Não invente regra de negócio. Se a spec.md tiver uma lacuna, pare e
   proponha uma decisão em vez de assumir algo silenciosamente.
8. Toda decisão técnica relevante tomada durante a implementação — escolha
   entre abordagens, desvio do plano, preenchimento de lacuna da spec,
   introdução de dependência nova — deve ser registrada no build-logs.md
   no momento em que é tomada, com: decisão, motivo, alternativas
   descartadas, impacto e se houve divergência em relação ao plan.md/spec.md.
9. Ao concluir cada bloco de implementação, explique brevemente o que foi
   feito antes de seguir para o próximo.
10. Ao final, valide a entrega contra os critérios de aceite da spec.md e
    contra o checklist de tasks.md.

## Antes de implementar

Depois de ler todos os arquivos, e antes de escrever qualquer código,
responda com:

- resumo do entendimento da feature;
- principais regras de negócio envolvidas;
- arquivos e módulos que provavelmente serão alterados;
- ordem de implementação baseada no tasks.md;
- decisões já registradas no build-logs.md que sejam relevantes para o que
  vem a seguir (se o arquivo existir);
- riscos, dúvidas ou lacunas identificadas antes de começar.

Não implemente nada antes que eu confirme esse resumo.

Contexto adicional desta tarefa (se houver):
[descreva aqui qualquer informação extra, restrição de tempo, ou foco
específico desta rodada de implementação]
```

---

## 3. Continuar feature já em andamento

Use quando a implementação já começou e você só quer retomar o trabalho seguindo o mesmo rigor, sem repetir a fase de confirmação completa.

```txt
Continue a implementação desta feature seguindo Spec Driven Development.

Releia rapidamente:
1. tasks.md      → [caminho]
2. build-logs.md → [caminho] (para retomar de onde as decisões anteriores pararam)

Confirme qual é a próxima tarefa pendente no tasks.md e continue a partir
dela, respeitando spec.md, plan.md e architecture.md.

Regras:
- registre toda nova decisão relevante no build-logs.md, com o motivo;
- não amplie o escopo sem autorização;
- ao concluir o bloco, explique brevemente o que foi feito e qual a
  próxima tarefa.
```

---

## 4. Validar contra a spec

Use na Fase 7, depois que a implementação (ou um bloco dela) estiver concluída.

```txt
Revise a implementação contra a spec.md.

Verifique:
- todos os critérios de aceite foram cumpridos?
- todas as regras de negócio foram implementadas?
- os casos de erro foram tratados?
- as permissões estão corretas?
- frontend e backend estão alinhados?
- existe algo fora do escopo?
- a arquitetura foi respeitada?

Liste o que está concluído, o que ficou pendente e o que precisa de atenção.

Registre o resultado desta revisão em `review.md`, dentro da pasta da
feature (`.ai/specs/[nome-da-feature]/review.md`). Se o arquivo ainda não
existir, crie-o. Cada execução desta validação deve gerar uma nova entrada
em `review.md`, com data e o que foi revisado — não sobrescreva entradas
anteriores. Cada entrada deve conter:

- data da revisão;
- critérios de aceite cumpridos e não cumpridos;
- regras de negócio cobertas e não cobertas;
- divergências encontradas em relação à spec.md;
- pendências e itens que precisam de atenção;
- conclusão: entrega aprovada, aprovada com pendências, ou reprovada.
```

---

## 5. Atualizar documentação

Use na Fase 8, sempre que o que foi implementado divergir do que estava documentado.

```txt
Atualize a documentação da feature com base no que foi realmente implementado.

Verifique se spec.md, plan.md e tasks.md continuam coerentes com o código final.

Se algo mudou durante o desenvolvimento, registre a decisão e explique o motivo.
```
