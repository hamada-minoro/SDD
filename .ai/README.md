# Manual de Spec Driven Development com IA

> Arquivo de contexto sobre o que é Spec Driven Development com IA e por que este projeto é organizado desta forma.
>
> Para orientações de comportamento da IA, veja `ai-instructions.md`.
> Para o passo a passo de como operar o fluxo no dia a dia, veja `INSTRUCTIONS.md`.
> Para os prompts prontos de cada etapa, veja `prompts.md`.
>
> Objetivo: impedir o desenvolvimento por tentativa, improviso ou *vibe coding*, obrigando a IA a entender o contexto, ler os documentos certos, planejar, quebrar tarefas e só então implementar.

---

## 1. Visão geral

Spec Driven Development com IA é um fluxo onde a implementação nasce de documentos estruturados, não de prompts soltos.

A IA não deve começar codando. Ela deve primeiro entender:

1. o contexto do projeto;
2. a arquitetura existente;
3. as regras de desenvolvimento;
4. a especificação da funcionalidade;
5. o plano técnico;
6. a lista de tarefas;
7. os critérios de aceite.

Somente depois disso a IA pode iniciar a implementação.

O fluxo base deste projeto usa oito arquivos principais. Os dois primeiros são globais do projeto (ficam na raiz de `.ai/`); os outros seis são **por feature** e ficam na pasta da spec (`.ai/specs/NNN-nome-da-feature/`):

```txt
ai-instructions.md
architecture.md
spec.md
plan.md
tasks.md
build-logs.md
tests.md
review.md
```

Cada um possui uma função específica dentro do processo.

Os cinco primeiros (`ai-instructions.md` a `tasks.md`) guiam o que será construído e como. O `build-logs.md` registra o que de fato aconteceu durante a construção: cada decisão técnica relevante, cada desvio do plano e o motivo por trás deles. O `tests.md` documenta os testes unitários (e de integração) escritos para a feature, cruzando cada teste com a regra de negócio ou critério de aceite que ele cobre. O `review.md` registra o resultado de cada validação da implementação contra a `spec.md`. Juntos, `build-logs.md`, `tests.md` e `review.md` dão ao desenvolvedor rastreabilidade total sobre o trabalho da IA, mesmo sem ter acompanhado a implementação em tempo real.

---

## 2. Objetivo do fluxo

Este fluxo existe para que a IA trabalhe como uma engenheira auxiliar, e não como uma geradora aleatória de código.

A finalidade é garantir que toda feature tenha:

- contexto claro;
- regras de negócio documentadas;
- arquitetura respeitada;
- plano técnico antes da implementação;
- tarefas pequenas e rastreáveis;
- critérios de aceite objetivos;
- validação antes de considerar a entrega finalizada.

O desenvolvimento deve ser guiado por documentos, não por tentativa e erro.

---

## 3. Estrutura recomendada de arquivos

A estrutura é organizada na pasta do projeto dentro de `.ai/`. Basta copiar esta pasta para qualquer projeto novo para já começar com o framework pronto.

```txt
projeto/
├── AGENTS.md                          # porta de entrada para qualquer agente de IA: manda ler .ai/ antes de tudo
├── CLAUDE.md                          # só importa o AGENTS.md (@AGENTS.md), para o Claude Code
├── .ai/
│   ├── README.md
│   ├── INSTRUCTIONS.md
│   ├── prompts.md
│   ├── ai-instructions.md
│   ├── architecture.md                # visão geral; em raiz multiprojeto, o mapa do ecossistema
│   ├── architecture-<projeto>.md      # obrigatório em raiz multiprojeto: um por pasta de projeto
│   ├── infraestrutura-testes.md       # referência verificada do ambiente local de testes
│   └── specs/
│       ├── template/                  # modelos dos arquivos de feature — copie para criar uma feature
│       │   ├── spec.md
│       │   ├── plan.md
│       │   ├── tasks.md
│       │   ├── build-logs.md
│       │   ├── tests.md
│       │   └── review.md
│       ├── concluidos/                # specs finalizadas e aprovadas são movidas para cá (mantêm o número)
│       │   └── 001-nome-da-feature/
│       └── 002-nome-da-feature/       # uma pasta numerada por feature pendente/em andamento
│           ├── spec.md
│           ├── plan.md
│           ├── tasks.md
│           ├── build-logs.md
│           ├── tests.md
│           └── review.md
├── .claude/                           # opcional — automação para Claude Code (ver .claude/README.md)
│   ├── agents/executor-spec-sdd.md
│   └── skills/executar-specs-pendentes/
└── src/
```

Sobre as peças além do fluxo base:

- **`architecture-<projeto>.md`**: obrigatório quando a raiz agrupa vários projetos (seção 3.2). Existe um arquivo por projeto, com o nome da pasta do projeto (ex.: `architecture-api-pedidos.md`). A IA lê o `architecture.md` geral e depois só os arquivos dos projetos que a feature toca.
- **`infraestrutura-testes.md`** — memória verificada do ambiente local de testes (portas reais, containers, como subir a stack, limitações conhecidas). Evita que cada sessão de IA redescubra — ou pior, assuma errado — como rodar testes de integração/E2E.
- **`AGENTS.md` / `CLAUDE.md`** (na raiz do projeto) — o `AGENTS.md` é lido automaticamente pelos agentes de IA e os obriga a começar por este `README.md`, criar spec/plan/tasks quando a tarefa ainda não tem spec e ler os arquivos obrigatórios quando ela já tem. O `CLAUDE.md` só contém `@AGENTS.md`, para garantir a leitura no Claude Code.
- **`specs/template/`** — os modelos dos seis arquivos de feature (`spec.md`, `plan.md`, `tasks.md`, `build-logs.md`, `tests.md`, `review.md`). Para criar uma feature, copie a pasta e renomeie seguindo a numeração (seção 3.1). A automação também usa esses modelos quando precisa gerar `plan.md`/`tasks.md`.
- **`specs/concluidos/`** — ciclo de vida das specs: pendente (em `specs/`) → aprovada na validação → movida para `concluidos/`. A fila de pendências é simplesmente o que ainda está em `specs/`, na ordem numérica.

### 3.1 Numeração das specs

Toda pasta de feature começa com um número sequencial de 3 dígitos: `NNN-nome-da-feature` (ex.: `001-login`, `002-recuperar-senha`). **O número define a ordem de execução**: a fila de pendências é sempre processada do menor número para o maior, seja manualmente, seja pela automação da `.claude/`.

Ao criar uma feature nova:

1. Procure o maior número já usado **nas duas** pastas, `.ai/specs/` e `.ai/specs/concluidos/`:

   ```bash
   ls -1 .ai/specs .ai/specs/concluidos 2>/dev/null | grep -E '^[0-9]+-' | sed -E 's/^([0-9]+)-.*/\1/' | sort -n | tail -1
   ```

2. Use o número seguinte, com 3 dígitos (`007` → `008`). Sem nenhuma spec, comece em `001`.
3. Nunca reutilize um número (nem de spec concluída) e nunca renumere specs existentes. Se uma feature precisar rodar antes de outra já criada, ajuste a dependência na spec em vez de trocar números.

Pastas sem prefixo numérico não entram na fila automática. Renomeie-as seguindo a sequência.

### 3.2 Raiz com vários projetos (microsserviços, APIs e frontends separados)

É comum instalar `.ai/` e `.claude/` numa **pasta raiz que agrupa vários projetos** do mesmo ecossistema: APIs, frontends, workers, lambdas, microsserviços ou projetos complementares, muitas vezes cada um com seu próprio repositório git. Nesse cenário a arquitetura é documentada em dois níveis, e **os dois são obrigatórios**:

```txt
raiz-do-ecossistema/
├── AGENTS.md
├── CLAUDE.md
├── .ai/
│   ├── architecture.md                    # mapa do ecossistema
│   ├── architecture-api-pedidos.md        # um por projeto da raiz
│   ├── architecture-api-pagamentos.md
│   ├── architecture-web-admin.md
│   └── ...
├── .claude/
├── api-pedidos/                           # projeto (repositório próprio ou não)
├── api-pagamentos/
└── web-admin/
```

- **`architecture.md` é o mapa do ecossistema.** Traz a tabela de projetos (pasta, tipo, stack, repositório, arquivo de arquitetura), como eles se comunicam (APIs, eventos, filas, banco compartilhado), os contratos entre eles e os conceitos comuns, como autenticação e padrões transversais. Os detalhes internos de cada projeto não ficam aqui.
- **`architecture-<projeto>.md` descreve um projeto.** Existe **um arquivo para cada projeto da raiz**, e `<projeto>` é **exatamente o nome da pasta** do projeto (`api-pedidos/` → `architecture-api-pedidos.md`). Ele traz stack, estrutura de pastas, padrões, banco, testes e restrições daquele projeto, usando as mesmas seções do modelo `architecture.md`.
- **Projeto sem arquivo de arquitetura não recebe feature.** Se uma spec toca um projeto que ainda não tem `architecture-<projeto>.md`, gere esse arquivo primeiro (prompt "0. Setup" de `prompts.md`, focado no projeto novo) e inclua o projeto na tabela do `architecture.md`.
- **Projeto novo na raiz = arquivo novo.** Ao adicionar um projeto à raiz, crie o `architecture-<projeto>.md` dele e atualize o mapa do ecossistema antes da primeira spec que o toque.
- **A spec diz quais projetos e arquiteturas entram.** A tabela "Projetos e arquiteturas envolvidos" da `spec.md` lista cada projeto que a feature altera e o arquivo de arquitetura dele. O `plan.md` repete essa tabela com a ordem entre os projetos, e a "Preparação" do `tasks.md` lista os arquivos a ler, um por item. Essa tabela também define em quais repositórios a automação cria branches.
- **Contexto mínimo: a IA lê só o que vai mexer.** Para executar uma feature, a IA lê o `architecture.md` (o mapa) e **apenas** os `architecture-<projeto>.md` da tabela da spec. Nunca lê as arquiteturas de todos os projetos "por garantia": isso polui o contexto e piora a execução. Se durante a execução aparecer a necessidade de mexer num projeto fora da tabela, a IA para, atualiza spec/plan/tasks, registra a decisão no `build-logs.md` da feature e só então lê a arquitetura desse projeto.

Em um projeto único (um só repositório na raiz), basta o `architecture.md`, sem arquivos por projeto.
- **`.claude/`** — camada opcional de execução autônoma para o Claude Code (ver seção 10 e `.claude/README.md`).

---

## 4. Função de cada arquivo

### 4.1 `ai-instructions.md`

Este é o arquivo de comportamento da IA.

Ele define como a IA deve agir dentro do projeto.

Deve conter:

- papel da IA no projeto;
- regras de desenvolvimento;
- padrões de resposta;
- o que a IA pode ou não pode fazer;
- ordem obrigatória de leitura dos arquivos;
- regras para alteração de código;
- regras para atualização de documentação;
- instruções para testes e validação.

Este arquivo é o mais parecido com um `CLAUDE.md`.

A IA deve ler este arquivo antes de qualquer tarefa relevante.

---

### 4.2 `architecture.md` (e `architecture-<projeto>.md`)

Este arquivo descreve a arquitetura do projeto. Em raiz com vários projetos, ele vira o mapa do ecossistema e cada projeto tem o seu `architecture-<projeto>.md` com o conteúdo abaixo (seção 3.2).

Ele responde à pergunta:

> Como o sistema está organizado tecnicamente?

Deve conter:

- stack utilizada;
- estrutura de pastas;
- arquitetura do backend;
- arquitetura do frontend;
- padrão de autenticação;
- padrão de autorização;
- banco de dados;
- integrações externas;
- filas, workers e jobs, se existirem;
- padrões de módulos;
- padrões de nomenclatura;
- decisões arquiteturais importantes;
- restrições técnicas.

A IA deve usar este arquivo para evitar criar soluções fora do padrão do projeto.

---

### 4.3 `spec.md`

Este arquivo descreve o que deve ser construído.

Ele responde à pergunta:

> Qual problema estamos resolvendo e qual comportamento a feature precisa ter?

Deve conter:

- contexto da funcionalidade;
- problema que será resolvido;
- objetivo da feature;
- usuários envolvidos;
- fluxo funcional esperado;
- regras de negócio;
- permissões;
- validações;
- telas envolvidas;
- dados necessários;
- estados da interface;
- mensagens de erro;
- critérios de aceite;
- casos de borda;
- fora de escopo.

A `spec.md` não deve focar inicialmente em código. Ela deve focar no comportamento esperado da funcionalidade.

---

### 4.4 `plan.md`

Este arquivo transforma a especificação em plano técnico.

Ele responde à pergunta:

> Como vamos implementar isso respeitando a arquitetura existente?

Deve conter:

- resumo técnico da solução;
- impacto no backend;
- impacto no frontend;
- impacto no banco de dados;
- novos endpoints;
- novos componentes;
- serviços ou módulos alterados;
- migrations necessárias;
- integrações;
- riscos técnicos;
- dependências;
- estratégia de testes;
- ordem sugerida de implementação.

A diferença central é:

```txt
spec.md = o que precisa existir
plan.md = como isso será construído
```

---

### 4.5 `tasks.md`

Este arquivo quebra o plano em tarefas pequenas e executáveis.

Ele responde à pergunta:

> Quais passos objetivos precisam ser feitos para concluir a feature?

Deve conter uma checklist clara, organizada por área (banco de dados, backend, frontend, integrações, testes, documentação, validação final).

A IA deve implementar seguindo essa ordem, marcando o progresso conforme avança.

---

### 4.6 `tests.md`

Este arquivo documenta os testes unitários (e de integração, quando aplicável) escritos para a feature.

Ele responde à pergunta:

> O que foi testado, como, e isso cobre as regras de negócio da spec?

Deve conter:

- referência de qual regra de negócio ou critério de aceite cada teste cobre;
- cenário testado e resultado esperado;
- status do teste (passou, falhou, pendente);
- casos de borda cobertos e não cobertos (com o motivo, quando não cobertos).

A IA deve atualizar este arquivo durante o bloco "Testes" da implementação (item 5 da ordem sugerida em `tasks.md`/`plan.md`), e ele serve de insumo para a revisão registrada em `review.md`.

---

### 4.7 `review.md`

Este arquivo registra o histórico de validações da implementação contra a `spec.md`.

Ele responde à pergunta:

> O que foi entregue realmente cumpre o que a spec pedia?

Diferente de `spec.md`, `plan.md` e `tasks.md` (escritos antes de codar), `review.md` é escrito *depois* — uma entrada nova a cada execução da validação (Fase 7), sem sobrescrever entradas anteriores. Cada entrada deve registrar:

- data da revisão;
- critérios de aceite cumpridos e não cumpridos;
- regras de negócio cobertas e não cobertas;
- casos de erro e permissões verificados;
- se os testes em `tests.md` cobrem o que foi revisado;
- pendências encontradas;
- conclusão: aprovada, aprovada com pendências, ou reprovada.

Sem o `review.md`, cada validação fica só na conversa com a IA e se perde — o desenvolvedor não tem como comparar revisões ao longo do tempo nem provar que a entrega foi de fato conferida contra a spec.

---

### 4.8 `build-logs.md`

Este é o diário de decisões da implementação. Cada feature tem o **seu próprio** `build-logs.md`, dentro da pasta da spec (`.ai/specs/NNN-nome-da-feature/build-logs.md`), criado a partir de `specs/template/build-logs.md`. Não existe build-logs global: as decisões de uma feature ficam junto da spec, do plano e dos testes dela e acompanham a pasta quando ela vai para `concluidos/`.

Ele responde à pergunta:

> O que realmente aconteceu durante o desenvolvimento, e por quê?

Diferente dos demais arquivos, que são escritos *antes* de codar, o `build-logs.md` é escrito *durante* e *depois*, à medida que decisões são tomadas.

Cada entrada deve registrar:

- data e hora (ou referência da tarefa/bloco em andamento);
- a decisão tomada;
- o motivo da decisão (por que essa opção e não outra);
- alternativas consideradas e descartadas, quando relevante;
- impacto da decisão (arquivos, módulos, comportamento, escopo);
- se a decisão é uma divergência em relação à `spec.md` ou ao `plan.md`, e se essa divergência foi validada com o desenvolvedor.

A IA deve adicionar uma entrada sempre que:

- escolher entre duas ou mais abordagens técnicas possíveis;
- desviar do que estava descrito no `plan.md` ou no `tasks.md`;
- descobrir uma lacuna na `spec.md` e precisar tomar uma decisão para seguir;
- introduzir uma dependência, biblioteca ou padrão novo;
- tomar qualquer decisão que não seria óbvia só de olhar o código depois.

A IA **não** deve usar o `build-logs.md` para narrar o que o código já deixa claro (ex: "criei o arquivo X com a função Y"). O objetivo é registrar o raciocínio, não o diff.

Sem o `build-logs.md`, a IA pode codar livremente e o desenvolvedor perde o porquê de cada escolha — o que é exatamente o tipo de *vibe coding* que este manual existe para evitar.

---

## 5. Ordem obrigatória de leitura pela IA

Antes de desenvolver, a IA deve ler os arquivos nesta ordem:

```txt
Obrigatórios (globais, sempre):
1. ai-instructions.md
2. architecture.md (em raiz multiprojeto: só o mapa do ecossistema)
3. infraestrutura-testes.md

Da feature (pasta .ai/specs/NNN-nome-da-feature/):
4. spec.md (a tabela "Projetos e arquiteturas envolvidos" diz o que ler no passo 5)
5. architecture-<projeto>.md: SOMENTE os listados na tabela da spec, nenhum outro
6. plan.md
7. tasks.md
8. build-logs.md (decisões anteriores desta feature)
9. tests.md (testes já escritos para esta feature)
10. review.md (validações anteriores desta feature)
```

A ordem importa.

Motivo:

1. `ai-instructions.md` define como a IA deve trabalhar.
2. `architecture.md` define os limites técnicos do projeto ou, em raiz multiprojeto, o mapa do ecossistema.
3. `infraestrutura-testes.md` define como o ambiente de testes realmente funciona, para que a IA não assuma portas, containers ou comandos errados.
4. `spec.md` define o que precisa ser construído e quais projetos e arquiteturas estão envolvidos.
5. Cada `architecture-<projeto>.md` listado define os limites do projeto que será alterado. Ler só esses mantém o contexto enxuto.
6. `plan.md` define como construir.
7. `tasks.md` define a ordem de execução.
8. `build-logs.md` mostra o que já foi decidido antes nesta feature, evitando que a IA repita discussões ou contradiga decisões já tomadas.
9. `tests.md` mostra o que já foi testado, evitando testes duplicados e mostrando lacunas de cobertura.
10. `review.md` mostra o que já foi validado contra a spec antes, evitando repetir uma revisão do zero.

Se a tarefa ainda não tem spec, a IA lê os três obrigatórios, usa o mapa do `architecture.md` para decidir quais projetos a feature toca e cria a pasta numerada da feature (seção 3.1). A **primeira** coisa que preenche na `spec.md` é a tabela "Projetos e arquiteturas envolvidos". Depois lê só as arquiteturas dessa tabela para escrever `plan.md` e `tasks.md`, que repetem a mesma lista. Nenhum código é escrito antes disso. Essa regra também está no `AGENTS.md` da raiz do projeto.

A IA não deve iniciar implementação se não tiver lido os arquivos necessários.

---

## 6. Fluxo completo de trabalho

O fluxo ideal é:

```txt
Setup do projeto (analisar arquitetura real e gerar architecture.md)
        ↓
Ideia ou necessidade
        ↓
Criar a pasta .ai/specs/NNN-nome-da-feature/ (próximo número da sequência)
        ↓
Criar ou atualizar spec.md
        ↓
Revisar a spec com a IA
        ↓
Criar plan.md
        ↓
Revisar o plano técnico
        ↓
Criar tasks.md
        ↓
IA lê ai-instructions.md
        ↓
IA lê architecture.md
        ↓
IA lê spec.md
        ↓
IA lê plan.md
        ↓
IA lê tasks.md
        ↓
IA implementa tarefa por tarefa
        ↓
IA registra decisões relevantes no build-logs.md da feature
        ↓
IA escreve testes e documenta em tests.md
        ↓
IA valida a entrega contra a spec e registra em review.md
        ↓
IA atualiza documentação se necessário
        ↓
Entrega revisada
```

O passo a passo detalhado de cada uma dessas etapas, com os prompts recomendados, está em `INSTRUCTIONS.md` e `prompts.md`.

---

## 7. Diferença entre os arquivos

Resumo rápido:

| Arquivo | Pergunta que responde | Finalidade |
|---|---|---|
| `ai-instructions.md` | Como a IA deve agir? | Define comportamento, limites e regras da IA |
| `architecture.md` | Como o sistema está organizado? | Define padrões técnicos e arquitetura |
| `spec.md` | O que precisa existir? | Define problema, regras, fluxos e aceite |
| `plan.md` | Como vamos construir? | Define estratégia técnica de implementação |
| `tasks.md` | Quais passos executar? | Define checklist objetiva de desenvolvimento |
| `build-logs.md` | O que aconteceu e por quê? | Registra decisões reais tomadas durante a implementação |
| `tests.md` | O que foi testado? | Documenta testes unitários/integração e sua cobertura sobre a spec |
| `review.md` | A entrega cumpre a spec? | Registra o histórico de validações da implementação contra a spec.md |

---

## 8. Como evitar vibe coding

Vibe coding acontece quando a IA começa a gerar código com base em uma ideia vaga, sem contrato, sem plano e sem validação.

Para evitar isso:

- nunca peça "faz essa feature" sem uma spec;
- nunca aceite código sem entender o plano;
- nunca deixe a IA inventar regra de negócio;
- nunca permita grandes refatorações sem motivo;
- sempre que a IA improvisar, volte para a documentação;
- mantenha `spec.md`, `plan.md` e `tasks.md` como fonte de verdade;
- exija que toda decisão tomada durante a implementação esteja registrada no `build-logs.md` — se a IA decidiu algo e não registrou, é sinal de que codou sem freio.

A regra principal é:

> Se não está na spec, não deve ser implementado silenciosamente. E se foi decidido durante a implementação, precisa estar no build-logs.md.

---

## 9. Modelo mental do fluxo

Pense nos arquivos assim:

```txt
ai-instructions.md  → contrato de comportamento da IA
architecture.md     → mapa técnico do sistema
spec.md             → contrato funcional da feature
plan.md             → estratégia técnica da entrega
tasks.md            → execução controlada passo a passo
build-logs.md       → memória das decisões tomadas durante a entrega
tests.md            → evidência de que o comportamento foi testado
review.md           → memória das validações da entrega contra a spec
```

A IA só deve codar depois que esses níveis estiverem claros, e deve manter o `build-logs.md`, o `tests.md` e o `review.md` atualizados enquanto codifica e valida — é o que permite ao desenvolvedor entender, depois, tudo o que aconteceu, o que foi testado e o que foi conferido contra a spec.

---

## 10. Execução autônoma de specs pendentes (opcional)

Quando o projeto acumula várias specs prontas em `.ai/specs/`, é possível executá-las em lote com a camada de automação da pasta `.claude/` (Claude Code):

- a skill **`/executar-specs-pendentes`** orquestra a fila: calcula a ordem pela numeração das pastas (`001`, `002`, … — seção 3.1), dispara um subagente por spec e, ao final de cada uma, confere o `review.md` — só move para `concluidos/` o que foi **"Aprovada"** sem ressalvas;
- o subagente **`executor-spec-sdd`** executa o ciclo SDD completo de uma única spec, em contexto zerado (sem memória das specs anteriores): leitura obrigatória na ordem da seção 5, decisões no `build-logs.md` da própria spec, `plan.md`/`tasks.md` a partir de `specs/template/` quando faltam, implementação tarefa por tarefa, testes, `review.md` e commit em branch própria (`feat/<slug>` ou `fix/<slug>`);
- guarda-corpos fixos: nunca `git push`, nunca PR, nunca commit na branch padrão, nunca editar os arquivos do framework, e as proibições do `ai-instructions.md` prevalecem sobre a autonomia.

O modo autônomo não substitui o fluxo das seções anteriores — ele o executa. A qualidade do resultado continua dependendo de specs bem escritas e de `architecture.md`/`ai-instructions.md` fiéis ao projeto (Fase 0). Detalhes de uso e revisão pós-rodada em `.claude/README.md`.

---

## 11. Conclusão

Spec Driven Development com IA não é burocracia. É uma forma de dar contexto, direção e limites para a IA.

O objetivo não é escrever documentação por escrever.

O objetivo é garantir que a IA desenvolva como um profissional trabalharia:

1. entendendo o problema;
2. respeitando a arquitetura;
3. planejando a solução;
4. quebrando em tarefas;
5. implementando com controle;
6. validando contra critérios objetivos;
7. registrando decisões importantes.

A IA deve ser usada como aceleradora de engenharia, não como piloto automático.
