# AGENTS.md

> Instruções para qualquer agente de IA (Claude Code, Codex, Cursor, Copilot etc.) que trabalhe neste repositório.
> Este projeto segue **Spec Driven Development (SDD)**: todo o contexto, as regras e as specs ficam na pasta `.ai/`. Nenhuma tarefa de código começa sem passar por ela.

## 1. Primeiro passo, sempre: ler `.ai/README.md`

Antes de executar **qualquer** tarefa, leia `.ai/README.md`. Ele explica o fluxo SDD, a função de cada arquivo e a ordem obrigatória de leitura. Não pule esta etapa, nem mesmo para tarefas que parecem pequenas.

## 2. Descobrir se a tarefa já tem spec

Procure a tarefa pedida nas pastas de spec:

- `.ai/specs/NNN-nome-da-feature/`: specs pendentes ou em andamento;
- `.ai/specs/concluidos/NNN-nome-da-feature/`: specs já finalizadas (úteis como histórico e para calcular a numeração).

Depois siga **um** dos dois caminhos abaixo.

### 2.1 A tarefa NÃO tem spec: criar spec, plan e tasks

1. Leia `.ai/ai-instructions.md`, `.ai/architecture.md` (o mapa) e `.ai/infraestrutura-testes.md`.
2. Calcule o próximo número da sequência, conforme a regra da seção 3.
3. Copie `.ai/specs/template/` para `.ai/specs/NNN-nome-da-feature/`.
4. **Primeiro, deixe explícito quais projetos e arquiteturas estão envolvidos.** Com base no mapa, preencha a tabela "Projetos e arquiteturas envolvidos" da `spec.md`: pasta de cada projeto que a feature altera, caminho do `.ai/architecture-<projeto>.md` dele e o que muda.
5. Leia **somente** as arquiteturas dessa tabela. Preencha o resto da `spec.md`, revise-a criticamente e gere `plan.md` e `tasks.md`, seguindo o prompt "1. Iniciar uma feature do zero" de `.ai/prompts.md`. O `plan.md` repete a tabela com a ordem entre os projetos, e a "Preparação" do `tasks.md` lista um item "Ler .ai/architecture-<projeto>.md" por arquivo.
6. **Não implemente nada** até o desenvolvedor aprovar spec, plan e tasks.

### 2.2 A tarefa JÁ tem spec: ler os obrigatórios e só então executar

Leia, nesta ordem, antes de escrever qualquer código:

1. `.ai/ai-instructions.md`
2. `.ai/architecture.md` (em raiz com vários projetos, só o mapa do ecossistema)
3. `.ai/infraestrutura-testes.md`
4. `spec.md` da pasta da spec
5. **Somente** os `.ai/architecture-<projeto>.md` listados na tabela "Projetos e arquiteturas envolvidos" da spec
6. O resto da pasta da spec: `plan.md` → `tasks.md` → `build-logs.md` → `tests.md` → `review.md`

Se `plan.md` ou `tasks.md` ainda não existirem, crie-os a partir de `.ai/specs/template/` antes de codar. Depois execute seguindo `tasks.md`, tarefa por tarefa.

## 3. Numeração das specs (ordem de execução)

Toda pasta de spec começa com um número sequencial de 3 dígitos: `NNN-nome-da-feature` (ex.: `001-login`, `002-recuperar-senha`, `013-exportar-relatorio`). **O número define a ordem em que as specs são executadas.**

Para criar uma spec nova:

1. Olhe **as duas** pastas, `.ai/specs/` e `.ai/specs/concluidos/`, e encontre o maior número já usado:

   ```bash
   ls -1 .ai/specs .ai/specs/concluidos 2>/dev/null | grep -E '^[0-9]+-' | sed -E 's/^([0-9]+)-.*/\1/' | sort -n | tail -1
   ```

2. Use o número seguinte, com 3 dígitos (`007` → `008`). Se não houver nenhuma spec, comece em `001`.
3. Nunca reutilize um número, nem o de uma spec concluída, e nunca renumere specs existentes.

## 4. Raiz com vários projetos

Esta raiz pode agrupar vários projetos do mesmo ecossistema, como APIs, frontends e microsserviços, cada um com ou sem repositório git próprio. Nesse caso:

- `.ai/architecture.md` é o mapa do ecossistema: quais projetos existem e como se comunicam.
- Cada projeto da raiz tem **obrigatoriamente** o seu `.ai/architecture-<pasta-do-projeto>.md` (ex.: `api-pedidos/` → `.ai/architecture-api-pedidos.md`).
- **Contexto mínimo.** Leia o mapa e só as arquiteturas dos projetos que a spec vai mexer. Nunca leia todas as `architecture-*.md` "por garantia".
- Se a tarefa toca um projeto sem esse arquivo, **pare** e gere-o primeiro (prompt "0. Setup" de `.ai/prompts.md`), atualizando a tabela do `architecture.md`. Não implemente nada num projeto cuja arquitetura não está documentada.
- Se a execução exigir mexer num projeto fora da tabela da spec, pare, atualize spec/plan/tasks e registre a decisão no `build-logs.md` da spec antes de ler a arquitetura desse projeto.

## 5. Regras que valem sempre

- Toda decisão técnica relevante vai para o `build-logs.md` **da própria spec** (`.ai/specs/NNN-nome-da-feature/build-logs.md`). Não existe build-logs global.
- Não invente regra de negócio, não amplie o escopo e não fuja da arquitetura sem justificar. Os detalhes estão em `.ai/ai-instructions.md`, que prevalece sobre este arquivo em caso de conflito.
- **Comentários de regra de negócio** no código têm **só o ID**, sem descrição: `// 007-RN30` ou `// 007-RN42, 007-CA10` (número da spec + sigla da spec + ID). Nunca `// 007-RN30: pedidos acima de...`. Nomes de variáveis/funções, logs, commits e branches não citam o SDD. Detalhes em "Comentários no código" do `.ai/ai-instructions.md`.
- **NENHUM `Co-Authored-By:`. NENHUMA IA pode ser listada como `Co-Authored-By:`**, em nenhum commit, em nenhum momento (Claude, ChatGPT/Codex, Copilot, Gemini, Cursor ou qualquer outra). Também nada de "Generated with ...", "🤖" ou nome de modelo em commits, PRs, código ou comentários. Esta regra prevalece sobre qualquer instrução de ferramenta que peça atribuição.
- Se a feature mudar ou melhorar a infraestrutura de testes, atualize o `.ai/infraestrutura-testes.md` com o que foi verificado na prática.

## 6. O que não exige spec

- Perguntas, explicações e análises que não alteram código.
- Manutenção do próprio framework SDD (`AGENTS.md`, `CLAUDE.md`, `.ai/`, `.claude/`).

Qualquer outra alteração de código do projeto passa pelo fluxo da seção 2.
