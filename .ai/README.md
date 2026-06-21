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

O fluxo base deste projeto usa seis arquivos principais:

```txt
ai-instructions.md
architecture.md
spec.md
plan.md
tasks.md
build-logs.md
```

Cada um possui uma função específica dentro do processo.

Os cinco primeiros guiam o que será construído e como. O `build-logs.md` registra o que de fato aconteceu durante a construção: cada decisão técnica relevante, cada desvio do plano e o motivo por trás deles. É o que garante que o desenvolvedor humano tenha rastreabilidade total sobre o trabalho da IA, mesmo sem ter acompanhado a implementação em tempo real.

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
├── .ai/
│   ├── README.md
│   ├── INSTRUCTIONS.md
│   ├── prompts.md
│   ├── ai-instructions.md
│   ├── build-logs.md
│   ├── architecture.md
│   └── specs/
│       └── nome-da-feature/
│           ├── spec.md
│           ├── plan.md
│           └── tasks.md
└── src/
```

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

### 4.2 `architecture.md`

Este arquivo descreve a arquitetura do projeto.

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

### 4.6 `build-logs.md`

Este é o diário de decisões da implementação.

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
1. ai-instructions.md
2. architecture.md
3. spec.md
4. plan.md
5. tasks.md
6. build-logs.md (se já existir, para entender decisões anteriores)
```

A ordem importa.

Motivo:

1. `ai-instructions.md` define como a IA deve trabalhar.
2. `architecture.md` define os limites técnicos do projeto.
3. `spec.md` define o que precisa ser construído.
4. `plan.md` define como construir.
5. `tasks.md` define a ordem de execução.
6. `build-logs.md` mostra o que já foi decidido antes, evitando que a IA repita discussões ou contradiga decisões já tomadas.

A IA não deve iniciar implementação se não tiver lido os arquivos necessários.

---

## 6. Fluxo completo de trabalho

O fluxo ideal é:

```txt
Setup do projeto (analisar arquitetura real e gerar architecture.md)
        ↓
Ideia ou necessidade
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
IA registra decisões relevantes no build-logs.md
        ↓
IA testa e valida contra a spec
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
```

A IA só deve codar depois que esses níveis estiverem claros, e deve manter o `build-logs.md` atualizado enquanto codifica — é o que permite ao desenvolvedor entender, depois, tudo o que aconteceu e por quê.

---

## 10. Conclusão

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
