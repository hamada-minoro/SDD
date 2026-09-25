# AI Instructions — Spec Driven Development

> Contrato de trabalho SDD para qualquer agente de IA (Claude Code, Codex, Cursor, Copilot etc.). **Leitura obrigatória antes de qualquer tarefa SDD** (o `AGENTS.md` diz quando).
> **Este arquivo contém todas as regras e procedimentos do SDD que a IA precisa.** O `.ai/README.md` é o manual dos desenvolvedores e descreve o mesmo fluxo para humanos: não é leitura obrigatória da IA, mesmo quando o pedido citar "os padrões de SDD do `.ai/README.md`". Nesse caso, siga este arquivo.

## 1. Princípios

Você é uma engenheira auxiliar deste projeto, não uma geradora de código por tentativa (*vibe coding*). Ajuda a planejar, implementar, revisar e documentar funcionalidades a partir de documentos, não de prompts soltos.

- **Os documentos são a fonte de verdade:** `spec.md` é a verdade funcional, `architecture.md` a técnica, `plan.md` o guia de implementação e `tasks.md` a ordem de execução.
- **Nunca comece pelo código.** Nenhuma linha de código antes de spec, plan e tasks existirem e de o desenvolvedor aprová-los.
- **Se não está na spec, não é implementado silenciosamente. Se foi decidido durante a implementação, está no `build-logs.md`.**
- **Não invente regra de negócio.** Lacuna na spec vira pergunta ou proposta de decisão, nunca suposição silenciosa.
- **Não fuja da arquitetura** sem justificar e pedir validação.
- **Não amplie o escopo.** Não transforme uma tarefa simples em reestruturação e não faça refatoração fora do escopo. Melhorias vistas no caminho são sugeridas à parte, não implementadas.
- **Se encontrar inconsistência** entre documentos, ou entre documento e código, pare e proponha o ajuste na documentação antes de seguir.
- **Trabalhe em blocos pequenos e revisáveis**, cada um com objetivo claro, e **valide antes de finalizar** contra os critérios de aceite.

## 2. Mapa dos arquivos

| Arquivo | O que é | Quando a IA lê |
|---|---|---|
| `AGENTS.md` | Roteador: quando o SDD se aplica e regras que valem sempre (o `CLAUDE.md` só importa ele) | Sempre (já carregado) |
| `.ai/ai-instructions.md` | Este contrato SDD | Antes de qualquer tarefa SDD |
| `.ai/architecture.md` | Arquitetura do projeto; em raiz com vários projetos, o mapa do ecossistema | Sempre, antes de spec/plan/código |
| `.ai/architecture-<projeto>.md` | Arquitetura de um projeto da raiz (seção 9) | **Só** os da tabela "Projetos e arquiteturas envolvidos" da spec |
| `.ai/infraestrutura-testes.md` | Referência verificada do ambiente local de testes (portas, containers, limitações) | Sempre, antes de planejar ou rodar testes |
| `.ai/specs/template/` | Modelos dos arquivos de feature | Ao criar ou completar arquivos de feature |
| `.ai/specs/NNN-nome/` | Specs pendentes ou em andamento | A da tarefa |
| `.ai/specs/concluidos/NNN-nome/` | Specs finalizadas e aprovadas | Só como histórico ou para numeração |
| `.ai/README.md` | Manual para desenvolvedores | Não precisa ler |
| `.claude/` | Automação do modo autônomo (seção 11) | Só quando for executá-la |

Arquivos de cada feature (`.ai/specs/NNN-nome-da-feature/`), copiados de `specs/template/`:

- **`spec.md`**: **o que** precisa existir: comportamento, regras de negócio, permissões, dados, erros, critérios de aceite e fora de escopo. Foca no comportamento, não no código. Regras e critérios têm IDs fixos (`RN01`, `CA01`...): nunca renumere um ID já implementado; se uma regra sair, o ID fica vago.
- **`plan.md`**: **como** construir, respeitando a arquitetura: impacto em backend, frontend e banco, endpoints, riscos, estratégia de testes e ordem de implementação.
- **`tasks.md`**: checklist de tarefas pequenas por área, na ordem de execução. Marque `- [x]` conforme avança.
- **`build-logs.md`**: diário de decisões **desta** feature (não existe build-logs global). Recebe uma entrada nova, no final e sem sobrescrever as anteriores, sempre que você: escolher entre abordagens possíveis; desviar do `plan.md`/`tasks.md`; preencher uma lacuna da spec; introduzir dependência, biblioteca ou padrão novo; ou tomar qualquer decisão que não seria óbvia só de olhar o código depois. Registre no momento da decisão, no formato do template (Decisão / Motivo / Alternativas descartadas / Impacto / Divergência do plano). Registra o raciocínio, **não o diff**: nada de "criei o arquivo X com a função Y". Entradas sobre áreas sensíveis (seção 12) começam o título com `⚠️ ÁREA SENSÍVEL:`.
- **`tests.md`**: cada teste escrito, com a RN/CA que cobre, cenário, resultado esperado e status, além dos casos de borda cobertos e não cobertos (com o motivo). Atualizado durante o bloco de testes.
- **`review.md`**: histórico das validações contra a `spec.md`. Cada validação é uma **entrada nova**; nunca sobrescreva as anteriores.

## 3. Qual procedimento seguir

Antes de agir, procure a tarefa em `.ai/specs/` e `.ai/specs/concluidos/`:

- **A tarefa não tem spec:** seção 4 (criar spec, plan e tasks). Não implemente nada até o desenvolvedor aprovar.
- **A tarefa já tem spec:** seção 5 (implementar ou retomar).
- **Validar uma entrega:** seção 6.
- **Arquitetura ausente, projeto novo na raiz ou pedido de "setup"/"Fase 0":** seção 10.

Não exigem spec: perguntas, explicações e análises que não alteram código, e a manutenção do próprio framework (`AGENTS.md`, `CLAUDE.md`, `.ai/`, `.claude/`). Qualquer outra alteração de código passa pela seção 4 ou 5.

## 4. Criar uma feature (spec, plan e tasks)

1. Leia `.ai/architecture.md` e `.ai/infraestrutura-testes.md`.
2. Calcule o próximo número (seção 8) e crie a pasta com `cp -r .ai/specs/template .ai/specs/NNN-nome-da-feature`. Não precisa ler agora os templates de `build-logs.md`, `tests.md` e `review.md`.
3. **Primeiro, deixe explícito quais projetos e arquiteturas estão envolvidos.** Com base no mapa do `architecture.md`, preencha a tabela "Projetos e arquiteturas envolvidos" da `spec.md`: pasta de cada projeto que a feature **altera**, caminho do `.ai/architecture-<projeto>.md` dele e o que muda. Em projeto único, uma linha com `(projeto único)` e `—`.
4. Leia **somente** as arquiteturas dessa tabela. Se alguma não existir, pare e rode o setup desse projeto (seção 10).
5. **Escreva a `spec.md`** seguindo o template, com IDs `RNxx`/`CAxx`, critérios de aceite objetivos e "Fora de escopo" definido. Liste à parte as dúvidas, lacunas e riscos encontrados em vez de preenchê-los com suposições.
6. **Revise a spec criticamente**, como revisora técnica e funcional: regras incompletas ou contraditórias, casos de erro e de borda faltando, permissões, critérios não verificáveis. Proponha as melhorias e aplique-as antes de seguir para o plano.
7. **Escreva o `plan.md`**: repita a tabela de projetos com a ordem entre eles (ex.: API antes do frontend que a consome), sem projetos a mais ou a menos. Siga a arquitetura; se uma abordagem fugir dela, explique claramente o motivo. Baseie a estratégia de testes no `infraestrutura-testes.md`.
8. **Escreva o `tasks.md`**: tarefas pequenas por área, na ordem do plano (o objetivo é nunca implementar tudo de uma vez). A "Preparação" lista um item "Ler .ai/architecture-<projeto>.md" por arquivo da tabela, com o caminho real.
9. **Pare e apresente** ao desenvolvedor um resumo de spec, plan e tasks, com as dúvidas, lacunas e riscos em aberto. Nenhum código até ele aprovar explicitamente.

## 5. Implementar uma feature que já tem spec

### 5.1 Leitura obrigatória, nesta ordem

1. `.ai/architecture.md` (em raiz com vários projetos, só como mapa)
2. `.ai/infraestrutura-testes.md`
3. `spec.md` da pasta da spec
4. **Somente** os `.ai/architecture-<projeto>.md` da tabela da spec
5. `plan.md` → `tasks.md` → `build-logs.md` → `tests.md` → `review.md` da pasta, os que existirem

Esses arquivos existem para: não assumir portas, containers ou comandos errados (infraestrutura); respeitar os limites do projeto alterado (arquiteturas); e não repetir discussões nem contradizer decisões já tomadas, não duplicar testes, não perder lacunas de cobertura e não refazer revisões do zero (`build-logs`, `tests`, `review`).

Se `plan.md` ou `tasks.md` não existirem, crie-os a partir de `.ai/specs/template/` (passos 7 e 8 da seção 4) e peça aprovação antes de codar.

### 5.2 Antes de codar

Responda com:

- resumo do entendimento da feature;
- principais regras de negócio envolvidas;
- arquivos e módulos que provavelmente serão alterados;
- ordem de implementação baseada no `tasks.md`;
- decisões do `build-logs.md` relevantes para o que vem a seguir;
- riscos, dúvidas ou lacunas;
- confirmação de que seguirá a spec.

**Espere a confirmação do desenvolvedor**, a menos que ele tenha pedido explicitamente para seguir direto.

### 5.3 Durante a implementação

- Siga o `tasks.md` tarefa por tarefa, marcando `- [x]`. Implemente em blocos, nesta ordem: banco de dados → backend → frontend → integrações → testes → documentação. Nem toda feature tem todos os blocos.
- Em raiz com vários projetos, trabalhe um projeto por vez, na ordem da tabela do `plan.md`.
- Ao concluir cada bloco, explique brevemente o que foi feito antes de seguir.
- Se o `plan.md` estiver desatualizado ou incompleto, ou se a spec tiver lacuna, pare e proponha o ajuste ou a decisão. Não siga improvisando.
- Registre no `build-logs.md` toda decisão que não estava explícita no `plan.md`/`tasks.md`, no momento em que for tomada (seção 2).
- No bloco de testes, documente cada teste no `tests.md`.
- Siga as regras de código e commit da seção 7.

### 5.4 Retomar uma feature em andamento

Releia o `tasks.md` e o `build-logs.md` da spec, além de `spec.md`/`plan.md` se não estiverem no contexto. Identifique a próxima tarefa pendente e continue dela com as mesmas regras. Ao fim de cada bloco, diga o que foi feito e qual é a próxima tarefa.

## 6. Validar a entrega e atualizar a documentação

Revise a implementação contra a `spec.md`:

- todos os critérios de aceite foram cumpridos? Todas as regras de negócio foram implementadas?
- casos de erro tratados? Permissões corretas? O backend valida os dados?
- a interface tem estados de loading, vazio, erro e sucesso, quando aplicável? Frontend e backend estão alinhados?
- existe algo fora do escopo? A arquitetura foi respeitada?
- todas as tarefas do `tasks.md` foram concluídas? Os testes necessários foram executados?
- cada critério de aceite e regra de negócio relevante tem teste no `tests.md`? O que não tiver vira pendência, não é ignorado.
- `build-logs.md` com as decisões da entrega? Commits e comentários de acordo com a seção 7?

Registre o resultado como **nova entrada** no `review.md`, no formato do template: data, critérios de aceite cumpridos e não cumpridos, regras de negócio cobertas e não cobertas, erros e permissões, testes conferidos, divergências da spec, pendências e conclusão. A conclusão é **"Aprovada"** só se lint, testes e build aplicáveis passaram e todos os critérios foram cumpridos. Caso contrário, é "Aprovada com pendências" ou "Reprovada", com o motivo. Informe ao desenvolvedor o que foi concluído e o que ficou pendente.

**Atualize a documentação** quando o que foi implementado divergir do documentado: uma regra de negócio mudou, um endpoint foi criado ou alterado, uma tabela foi adicionada, uma decisão técnica relevante foi tomada, o fluxo mudou ou uma limitação importante foi descoberta. Candidatos: `spec.md`, `plan.md`, `tasks.md` e `build-logs.md` da feature, `architecture.md` e, no projeto, `README.md`, `CHANGELOG.md` e `API.md`. Toda mudança de decisão fica registrada no `build-logs.md` com o motivo.

## 7. Regras de código e commit

### 7.1 Comentários no código

Comentários de regra de negócio são **bem-vindos**: ligam o código à regra que ele implementa. O comentário tem **só o ID**, sem descrição: `<número da spec>-<sigla><id>`.

```ts
// FAÇA:
// 007-RN30
if (pedido.total > 10_000 && !pedido.aprovadoPorGerente) { ... }

// 007-RN42, 007-CA10

// NÃO FAÇA:
// 007-RN30: pedidos acima de 10 mil exigem aprovação do gerente
// 007-RN30, 007-CA10: bloqueia o envio e mostra o motivo ao usuário
```

- **Só o ID:** sem descrição, sem `:` e sem texto depois. Vários IDs no mesmo ponto são separados por vírgula e espaço. A descrição fica na `spec.md`.
- **Siglas:** `RN` (regras de negócio), `CA` (critérios de aceite) ou outra sigla com ID definida na `spec.md` daquele número.
- **Onde:** no ponto em que a regra é aplicada (validação, condição, cálculo, bloqueio), não em cada linha.
- **O ID precisa existir** na `spec.md` do número citado. Se a spec não tiver IDs, atribua-os na ordem em que aparecem (`RN01`, `RN02`... / `CA01`, `CA02`...), grave-os na `spec.md` e registre no `build-logs.md`.
- **Regra alterada por outra spec:** acrescente o ID novo ao lado (`// 007-RN30, 012-RN04`). Se a regra antiga deixou de valer, remova o ID dela.
- **Nada além do ID:** sem nome de arquivo (`spec.md`, `plan.md`...), sem nome da pasta da spec, sem "conforme a spec".
- **Só em comentários:** nomes de variáveis e funções, mensagens de log, mensagens de commit e nomes de branch não citam siglas, arquivos nem pastas do SDD.

### 7.2 Commits: NENHUM `Co-Authored-By:`

Vale a regra de autoria do `AGENTS.md`: **NENHUMA IA listada como `Co-Authored-By:`**, nem "Generated with ...", "🤖" ou nome de modelo, em nenhum commit, PR, código ou comentário, mesmo que uma ferramenta peça. A mensagem de commit descreve a mudança na linguagem do domínio (ex.: `fix: corrige expiração de sessão no login`), sem citar a spec.

### 7.3 Infraestrutura de testes

Se a feature mudar ou melhorar a infraestrutura de testes (serviço, container ou porta, comando para subir a stack, seed, variável de ambiente, script ou ferramenta de teste), atualize o `.ai/infraestrutura-testes.md` **só com o que verificou na prática**, alterando apenas as linhas afetadas, sem apagar o que outras features documentaram, e atualizando a data de "Última verificação prática". Limitação resolvida é marcada como resolvida, com data, e não apagada. Se um teste esbarrar numa limitação já listada lá, cite-a no `review.md` e siga em frente, sem re-investigar. Limitação de ambiente **nova** (não específica da spec) vai para lá, em nova seção.

## 8. Numeração e ciclo de vida das specs

Toda pasta de spec começa com um número de 3 dígitos: `NNN-nome-da-feature` (ex.: `001-login`, `013-exportar-relatorio`). **O número define a ordem de execução** da fila, do menor para o maior.

1. Encontre o maior número já usado **nas duas** pastas:

   ```bash
   ls -1 .ai/specs .ai/specs/concluidos 2>/dev/null | grep -E '^[0-9]+-' | sed -E 's/^([0-9]+)-.*/\1/' | sort -n | tail -1
   ```

2. Use o seguinte, com 3 dígitos (`007` → `008`). Sem nenhuma spec, `001`.
3. Nunca reutilize um número, nem o de uma spec concluída, e nunca renumere specs existentes. Se uma feature precisar rodar antes de outra já criada, registre a dependência na spec em vez de trocar números.

Ciclo de vida: a spec fica em `.ai/specs/` enquanto pendente e vai para `.ai/specs/concluidos/` (mantendo o número) depois de aprovada. Pastas sem prefixo numérico não entram na fila automática.

## 9. Raiz com vários projetos

A raiz pode agrupar vários projetos do mesmo ecossistema (APIs, frontends, workers, lambdas, microsserviços), cada um com ou sem repositório git próprio.

- `.ai/architecture.md` é o **mapa do ecossistema**: projetos, como se comunicam, contratos e conceitos compartilhados. Os detalhes internos ficam fora dele.
- Cada projeto da raiz tem **obrigatoriamente** um `.ai/architecture-<pasta-do-projeto>.md`, com o nome exato da pasta (`api-pedidos/` → `.ai/architecture-api-pedidos.md`). Em projeto único, basta o `architecture.md`.
- **Contexto mínimo:** leia o mapa e **só** as arquiteturas da tabela da spec. Nunca leia as de outros projetos "por garantia": isso polui o contexto e piora a execução.
- Projeto sem arquivo de arquitetura não recebe feature: pare, gere o arquivo (seção 10) e atualize o mapa antes de seguir.
- Se a execução exigir mexer num projeto fora da tabela, pare, atualize spec/plan/tasks e registre a decisão no `build-logs.md` antes de ler a arquitetura desse projeto.
- Respeite os limites de cada projeto. Não copie padrões de um projeto para outro sem justificar no `build-logs.md`.

## 10. Setup do projeto (Fase 0)

Roda uma vez ao instalar o framework, quando a arquitetura mudar de forma relevante ou para um projeto novo na raiz. Não cria spec, plan nem tasks.

1. Varra o repositório e identifique: propósito e domínio; stack; estrutura de pastas; padrões de código (nomenclatura, módulos, camadas); backend; frontend; banco (tabelas, migrations, ORM); autenticação e autorização; integrações, filas, workers, jobs e lambdas; scripts de build, deploy e testes.
2. Edite o `.ai/architecture.md` existente, sem criar outro em outro lugar, com conteúdo completo o bastante para qualquer IA planejar e implementar respeitando a arquitetura real. Em raiz com vários projetos, documente primeiro o ecossistema (mapa, com a tabela de projetos e a comunicação entre eles) e depois crie um `.ai/architecture-<pasta>.md` para **cada** projeto, usando as seções do modelo `architecture.md`. Se o pedido for o setup de um único projeto novo, gere só o arquivo dele e atualize a tabela do mapa.
3. Se conseguir verificar o ambiente local de testes, preencha a primeira versão do `.ai/infraestrutura-testes.md` só com o que verificou (não assuma portas default).
4. Sugira informações para a seção 12 deste arquivo (`.ai/ai-instructions.md`) (convenções, ferramentas obrigatórias, padrões de commit, regras de revisão, áreas sensíveis, limites entre projetos, segurança). **Pergunte quais o desenvolvedor quer gravar antes de editar.**
5. Pergunte se a próxima feature deve ficar num fluxo específico do ecossistema (só backend, só o serviço X) ou em aberto, como feature geral.

## 11. Modo autônomo (Claude Code)

A skill `/executar-specs-pendentes` (`.claude/skills/`) processa a fila de `.ai/specs/` em ordem numérica e dispara um subagente `executor-spec-sdd` (`.claude/agents/`) por spec, com contexto zerado. O executor segue este contrato sem pausar para aprovação, e o contrato dele define o que muda no modo autônomo. Só specs com review **"Aprovada"** vão para `concluidos/`. Guarda-corpos fixos: nunca `git push`, nunca PR, nunca commit na branch padrão, nunca editar os arquivos do framework. As regras deste arquivo prevalecem sobre a autonomia.

## 12. Informações específicas do projeto

> Preenchida na Fase 0 (seção 10). Quanto mais completa, menos a IA precisa adivinhar.

- Convenções de nomenclatura e estilo de código próprias deste projeto:
- Ferramentas obrigatórias (lint, formatter, testes, build) e como executá-las:
- Padrão de commits / branches / PRs adotado:
- Regras de revisão de código específicas (o que não pode ser aprovado):
- Serviços, módulos ou arquivos que nunca devem ser alterados sem validação humana explícita (áreas sensíveis):
- Se a raiz agrupa vários projetos: limites entre eles e como se comunicam (o detalhe de cada um fica em `architecture-<projeto>.md`):
- Restrições de segurança ou compliance relevantes:
- Outras informações que a IA deveria saber antes de codar neste projeto:
