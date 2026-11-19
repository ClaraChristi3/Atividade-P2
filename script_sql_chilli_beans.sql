-- Projeto acadêmico: Sistema de vendas | Empresa de referência: Chilli Beans
-- Integrantes: Andrei, Anthony, Clara e Letícia
-- Gerado a partir do modelo MySQL Workbench enviado pela equipe.
SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS `sistema_vendas` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `sistema_vendas`;

CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `cpf_cnpj` VARCHAR(14) NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `uk_cliente_cpf_cnpj` (`cpf_cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `login` VARCHAR(100) NOT NULL,
  `senha_hash` VARCHAR(255) NOT NULL,
  `perfil` ENUM('administrador', 'gerente', 'vendedor', 'estoquista') NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `uk_usuario_login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `transportadora` (
  `id_transportadora` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_transportadora`),
  UNIQUE KEY `uk_transportadora_cnpj` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `fornecedor` (
  `id_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `razao_social` VARCHAR(255) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_fornecedor`),
  UNIQUE KEY `uk_fornecedor_cnpj` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `uk_categoria_nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `forma_pagamento` (
  `id_forma_pagamento` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_forma_pagamento`),
  UNIQUE KEY `uk_forma_pagamento_descricao` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `promocao` (
  `id_promocao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `percentual_desconto` DECIMAL(5,2) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_promocao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `cupom` (
  `id_cupom` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(50) NOT NULL,
  `percentual_desconto` DECIMAL(5,2) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_validade` DATE NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_cupom`),
  UNIQUE KEY `uk_cupom_codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `solicitacao_titular` (
  `id_solicitacao` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NULL DEFAULT NULL,
  `tipo` VARCHAR(100) NOT NULL,
  `data_abertura` DATETIME NOT NULL,
  `situacao` VARCHAR(50) NOT NULL,
  `data_conclusao` DATETIME NULL DEFAULT NULL,
  `resposta` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_solicitacao`),
  KEY `fk_solicitacao_cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `consentimento_lgpd` (
  `id_consentimento` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `finalidade` VARCHAR(255) NOT NULL,
  `versao_termo` VARCHAR(50) NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `revogado_em` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_consentimento`),
  KEY `fk_consentimento_cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `logradouro` VARCHAR(255) NOT NULL,
  `numero` VARCHAR(20) NOT NULL,
  `complemento` VARCHAR(100) NULL DEFAULT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cep` CHAR(8) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `pais` VARCHAR(50) NULL DEFAULT 'Brasil',
  `tipo` VARCHAR(50) NOT NULL,
  `principal` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_endereco`),
  KEY `fk_endereco_cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `telefone_cliente` (
  `id_telefone` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `numero` VARCHAR(20) NOT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  `principal` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_telefone`),
  KEY `fk_telefone_cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `endereco_fornecedor` (
  `id_endereco_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `id_fornecedor` INT NOT NULL,
  `logradouro` VARCHAR(255) NOT NULL,
  `numero` VARCHAR(20) NOT NULL,
  `complemento` VARCHAR(100) NULL DEFAULT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cep` CHAR(8) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  PRIMARY KEY (`id_endereco_fornecedor`),
  KEY `fk_endforn_fornecedor` (`id_fornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `id_categoria` INT NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `preco_tabela` DECIMAL(10,2) NOT NULL,
  `saldo_estoque` INT NOT NULL,
  `ativo` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_produto`),
  KEY `fk_produto_categoria` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `produto_fornecedor` (
  `id_produto_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `id_produto` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  PRIMARY KEY (`id_produto_fornecedor`),
  KEY `fk_prodforn_produto` (`id_produto`),
  KEY `fk_prodforn_fornecedor` (`id_fornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `promocao_produto` (
  `id_promocao_produto` INT NOT NULL AUTO_INCREMENT,
  `id_promocao` INT NOT NULL,
  `id_produto` INT NOT NULL,
  PRIMARY KEY (`id_promocao_produto`),
  KEY `fk_promprod_promocao` (`id_promocao`),
  KEY `fk_promprod_produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `historico_preco` (
  `id_historico` INT NOT NULL AUTO_INCREMENT,
  `id_produto` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `data_inicio` DATETIME NOT NULL,
  `data_fim` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_historico`),
  KEY `fk_histpreco_produto` (`id_produto`),
  KEY `fk_histpreco_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entrada_mercadoria` (
  `id_entrada` INT NOT NULL AUTO_INCREMENT,
  `id_fornecedor` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `data_entrada` DATETIME NOT NULL,
  `numero_documento` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_entrada`),
  KEY `fk_entrada_fornecedor` (`id_fornecedor`),
  KEY `fk_entrada_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `item_entrada` (
  `id_item_entrada` INT NOT NULL AUTO_INCREMENT,
  `id_entrada` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `custo_unitario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_item_entrada`),
  KEY `fk_itementrada_entrada` (`id_entrada`),
  KEY `fk_itementrada_produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_forma_pagamento` INT NOT NULL,
  `id_cupom` INT NULL DEFAULT NULL,
  `data_hora` DATETIME NOT NULL,
  `situacao` VARCHAR(50) NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL COMMENT 'Calculado - RN05',
  PRIMARY KEY (`id_pedido`),
  KEY `fk_pedido_cliente` (`id_cliente`),
  KEY `fk_pedido_usuario` (`id_usuario`),
  KEY `fk_pedido_forma_pagamento` (`id_forma_pagamento`),
  KEY `fk_pedido_cupom` (`id_cupom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `item_pedido` (
  `id_item` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario_venda` DECIMAL(10,2) NOT NULL COMMENT 'Congelado - RN03',
  PRIMARY KEY (`id_item`),
  KEY `fk_itempedido_pedido` (`id_pedido`),
  KEY `fk_itempedido_produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `garantia` (
  `id_garantia` INT NOT NULL AUTO_INCREMENT,
  `id_item` INT NOT NULL,
  `data_inicio` DATE NOT NULL,
  `prazo_meses` INT NOT NULL,
  `data_vencimento` DATE NOT NULL,
  PRIMARY KEY (`id_garantia`),
  UNIQUE KEY `uk_garantia_item` (`id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entrega` (
  `id_entrega` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `id_transportadora` INT NOT NULL,
  `codigo_rastreio` VARCHAR(100) NULL DEFAULT NULL,
  `data_despacho` DATETIME NULL DEFAULT NULL,
  `data_previsao` DATETIME NOT NULL,
  `data_entrega` DATETIME NULL DEFAULT NULL,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_entrega`),
  UNIQUE KEY `uk_entrega_pedido` (`id_pedido`),
  KEY `fk_entrega_endereco` (`id_endereco`),
  KEY `fk_entrega_transportadora` (`id_transportadora`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `reclamacao` (
  `id_reclamacao` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_pedido` INT NULL DEFAULT NULL,
  `descricao` TEXT NOT NULL,
  `data_abertura` DATETIME NOT NULL,
  `situacao` VARCHAR(50) NOT NULL,
  `solucao` TEXT NULL DEFAULT NULL,
  `data_encerramento` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_reclamacao`),
  KEY `fk_reclamacao_cliente` (`id_cliente`),
  KEY `fk_reclamacao_pedido` (`id_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `nota_fiscal` (
  `id_nota_fiscal` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `chave_acesso` VARCHAR(44) NOT NULL,
  `modelo` VARCHAR(10) NOT NULL,
  `serie` INT NOT NULL,
  `numero` INT NOT NULL,
  `data_emissao` DATETIME NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `status_autorizacao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_nota_fiscal`),
  UNIQUE KEY `uk_nota_fiscal_chave` (`chave_acesso`),
  KEY `fk_notafiscal_pedido` (`id_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `movimentacao_financeira` (
  `id_movimentacao_financeira` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `situacao` VARCHAR(50) NOT NULL,
  `referencia` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_movimentacao_financeira`),
  KEY `fk_movfin_pedido` (`id_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `estorno` (
  `id_estorno` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `data_solicitacao` DATETIME NOT NULL,
  `motivo` TEXT NOT NULL,
  `valor_estornado` DECIMAL(10,2) NOT NULL,
  `data_estorno` DATETIME NULL DEFAULT NULL,
  `situacao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_estorno`),
  KEY `fk_estorno_pedido` (`id_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `movimentacao_estoque` (
  `id_movimentacao` INT NOT NULL AUTO_INCREMENT,
  `id_produto` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_pedido` INT NULL DEFAULT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  `quantidade` INT NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `motivo` TEXT NOT NULL,
  PRIMARY KEY (`id_movimentacao`),
  KEY `fk_movest_produto` (`id_produto`),
  KEY `fk_movest_usuario` (`id_usuario`),
  KEY `fk_movest_pedido` (`id_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `log_auditoria` (
  `id_log` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `tabela_afetada` VARCHAR(100) NOT NULL,
  `identificador_registro` INT NOT NULL,
  `operacao` VARCHAR(50) NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `valor_anterior` JSON NULL DEFAULT NULL,
  `valor_novo` JSON NULL DEFAULT NULL,
  PRIMARY KEY (`id_log`),
  KEY `fk_log_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Chaves estrangeiras (adicionadas após a criação de todas as tabelas)
ALTER TABLE `solicitacao_titular` ADD CONSTRAINT `fk_solicitacao_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
ALTER TABLE `consentimento_lgpd` ADD CONSTRAINT `fk_consentimento_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
ALTER TABLE `endereco` ADD CONSTRAINT `fk_endereco_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
ALTER TABLE `telefone_cliente` ADD CONSTRAINT `fk_telefone_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
ALTER TABLE `endereco_fornecedor` ADD CONSTRAINT `fk_endforn_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`);
ALTER TABLE `produto` ADD CONSTRAINT `fk_produto_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`);
ALTER TABLE `produto_fornecedor` ADD CONSTRAINT `fk_prodforn_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);
ALTER TABLE `produto_fornecedor` ADD CONSTRAINT `fk_prodforn_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`);
ALTER TABLE `promocao_produto` ADD CONSTRAINT `fk_promprod_promocao` FOREIGN KEY (`id_promocao`) REFERENCES `promocao` (`id_promocao`);
ALTER TABLE `promocao_produto` ADD CONSTRAINT `fk_promprod_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);
ALTER TABLE `historico_preco` ADD CONSTRAINT `fk_histpreco_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);
ALTER TABLE `historico_preco` ADD CONSTRAINT `fk_histpreco_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);
ALTER TABLE `entrada_mercadoria` ADD CONSTRAINT `fk_entrada_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`);
ALTER TABLE `entrada_mercadoria` ADD CONSTRAINT `fk_entrada_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);
ALTER TABLE `item_entrada` ADD CONSTRAINT `fk_itementrada_entrada` FOREIGN KEY (`id_entrada`) REFERENCES `entrada_mercadoria` (`id_entrada`);
ALTER TABLE `item_entrada` ADD CONSTRAINT `fk_itementrada_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);
ALTER TABLE `pedido` ADD CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
ALTER TABLE `pedido` ADD CONSTRAINT `fk_pedido_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);
ALTER TABLE `pedido` ADD CONSTRAINT `fk_pedido_forma_pagamento` FOREIGN KEY (`id_forma_pagamento`) REFERENCES `forma_pagamento` (`id_forma_pagamento`);
ALTER TABLE `pedido` ADD CONSTRAINT `fk_pedido_cupom` FOREIGN KEY (`id_cupom`) REFERENCES `cupom` (`id_cupom`);
ALTER TABLE `item_pedido` ADD CONSTRAINT `fk_itempedido_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);
ALTER TABLE `item_pedido` ADD CONSTRAINT `fk_itempedido_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);
ALTER TABLE `garantia` ADD CONSTRAINT `fk_garantia_item` FOREIGN KEY (`id_item`) REFERENCES `item_pedido` (`id_item`);
ALTER TABLE `entrega` ADD CONSTRAINT `fk_entrega_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);
ALTER TABLE `entrega` ADD CONSTRAINT `fk_entrega_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`id_endereco`);
ALTER TABLE `entrega` ADD CONSTRAINT `fk_entrega_transportadora` FOREIGN KEY (`id_transportadora`) REFERENCES `transportadora` (`id_transportadora`);
ALTER TABLE `reclamacao` ADD CONSTRAINT `fk_reclamacao_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
ALTER TABLE `reclamacao` ADD CONSTRAINT `fk_reclamacao_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);
ALTER TABLE `nota_fiscal` ADD CONSTRAINT `fk_notafiscal_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);
ALTER TABLE `movimentacao_financeira` ADD CONSTRAINT `fk_movfin_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);
ALTER TABLE `estorno` ADD CONSTRAINT `fk_estorno_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);
ALTER TABLE `movimentacao_estoque` ADD CONSTRAINT `fk_movest_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);
ALTER TABLE `movimentacao_estoque` ADD CONSTRAINT `fk_movest_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);
ALTER TABLE `movimentacao_estoque` ADD CONSTRAINT `fk_movest_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);
ALTER TABLE `log_auditoria` ADD CONSTRAINT `fk_log_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);