# Documentação do banco de dados — Sistema de Vendas

**Empresa de referência:** Chilli Beans  
**Integrantes:** Andrei, Anthony, Clara e Letícia  
**SGBD/modelador:** MySQL / MySQL Workbench

## Arquivos entregues

| Arquivo | Descrição |
|---|---|
| `atividade_tabelas.zip` | Arquivo original recebido, contendo o modelo do MySQL Workbench. |
| `document.mwb.xml` | Estrutura XML interna do modelo Workbench; contém os esquemas, tabelas, colunas e relacionamentos. |
| `@db/data.db` | Banco interno de apoio do arquivo de modelo Workbench. |
| `lock` | Arquivo interno de controle do pacote Workbench. |
| `script_sql_chilli_beans.sql` | Script SQL exportado a partir da estrutura do modelo, para criação dos bancos e tabelas. |
| `documentacao_banco_chilli_beans.pdf` | Esta documentação em PDF. |

## Identidade visual sugerida

- Vermelho: `#E52332` (destaque e elementos principais).
- Preto: `#171717` (títulos e textos).
- Branco: `#FFFFFF` (fundo e contraste).

## Estrutura identificada no modelo

### Esquema `mydb`

Não foram identificadas tabelas neste esquema.

### Esquema `sistema_vendas`

Quantidade de tabelas: **29**

- **`cliente`** — `id_cliente` (INT), `nome` (VARCHAR(255)), `cpf_cnpj` (VARCHAR(14)), `ativo` (TINYINT).
- **`usuario`** — `id_usuario` (INT), `nome` (VARCHAR(255)), `login` (VARCHAR(100)), `senha_hash` (VARCHAR(255)), `perfil` (ENUM('administrador', 'gerente', 'vendedor', 'estoquista')), `ativo` (TINYINT).
- **`transportadora`** — `id_transportadora` (INT), `nome` (VARCHAR(255)), `cnpj` (VARCHAR(14)), `telefone` (VARCHAR(20)), `ativo` (TINYINT).
- **`fornecedor`** — `id_fornecedor` (INT), `razao_social` (VARCHAR(255)), `cnpj` (VARCHAR(14)), `telefone` (VARCHAR(20)), `email` (VARCHAR(255)), `ativo` (TINYINT).
- **`categoria`** — `id_categoria` (INT), `nome` (VARCHAR(100)), `ativo` (TINYINT).
- **`forma_pagamento`** — `id_forma_pagamento` (INT), `descricao` (VARCHAR(100)), `ativo` (TINYINT).
- **`promocao`** — `id_promocao` (INT), `nome` (VARCHAR(255)), `percentual_desconto` (DECIMAL(5,2)), `data_inicio` (DATE), `data_fim` (DATE), `ativo` (TINYINT).
- **`cupom`** — `id_cupom` (INT), `codigo` (VARCHAR(50)), `percentual_desconto` (DECIMAL(5,2)), `data_inicio` (DATE), `data_validade` (DATE), `ativo` (TINYINT).
- **`solicitacao_titular`** — `id_solicitacao` (INT), `id_cliente` (INT), `tipo` (VARCHAR(100)), `data_abertura` (DATETIME), `situacao` (VARCHAR(50)), `data_conclusao` (DATETIME), `resposta` (TEXT).
- **`consentimento_lgpd`** — `id_consentimento` (INT), `id_cliente` (INT), `finalidade` (VARCHAR(255)), `versao_termo` (VARCHAR(50)), `data_hora` (DATETIME), `revogado_em` (DATETIME).
- **`endereco`** — `id_endereco` (INT), `id_cliente` (INT), `logradouro` (VARCHAR(255)), `numero` (VARCHAR(20)), `complemento` (VARCHAR(100)), `bairro` (VARCHAR(100)), `cep` (CHAR(8)), `cidade` (VARCHAR(100)), `uf` (CHAR(2)), `pais` (VARCHAR(50)), `tipo` (VARCHAR(50)), `principal` (TINYINT).
- **`telefone_cliente`** — `id_telefone` (INT), `id_cliente` (INT), `numero` (VARCHAR(20)), `tipo` (VARCHAR(50)), `principal` (TINYINT).
- **`endereco_fornecedor`** — `id_endereco_fornecedor` (INT), `id_fornecedor` (INT), `logradouro` (VARCHAR(255)), `numero` (VARCHAR(20)), `complemento` (VARCHAR(100)), `bairro` (VARCHAR(100)), `cep` (CHAR(8)), `cidade` (VARCHAR(100)), `uf` (CHAR(2)).
- **`produto`** — `id_produto` (INT), `id_categoria` (INT), `descricao` (VARCHAR(255)), `preco_tabela` (DECIMAL(10,2)), `saldo_estoque` (INT), `ativo` (TINYINT).
- **`produto_fornecedor`** — `id_produto_fornecedor` (INT), `id_produto` (INT), `id_fornecedor` (INT).
- **`promocao_produto`** — `id_promocao_produto` (INT), `id_promocao` (INT), `id_produto` (INT).
- **`historico_preco`** — `id_historico` (INT), `id_produto` (INT), `id_usuario` (INT), `preco` (DECIMAL(10,2)), `data_inicio` (DATETIME), `data_fim` (DATETIME).
- **`entrada_mercadoria`** — `id_entrada` (INT), `id_fornecedor` (INT), `id_usuario` (INT), `data_entrada` (DATETIME), `numero_documento` (VARCHAR(100)).
- **`item_entrada`** — `id_item_entrada` (INT), `id_entrada` (INT), `id_produto` (INT), `quantidade` (INT), `custo_unitario` (DECIMAL(10,2)).
- **`pedido`** — `id_pedido` (INT), `id_cliente` (INT), `id_usuario` (INT), `id_forma_pagamento` (INT), `id_cupom` (INT), `data_hora` (DATETIME), `situacao` (VARCHAR(50)), `valor_total` (DECIMAL(10,2)).
- **`item_pedido`** — `id_item` (INT), `id_pedido` (INT), `id_produto` (INT), `quantidade` (INT), `preco_unitario_venda` (DECIMAL(10,2)).
- **`garantia`** — `id_garantia` (INT), `id_item` (INT), `data_inicio` (DATE), `prazo_meses` (INT), `data_vencimento` (DATE).
- **`entrega`** — `id_entrega` (INT), `id_pedido` (INT), `id_endereco` (INT), `id_transportadora` (INT), `codigo_rastreio` (VARCHAR(100)), `data_despacho` (DATETIME), `data_previsao` (DATETIME), `data_entrega` (DATETIME), `status` (VARCHAR(50)).
- **`reclamacao`** — `id_reclamacao` (INT), `id_cliente` (INT), `id_pedido` (INT), `descricao` (TEXT), `data_abertura` (DATETIME), `situacao` (VARCHAR(50)), `solucao` (TEXT), `data_encerramento` (DATETIME).
- **`nota_fiscal`** — `id_nota_fiscal` (INT), `id_pedido` (INT), `chave_acesso` (VARCHAR(44)), `modelo` (VARCHAR(10)), `serie` (INT), `numero` (INT), `data_emissao` (DATETIME), `valor_total` (DECIMAL(10,2)), `status_autorizacao` (VARCHAR(50)).
- **`movimentacao_financeira`** — `id_movimentacao_financeira` (INT), `id_pedido` (INT), `tipo` (VARCHAR(50)), `valor` (DECIMAL(10,2)), `data_hora` (DATETIME), `situacao` (VARCHAR(50)), `referencia` (VARCHAR(255)).
- **`estorno`** — `id_estorno` (INT), `id_pedido` (INT), `data_solicitacao` (DATETIME), `motivo` (TEXT), `valor_estornado` (DECIMAL(10,2)), `data_estorno` (DATETIME), `situacao` (VARCHAR(50)).
- **`movimentacao_estoque`** — `id_movimentacao` (INT), `id_produto` (INT), `id_usuario` (INT), `id_pedido` (INT), `tipo` (VARCHAR(50)), `quantidade` (INT), `data_hora` (DATETIME), `motivo` (TEXT).
- **`log_auditoria`** — `id_log` (INT), `id_usuario` (INT), `tabela_afetada` (VARCHAR(100)), `identificador_registro` (INT), `operacao` (VARCHAR(50)), `data_hora` (DATETIME), `valor_anterior` (JSON), `valor_novo` (JSON).

## Observações importantes

- O modelo enviado contém dois esquemas: `mydb` e `sistema_vendas`. O esquema `mydb` não apresentou tabelas no conteúdo inspecionado; as tabelas estão em `sistema_vendas`.
- O script foi montado com base nas definições presentes no modelo Workbench. Antes de usar em produção, recomenda-se executar em ambiente de teste e conferir especialmente os tipos ENUM, índices e regras referenciais no MySQL instalado.
- O arquivo `.mwb` original não foi alterado. O ZIP recebido foi preservado e o script SQL foi gerado como arquivo separado.
