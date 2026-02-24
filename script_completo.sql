/*---- Comandos de criação de banco comandos DDL----*/

/* Criando banco de dados */
CREATE DATABASE IF NOT EXISTS hospital_db_Danilo_Alberto;

USE hospital_db_Danilo_Alberto;

/* Criando tabela pacientes */
CREATE TABLE pacientes (
    idpacientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(45) NOT NULL,
    telefone INT(10) NOT NULL,
    email VARCHAR(45) NOT NULL,
    cpf INT(11) NOT NULL,
    rg INT(10) NOT NULL
);

ALTER TABLE pacientes
    MODIFY COLUMN data_nascimento DATE,
    MODIFY COLUMN endereco VARCHAR(45),
    MODIFY COLUMN telefone INT,
    MODIFY COLUMN email VARCHAR(45),
    MODIFY COLUMN cpf VARCHAR(45),
    MODIFY COLUMN rg VARCHAR(45);

/* Criando tabela convenios */
CREATE TABLE IF NOT EXISTS convenios (
    idconvenios INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    cnpj INT(14) NOT NULL,
    tempo_carencia VARCHAR(45) NOT NULL,
    numero_carteira INT NOT NULL
);

ALTER TABLE convenios
    MODIFY COLUMN cnpj VARCHAR(45) NOT NULL,
    MODIFY COLUMN numero_carteira VARCHAR(45) NOT NULL;

/* Adicionando chave estrangeira a pacientes */
ALTER TABLE pacientes
    ADD COLUMN convenios_idconvenios INT,
    ADD FOREIGN KEY (convenios_idconvenios) REFERENCES convenios(idconvenios);

/* Criando tabela medicos */
CREATE TABLE IF NOT EXISTS medicos (
    idmedicos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    crm INT NOT NULL
);

/* Criando tabela especialidades */
CREATE TABLE IF NOT EXISTS especialidades (
    idespecialidades INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL
);

/* Criando tabela medicos_especialidades para ligação n-n */
CREATE TABLE IF NOT EXISTS medicos_has_especialidades (
    medicos_idmedicos INT,
    especialidades_idespecialidades INT,
    FOREIGN KEY (medicos_idmedicos) REFERENCES medicos(idmedicos)
);

/* Adicionando chave estrangeira a medicos_especialidades */
ALTER TABLE medicos_has_especialidades
    ADD FOREIGN KEY (especialidades_idespecialidades) REFERENCES especialidades(idespecialidades);

/* Criando tabela consultas */
CREATE TABLE IF NOT EXISTS consultas (
    idconsultas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    valor DECIMAL(3,2) NOT NULL,
    medicos_idmedicos INT,
    FOREIGN KEY (medicos_idmedicos) REFERENCES medicos(idmedicos),
    pacientes_idpacientes INT,
    FOREIGN KEY (pacientes_idpacientes) REFERENCES pacientes(idpacientes),
    convenios_idconvenios INT,
    FOREIGN KEY (convenios_idconvenios) REFERENCES convenios(idconvenios),
    especialidades_idespecialidades INT,
    FOREIGN KEY (especialidades_idespecialidades) REFERENCES especialidades(idespecialidades)
);

ALTER TABLE consultas
    MODIFY COLUMN valor DECIMAL(4,2) NOT NULL;

/* Criando tabela receitas */
CREATE TABLE IF NOT EXISTS receitas (
    idreceitas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    medicamento TEXT,
    dosagem TEXT,
    consultas_idconsultas INT,
    FOREIGN KEY (consultas_idconsultas) REFERENCES consultas(idconsultas)
);

/* Criando tabela quarto */
CREATE TABLE IF NOT EXISTS quarto (
    idquarto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL 
);

/* Criando tabela tipo_quarto */
CREATE TABLE IF NOT EXISTS tipo_quarto (
    idtipo_quarto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    valor_diaria DECIMAL(3,2),
    descricao VARCHAR(45) NOT NULL
);

ALTER TABLE tipo_quarto
    MODIFY COLUMN valor_diaria DECIMAL(5,2);

/* Adicionando chave estrangeira */
ALTER TABLE quarto
    ADD COLUMN tipo_quarto_idtipo_quarto INT,
    ADD FOREIGN KEY (tipo_quarto_idtipo_quarto) REFERENCES tipo_quarto(idtipo_quarto);

/* Criando tabela internacao */
CREATE TABLE IF NOT EXISTS internacao (
    idinternacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_entrada DATE NOT NULL,
    data_prev_alta DATE NOT NULL,
    data_alta DATE NOT NULL,
    procedimentos TEXT NOT NULL,
    quarto_idquarto INT NOT NULL,
    pacientes_idpacientes INT NOT NULL,
    medicos_idmedicos INT NOT NULL,
    FOREIGN KEY (quarto_idquarto) REFERENCES quarto(idquarto),
    FOREIGN KEY (pacientes_idpacientes) REFERENCES pacientes(idpacientes),
    FOREIGN KEY (medicos_idmedicos) REFERENCES medicos(idmedicos)
);

/* Criando tabela enfermeiro */
CREATE TABLE IF NOT EXISTS enfermeiro (
    idenfermeiro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    cre VARCHAR(10)
);

ALTER TABLE enfermeiro
    MODIFY COLUMN cpf VARCHAR(45) NOT NULL;

/* Criando tabela internacao_has_enfermeiro e adicionando chaves estrangeiras n-n */
CREATE TABLE IF NOT EXISTS internacao_has_enfermeiro (
    internacao_idinternacao INT NOT NULL,
    enfermeiro_idenfermeiro INT NOT NULL,
    FOREIGN KEY (internacao_idinternacao) REFERENCES internacao(idinternacao),
    FOREIGN KEY (enfermeiro_idenfermeiro) REFERENCES enfermeiro(idenfermeiro)
);
/* ---------------------- FIM SCRIPT ---------------------- */


/*---- Comandos de manipulação de banco comandos DML----*/


/* Inserindo medicos na tabela */
INSERT INTO medicos (nome, crm) 
VALUES
    ('Ester Adriana Araújo', 11111),
    ('Heloisa Isis Baptista', 12121),
    ('Sophia Tatiane Drumond', 11121),
    ('Tânia Kamilly Tatiane Novaes', 11131),
    ('Elza Elza Moreira', 11141),
    ('Theo Manuel Cavalcanti', 11151),
    ('Bruno Iago Fernandes', 11161),
    ('Sophia Márcia Ferreira', 11171),
    ('Simone Esther Souza', 11181),
    ('Caio Martin Anderson Castro', 11191);

/* Inserindo pacientes na tabela */
INSERT INTO pacientes (idpacientes, nome, data_nascimento, endereco, telefone, email, cpf, rg, convenios_idconvenios) 
VALUES
    ('1', 'Martin Diego Dias', '2001-04-02', 'Rua Diogo de Ordonhes', '998171820', 'martin-dias91@mpc.com.br', 43267259827, '125295017', '3'),
    ('2', 'Pietra Sabrina Viana', '1944-07-01', 'Alameda do Pilões', '997165165', 'pietrasabrinaviana@rjnet.com.br', 26315642861, 181559808, '2'),
    ('3', 'Lorenzo Osvaldo Galvão', '2005-05-03', 'Rua Irmã Leonor de São José', '993443377', 'lorenzoosvaldogalvao@hotmmail.com', 31247087840, 278047257, '4'),
    ('4', 'Henry Kauê da Mota', '1982-07-11', 'Viela Um', '984284524', 'henry_damota@araraquara.com.br', 67205978840, 206936953, '2'),
    ('5', 'Henry Matheus Cavalcanti', '1990-08-01', 'Rua Mário Magri', '989398643', 'henry-cavalcanti72@golinelli.eti.br', 62905267828, 228224536, '1'),
    ('6', 'Manoel Victor Rocha', '1950-08-02', 'Rua Joaquim de Almeida', '985080707', 'manoel.victor.rocha@daou.com.br', 39653280856, 407948132, '4'),
    ('7', 'Geraldo Theo Alexandre dos Santos', '1994-07-04', 'Praça dos Ipês', '984914635', 'geraldo_theo_dossantos@compecia.com.br', 84575615889, 411748269, '2'),
    ('8', 'Henrique Augusto Thiago Moura', '1956-07-27', 'Rua Benedito Lino de Campos', '984159094', 'henriqueaugustomoura@mucoucah.com.br', 00149283881, 482666742, '3'),
    ('9', 'Guilherme Miguel Freitas', '2004-01-07', 'Avenida Poema', '989988115', 'guilherme_freitas@fictor.com.br', 45481499886, 384227892, '4'),
    ('10', 'Regina Elisa Alves', '2004-03-09', 'Rua Antenor Leite da Cunha', '994479497', 'regina-alves97@novotempo.com', 86903398848, 185275412, '1');

/* Inserindo consultas */
INSERT INTO consultas (data, hora, valor, medicos_idmedicos, pacientes_idpacientes, convenios_idconvenios)
VALUES
    ('2018-08-07', '12:30:00', '45.50', '1', '2', '2'),
    ('2019-05-02', '07:10:00', '40.00', '2', '1', '3'),
    ('2020-02-02', '10:10:00', '40.00', '3', '4', '2'),
    ('2021-04-20', '14:00:00', '35.00', '4', '5', '1'),
    ('2019-06-22', '09:30:00', '40.00', '6', '1', '3'),
    ('2022-02-10', '15:30:00', '45.00', '5', '6', '4'),
    ('2022-12-01', '06:30:00', '50.00', '10', '8', '3'),
    ('2021-08-28', '18:40:00', '55.00', '7', '2', '2'),
    ('2020-04-16', '15:20:00', '35.00', '9', '9', '4'),
    ('2022-02-22', '11:30:00', '30.00', '8', '10', '1');

/* Inserindo receitas a consultas */
INSERT INTO receitas (medicamento, dosagem, consultas_idconsultas)
VALUES
    ('clonazepan', '2,5 mg com 20 comprimidos. tomar 1 comprimdo a cada 8 horas.', '2'),
    ('bromazepam', '3 mg com 30 comprimidos. tomar 1 comprimido a noite.', '2'),
    ('clavulin', '875 mg com 10 comprimidos. tomar 1 comprimdo a cada 12 horas por 5 dias.', '5'),
    ('ibuprofeno', '600 mg com 30 comprimidos. tomar 1 comprimdo a cada 8 horas por 10 dias.', '5'),
    ('aerolin spray', '100 mcrg  com 200 doses. 3 puffs a cada 8 se nescecidade.', '7'),
    ('clenil spray', '250 mcrg com 200 doses. 1 puff ao dia.', '7'),
    ('omeprazol', '20 mg com 28 comprimidos. tomar 1 comprimdo em jejum .', '1'),
    ('hidroxido de aluminio', '200 ml. tomar uma colher  de sopa a cada refeição.', '1'),
    ('Glifaxe xr', '500 mg com 30 comprimidos. tomar 1 comprimdo a cada 8 horas.', '10'),
    ('losartana', '50 mg com 30 comprimidos. tomar 1 comprimdo a cada 8 horas.', '10'),
    ('insulina nph', 'utilizar 5unidades de manha, 10 a tarde, 8 a noite.', '10');

/* Inserindo quartos */
INSERT INTO quarto (numero)
VALUES (1), (5), (8);

/* Inserindo internações */
INSERT INTO internacao (data_entrada, data_prev_alta, data_alta, procedimentos, quarto_idquarto, pacientes_idpacientes, medicos_idmedicos)
VALUES
    ('2018-08-22', '2018-09-01', '2018-09-01', 'jejum', '1', '2', '1'),
    ('2020-07-12', '2020-10-20', '2020-11-10', 'Administração de Medicação Intravenosa', '2', '5', '5'),
    ('2019-07-02', '2019-08-15', '2020-01-05', 'Monitoramento Cardíaco Contínuo', '3', '8', '6'),
    ('2021-04-02', '2021-06-12', '2021-06-30', 'Curativos e Tratamento de Feridas', '1', '10', '4'),
    ('2021-12-20', '2022-01-02', '2022-01-10', 'Administração de Oxigênio por Cateter Nasal', '3', '5', '8'),
    ('2021-08-22', '2021-10-01', '2021-10-30', 'Mudança de Posição e Mobilização', '2', '10', '9'),
    ('2022-02-05', '2022-06-25', '2022-07-15', 'Administração de Nutrição Enteral', '3', '3', '2');

/* Inserindo enfermeiro */
INSERT INTO enfermeiro (nome, cpf, cre)
VALUES
    ('Manuela Ayla Fogaça', '59392816804', '5555'),
    ('Lúcia Alice da Silva', '32473781117', '1555'),
    ('Kevin Nicolas Davi Cavalcanti', '77992699289', '4587'),
    ('Laís Aline Stella Carvalho', '72674738812', '1456'),
    ('Tânia Isabella Elisa da Cunha', '34935938307', '5287'),
    ('Sophie Clara Aparício', '43259749381', '2366');

/* Associando enfermeiros a internações */
INSERT INTO internacao_has_enfermeiro (internacao_idinternacao, enfermeiro_idenfermeiro)
VALUES
    ('1', '2'), ('1', '1'),
    ('2', '5'), ('2', '6'),
    ('3', '6'), ('3', '4'),
    ('4', '3'), ('4', '4'),
    ('5', '2'), ('5', '1'),
    ('6', '3'), ('6', '5'),
    ('7', '2'), ('7', '6');

/* Inserindo tipo_quarto */
INSERT INTO tipo_quarto (idtipo_quarto, valor_diaria, descricao)
VALUES
    (1, '50.00', 'Enfermaria'),
    (2, '100.00', 'Quartos duplos'),
    (3, '250.00', 'Apartamentos');

/* Inserindo convenios */
INSERT INTO convenios (idconvenios, nome, cnpj, tempo_carencia, numero_carteira)
VALUES
    (1, 'Notredame', '76679098000117', '30 dias', ''),
    (2, 'Amil', '15693338000143', '60 dias', ''),
    (3, 'Central Nacional Unimed', '27408581000151', '50 dias', ''),
    (4, 'Bradesco Sáude', '16278267000185', 'não há', '');

/* Inserindo especialidades */
INSERT INTO especialidades (descricao)
VALUES
    ('pediatria'),
    ('clínica geral'),
    ('gastroenterologia'),
    ('dermatologia'),
    ('Neurologia'),
    ('Psiquiatria'),
    ('Oftalmologia');


/* Incluindo coluna "Em_Atividade" na tabela medicos */
ALTER TABLE medicos
    ADD COLUMN Em_Atividade BOOL;

/* Alterando a coluna Em_Atividade para 0 (Não) para médicos específicos */
UPDATE medicos
SET Em_Atividade = 0 
WHERE idmedicos = 1 OR idmedicos = 3;

/* Alterando a coluna Em_Atividade para 1 (Sim) para os demais médicos */
UPDATE medicos
SET Em_Atividade = 1
WHERE idmedicos <> 1 AND idmedicos <> 3;

/* Alterando data da alta para três dias após a entrada em internações específicas */
UPDATE internacao
SET data_alta = '2018-08-25' 
WHERE idinternacao = 1;

UPDATE internacao
SET data_alta = '2021-04-05' 
WHERE idinternacao = 4;

/* Removendo associação de convênio em consultas específicas */
UPDATE consultas
SET convenios_idconvenios = NULL 
WHERE idconsultas = 6;

UPDATE consultas
SET convenios_idconvenios = NULL 
WHERE idconsultas = 9;

/* Removendo associação de convênio em pacientes específicos */
UPDATE pacientes
SET convenios_idconvenios = NULL 
WHERE idpacientes = 3 OR idpacientes = 6 OR idpacientes = 9;

/* Deletando o último convênio cadastrado */
DELETE FROM convenios 
WHERE idconvenios = 4 
LIMIT 1;

/* Incluindo consultas realizadas em 2020 sem convenio */
INSERT INTO consultas (data, hora, valor, medicos_idmedicos, pacientes_idpacientes)
VALUES
    ('2020-08-09', '14:20:00', '40.00', '4', '2'),
    ('2020-05-17', '15:50:20', '50.20', '1', '4');

/* Incluindo consultas realizadas em 2020 com convenio */
INSERT INTO consultas (data, hora, valor, medicos_idmedicos, pacientes_idpacientes, convenios_idconvenios)
VALUES
    ('2020-08-05', '12:20:00', 35.00, '5', '3', '2'),
    ('2020-01-15', '12:50:00', 35.00, '3', '8', '2');

/* Incluindo especialidades a medicos */
INSERT INTO medicos_has_especialidades (medicos_idmedicos, especialidades_idespecialidades)
VALUES
    ('1', '2'), ('2', '3'), ('3', '1'), ('4', '6'), ('5', '7'),
    ('6', '4'), ('7', '5'), ('8', '3'), ('9', '1'), ('10', '2');

/* Modificando data_nascimento pacientes */
UPDATE pacientes SET data_nascimento = '2018-02-20' WHERE idpacientes = 1;
UPDATE pacientes SET data_nascimento = '2020-05-10' WHERE idpacientes = 5;
UPDATE pacientes SET data_nascimento = '2022-05-15' WHERE idpacientes = 7;

/* Atualizando especialidades na tabela consultas */
UPDATE consultas SET especialidades_idespecialidades = 2 WHERE medicos_idmedicos = 1;
UPDATE consultas SET especialidades_idespecialidades = 3 WHERE medicos_idmedicos = 2;
UPDATE consultas SET especialidades_idespecialidades = 1 WHERE medicos_idmedicos = 3;
UPDATE consultas SET especialidades_idespecialidades = 6 WHERE medicos_idmedicos = 4;
UPDATE consultas SET especialidades_idespecialidades = 7 WHERE medicos_idmedicos = 5;
UPDATE consultas SET especialidades_idespecialidades = 4 WHERE medicos_idmedicos = 6;
UPDATE consultas SET especialidades_idespecialidades = 5 WHERE medicos_idmedicos = 7;
UPDATE consultas SET especialidades_idespecialidades = 3 WHERE medicos_idmedicos = 8;
UPDATE consultas SET especialidades_idespecialidades = 1 WHERE medicos_idmedicos = 9;
UPDATE consultas SET especialidades_idespecialidades = 2 WHERE medicos_idmedicos = 10;

/* Incluindo mais quartos */
INSERT INTO quarto (numero, tipo_quarto_idtipo_quarto)
VALUES
    ('2', '3'), ('3', '2'), ('4', '3'), ('6', '1'), ('7', '3');

/* Incluindo mais internacoes */
INSERT INTO internacao (data_entrada, data_prev_alta, data_alta, procedimentos, quarto_idquarto, pacientes_idpacientes, medicos_idmedicos)
VALUES
    ('2019-05-22', '2018-05-30', '2018-05-25', 'jejum', '4', '3', '5'),
    ('2020-08-12', '2020-09-20', '2020-09-30', 'Administração de Medicação Intravenosa', '5', '1', '1'),
    ('2019-09-30', '2019-10-10', '2020-10-12', 'Monitoramento Cardíaco Contínuo', '6', '8', '3'),
    ('2021-04-15', '2021-06-10', '2021-06-11', 'Curativos e Tratamento de Feridas', '7', '5', '4'),
    ('2021-12-30', '2022-01-02', '2022-01-12', 'Administração de Oxigênio por Cateter Nasal', '8', '10', '8');

/* Atualizando e incluindo o tipo de quarto a quarto */
UPDATE quarto SET tipo_quarto_idtipo_quarto = 1 WHERE idquarto = 2;
UPDATE quarto SET tipo_quarto_idtipo_quarto = 2 WHERE idquarto = 1;
UPDATE quarto SET tipo_quarto_idtipo_quarto = 3 WHERE idquarto = 3;

/* Mudando o tipo de quarto para enfermaria e ajustando médicos */
UPDATE internacao SET medicos_idmedicos = 9 WHERE idinternacao = 2;
UPDATE internacao SET quarto_idquarto = 1 WHERE idinternacao = 7;
UPDATE internacao SET quarto_idquarto = 1 WHERE idinternacao = 5;

/* ---------------------- FIM SCRIPT ---------------------- */

/*---- Comandos de query  de banco comandos DQL----*/

USE hospital_db_danilo_alberto;

/* Todos os dados e o valor médio das consultas do ano de 2020 realizadas SEM convênio */
SELECT * FROM consultas 
WHERE YEAR(data) = 2020 AND convenios_idconvenios IS NULL;

SELECT AVG(valor) AS valor_medio FROM consultas 
WHERE YEAR(data) = 2020 AND convenios_idconvenios IS NULL;

/* Todos os dados e o valor médio das consultas do ano de 2020 realizadas POR convênio */
SELECT * FROM consultas 
WHERE YEAR(data) = 2020 AND convenios_idconvenios IS NOT NULL;

SELECT AVG(valor) AS valor_medio FROM consultas 
WHERE YEAR(data) = 2020 AND convenios_idconvenios IS NOT NULL;

/* Todos os dados das internações que tiveram data de alta maior que a data prevista */
SELECT * FROM internacao 
WHERE data_alta > data_prev_alta;

/* Receituário completo da primeira consulta registrada com receituário associado */
SELECT * FROM receitas 
WHERE consultas_idconsultas = 1;

/* Consulta de maior e menor valor (sem convênio) usando Subqueries */
SELECT * FROM consultas 
WHERE convenios_idconvenios IS NULL 
AND (
    valor = (SELECT MAX(valor) FROM consultas WHERE convenios_idconvenios IS NULL)  
    OR 
    valor = (SELECT MIN(valor) FROM consultas WHERE convenios_idconvenios IS NULL)
)
ORDER BY valor DESC;

/* Cálculo do total da internação (diária * dias) */
SELECT 
    i.*, 
    t.idtipo_quarto, 
    t.valor_diaria,
    (DATEDIFF(i.data_alta, i.data_entrada) * t.valor_diaria) AS total_internacao, 
    DATEDIFF(i.data_alta, i.data_entrada) AS diferenca_dias 
FROM internacao i 
JOIN tipo_quarto t ON i.quarto_idquarto = t.idtipo_quarto;

/* Internações em quartos do tipo “apartamento” */
SELECT i.data_entrada, i.procedimentos, q.numero  
FROM internacao i 
JOIN quarto q ON i.quarto_idquarto = q.idquarto  
JOIN tipo_quarto ti ON ti.idtipo_quarto = q.tipo_quarto_idtipo_quarto 
WHERE ti.descricao = 'Apartamentos';

/* Pacientes menores de 18 anos em especialidades exceto pediatria */
SELECT 
    p.nome AS nome_paciente, 
    c.data AS data_consulta, 
    es.descricao AS nome_especialidades 
FROM pacientes p 
JOIN consultas c ON p.idpacientes = c.pacientes_idpacientes
JOIN especialidades es ON es.idespecialidades = c.especialidades_idespecialidades 
WHERE es.descricao != 'pediatria' 
AND TIMESTAMPDIFF(YEAR, p.data_nascimento, c.data) < 18 
ORDER BY c.data;

/* Internações por "gastroenterologia" em "enfermaria" */
SELECT 
    p.nome AS nome_paciente, 
    m.nome AS nome_medico, 
    i.data_entrada AS data_internacao, 
    i.procedimentos AS procedimentos, 
    es.descricao AS especialidade,
    ti.descricao AS tipo_quarto 
FROM pacientes AS p 
JOIN internacao AS i ON i.pacientes_idpacientes = p.idpacientes 
JOIN medicos AS m ON i.medicos_idmedicos = m.idmedicos 
JOIN medicos_has_especialidades AS esm ON esm.medicos_idmedicos = m.idmedicos 
JOIN especialidades AS es ON esm.especialidades_idespecialidades = es.idespecialidades 
JOIN quarto AS q ON i.quarto_idquarto = q.idquarto
JOIN tipo_quarto AS ti ON q.tipo_quarto_idtipo_quarto = ti.idtipo_quarto 
WHERE es.idespecialidades = 3;

/* Quantidade de consultas por médico */
SELECT 
    m.nome AS nome_medico, 
    m.crm, 
    COUNT(c.idconsultas) AS total_consultas 
FROM medicos AS m 
JOIN consultas AS c ON m.idmedicos = c.medicos_idmedicos 
GROUP BY m.idmedicos 
ORDER BY m.nome;

/* Enfermeiros com mais de uma internação (Uso de HAVING) */
SELECT 
    e.nome AS nome_enfermeiro, 
    e.cre AS numero_registro,
    COUNT(ie.internacao_idinternacao) AS numero_internacao 
FROM enfermeiro AS e 
LEFT JOIN internacao_has_enfermeiro AS ie ON e.idenfermeiro = ie.enfermeiro_idenfermeiro 
GROUP BY e.idenfermeiro 
HAVING COUNT(ie.internacao_idinternacao) > 1 
ORDER BY e.nome;

/* --- Consultas autorais: Filtro de especialidades específicas --- */
SELECT 
    p.nome AS nome_paciente, 
    m.nome AS nome_medico, 
    c.data AS data_consulta, 
    es.descricao 
FROM pacientes AS p 
JOIN consultas AS c ON c.pacientes_idpacientes = p.idpacientes
JOIN medicos AS m ON c.medicos_idmedicos = m.idmedicos 
JOIN medicos_has_especialidades AS mes ON mes.medicos_idmedicos = m.idmedicos 
JOIN especialidades AS es ON mes.especialidades_idespecialidades = es.idespecialidades 
WHERE es.descricao <> 'dermatologia' AND es.descricao <> 'pediatria' 
ORDER BY p.nome;

/* ---------------------- FIM SCRIPT ---------------------- */


