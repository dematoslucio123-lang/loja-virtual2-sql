# 🛒 Loja Virtual — Banco de Dados SQL

Banco de dados relacional de uma loja virtual fictícia, criado para prática de SQL com PostgreSQL.

## 📦 Estrutura do Banco

```
loja_virtual
├── clientes       (25 registros)
├── categorias     (6 registros)
├── produtos       (30 registros)
├── funcionarios   (10 registros)
├── pedidos        (40 registros)
└── itens_pedido   (75+ registros)
```

## 🗺️ Diagrama de Relacionamentos

```
clientes ──────────── pedidos ──────────── itens_pedido
                         │                      │
                    funcionarios             produtos
                                                 │
                                            categorias
```

## ⚙️ Como usar

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/loja-virtual-sql.git
cd loja-virtual-sql
```

### 2. Crie o banco no PostgreSQL

```bash
psql -U postgres -c "CREATE DATABASE loja_virtual;"
```

### 3. Execute o script

```bash
psql -U postgres -d loja_virtual -f loja_virtual.sql
```

Ou abra o arquivo `loja_virtual.sql` diretamente no **pgAdmin** e execute.

---

## 📋 Descrição das Tabelas

### `clientes`
| Coluna | Tipo | Descrição |
|---|---|---|
| id | SERIAL | Chave primária |
| nome | VARCHAR | Nome completo |
| email | VARCHAR | E-mail único |
| cpf | VARCHAR | CPF único |
| cidade | VARCHAR | Cidade |
| estado | CHAR(2) | UF |
| data_nascimento | DATE | Data de nascimento |
| data_cadastro | DATE | Data de cadastro |

### `produtos`
| Coluna | Tipo | Descrição |
|---|---|---|
| id | SERIAL | Chave primária |
| nome | VARCHAR | Nome do produto |
| categoria_id | INT | FK → categorias |
| preco | NUMERIC | Preço unitário |
| estoque | INT | Qtd em estoque |

### `pedidos`
| Coluna | Tipo | Descrição |
|---|---|---|
| id | SERIAL | Chave primária |
| cliente_id | INT | FK → clientes |
| funcionario_id | INT | FK → funcionarios |
| data_pedido | DATE | Data do pedido |
| status | VARCHAR | pago / pendente / cancelado / enviado |
| valor_total | NUMERIC | Valor total do pedido |

### `itens_pedido`
| Coluna | Tipo | Descrição |
|---|---|---|
| id | SERIAL | Chave primária |
| pedido_id | INT | FK → pedidos |
| produto_id | INT | FK → produtos |
| quantidade | INT | Quantidade comprada |
| preco_unitario | NUMERIC | Preço no momento da compra |

---

## 🧪 Exemplos de Queries

### Total de pedidos por status
```sql
SELECT status, COUNT(*) AS total, SUM(valor_total) AS receita
FROM pedidos
GROUP BY status
ORDER BY receita DESC;
```

### Top 5 produtos mais vendidos
```sql
SELECT p.nome, SUM(i.quantidade) AS total_vendido
FROM itens_pedido i
JOIN produtos p ON i.produto_id = p.id
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 5;
```

### Clientes que gastaram mais de R$2.000
```sql
SELECT c.nome, SUM(pe.valor_total) AS total_gasto
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
WHERE pe.status = 'pago'
GROUP BY c.nome
HAVING SUM(pe.valor_total) > 2000
ORDER BY total_gasto DESC;
```

### Classificação de produtos por faixa de preço
```sql
SELECT nome, preco,
  CASE
    WHEN preco < 100  THEN 'Econômico'
    WHEN preco < 500  THEN 'Intermediário'
    WHEN preco < 1500 THEN 'Premium'
    ELSE 'Luxo'
  END AS faixa_preco
FROM produtos
ORDER BY preco;
```

---

## 🛠️ Tecnologias

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-informational?style=for-the-badge)

---

## 👤 Autor

**Lucio** — git clone https://github.com/dematoslucio123-lang/loja-virtual-sql.git · [LinkedIn](luciodematos)

Projeto criado para prática e portfólio de SQL.
