# SDD — Spec Driven Development com IA

Framework pronto para guiar o desenvolvimento de software com IA a partir de documentos estruturados, em vez de prompts soltos. Basta copiar `.ai/`, `.claude/`, `AGENTS.md` e `CLAUDE.md` para qualquer projeto e começar a usar.

**Manual completo (instalação, fases, prompts, modo autônomo): [`.ai/README.md`](.ai/README.md).**

## O que existe aqui

- **[`AGENTS.md`](AGENTS.md)**: roteador leve que os agentes de IA carregam em toda sessão. Diz quando o SDD se aplica (qualquer alteração de código) e traz as regras que valem sempre. O [`CLAUDE.md`](CLAUDE.md) só importa o `AGENTS.md`, para o Claude Code.
- **[`.ai/ai-instructions.md`](.ai/ai-instructions.md)**: o contrato SDD da IA, lido só quando a tarefa envolve SDD, com todas as regras e procedimentos (como criar spec/plan/tasks, como implementar, quais arquivos ler, regras de código e commit).
- **[`.ai/`](.ai/README.md)**: o manual para desenvolvedores (`README.md`), o contrato SDD da IA (`ai-instructions.md`), a arquitetura do projeto (`architecture.md` e, em raiz com vários projetos, um `architecture-<projeto>.md` por projeto), a referência do ambiente de testes (`infraestrutura-testes.md`) e o ciclo de specs por feature (`spec.md`, `plan.md`, `tasks.md`, `build-logs.md`, `tests.md`, `review.md`). As specs ficam em pastas numeradas (`001-...`, `002-...`) que definem a ordem de execução, com templates em `specs/template/` e ciclo de vida pendente → `specs/concluidos/`.
- **`.claude/`**: camada opcional de automação para o Claude Code. A skill `/executar-specs-pendentes` orquestra a fila, e o subagente `executor-spec-sdd` executa o ciclo SDD completo de uma spec por vez, em contexto zerado, commitando em branch própria, sem nunca dar push nem abrir PR.

## Por que existe

Para fugir do *vibe coding*: a IA gerando código a partir de uma ideia vaga, sem contrato, sem plano e sem validação. O fluxo obriga a IA a entender o contexto, ler a spec, seguir um plano, executar tarefa por tarefa e registrar toda decisão relevante.

## O que agrega

- **Contexto consistente e enxuto**: a IA lê a arquitetura, as regras de negócio e as decisões anteriores antes de implementar, e só as arquiteturas dos projetos que a feature toca.
- **Rastreabilidade**: `build-logs.md` guarda o porquê de cada decisão, `tests.md` o que foi testado e `review.md` o histórico de validações contra a spec.
- **Escopo controlado**: tarefas pequenas e critérios de aceite objetivos.
- **Execução em lote com segurança**: branch própria por spec, sem push, sem PR, e as regras do `ai-instructions.md` prevalecem sobre a autonomia.
- **Padronização**: o mesmo fluxo em qualquer projeto.

## Consumo de tokens por rodada

Estimativa de quanto a IA consome ao ler os arquivos obrigatórios do SDD, antes de começar o trabalho de fato:

| Arquivo | Sessão sem SDD | Escrever spec, plan e tasks | Implementar uma spec | Implementar no modo autônomo (por spec) |
|---|---:|---:|---:|---:|
| `AGENTS.md` (carregado sempre) | 500 | 500 | 500 | 500 |
| `.ai/ai-instructions.md` | — | 6.200 | 6.200 | 6.200 |
| `.ai/architecture.md` | — | 800 | 800 | 800 |
| `.ai/infraestrutura-testes.md` | — | 800 | 800 | 800 |
| `spec.md` | — | 800 | 800 | 800 |
| `plan.md` | — | 500 | 500 | 500 |
| `tasks.md` | — | 600 | 600 | 600 |
| `build-logs.md` | — | — | 500 | 500 |
| `tests.md` | — | — | 400 | 400 |
| `review.md` | — | — | 400 | 400 |
| `.claude/agents/executor-spec-sdd.md` (system prompt do subagente) | — | — | — | 5.900 |
| **Total** | **~500** | **~10.200** | **~11.500** | **~17.400** |

Como ler a tabela:

- **Estimativa de ±20%**, calculada pelo tamanho dos arquivos (cerca de 3,3 caracteres por token em português, mais o custo das linhas na leitura).
- **O mínimo de cada rodada.** `architecture.md`, `infraestrutura-testes.md` e os arquivos da feature foram medidos como templates vazios. Preenchidos com o projeto real e com a feature, eles crescem. Esse crescimento é contexto útil, não custo do framework.
- **Fora da conta:** os `architecture-<projeto>.md` da tabela "Projetos e arquiteturas envolvidos" da spec. Em raiz com vários projetos, some um arquivo por projeto que a feature altera.
- **Ao escrever a spec**, os templates de `spec.md`, `plan.md` e `tasks.md` são lidos para preenchimento. `build-logs.md`, `tests.md` e `review.md` só são copiados.
- **O `.ai/README.md`** é o manual para desenvolvedores e não entra em nenhuma rodada.
