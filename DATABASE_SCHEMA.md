# Projeto: Bot de Vendas e Suporte (Discord)

Documentação alinhada ao script [`DDL/01_criacao_tabelas.sql`](DDL/01_criacao_tabelas.sql).  
**SGBD:** PostgreSQL.

---

## Módulo 1: Usuários e Cargos

#### **utilizadores**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| discord_uid | BIGINT | PK — ID do Discord |
| nome_usuario | VARCHAR(100) | Nome exibido no perfil |
| tag_usuario | VARCHAR(10) | Tag numérica (ex: 0001) |
| data_registro | TIMESTAMP | Primeira interação com o bot |

#### **cargos**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| nome_cargo | VARCHAR(50) | Ex: Admin, Suporte, Comprador VIP |
| discord_role_uid | BIGINT | ID do cargo no servidor Discord |

#### **utilizador_cargos** (N:N)
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| usuario_uid | BIGINT | FK → utilizadores |
| cargo_codigo | INT | FK → cargos |

#### **permissoes**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| cargo_codigo | INT | FK → cargos |
| chave_permissao | VARCHAR(100) | Código da ação permitida |

---

## Módulo 2: Catálogo de Produtos

#### **categorias**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| nome_categoria | VARCHAR(100) | Ex: VIPs e Cargos, Scripts FiveM |
| descricao_categoria | TEXT | Descrição da categoria |

#### **produtos**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| categoria_codigo | INT | FK → categorias |
| nome_produto | VARCHAR(150) | Nome do produto |
| preco_centavos | INT | Valor em centavos |

#### **produto_imagens**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| produto_codigo | INT | FK → produtos |
| url_imagem | VARCHAR(255) | URL da imagem |

#### **stock_digital**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| produto_codigo | INT | FK → produtos |
| conteudo_entrega | TEXT | Key, link ou arquivo |
| foi_vendido | BOOLEAN | FALSE = disponível, TRUE = entregue |

---

## Módulo 3: Tickets e Atendimento

#### **tipos_ticket**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| nome_tipo | VARCHAR(100) | Motivo de abertura |
| descricao_tipo | VARCHAR(255) | Detalhe do tipo |

#### **tickets**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| numero | SERIAL | PK |
| canal_discord_uid | BIGINT | Canal do ticket no Discord |
| dono_uid | BIGINT | FK → utilizadores |
| tipo_codigo | INT | FK → tipos_ticket |
| status_ticket | VARCHAR(50) | ABERTO, EM ANÁLISE, FECHADO, Resolvido |
| data_abertura | TIMESTAMP | Data de abertura |
| data_fechamento | TIMESTAMP | Data de encerramento (nullable) |

#### **mensagens_ticket**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| ticket_numero | INT | FK → tickets |
| autor_uid | BIGINT | FK → utilizadores |
| conteudo_mensagem | TEXT | Conteúdo da mensagem |
| data_envio | TIMESTAMP | Data do envio |

#### **avaliacoes_atendimento**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| ticket_numero | INT | FK → tickets (UNIQUE) |
| nota_avaliacao | INT | Nota de 1 a 5 |
| comentario | TEXT | Feedback do cliente |

---

## Módulo 4: Vendas e Financeiro

#### **cupons**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| chave_cupom | VARCHAR(50) | Código do cupom (UNIQUE) |
| percentual_desconto | INT | 0 a 100 |
| data_validade | DATE | Data de expiração |

#### **formas_pagamento**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| descricao_forma | VARCHAR(50) | Ex: PIX, Cartão de Crédito |

#### **pedidos**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| numero | SERIAL | PK |
| comprador_uid | BIGINT | FK → utilizadores |
| cupom_codigo | INT | FK → cupons (nullable) |
| valor_final | INT | Valor final em centavos |
| status_pedido | VARCHAR(20) | Pendente, Pago, Cancelado, Reembolsado |

#### **itens_pedido**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| pedido_numero | INT | FK → pedidos |
| produto_codigo | INT | FK → produtos |
| quantidade_comprada | INT | Quantidade |

#### **pagamentos**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| pedido_numero | INT | FK → pedidos (UNIQUE) |
| forma_codigo | INT | FK → formas_pagamento |
| codigo_transacao | VARCHAR(100) | ID da transação |
| status_pagamento | VARCHAR(20) | Pendente, Aprovado, Recusado |
| data_atualizacao | TIMESTAMP | Última atualização |

---

## Módulo 5: Segurança, Pós-Venda e Auditoria

#### **reembolsos_revogacoes**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| pedido_numero | INT | FK → pedidos (UNIQUE) |
| motivo_reembolso | TEXT | Justificativa |
| status_reembolso | VARCHAR(20) | Aprovado, Negado, Pendente |

#### **blacklist**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| banido_uid | BIGINT | FK → utilizadores (UNIQUE) |
| motivo_banimento | TEXT | Razão do banimento |
| data_banimento | TIMESTAMP | Data do bloqueio |

#### **logs_auditoria**
| Campo | Tipo | Descrição |
| ----- | ---- | --------- |
| codigo | SERIAL | PK |
| admin_uid | BIGINT | FK → utilizadores (administrador) |
| tabela_afetada | VARCHAR(50) | Tabela alterada (produtos, permissoes, etc.) |
| registro_id | INT | ID do registro afetado |
| acao | VARCHAR(50) | CRIAR, EDITAR, DESATIVAR, APROVAR, etc. |
| detalhes | TEXT | Descrição da ação |
| data_evento | TIMESTAMP | Data/hora do evento |

---

## Tecnologias

- Modelagem e scripts: SQL (DDL, DML, DQL, DPL)
- Banco de Dados: PostgreSQL
- Integração prevista: Bot Discord
- Versionamento: Git e GitHub
