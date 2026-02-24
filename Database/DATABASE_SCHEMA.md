# 🧩 Projeto: Bot de Vendas e Suporte (Discord)

## 📦 Módulo 1: Usuários e Cargos (4 Tabelas)

#### **tb_utilizadores — Registo de utilizadores**
| Campo           | Tipo      | Descrição                                     |
| --------------- | --------- | --------------------------------------------- |
| id_discord      | BIGINT    | ID único gerado pelo Discord (chave primária) |
| nome_utilizador | VARCHAR   | Nome exibido no perfil (ex: devmurilo)           |
| tag_discord     | VARCHAR   | Identificador numérico (ex: `#0001`)          |
| data_registo    | TIMESTAMP | Primeira interação com o bot                  |

-------------------------------------------------------------

#### **tb_cargos — Definição dos níveis de acesso**
| Campo            | Tipo    | Descrição                                              |
| ---------------- | ------- | ------------------------------------------------------ |
| id_cargo         | INT     | Identificador interno                                  |
| nome_cargo       | VARCHAR | Ex: Comprador, Vendedor, Suporte, Admin, Comprador Vip |
| id_cargo_discord | BIGINT  | ID real do cargo no servidor                           |

-------------------------------------------------------------


#### **tb_utilizador_cargos — Associação Utilizador × Cargo+**

| Campo      | Tipo   | Descrição                     |
| ---------- | ------ | ----------------------------- |
| id_discord | BIGINT | Referência ao utilizador      |
| id_cargo   | INT    | Referência ao cargo atribuído |

-------------------------------------------------------------

#### **tb_permissoes — Permissões por cargo**
| Campo           | Tipo    | Descrição                                                  |
| --------------- | ------- | ---------------------------------------------------------- |
| id_permissao    | INT     | Identificador da permissão                                 |
| id_cargo        | INT     | Cargo ao qual pertence                                     |
| chave_permissao | VARCHAR | Código da ação permitida                                   |

-------------------------------------------------------------

#### **📋 Lista de chave_permissao (para registo)**
| chave_permissao     |
| ------------------- |
| ver_utilizador      |
| editar_utilizador   |
| atribuir_cargo      |
| remover_cargo       |
| banir_utilizador    |
| desbanir_utilizador |
| adicionar_blacklist |
| remover_blacklist   |
| ver_blacklist       |


📦 Categorias e Produtos
| chave_permissao          |
| ------------------------ |
| criar_categoria          |
| editar_categoria         |
| ativar_categoria         |
| desativar_categoria      |
| criar_produto            |
| editar_produto           |
| alterar_preco_produto    |
| ativar_produto           |
| desativar_produto        |
| adicionar_imagem_produto |
| remover_imagem_produto   |
| adicionar_stock_digital  |
| remover_stock_digital    |
| ver_stock_digital        |

🎫 Tickets e Atendimento
| chave_permissao            |
| -------------------------- |
| abrir_ticket               |
| ver_ticket                 |
| assumir_ticket             |
| transferir_ticket          |
| enviar_mensagem_ticket     |
| apagar_mensagem_ticket     |
| alterar_status_ticket      |
| fechar_ticket              |
| reabrir_ticket             |
| criar_tipo_ticket          |
| editar_tipo_ticket         |
| desativar_tipo_ticket      |
| avaliar_atendimento        |
| ver_avaliacoes_atendimento |

💰 Pedidos, Pagamentos e Cupons
| chave_permissao         |
| ----------------------- |
| criar_pedido            |
| ver_pedido              |
| cancelar_pedido         |
| ver_itens_pedido        |
| gerar_pix               |
| confirmar_pagamento_pix |
| cancelar_pagamento_pix  |
| criar_cupom             |
| editar_cupom            |
| ativar_cupom            |
| desativar_cupom         |

🔍 Pós-Venda e Auditoria
| chave_permissao        |
| ---------------------- |
| solicitar_reembolso    |
| aprovar_reembolso      |
| negar_reembolso        |
| executar_reembolso     |
| ver_logs_auditoria     |
| registar_log_auditoria |


## 📦 Módulo 2: Catálogo de Produtos (4 Tabelas)

#### **tb_categorias — Organização da loja**
| Campo        | Tipo    | Descrição                         |
| ------------ | ------- | --------------------------------- |
| id_categoria | INT     | Identificador da categoria        |
| nome         | VARCHAR | Ex: Scripts, Skins, Moeda Virtual |
| descricao    | TEXT    | Descrição da categoria            |

-------------------------------------------------------------


#### **tb_produtos — Produtos à venda**

| Campo               | Tipo    | Observações                                |
| ------------------- | ------- | ------------------------------------------ |
| id_produto          | INT     | Identificador do produto                   |
| id_categoria        | INT     | Categoria associada                        |
| nome                | VARCHAR | Nome do produto                            |
| preco_centavos      | INT     | Valor em cêntimos (ex: 1000 = €10,00)      |

-------------------------------------------------------------

#### **tb_produto_imagens — Imagens do produto**
| Campo      | Tipo    | Descrição                 |
| ---------- | ------- | ------------------------- |
| id_imagem  | INT     | Identificador da imagem   |
| id_produto | INT     | Produto associado         |
| url_imagem | VARCHAR | Link da imagem no Discord |

-------------------------------------------------------------

#### **tb_stock_digital — Itens digitais para entrega**
| Campo            | Tipo    | Descrição                |
| ---------------- | ------- | ------------------------ |
| id_item          | INT     | Identificador individual |
| id_produto       | INT     | Produto correspondente   |
| conteudo_entrega | TEXT    | Key, link ou ficheiro    |
| vendido          | BOOLEAN | Disponível ou entregue   |

-------------------------------------------------------------


## 🎫 Módulo 3: Tickets e Atendimento (5 Tabelas)**

#### **tb_tickets — Controlo de atendimentos**
| Campo            | Tipo    | Descrição                   |
| ---------------- | ------- | --------------------------- |
| id_ticket        | INT     | Identificador do ticket     |
| id_canal_discord | BIGINT  | Canal criado no Discord     |
| id_dono_discord  | BIGINT  | Utilizador que abriu        |
| status           | VARCHAR | Aberto, Em Análise, Fechado |


-------------------------------------------------------------

#### **tb_mensagens_ticket — Histórico da conversa**
| Campo            | Tipo   | Descrição            |
| ---------------- | ------ | -------------------- |
| id_mensagem      | INT    | Identificador        |
| id_ticket        | INT    | Ticket associado     |
| id_autor_discord | BIGINT | Autor da mensagem    |
| conteudo         | TEXT   | Conteúdo da mensagem |

-------------------------------------------------------------

#### **tb_mapeamento_categorias_tickets - relacionamento**
| Campo            | Tipo    | Descrição                                  |
| ---------------- | ------- | ------------------------------------------ |
| id_categoria     | BIGINT  | Id da categroia                            |
| nome_tipo        | VARCHAR |  Compra, Suporte, Reclamação, Reembolso    |

-------------------------------------------------------------

#### **tb_tipos_ticket — Motivos de abertura**
| Campo                | Tipo    | Descrição                              |
| -------------------- | ------- | -------------------------------------- |
| id_tipo              | INT     | Identificador                          |
| nome_tipo            | VARCHAR | Compra, Suporte, Reclamação, Reembolso |
| descricao            | VARCHAR | O que ele precisa no ticket            |


-------------------------------------------------------------

#### **tb_avaliacoes_atendimento — Feedback do cliente**
| Campo        | Tipo | Descrição            |
| ------------ | ---- | -------------------- |
| id_avaliacao | INT  | Identificador        |
| id_ticket    | INT  | Atendimento avaliado |
| nota         | INT  | Nota de 1 a 5        |



## 💰 Módulo 4: Vendas e Financeiro (4 Tabelas)

#### **tb_cupons — Cupons de desconto**
| Campo               | Tipo    | Descrição         |
| ------------------- | ------- | ----------------- |
| id_cupom            | INT     | Identificador     |
| codigo              | VARCHAR | Ex: DESCONTO10    |
| percentual_desconto | INT     | 0 a 100           |
| data_validade       | DATE    | Data de expiração |

-------------------------------------------------------------

#### **tb_pedidos — Registo das vendas**
| Campo                | Tipo    | Descrição                 |
| -------------------- | ------- | ------------------------- |
| id_pedido            | INT     | Número do pedido          |
| id_comprador_discord | BIGINT  | Comprador                 |
| id_cupom             | INT     | Cupom aplicado            |
| valor_total          | INT     | Valor final               |
| status_pagamento     | VARCHAR | Pendente, Pago, Cancelado |


-------------------------------------------------------------

#### **tb_itens_pedido — Itens do carrinho**
| Campo          | Tipo | Descrição           |
| -------------- | ---- | ------------------- |
| id_item_pedido | INT  | Identificador       |
| id_pedido      | INT  | Pedido associado    |
| id_produto     | INT  | Produto             |
| quantidade     | INT  | Quantidade comprada |

-------------------------------------------------------------

#### **tb_pagamentos_pix — Controlo de pagamentos PIX**
| Campo               | Tipo         | Descrição                             |
| ------------------- | ------------ | ------------------------------------- |
| id_pagamento        | INT          | Identificador                         |
| id_pedido           | INT          | Pedido pago                           |
| codigo_copia_cola   | TEXT         | Código PIX                            |
| confirmado          | BOOLEAN      | Pagamento confirmado                  |
| txid                | VARCHAR(100) | ID da transação PIX                   |
| expiracao_pagamento | TIMESTAMP    | Quando deve cancelar                  |
| id_cargo_recompensa | INT     | Cargo de recompensa (Cargo= Comprador Vip) |


## 🔍 Módulo 5: Segurança e Pós-Venda (1 Tabelas)

#### **tb_reembolsos_revogacoes — Gestão de reembolsos**
| Campo            | Tipo    | Descrição                  |
| ---------------- | ------- | -------------------------- |
| id_reembolso     | INT     | Identificador              |
| id_pedido        | INT     | Pedido associado           |
| motivo           | TEXT    | Justificação               |
| status_reembolso | VARCHAR | Aprovado, Negado, Pendente |

-------------------------------------------------------------

#### **tb_blacklist — Controle de usuários banidos**
| Campo             | Tipo      | Descrição                                      |
| ----------------- | --------- | ---------------------------------------------- |
| id_blacklist      | INT       | Identificador interno                          |
| id_discord_banido | BIGINT    | ID do usuário bloqueado                        |
| motivo            | TEXT      | Razão do banimento (Ex: 'Tentativa de fraude') |
| data_banimento    | TIMESTAMP | Data do bloqueio                               |

## 🛠️ Tecnologias Utilizadas

* Modelagem: SQL (DDL)

* Banco de Dados: PostgreSQL / MySQL

* Integração: Bot Discord

* Versionamento: Git & GitHub
