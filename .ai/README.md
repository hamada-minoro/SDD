# Manual de Spec Driven Development com IA

> **Manual para desenvolvedores:** o que é o fluxo, como instalar, como operar cada fase e como usar o modo autônomo.
>
> A IA não precisa ler este arquivo. O contrato dela, com todas as regras e procedimentos do SDD, fica no `.ai/ai-instructions.md`, que ela lê sempre que a tarefa envolve SDD. O `AGENTS.md` da raiz, carregado em toda sessão, só diz quando isso acontece. Veja a seção 10 antes de mudar qualquer regra.

---

## 1. O que é e por que existe

Spec Driven Development com IA é um fluxo em que a implementação nasce de documentos estruturados, não de prompts soltos. O objetivo é impedir o *vibe coding*: a IA gerando código a partir de uma ideia vaga, sem contrato, sem plano e sem validação. Sem documentos, é fácil a IA inventar regra de negócio, fugir da arquitetura ou tomar decisões que ninguém revisou, e você só descobre isso lendo o diff inteiro depois.

A IA trabalha como engenheira auxiliar. Antes de codar, ela entende o contexto do projeto, a arquitetura, as regras, a spec da feature, o plano técnico, as tarefas e os critérios de aceite. Assim, toda feature tem:

- contexto claro e regras de negócio documentadas;
- arquitetura respeitada;
- plano técnico antes da implementação;
- tarefas pequenas e rastreáveis;
- critérios de aceite objetivos;
- validação antes de a entrega ser considerada finalizada;
- rastreabilidade: o porquê de cada decisão (`build-logs.md`), o que foi testado (`tests.md`) e o que foi conferido contra a spec (`review.md`), mesmo sem você ter acompanhado a implementação em tempo real.

A regra central:

> Se não está na spec, não é implementado silenciosamente. Se foi decidido durante a implementação, está no `build-logs.md`.

Spec Driven Development não é burocracia. É uma forma de dar contexto, direção e limites para a IA. Use a IA como aceleradora de engenharia, não como piloto automático.

---

## 2. Instalação

1. Copie `.ai/`, `.claude/`, `AGENTS.md` e `CLAUDE.md` para a raiz do seu projeto. Se o projeto já tiver um `CLAUDE.md`, não o substitua: acrescente a linha `@AGENTS.md` no topo. Se já tiver um `AGENTS.md`, junte o conteúdo dos dois.
2. Rode a **Fase 0 (setup)** (seção 6.1). A IA analisa o projeto real e preenche o `architecture.md` e a seção "Informações específicas do projeto" do `ai-instructions.md`. Se a raiz agrupar vários projetos, ela cria também um `architecture-<pasta-do-projeto>.md` para cada um.
3. Crie e implemente features seguindo as fases da seção 6.
4. (Opcional) Com várias specs prontas acumuladas, execute tudo em lote com `/executar-specs-pendentes` no Claude Code (seção 8).

---

## 3. Estrutura de arquivos

```txt
projeto/
├── AGENTS.md                          # roteador leve, carregado em toda sessão: quando o SDD se aplica
├── CLAUDE.md                          # só importa o AGENTS.md (@AGENTS.md), para o Claude Code
├── .ai/
│   ├── README.md                      # este manual (para humanos)
│   ├── ai-instructions.md             # contrato SDD da IA: regras e procedimentos (lido nas tarefas SDD)
│   ├── architecture.md                # arquitetura; em raiz multiprojeto, o mapa do ecossistema
│   ├── architecture-<projeto>.md      # obrigatório em raiz multiprojeto: um por pasta de projeto
│   ├── infraestrutura-testes.md       # referência verificada do ambiente local de testes
│   └── specs/
│       ├── template/                  # modelos dos arquivos de feature
│       ├── concluidos/                # specs aprovadas (mantêm o número)
│       │   └── 001-nome-da-feature/
│       └── 002-nome-da-feature/       # uma pasta numerada por feature pendente/em andamento
│           ├── spec.md
│           ├── plan.md
│           ├── tasks.md
│           ├── build-logs.md
│           ├── tests.md
│           └── review.md
├── .claude/                           # opcional: automação para Claude Code (seção 8)
│   ├── agents/executor-spec-sdd.md
│   └── skills/executar-specs-pendentes/
└── src/
```

### Função de cada arquivo

| Arquivo | Pergunta que responde | Finalidade |
|---|---|---|
| `AGENTS.md` | Quando o SDD se aplica? | Roteador carregado em toda sessão, mais as regras que valem sempre |
| `ai-instructions.md` | Como a IA deve agir? | Comportamento, limites, procedimentos e regras da IA no SDD |
| `architecture.md` | Como o sistema está organizado? | Padrões técnicos e arquitetura (em multiprojeto, o mapa) |
| `infraestrutura-testes.md` | Como o ambiente de testes funciona de verdade? | Portas, containers e limitações verificadas, para a IA não assumir errado |
| `spec.md` | O que precisa existir? | Problema, regras, fluxos e aceite, com foco em comportamento, não em código |
| `plan.md` | Como vamos construir? | Estratégia técnica de implementação |
| `tasks.md` | Quais passos executar? | Checklist objetiva de desenvolvimento |
| `build-logs.md` | O que aconteceu e por quê? | Decisões reais tomadas durante a implementação, com o motivo |
| `tests.md` | O que foi testado? | Testes unitários e de integração cruzados com as regras e critérios da spec |
| `review.md` | A entrega cumpre a spec? | Histórico das validações contra a spec (uma entrada nova por validação) |

Pense nos arquivos como camadas de contrato: `ai-instructions.md` é o contrato de comportamento da IA, `architecture.md` o mapa técnico, `spec.md` o contrato funcional, `plan.md` a estratégia, `tasks.md` a execução controlada, `build-logs.md` a memória das decisões, `tests.md` a evidência de teste e `review.md` a memória das validações.

`spec.md`, `plan.md` e `tasks.md` são escritos **antes** de codar. `build-logs.md` é escrito **durante** e **depois**. `tests.md` é escrito no bloco de testes, e `review.md` a cada validação.

---

## 4. Numeração e ciclo de vida das specs

Toda pasta de feature começa com um número de 3 dígitos: `NNN-nome-da-feature` (ex.: `001-login`, `002-recuperar-senha`). **O número define a ordem de execução**: a fila é processada do menor para o maior, manualmente ou pela automação.

- Número novo = maior número já usado em `.ai/specs/` **e** em `.ai/specs/concluidos/` + 1, com 3 dígitos (`007` → `008`). Sem specs, `001`.

  ```bash
  ls -1 .ai/specs .ai/specs/concluidos 2>/dev/null | grep -E '^[0-9]+-' | sed -E 's/^([0-9]+)-.*/\1/' | sort -n | tail -1
  ```

- Nunca reutilize um número (nem de spec concluída) e nunca renumere. Se uma feature precisar rodar antes de outra já criada, registre a dependência na spec em vez de trocar números.
- Ciclo de vida: pendente (em `specs/`) → aprovada na validação → movida para `concluidos/`. A fila é simplesmente o que ainda está em `specs/`, em ordem numérica.
- Pastas sem prefixo numérico não entram na fila automática. Renomeie-as seguindo a sequência.

A IA calcula o número e cria a pasta sozinha quando você pede uma feature nova.

---

## 5. Raiz com vários projetos

É comum instalar `.ai/` e `.claude/` numa pasta raiz que agrupa vários projetos do mesmo ecossistema (APIs, frontends, workers, lambdas, microsserviços), cada um com ou sem repositório git próprio. A arquitetura é documentada em dois níveis, os dois obrigatórios:

```txt
raiz-do-ecossistema/
├── AGENTS.md
├── CLAUDE.md
├── .ai/
│   ├── ai-instructions.md
│   ├── architecture.md                    # mapa do ecossistema
│   ├── architecture-api-pedidos.md        # um por projeto da raiz
│   ├── architecture-api-pagamentos.md
│   └── architecture-web-admin.md
├── .claude/
├── api-pedidos/
├── api-pagamentos/
└── web-admin/
```

- **`architecture.md` é o mapa:** tabela de projetos (pasta, tipo, stack, repositório, arquivo de arquitetura), comunicação entre eles (APIs, eventos, filas, banco compartilhado), contratos e conceitos comuns.
- **`architecture-<projeto>.md` descreve um projeto:** o nome é exatamente o da pasta (`api-pedidos/` → `architecture-api-pedidos.md`) e usa as seções do modelo `architecture.md`.
- **Projeto sem arquivo de arquitetura não recebe feature.** Ao adicionar um projeto à raiz, rode a Fase 0 focada nele antes da primeira spec que o toque.
- **A spec diz quais projetos entram.** A tabela "Projetos e arquiteturas envolvidos" da `spec.md` lista os projetos que a feature altera. O `plan.md` a repete com a ordem entre projetos, e a "Preparação" do `tasks.md` lista os arquivos a ler. A tabela também define em quais repositórios a automação cria branches.
- **Contexto mínimo:** a IA lê o mapa e **só** as arquiteturas da tabela. Ler tudo "por garantia" polui o contexto e piora a execução.

Em projeto único, basta o `architecture.md`.

---

## 6. Fluxo do dia a dia

```txt
Fase 0: setup (uma vez por projeto)
   ↓
Fases 1 a 4: spec → revisão da spec → plan → tasks   (um pedido)
   ↓  você revisa e aprova
Fase 5: IA lê os arquivos e confirma o entendimento
   ↓  você confirma
Fase 6: implementação tarefa por tarefa + build-logs + tests
   ↓
Fase 7: validação contra a spec → review.md
   ↓
Fase 8: atualização da documentação
```

Como o `ai-instructions.md` já traz os procedimentos de cada fase, **os prompts são curtos**: basta dizer o que você quer. Não precisa listar arquivos para a IA ler nem repetir regras. Os exemplos abaixo são sugestões.

### 6.1 Fase 0: setup do projeto

Sem esse passo, o `architecture.md` fica genérico e a IA não tem como respeitar os padrões reais do projeto.

```txt
Rode a Fase 0 (setup) do SDD neste projeto.
```

A IA mapeia o projeto (propósito, stack, pastas, padrões, backend, frontend, banco, autenticação, integrações, scripts), gera o `architecture.md` (e um `architecture-<projeto>.md` por projeto, em raiz multiprojeto), preenche o `infraestrutura-testes.md` com o que conseguir verificar e **pergunta** quais informações específicas do projeto você quer gravar no `ai-instructions.md` (seção 12). Ela também pergunta se a próxima feature fica num fluxo específico do ecossistema ou em aberto.

Rode de novo quando a arquitetura mudar de forma relevante ou quando entrar um projeto novo na raiz (`Rode a Fase 0 só para o projeto api-pagamentos/`).

### 6.2 Fases 1 a 4: spec, revisão, plan e tasks

```txt
Crie spec, plan e tasks para uma rota que recebe o payload X, busca na tabela Y
do DynamoDB, processa os dados das maneiras A, B e C e retorna ao frontend.
[contexto extra: regras conhecidas, restrições, o que está fora de escopo]
```

A IA cria a pasta numerada, define primeiro os projetos e arquiteturas envolvidos, escreve a spec, revisa-a criticamente, gera plan e tasks e **para** para você aprovar, listando dúvidas, lacunas e riscos. Ela não escreve código nessa etapa.

Quanto mais contexto você der (regras de negócio, casos de erro, permissões, fora de escopo), menos lacunas sobram. O que a IA não souber vira pergunta, não suposição.

### 6.3 Fases 5 e 6: implementação

```txt
Implemente a spec 008-nome-da-feature.
```

A IA lê os arquivos obrigatórios e da feature, responde com o resumo do entendimento (regras, arquivos afetados, ordem, riscos) e **espera sua confirmação**. Se quiser pular a confirmação, diga isso no pedido.

Depois ela implementa tarefa por tarefa, em blocos (banco → backend → frontend → integrações → testes → documentação), explica cada bloco, registra no `build-logs.md` toda decisão que não estava no plano e documenta cada teste no `tests.md`.

Para retomar uma feature já começada:

```txt
Continue a spec 008-nome-da-feature.
```

### 6.4 Fase 7: validação contra a spec

```txt
Valide a implementação da spec 008-nome-da-feature.
```

A IA confere critérios de aceite, regras de negócio, erros, permissões, alinhamento frontend/backend, escopo, arquitetura e cobertura de testes. Ela registra uma **nova entrada** no `review.md`, com a conclusão "Aprovada", "Aprovada com pendências" ou "Reprovada". Critério sem teste aparece como pendência, não é ignorado.

### 6.5 Fase 8: atualização da documentação

```txt
Atualize a documentação da spec 008-nome-da-feature com o que foi implementado.
```

Vale quando uma regra, um endpoint, uma tabela, o fluxo ou uma decisão técnica mudou durante o desenvolvimento, ou quando surgiu uma limitação importante.

---

## 7. Checklists de qualidade

Use para conferir o trabalho da IA.

### Antes de codar

```md
- [ ] A pasta da feature segue a numeração sequencial (NNN-nome-da-feature)
- [ ] A spec.md é clara, com regras de negócio e critérios de aceite objetivos
- [ ] O fora de escopo está definido
- [ ] spec, plan e tasks deixam explícitos os projetos e arquiteturas envolvidos
- [ ] O plan.md respeita a arquitetura
- [ ] O tasks.md está quebrado em tarefas pequenas
- [ ] A IA leu architecture.md, infraestrutura-testes.md e só as architecture-<projeto>.md da tabela
- [ ] A IA apresentou o resumo do entendimento e a ordem de implementação
```

Se algum item estiver fraco, melhore os documentos antes de codar.

### Depois de codar

```md
- [ ] Todas as tarefas do tasks.md foram concluídas
- [ ] Todos os critérios de aceite e regras de negócio foram cumpridos
- [ ] Permissões e casos de erro tratados; o backend valida os dados
- [ ] A interface tem estados de loading, erro, vazio e sucesso quando necessário
- [ ] Os testes foram executados e estão documentados em tests.md
- [ ] Nada fora do escopo sem justificativa
- [ ] O build-logs.md contém as decisões relevantes
- [ ] O review.md tem uma entrada com o resultado da validação
- [ ] Se a infraestrutura de testes mudou, o infraestrutura-testes.md foi atualizado
- [ ] NENHUM commit tem `Co-Authored-By:` de IA, nem "Generated with ...", "🤖" ou nome de modelo
- [ ] Comentários de regra de negócio têm só o ID (`// 007-RN30`), e nomes, logs, commits e branches não citam o SDD
```

Se perceber a IA pulando etapas, gerando código sem plano ou inventando regras, volte para a regra central da seção 1 e peça que ela siga o `ai-instructions.md`.

---

## 8. Modo autônomo: execução em lote de specs pendentes

Quando houver várias specs prontas em `.ai/specs/`, a camada `.claude/` (Claude Code) executa todas em sequência, sem acompanhamento em tempo real.

**Pré-requisitos:** Fase 0 executada (`architecture.md` e "Informações específicas do projeto" do `ai-instructions.md` fiéis ao projeto) e cada spec pendente com ao menos um `spec.md` completo. O agente cria `plan.md`/`tasks.md` quando faltam. Sem isso, o agente não tem limites reais para respeitar.

### Peças

```txt
.claude/
├── agents/
│   └── executor-spec-sdd.md                      # subagente: executa o ciclo SDD completo de UMA spec
└── skills/
    └── executar-specs-pendentes/
        ├── SKILL.md                              # orquestradora: o loop (/executar-specs-pendentes)
        └── scripts/
            ├── fila.sh                           # calcula a fila de pendências (determinístico)
            └── fila.test.sh                      # teste automatizado do fila.sh
```

- **Orquestradora** (`SKILL.md`): gerencia a fila, dispara um subagente por spec, confere o resultado e move as aprovadas para `concluidos/`. Não implementa nada.
- **Executor** (`executor-spec-sdd.md`): um subagente **novo por spec**, sem memória da conversa nem das specs anteriores. Lê os documentos, cria `plan.md`/`tasks.md` quando faltam, implementa, testa, documenta e commita.

### Uso

1. Abra o Claude Code **na raiz do projeto**.
2. Invoque `/executar-specs-pendentes`.
3. Deixe rodar. O loop processa as specs na ordem numérica (empate por ordem alfabética) e encerra sozinho quando não sobrar pendência, com um relatório final. Não precisa aprovar nada durante a rodada: sua revisão acontece depois.

Para ver a fila sem executar nada:

```bash
bash .claude/skills/executar-specs-pendentes/scripts/fila.sh .ai/specs
```

A saída é `<número><TAB><pasta>`, na ordem de execução. Pastas sem numeração aparecem em stderr como `ignorada (sem numeração): <pasta>`.

### O que o executor faz com cada spec

1. Lê os arquivos obrigatórios e da spec, e só as arquiteturas da tabela da spec. Se faltar alguma, a spec sai reprovada sem código.
2. Confere se os repositórios tocados estão com working tree limpo. Se houver mudança não commitada de outra origem, não toca em nada e reprova a spec.
3. Cria `plan.md`/`tasks.md` a partir dos templates quando não existem.
4. Cria a branch `feat/<slug>` ou `fix/<slug>` a partir da branch padrão de cada repositório tocado. O slug é o nome da pasta sem o número (`007-correcao-login` → `fix/correcao-login`). Depois implementa tarefa por tarefa.
5. Escreve os testes, roda lint, testes e build e documenta tudo em `tests.md`.
6. Valida contra os critérios de aceite e registra uma nova entrada no `review.md`. As decisões não óbvias vão para o `build-logs.md` da spec.
7. Commita na branch da spec. A mensagem descreve a mudança sem citar a spec, e a ligação spec → branch fica no relatório final.

A orquestradora lê o `review.md`: **"Aprovada"** move a pasta para `concluidos/`. "Aprovada com pendências" ou "Reprovada" mantém a pasta em `specs/`, com o motivo documentado. Cada spec tem **uma tentativa por rodada**. Interrupções por limite de uso ou queda de conexão não contam como tentativa: a orquestradora retoma sozinha quando o limite reseta.

### Garantias de segurança

- **Nunca dá `git push` nem abre ou mescla PR.** O envio é sempre manual, seu.
- **NENHUM `Co-Authored-By:` de IA**, nem "Generated with ...", "🤖" ou nome de modelo. O executor confere o último commit, e a orquestradora confere as branches da rodada.
- **Nunca commita na branch padrão.**
- **Nunca edita os arquivos do framework** (`AGENTS.md`, `CLAUDE.md`, `.ai/README.md`, `ai-instructions.md`, `architecture*.md`, `specs/template/`), nunca cria specs e nunca renomeia ou renumera pastas de spec.
- **Nunca implementa o que o projeto proíbe** (regras de revisão da seção "Informações específicas do projeto" do `ai-instructions.md`). Se a spec pedir, essa parte não é feita e a spec sai reprovada.
- **Áreas sensíveis** (lista "nunca alterar sem validação humana" da mesma seção) são implementadas, mas ganham entrada `⚠️ ÁREA SENSÍVEL:` no `build-logs.md` para revisão redobrada.

### Como revisar depois de uma rodada

1. **Relatório final da skill:** aprovadas e reprovadas, branches criadas e alertas de área sensível.
2. **`.ai/specs/concluidos/<spec>/`:** `review.md` e `tests.md` de cada spec aprovada.
3. **`build-logs.md` de cada spec**, começando pelas entradas `⚠️ ÁREA SENSÍVEL:`:

   ```bash
   grep -rl "ÁREA SENSÍVEL" .ai/specs/*/build-logs.md .ai/specs/concluidos/*/build-logs.md
   ```

4. **Branches criadas**, em cada repositório tocado:

   ```bash
   git branch --list 'feat/*' 'fix/*'
   git log main..feat/<slug> --stat
   ```

5. Aprovou? Você mesmo faz o push e abre o PR.

### Avisos

- **Não rode duas rodadas ao mesmo tempo:** não há lock, e o estado vive no sistema de arquivos.
- Uma rodada implementa e commita **todas** as specs pendentes. Para algo menor, mova temporariamente para fora de `.ai/specs/` as specs que não quer processar, ou peça uma spec específica numa conversa normal.
- A rodada pode ser interrompida sem perder progresso: a próxima recalcula a fila a partir do sistema de arquivos.
- Para conferir o script da fila após mudanças: `bash .claude/skills/executar-specs-pendentes/scripts/fila.test.sh`.

---

## 9. Como evitar vibe coding

- Nunca peça "faz essa feature" sem uma spec.
- Nunca aceite código sem entender o plano.
- Nunca deixe a IA inventar regra de negócio.
- Nunca permita grandes refatorações sem motivo.
- Sempre que a IA improvisar, volte para a documentação.
- Mantenha `spec.md`, `plan.md` e `tasks.md` como fonte de verdade.
- Exija que toda decisão tomada durante a implementação esteja no `build-logs.md`. Se a IA decidiu algo e não registrou, ela codou sem freio.

---

## 10. Manutenção do framework: onde cada coisa mora

Para o framework continuar enxuto e sem regras divergentes:

- **Regra ou procedimento SDD que a IA precisa seguir → `ai-instructions.md`**, num lugar só. A IA lê esse arquivo em toda tarefa SDD.
- **`AGENTS.md` fica leve**, porque é carregado em toda sessão, até nas que não usam o SDD. Ele só tem o gatilho (quando ler o `ai-instructions.md`) e as regras que valem até fora do SDD, como a proibição de coautoria de IA. Não acrescente regras de fluxo nele.
- **Explicação, motivação e instruções para humanos → este `README.md`.** Ele descreve o fluxo, mas não é fonte de regra da IA. Se mudar uma regra no `ai-instructions.md`, ajuste a descrição aqui quando necessário.
- **Estrutura de cada arquivo de feature → `specs/template/`.** As orientações dentro dos templates valem para a IA e para você.
- **Regras exclusivas do modo autônomo → `.claude/agents/executor-spec-sdd.md` e `.claude/skills/executar-specs-pendentes/SKILL.md`.** Eles remetem ao `ai-instructions.md` para o resto.
- **Informações do projeto real → seção 12 do `ai-instructions.md`, `architecture*.md` e `infraestrutura-testes.md`**, preenchidos na Fase 0.
