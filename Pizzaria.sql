CREATE TABLE embalagem (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    material VARCHAR(50) NOT NULL,
    tamanho VARCHAR(20) NOT NULL,
    preco DECIMAL(8, 2) NOT NULL
);

CREATE TABLE receita (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    instrucoes TEXT NOT NULL,
    autor VARCHAR(100) NOT NULL
);

CREATE TABLE pizzaiolo (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE pizza (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    sabor VARCHAR(100) NOT NULL,
    preco DECIMAL(8, 2) NOT NULL,
    descricao TEXT,
    tamanho VARCHAR(20) NOT NULL,
    ingredientes TEXT,
    embalagem_id INT,
    receita_id INT,
    pizzaiolo_id INT,
    FOREIGN KEY (embalagem_id) REFERENCES embalagem(ID),
    FOREIGN KEY (receita_id) REFERENCES receita(ID),
    FOREIGN KEY (pizzaiolo_id) REFERENCES pizzaiolo(ID)
);

CREATE TABLE ingrediente (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE pizza_ingrediente (
    pizza_id INT,
    ingrediente_id INT,
    FOREIGN KEY (pizza_id) REFERENCES pizza(ID),
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(ID),
    PRIMARY KEY (pizza_id, ingrediente_id)
);

-- tabela embalagem
INSERT INTO embalagem (material, tamanho, preco) VALUES 
('Papelão', 'Pequeno', 1.99),
('Plástico', 'Médio', 3.49),
('Papelão', 'Grande', 3.99),
('Plástico', 'Extra Grande', 5.49),
('Papelão', 'Gigante', 8.99);

--  tabela receita
INSERT INTO receita (instrucoes, autor) VALUES 
('Misture todos os ingredientes secos em uma tigela grande.', 'Chef João'),
('Em uma panela, aqueça o óleo e refogue a cebola e o alho até dourarem.', 'Chef Maria'),
('Em uma tigela grande, misture a farinha, o fermento, o sal e o açúcar.', 'Chef Pedro'),
('Em uma panela, derreta a manteiga e doure a cebola.', 'Chef Ana'),
('Em uma tigela, misture a farinha, o fermento, o sal e o açúcar.', 'Chef Carlos');

-- Inserções para a tabela pizzaiolo
INSERT INTO pizzaiolo (nome, salario) VALUES 
('Marcos Silva', 3000.00),
('Ana Souza', 3200.00),
('Pedro Oliveira', 3100.00),
('Maria Santos', 3150.00),
('João Ferreira', 3300.00);

-- Inserções para a tabela pizza

INSERT INTO pizza (sabor, preco, tamanho, embalagem_id, receita_id, pizzaiolo_id) VALUES 
('Calabresa', 25.99, 'Grande', 3, 1, 1),
('Margherita', 23.99, 'Médio', 2, 2, 2),
('Frango com Catupiry', 27.99, 'Grande', 3, 3, 3),
('Quatro Queijos', 26.99, 'Médio', 4, 4, 4),
('Portuguesa', 28.99, 'Grande', 5, 5, 5);

-- tabela ingrediente
INSERT INTO ingrediente (nome) VALUES 
('Mussarela'),
('Calabresa'),
('Tomate'),
('Cebola'),
('Presunto');

-- tabela pizza_ingredient
INSERT INTO pizza_ingrediente (pizza_id, ingrediente_id) VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 3),
(2, 5),
(3, 1),
(3, 5),
(4, 1),
(4, 2),
(4, 3),
(4, 5),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5);

-- todas as pizzas e pizzaiolos
SELECT 
    p.ID AS 'ID da Pizza',
    p.sabor AS 'Sabor',
    p.preco AS 'Preço',
    p.tamanho AS 'Tamanho',
    e.material AS 'Material da Embalagem',
    e.tamanho AS 'Tamanho da Embalagem',
    e.preco AS 'Preço da Embalagem',
    r.instrucoes AS 'Instruções da Receita',
    r.autor AS 'Autor da Receita',
    pi.nome AS 'Nome do Pizzaiolo',
    pi.salario AS 'Salário do Pizzaiolo',
    GROUP_CONCAT(i.nome SEPARATOR ', ') AS 'Ingredientes'
FROM 
    pizza p
INNER JOIN 
    embalagem e ON p.embalagem_id = e.ID
INNER JOIN 
    receita r ON p.receita_id = r.ID
INNER JOIN 
    pizzaiolo pi ON p.pizzaiolo_id = pi.ID
INNER JOIN 
    pizza_ingrediente pi_ing ON p.ID = pi_ing.pizza_id
INNER JOIN 
    ingrediente i ON pi_ing.ingrediente_id = i.ID
GROUP BY 
    p.ID;
    
    -- pizza e infredientes
    SELECT 
    p.ID AS 'ID da Pizza',
    p.sabor AS 'Sabor',
    p.preco AS 'Preço',
    p.tamanho AS 'Tamanho',
    GROUP_CONCAT(i.nome SEPARATOR ', ') AS 'Ingredientes'
FROM 
    pizza p
INNER JOIN 
    pizza_ingrediente pi ON p.ID = pi.pizza_id
INNER JOIN 
    ingrediente i ON pi.ingrediente_id = i.ID
GROUP BY 
    p.ID;
    
    
    -- ingredientes e onde sao usados
    SELECT 
    i.nome AS 'Ingrediente',
    GROUP_CONCAT(p.sabor SEPARATOR ', ') AS 'Pizzas'
FROM 
    ingrediente i
INNER JOIN 
    pizza_ingrediente pi ON i.ID = pi.ingrediente_id
INNER JOIN 
    pizza p ON pi.pizza_id = p.ID
GROUP BY 
    i.ID;
    
    -- pizza, pizzaiolo e instruções
    SELECT 
    p.sabor AS 'Sabor da Pizza',
    pi.nome AS 'Nome do Pizzaiolo',
    r.instrucoes AS 'Instruções para Produção'
FROM 
    pizza p
INNER JOIN 
    pizzaiolo pi ON p.pizzaiolo_id = pi.ID
INNER JOIN 
    receita r ON p.receita_id = r.ID;



