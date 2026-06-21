# Prompts — Spec Driven Development

> Biblioteca de prompts prontos para cada fase do fluxo descrito em `README.md` e `INSTRUCTIONS.md`.
>
> Use os prompts na ordem das fases. Substitua qualquer trecho entre `[colchetes]` pelo conteúdo real da sua feature ou pelos caminhos reais dos arquivos no projeto.

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

## 2. Criar `spec.md`

Use na Fase 1. A IA não deve gerar código nesta etapa.

```txt
Quero criar uma nova funcionalidade seguindo Spec Driven Development.
Antes de codar, me ajude a criar uma spec.md completa.

Contexto da feature:
[descreva aqui]

Objetivo:
[descreva aqui]

Regras conhecidas:
[descreva aqui]

Me ajude a transformar isso em uma spec.md com:
- contexto
- problema
- objetivo
- usuários envolvidos
- fluxo funcional
- regras de negócio
- permissões
- validações
- telas
- dados necessários
- casos de erro
- critérios de aceite
- fora de escopo

Não gere código neste momento.
```

---

## 3. Revisar `spec.md`

Use na Fase 2, depois que a primeira versão da spec já existe.

```txt
Leia a spec.md abaixo e faça uma revisão crítica.

Quero que você aponte:
- ambiguidades
- regras de negócio incompletas
- riscos de implementação
- fluxos não tratados
- critérios de aceite fracos
- possíveis conflitos com a arquitetura

Não gere código ainda.
```

---

## 4. Criar `plan.md`

Use na Fase 3, com a spec já validada.

```txt
Com base na spec.md e na architecture.md, crie um plan.md técnico para implementação.

O plano deve conter:
- resumo da solução
- alterações no backend
- alterações no frontend
- alterações no banco de dados
- endpoints necessários
- componentes necessários
- serviços afetados
- validações
- testes necessários
- riscos técnicos
- ordem recomendada de implementação

Não implemente código ainda.
```

---

## 5. Criar `tasks.md`

Use na Fase 4, com o plano já pronto.

```txt
Com base na spec.md e no plan.md, crie um tasks.md com uma checklist de implementação.

As tarefas devem ser pequenas, objetivas e organizadas por área:
- banco de dados
- backend
- frontend
- integrações
- testes
- documentação
- validação final

Não implemente código ainda.
```

---

## 6. Prompt mestre — Ler arquivos e confirmar entendimento

Use na Fase 5, sempre que `spec.md`, `plan.md` e `tasks.md` já estiverem prontos (ou parcialmente prontos) e você quiser que a IA leia tudo, confirme entendimento e só então comece a implementar.

Substitua os caminhos entre `[colchetes]` pelos caminhos reais dos arquivos da feature no seu projeto.

```txt
Você vai atuar como engenheira de software auxiliar, seguindo rigorosamente a
metodologia de Spec Driven Development descrita nos arquivos README.md e
INSTRUCTIONS.md deste projeto.

Antes de qualquer linha de código, você deve ler — nesta ordem exata — os
seguintes arquivos:

1. ai-instructions.md          → [caminho/para/ai-instructions.md]
2. architecture.md             → [caminho/para/architecture.md]
3. spec.md                     → [caminho/para/spec.md]
4. plan.md                     → [caminho/para/plan.md]
5. tasks.md                    → [caminho/para/tasks.md]
6. build-logs.md               → [caminho/para/build-logs.md] (se já existir)

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

## Regras obrigatórias

1. Não comece a codar antes de ler todos os arquivos listados acima.
2. Não implemente nada que não esteja descrito na spec.md.
3. Não ignore ou contrarie o architecture.md sem justificar explicitamente
   e pedir validação antes de prosseguir.
4. Siga o plan.md como guia técnico. Se identificar que o plano está
   desatualizado ou incompleto, pare e proponha um ajuste antes de seguir.
5. Implemente seguindo a ordem do tasks.md, tarefa por tarefa, em blocos
   pequenos e revisáveis (ex.: banco de dados → backend → frontend →
   integrações → testes → documentação).
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

## 7. Implementação controlada

Use na Fase 6, depois que a IA já confirmou o entendimento com o prompt acima.

```txt
Agora implemente seguindo o tasks.md.

Regras obrigatórias:
- siga a ordem das tarefas
- não implemente nada fora da spec.md
- respeite architecture.md
- não altere padrões existentes sem justificar
- se encontrar uma lacuna, pare e proponha atualização da spec ou do plan
- ao concluir cada bloco, explique brevemente o que foi feito
- registre toda decisão técnica relevante no build-logs.md, com o motivo
```

---

## 8. Variante curta — continuar feature já em andamento

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

## 9. Validar contra a spec

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
```

---

## 10. Atualizar documentação

Use na Fase 8, sempre que o que foi implementado divergir do que estava documentado.

```txt
Atualize a documentação da feature com base no que foi realmente implementado.

Verifique se spec.md, plan.md e tasks.md continuam coerentes com o código final.

Se algo mudou durante o desenvolvimento, registre a decisão e explique o motivo.
```
