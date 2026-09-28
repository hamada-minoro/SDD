# Tasks: Nome da Feature

## Preparação

> Leia **somente** os arquivos desta lista. As arquiteturas de projeto são as da tabela "Projetos e arquiteturas envolvidos" da `spec.md`: escreva um item por arquivo, com o caminho real. Não leia `architecture-*.md` de projetos que não estão aqui.

- [ ] Ler .ai/ai-instructions.md
- [ ] Ler .ai/architecture.md (mapa do ecossistema)
- [ ] Ler .ai/infraestrutura-testes.md
- [ ] Se houver jornada frontend + backend, ler .ai/teste-usuario-frontend-backend.md
- [ ] Ler spec.md
- [ ] Ler .ai/architecture-pasta-do-projeto.md
- [ ] Ler plan.md
- [ ] Confirmar leitura do build-logs.md desta feature (decisões anteriores)

## Banco de dados

- [ ] Criar migration necessária
- [ ] Atualizar schema/modelos
- [ ] Validar relacionamentos

## Backend

- [ ] Criar DTOs
- [ ] Criar validações
- [ ] Criar service
- [ ] Criar controller/route
- [ ] Implementar permissões
- [ ] Tratar erros
- [ ] Criar testes

## Frontend

- [ ] Criar tela ou página
- [ ] Criar componentes
- [ ] Integrar com API
- [ ] Implementar loading
- [ ] Implementar estado vazio
- [ ] Implementar estado de erro
- [ ] Implementar feedback de sucesso
- [ ] Validar responsividade

## Validação

- [ ] Conferir regras de negócio
- [ ] Conferir permissões
- [ ] Conferir critérios de aceite
- [ ] Conferir casos de erro
- [ ] Executar testes
- [ ] Se houver jornada frontend + backend, preencher e executar plano-teste-usuario.md, registrar evidências seguras e confirmar o resultado por leitura no backend
- [ ] Se houver jornada frontend + backend, atualizar tests.md e review.md com cobertura, bloqueios, dados criados e limpeza

## Documentação

- [ ] Atualizar spec.md, se necessário
- [ ] Atualizar plan.md, se necessário
- [ ] Atualizar README/API/CHANGELOG, se necessário
- [ ] Confirmar que toda decisão relevante está registrada no build-logs.md desta feature
