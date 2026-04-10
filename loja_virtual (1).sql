-- ============================================================
--  BANCO DE DADOS: Loja Virtual
--  Banco: PostgreSQL
--  Descrição: Banco de dados para prática de SQL
-- ============================================================

-- Apaga as tabelas se já existirem (para rodar o script do zero)
DROP TABLE IF EXISTS itens_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS funcionarios;

-- ============================================================
--  TABELAS
-- ============================================================

CREATE TABLE clientes (
    id              SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    cpf             VARCHAR(14) UNIQUE NOT NULL,
    cidade          VARCHAR(80),
    estado          CHAR(2),
    data_nascimento DATE,
    data_cadastro   DATE DEFAULT CURRENT_DATE
);

CREATE TABLE categorias (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL
);

CREATE TABLE produtos (
    id           SERIAL PRIMARY KEY,
    nome         VARCHAR(120) NOT NULL,
    categoria_id INT REFERENCES categorias(id),
    preco        NUMERIC(10,2) NOT NULL,
    estoque      INT DEFAULT 0
);

CREATE TABLE funcionarios (
    id             SERIAL PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    cargo          VARCHAR(80),
    departamento   VARCHAR(60),
    salario        NUMERIC(10,2),
    data_admissao  DATE
);

CREATE TABLE pedidos (
    id            SERIAL PRIMARY KEY,
    cliente_id    INT REFERENCES clientes(id),
    funcionario_id INT REFERENCES funcionarios(id),
    data_pedido   DATE NOT NULL,
    status        VARCHAR(20) CHECK (status IN ('pago', 'pendente', 'cancelado', 'enviado')),
    valor_total   NUMERIC(10,2)
);

CREATE TABLE itens_pedido (
    id              SERIAL PRIMARY KEY,
    pedido_id       INT REFERENCES pedidos(id),
    produto_id      INT REFERENCES produtos(id),
    quantidade      INT NOT NULL,
    preco_unitario  NUMERIC(10,2) NOT NULL
);

-- ============================================================
--  DADOS: CLIENTES (25 registros)
-- ============================================================

INSERT INTO clientes (nome, email, cpf, cidade, estado, data_nascimento, data_cadastro) VALUES
('Lucas Ferreira',      'lucas.ferreira@email.com',    '123.456.789-01', 'São Paulo',       'SP', '1995-03-14', '2022-01-10'),
('Ana Paula Costa',     'ana.costa@email.com',          '234.567.890-12', 'Rio de Janeiro',  'RJ', '1990-07-22', '2022-02-15'),
('Pedro Oliveira',      'pedro.oliveira@email.com',     '345.678.901-23', 'Belo Horizonte',  'MG', '1988-11-05', '2022-03-01'),
('Mariana Santos',      'mariana.santos@email.com',     '456.789.012-34', 'Curitiba',        'PR', '1993-05-30', '2022-03-18'),
('Rafael Lima',         'rafael.lima@email.com',        '567.890.123-45', 'Porto Alegre',    'RS', '1997-01-12', '2022-04-05'),
('Camila Rodrigues',    'camila.rodrigues@email.com',   '678.901.234-56', 'Salvador',        'BA', '1992-09-18', '2022-04-22'),
('Bruno Alves',         'bruno.alves@email.com',        '789.012.345-67', 'Fortaleza',       'CE', '1985-12-03', '2022-05-10'),
('Fernanda Martins',    'fernanda.martins@email.com',   '890.123.456-78', 'Recife',          'PE', '1991-04-27', '2022-05-28'),
('Gustavo Pereira',     'gustavo.pereira@email.com',    '901.234.567-89', 'São Paulo',       'SP', '1996-08-15', '2022-06-14'),
('Juliana Souza',       'juliana.souza@email.com',      '012.345.678-90', 'Campinas',        'SP', '1994-02-09', '2022-07-01'),
('Thiago Nascimento',   'thiago.nascimento@email.com',  '111.222.333-44', 'Manaus',          'AM', '1989-06-21', '2022-07-19'),
('Larissa Carvalho',    'larissa.carvalho@email.com',   '222.333.444-55', 'Curitiba',        'PR', '1998-10-04', '2022-08-05'),
('Diego Mendes',        'diego.mendes@email.com',       '333.444.555-66', 'Goiânia',         'GO', '1987-03-16', '2022-08-23'),
('Priscila Barbosa',    'priscila.barbosa@email.com',   '444.555.666-77', 'São Paulo',       'SP', '1995-07-08', '2022-09-10'),
('Vinicius Castro',     'vinicius.castro@email.com',    '555.666.777-88', 'Rio de Janeiro',  'RJ', '1993-11-25', '2022-09-28'),
('Tatiana Moreira',     'tatiana.moreira@email.com',    '666.777.888-99', 'Florianópolis',   'SC', '1990-01-30', '2022-10-15'),
('Rodrigo Figueiredo',  'rodrigo.figueiredo@email.com', '777.888.999-00', 'Belém',           'PA', '1986-05-13', '2022-11-02'),
('Beatriz Teixeira',    'beatriz.teixeira@email.com',   '888.999.000-11', 'Belo Horizonte',  'MG', '1999-09-07', '2022-11-20'),
('Henrique Cardoso',    'henrique.cardoso@email.com',   '999.000.111-22', 'São Paulo',       'SP', '1984-12-19', '2022-12-07'),
('Natália Ribeiro',     'natalia.ribeiro@email.com',    '000.111.222-33', 'Porto Alegre',    'RS', '1997-04-02', '2023-01-15'),
('Felipe Gomes',        'felipe.gomes@email.com',       '112.223.334-45', 'Recife',          'PE', '1992-08-24', '2023-02-10'),
('Isabela Rocha',       'isabela.rocha@email.com',      '223.334.445-56', 'Salvador',        'BA', '1996-02-16', '2023-03-05'),
('Alexandre Nunes',     'alexandre.nunes@email.com',    '334.445.556-67', 'São Paulo',       'SP', '1988-06-11', '2023-04-01'),
('Renata Azevedo',      'renata.azevedo@email.com',     '445.556.667-78', 'Fortaleza',       'CE', '1994-10-28', '2023-04-20'),
('Carlos Eduardo',      'carlos.eduardo@email.com',     '556.667.778-89', 'Curitiba',        'PR', '1991-03-06', '2023-05-12');

-- ============================================================
--  DADOS: CATEGORIAS (6 registros)
-- ============================================================

INSERT INTO categorias (nome) VALUES
('Eletrônicos'),
('Roupas'),
('Calçados'),
('Livros'),
('Esportes'),
('Casa e Decoração');

-- ============================================================
--  DADOS: PRODUTOS (30 registros)
-- ============================================================

INSERT INTO produtos (nome, categoria_id, preco, estoque) VALUES
('Smartphone Samsung Galaxy A54',   1,  1899.90,  45),
('Notebook Dell Inspiron 15',       1,  3499.00,  18),
('Fone de Ouvido JBL Bluetooth',    1,   299.90,  80),
('Smart TV LG 50"',                 1,  2799.00,  12),
('Tablet Lenovo Tab M10',           1,   999.00,  30),
('Carregador Portátil 20000mAh',    1,   189.90,  95),
('Camiseta Básica Masculina',       2,    59.90, 200),
('Camiseta Feminina Estampada',     2,    79.90, 150),
('Calça Jeans Skinny',              2,   189.90,  85),
('Vestido Floral Verão',            2,   149.90,  60),
('Moletom Canguru',                 2,   219.90,  70),
('Blusa de Frio Feminina',          2,   159.90,  55),
('Tênis Nike Air Max',              3,   599.90,  40),
('Tênis Adidas Ultraboost',         3,   749.90,  35),
('Sandália Havaianas Premium',      3,    89.90, 120),
('Bota Couro Masculina',            3,   399.90,  25),
('Sapatilha Feminina',              3,   199.90,  50),
('Chinelo Slide',                   3,    49.90, 180),
('Clean Code - Robert Martin',      4,   119.90,  60),
('O Programador Pragmático',        4,   109.90,  45),
('SQL Para Iniciantes',             4,    79.90,  70),
('Inteligência de Dados',           4,    89.90,  35),
('Halteres 10kg (par)',             5,   189.90,  40),
('Corda de Pular Speed',            5,    69.90,  90),
('Tapete de Yoga Antiderrapante',   5,   129.90,  55),
('Garrafa Térmica 1L',              5,    89.90, 110),
('Luminária de Mesa LED',           6,   149.90,  45),
('Almofada Decorativa',             6,    69.90, 100),
('Porta-Retratos Madeira 3 Peças',  6,    99.90,  65),
('Vaso Planta Cerâmica',            6,    59.90,  80);

-- ============================================================
--  DADOS: FUNCIONÁRIOS (10 registros)
-- ============================================================

INSERT INTO funcionarios (nome, cargo, departamento, salario, data_admissao) VALUES
('Marcos Vieira',      'Gerente de Vendas',      'Vendas',    9500.00, '2019-03-01'),
('Patrícia Lopes',     'Analista de Marketing',  'Marketing', 6800.00, '2020-06-15'),
('Roberto Cunha',      'Vendedor',               'Vendas',    3200.00, '2021-01-10'),
('Aline Freitas',      'Vendedora',              'Vendas',    3200.00, '2021-02-20'),
('Eduardo Pinto',      'Suporte ao Cliente',     'Suporte',   3800.00, '2020-09-05'),
('Simone Batista',     'Analista de Dados',      'TI',        7200.00, '2019-11-12'),
('Carlos Henrique',    'Desenvolvedor Backend',  'TI',        8500.00, '2018-07-22'),
('Amanda Correia',     'Designer',               'Marketing', 5500.00, '2022-03-08'),
('Leandro Monteiro',   'Vendedor',               'Vendas',    3200.00, '2022-08-15'),
('Giovana Silva',      'Gerente de TI',          'TI',       11000.00, '2017-04-30');

-- ============================================================
--  DADOS: PEDIDOS (40 registros)
-- ============================================================

INSERT INTO pedidos (cliente_id, funcionario_id, data_pedido, status, valor_total) VALUES
(1,  3, '2023-01-05', 'pago',      1899.90),
(2,  4, '2023-01-12', 'pago',       449.80),
(3,  3, '2023-01-18', 'pago',      3499.00),
(4,  9, '2023-02-02', 'cancelado',  189.90),
(5,  4, '2023-02-14', 'pago',       689.80),
(1,  3, '2023-02-20', 'pago',       299.90),
(6,  9, '2023-03-01', 'pago',      2799.00),
(7,  4, '2023-03-10', 'pendente',   399.90),
(8,  3, '2023-03-22', 'pago',       179.80),
(9,  9, '2023-04-05', 'pago',      1348.90),
(10, 4, '2023-04-11', 'pago',       419.80),
(2,  3, '2023-04-19', 'cancelado',  749.90),
(11, 9, '2023-05-03', 'pago',       259.80),
(12, 4, '2023-05-15', 'pago',      4498.00),
(3,  3, '2023-05-27', 'enviado',    599.90),
(13, 9, '2023-06-08', 'pago',     329.80),
(14, 4, '2023-06-20', 'pago',       999.00),
(15, 3, '2023-07-02', 'pago',      2349.80),
(5,  9, '2023-07-14', 'cancelado',  219.90),
(16, 4, '2023-07-26', 'pago',       469.80),
(17, 3, '2023-08-07', 'pago',      1099.90),
(18, 9, '2023-08-19', 'pago',       199.80),
(6,  4, '2023-09-01', 'enviado',   3798.90),
(19, 3, '2023-09-13', 'pago',       269.80),
(20, 9, '2023-09-25', 'pago',       939.80),
(1,  4, '2023-10-07', 'pago',      1549.90),
(21, 3, '2023-10-19', 'pendente',   149.90),
(22, 9, '2023-11-01', 'pago',      2299.00),
(9,  4, '2023-11-13', 'pago',       389.80),
(23, 3, '2023-11-25', 'pago',      4299.00),
(24, 9, '2023-12-07', 'pago',       279.80),
(10, 4, '2023-12-19', 'cancelado',  189.90),
(25, 3, '2024-01-10', 'pago',       849.80),
(4,  9, '2024-01-22', 'pago',      1299.90),
(7,  4, '2024-02-03', 'enviado',    689.80),
(11, 3, '2024-02-15', 'pago',      3199.00),
(8,  9, '2024-03-01', 'pago',       199.80),
(15, 4, '2024-03-13', 'pago',      2099.90),
(2,  3, '2024-03-25', 'pago',       629.80),
(20, 9, '2024-04-06', 'pendente',   459.80);

-- ============================================================
--  DADOS: ITENS DE PEDIDO
-- ============================================================

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1,  1,  1, 1899.90),
(2,  7,  2,   59.90),
(2,  18, 2,   49.90),
(2,  15, 2,   89.90),
(3,  2,  1, 3499.00),
(4,  9,  1,  189.90),
(5,  13, 1,  599.90),
(5,  24, 1,   69.90),
(6,  3,  1,  299.90),
(7,  6,  1,  189.90),
(7,  10, 1,  149.90),
(8,  8,  1,   79.90),
(8,  18, 2,   49.90),
(9,  4,  1, 2799.00),
(9,  15, 3,   89.90),
(9,  18, 2,   49.90),
(10, 11, 1,  219.90),
(10, 7,  2,   59.90),
(10, 28, 1,   69.90),
(11, 2,  1, 3499.00),
(11, 5,  1,  999.00),
(12, 14, 1,  749.90),
(13, 8,  1,   79.90),
(13, 17, 1,  199.90),
(14, 2,  1, 3499.00),
(14, 5,  1,  999.00),
(15, 13, 1,  599.90),
(16, 9,  1,  189.90),
(16, 7,  2,   59.90),
(17, 5,  1,  999.00),
(18, 8,  1,   79.90),
(18, 17, 1,  199.90),
(19, 11, 1,  219.90),
(20, 10, 1,  149.90),
(20, 16, 1,  399.90),
(21, 4,  1, 2799.00),
(21, 6,  1,  189.90),
(22, 23, 1,  189.90),
(22, 25, 1,   69.90),
(23, 1,  1, 1899.90),
(23, 4,  1, 2799.00),
(23, 6,  1,  189.90),
(24, 9,  1,  599.90),
(24, 7,  1,   59.90),
(25, 20, 2,  109.90),
(25, 21, 2,   79.90),
(25, 19, 2,  119.90),
(25, 22, 2,   89.90),
(26, 1,  1, 1899.90),
(26, 6,  2,  189.90),
(27, 10, 1,  149.90),
(28, 4,  1, 2799.00),
(28, 3,  1,  299.90),
(29, 13, 1,  599.90),
(29, 7,  1,   59.90),
(30, 2,  1, 3499.00),
(30, 5,  1,  999.00),
(31, 8,  2,   79.90),
(31, 15, 1,   89.90),
(32, 9,  1,  189.90),
(33, 14, 1,  749.90),
(33, 15, 1,   99.90),
(34, 1,  1, 1899.90),
(34, 6,  1,  189.90),
(35, 13, 1,  599.90),
(35, 24, 1,   69.90),
(36, 2,  1, 3499.00),
(37, 8,  1,   79.90),
(37, 18, 2,   49.90),
(38, 1,  1, 1899.90),
(38, 6,  1,  189.90),
(39, 3,  1,  299.90),
(39, 15, 2,   89.90),
(39, 18, 2,   49.90),
(40, 13, 1,  599.90),
(40, 7,  2,   59.90);

-- ============================================================
--  VERIFICAÇÃO FINAL
-- ============================================================

SELECT 'clientes'     AS tabela, COUNT(*) AS total FROM clientes
UNION ALL
SELECT 'categorias',   COUNT(*) FROM categorias
UNION ALL
SELECT 'produtos',     COUNT(*) FROM produtos
UNION ALL
SELECT 'funcionarios', COUNT(*) FROM funcionarios
UNION ALL
SELECT 'pedidos',      COUNT(*) FROM pedidos
UNION ALL
SELECT 'itens_pedido', COUNT(*) FROM itens_pedido;
