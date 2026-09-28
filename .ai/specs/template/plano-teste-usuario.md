# Plano de teste de usuário: Nome da Feature

> Preencha para specs com jornada frontend + backend. Siga `.ai/teste-usuario-frontend-backend.md` e `.ai/infraestrutura-testes.md`. Não registre valores de credenciais nem dados pessoais reais.

## 0. Regras desta execução

- Ambiente de teste/homologação e prova de que frontend e APIs apontam para ele:
- Operações permitidas e escopo da autorização atual:
- Passos 🔒 que gravam ou geram efeitos externos:
- Ações irreversíveis que exigem aprovação específica:
- Variáveis exigidas no `.env` local, **somente nomes**:

| Nome da variável | Uso | Como verificar sem exibir o valor |
|---|---|---|
| `TEST_FRONT_URL` | URL do frontend de teste | |

## 0.A Onde paramos e como retomar

| Seção/passo | Situação | Evidência/ID criado | Próxima ação |
|---|---|---|---|
| | Não iniciado | | |

- Autorizações já recebidas (passos exatos e escopo):
- Gravações executadas e estado atual dos dados:
- Ordem exata de retomada, sem repetir gravações:

## 1. Pré-requisitos

| Item | Como verificar neste projeto | Situação em AAAA-MM-DD |
|---|---|---|
| Ambiente remoto disponível, se houver | | |
| Branch e `git status` de cada projeto | | |
| Runtime e dependências | | |
| Configuração do frontend e APIs para teste | | |
| Portas e health checks | | |
| Conta e permissões de teste | | |
| `agent-browser` instalado e funcional | | |

## 2. Evidências

- Pasta: `.ai/specs/NNN-feature/evidencias/`
- Diário: `evidencias/00-registro-execucao.md`
- Padrão dos nomes: `NN-passo-descricao.png` ou `.txt` mascarado.
- Dados preparados: `evidencias/dados-teste/` (backup, rollback e IDs).

## 3. Configuração temporária e reversão

- Como apontar frontend e APIs para teste:
- Como confirmar o destino:
- Como desfazer e verificar o diff final:

## 4. Subir e verificar a stack

| Serviço | Comando verificado | Health check / resultado esperado | Como encerrar |
|---|---|---|---|
| Frontend | | | |
| Backend/API | | | |

## 5. Dados de teste

| Dado necessário | Origem | Preparação/backup | ID ou referência | Rollback |
|---|---|---|---|---|
| | | | | |

## 6. Login

- URL de teste:
- Sessão nomeada e modo `--headed` (ou justificativa para headless):
- Campos e botão localizados por `snapshot -i`:
- Print anterior ao preenchimento de segredo:
- Como confirmar login sem exibir token:

## 7. Passos da jornada

> Acrescente uma tabela por tela ou etapa. Use o texto/estado literal esperado e IDs existentes na `spec.md`. Marque 🔒 antes da ação que grava. Indique a leitura do backend que confirma o resultado.

| Passo | Ação concreta | Esperado | Evidência | Cobre (RN/CA) | Confirmação no backend |
|---|---|---|---|---|---|
| 7.1 | | | `01-descricao.png` | CA01 | |
| 7.2 🔒 | | | `02-descricao.png` | RN01, CA02 | |

## Falhas e observações

| ID | Passo | Esperado | Obtido (mensagem exata) | Evidência | Tipo (defeito/ambiente/dado/observação) | Encaminhamento |
|---|---|---|---|---|---|---|
| | | | | | | |

## Checklist de evidências

- [ ] Cada passo executado tem resultado observado e evidência segura.
- [ ] Escritas e IDs criados estão no diário.
- [ ] Dados pessoais e segredos foram omitidos ou mascarados.
- [ ] Passos bloqueados e cobertura não provada estão identificados.

## Encerramento e limpeza

- [ ] Fechar sessão do navegador e processos iniciados.
- [ ] Reverter configuração temporária e conferir `git diff`/`git status`.
- [ ] Limpar apenas dados criados neste teste e autorizados; registrar pendências.
- [ ] Atualizar `tests.md` por RN/CA e acrescentar entrada em `review.md`.
- [ ] Registrar fatos novos verificados em `.ai/infraestrutura-testes.md`.
