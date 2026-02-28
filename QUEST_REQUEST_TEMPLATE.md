# Quest Request Template

Use este documento para solicitar novas quests com padrao tecnico e criterio de aceite.

## 1) Identificacao
- Nome da quest:
- Tipo: `Entrega` | `Coleta` | `Abate` | `Conversa` | `Cadeia`
- Prioridade: `Alta` | `Media` | `Baixa`
- Responsavel:
- Data alvo:

## 2) IDs Tecnicos
- `sid` inicio (`DefineMission` no NPC de origem):
- `sid` conclusao (`DefineMission` com `COMPLETE_SHOW` no NPC de destino):
- `misid/record` (estado real da missao):
- Observacao: validar faixa de `record` suportada antes de implementar.

## 3) NPCs e Mapa
- NPC inicial:
- Coordenada inicial:
- NPC final:
- Coordenada final:
- Mapa(s):

## 4) Pre-requisitos
- Nivel minimo:
- Classe/profissao:
- Quests anteriores (records):
- Itens obrigatorios:
- Gold obrigatorio:
- Espaco minimo de bag:

## 5) Fluxo da Quest
- Inicio (texto do NPC):
- Objetivo (descricao clara):
- Condicoes de progresso:
- Condicoes de falha/cancelamento:
- Conclusao (texto do NPC):

## 6) Recompensas
- EXP:
- Gold:
- Itens:
- Flags/Records liberados:
- Missao seguinte desbloqueada:

## 7) Regras de Balanceamento
- Tempo medio esperado (min):
- Dificuldade alvo:
- Frequencia: `Unica` | `Repetivel` | `Diaria`
- Anti-exploit (limites/validacoes):

## 8) Implementacao Esperada
- Arquivo de missao: `Resource/script/MisScript/MissionScript0X.lua`
- NPC de origem: `Resource/script/MisScript/NpcScript01.lua`
- NPC de destino: `Resource/script/MisScript/NpcScript01.lua`
- Regras extras (se houver): `Resource/script/calculate/functions.lua` ou `Resource/script/calculate/ItemEffect.lua`

## 9) Criterios de Aceite (QA)
- Quest aparece no NPC inicial.
- Aceita sem erro de `record index`.
- Progresso atualiza corretamente.
- Entrega conclui e consome itens esperados.
- Recompensas corretas aplicadas.
- Persistencia apos relog/restart.
- Sem erro novo em logs.

## 10) Evidencias
- Print da aceitacao:
- Print do progresso:
- Print da conclusao:
- Trecho de log (se necessario):

## 11) Convencao de IDs (recomendado)
- Reservar faixa por feature (exemplo: `sid` `7000-7099`).
- Separar `sid` (UI/script) de `misid` (estado/record).
- Registrar no changelog interno as faixas ja usadas.

## 12) Checklist de Entrega para Dev
- [ ] IDs conferidos e sem conflito.
- [ ] NPC inicial e final com `AddNpcMission` correto.
- [ ] `MisListPage` validado no NPC.
- [ ] Condicoes de inicio/entrega revisadas.
- [ ] Recompensas revisadas.
- [ ] Teste local completo feito.
- [ ] Log sem erro apos implementacao.
