# Instruções de Operação — Spec Driven Development

> Este arquivo é direcionado ao **desenvolvedor humano**: como operar o fluxo de Spec Driven Development descrito em `README.md`, fase por fase, no dia a dia.
>
> Para o "porquê" e os conceitos por trás do fluxo, veja `README.md`.
> Para os prompts prontos de cada fase abaixo, veja `prompts.md`.

---

## 1. Fase 1 — Criação da especificação

A primeira etapa é transformar uma ideia em uma `spec.md`.

Nesta fase, a IA deve ajudar a organizar a funcionalidade, mas não deve implementar código.

Use o prompt **"Criar spec.md"** em `prompts.md`.

A IA deve devolver uma especificação organizada e também apontar dúvidas, lacunas e riscos.

---

## 2. Fase 2 — Revisão da especificação

Depois de criar a `spec.md`, a IA deve revisá-la antes de gerar o plano.

Use o prompt **"Revisar spec.md"** em `prompts.md`.

A IA deve atuar como revisora técnica e funcional. Se a spec estiver incompleta, ela deve propor melhorias antes de avançar.

---

## 3. Fase 3 — Criação do plano técnico

Com a spec validada, a IA deve criar o `plan.md`.

Use o prompt **"Criar plan.md"** em `prompts.md`.

O plano deve respeitar a arquitetura existente. A IA não deve propor uma abordagem incompatível com o projeto sem explicar claramente o motivo.

---

## 4. Fase 4 — Criação das tarefas

Depois do `plan.md`, a IA deve quebrar a implementação em tarefas.

Use o prompt **"Criar tasks.md"** em `prompts.md`.

O objetivo do `tasks.md` é evitar que a IA tente implementar tudo de uma vez.

---

## 5. Fase 5 — Preparação para implementação

Antes de desenvolver, a IA deve confirmar que leu os documentos na ordem correta e devolver um resumo do entendimento, antes de escrever qualquer código.

Use o prompt mestre **"Ler arquivos e confirmar entendimento"** em `prompts.md`.

Essa etapa é importante para garantir que a IA entendeu o escopo antes de codar.

---

## 6. Fase 6 — Implementação controlada

A implementação deve seguir o `tasks.md`, tarefa por tarefa.

Use o prompt **"Implementação controlada"** em `prompts.md`.

A IA deve evitar grandes alterações de uma vez. Sempre que tomar uma decisão que não estava explícita no `plan.md` ou no `tasks.md` — escolher entre abordagens, desviar do plano, preencher uma lacuna da spec — a IA deve parar e adicionar uma entrada no `build-logs.md` antes de continuar. Isso vale mesmo para decisões pequenas, se elas não forem óbvias só de olhar o código depois.

O ideal é implementar em blocos:

1. banco de dados;
2. backend;
3. frontend;
4. integrações;
5. testes;
6. documentação.

Nem toda feature exige todos esses blocos.

---

## 7. Fase 7 — Validação contra a spec

Após implementar, a IA deve revisar o resultado contra os critérios de aceite.

Use o prompt **"Validar contra a spec"** em `prompts.md`.

A entrega só deve ser considerada finalizada quando os critérios de aceite forem atendidos.

---

## 8. Fase 8 — Atualização da documentação

Se durante a implementação houver mudança de decisão, regra ou comportamento, a documentação precisa ser atualizada.

Arquivos que podem precisar de atualização:

```txt
spec.md
plan.md
tasks.md
architecture.md
build-logs.md
README.md
CHANGELOG.md
API.md
```

A IA deve atualizar a documentação quando:

- uma regra de negócio mudar;
- um endpoint for criado ou alterado;
- uma tabela nova for adicionada;
- uma decisão técnica relevante for tomada;
- houver mudança no fluxo da funcionalidade;
- alguma limitação importante for descoberta.

Use o prompt **"Atualizar documentação"** em `prompts.md`.

---

## 9. Regras obrigatórias para a IA

Estas regras devem ser seguidas sempre que a IA for usada para desenvolver.

### 9.1 Nunca começar pelo código

A IA não deve gerar código antes de entender a spec, o plano e as tarefas.

### 9.2 Sempre respeitar a arquitetura

A IA deve seguir o `architecture.md` como fonte de verdade técnica.

Se for necessário fugir da arquitetura, ela deve justificar e pedir validação humana.

### 9.3 Não inventar regra de negócio

Se uma regra não estiver na `spec.md`, a IA não deve inventar silenciosamente.

Ela deve registrar a dúvida e propor uma decisão.

### 9.4 Não ampliar escopo sem autorização

A IA não deve transformar uma tarefa simples em uma reestruturação grande.

Se identificar oportunidade de melhoria, deve sugerir separadamente.

### 9.5 Implementar em blocos pequenos

A IA deve evitar alterações grandes e difíceis de revisar.

Cada bloco deve ter objetivo claro.

### 9.6 Validar antes de finalizar

Toda entrega deve ser conferida contra os critérios de aceite.

### 9.7 Atualizar documentação quando necessário

Se o código final divergir do plano, a documentação precisa ser atualizada.

### 9.8 Registrar toda decisão relevante no build-logs.md

A IA não deve codar sem freio. Toda decisão técnica que não estava 100% explícita no `plan.md` ou no `tasks.md` — escolha entre abordagens, desvio de plano, preenchimento de lacuna da spec, introdução de dependência nova — deve ser registrada no `build-logs.md` com o motivo, no momento em que é tomada.

Sem esse registro, o desenvolvedor não tem como saber o que foi decidido e por quê depois que a implementação termina.

---

## 10. Checklist de qualidade antes de codar

Antes da implementação, confirme:

```md
- [ ] A feature tem uma spec.md clara
- [ ] As regras de negócio estão documentadas
- [ ] Existem critérios de aceite objetivos
- [ ] O fora de escopo está definido
- [ ] O plan.md respeita a arquitetura
- [ ] O tasks.md está quebrado em tarefas pequenas
- [ ] A IA leu ai-instructions.md
- [ ] A IA leu architecture.md
- [ ] A IA entendeu a ordem de implementação
```

Se qualquer item estiver fraco, melhore os documentos antes de codar.

---

## 11. Checklist de qualidade depois de codar

Depois da implementação, confirme:

```md
- [ ] Todas as tarefas do tasks.md foram concluídas
- [ ] Todos os critérios de aceite da spec.md foram cumpridos
- [ ] As regras de negócio foram respeitadas
- [ ] As permissões foram implementadas corretamente
- [ ] Os casos de erro foram tratados
- [ ] A interface possui estados de loading, erro, vazio e sucesso quando necessário
- [ ] O backend valida os dados corretamente
- [ ] Os testes necessários foram executados
- [ ] A documentação foi atualizada quando necessário
- [ ] Não houve alteração fora do escopo sem justificativa
- [ ] O build-logs.md contém as decisões relevantes tomadas durante a implementação
```

---

## 12. Vibe coding e modelo mental — lembrete

Dois pontos do `README.md` valem ser revisados sempre que o fluxo parecer estar sendo abandonado:

- **Como evitar vibe coding** (`README.md`, seção 8): a regra central é que nada deve ser implementado silenciosamente fora da spec, e toda decisão tomada durante a implementação precisa estar no `build-logs.md`.
- **Modelo mental do fluxo** (`README.md`, seção 9): cada arquivo representa uma camada de contrato — comportamento da IA, arquitetura, spec, plano, execução e memória de decisões — e a IA só deve codar depois que essas camadas estiverem claras.

Se você, como desenvolvedor, perceber que a IA está pulando etapas, gerando código sem plano ou inventando regras, volte para esses dois pontos antes de continuar.
