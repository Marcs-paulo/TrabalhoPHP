-- Criação da "DATABASE"
CREATE DATABASE Escola_MCPF;
USE Escola_MCPF;

-- Criação de tabelas
CREATE TABLE Alunos (
    nome_aluno VARCHAR(150),
    matricula_aluno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_nascimento_aluno DATE,
    fk_Avaliacao_ID INT
);


CREATE TABLE Professor (
    nome_prof VARCHAR(150),
    matricula_prof INT NOT NULL PRIMARY KEY,
    data_nascimento DATE,
    disciplina_prof VARCHAR(150)
);

CREATE TABLE Avaliacao (
    tipologia VARCHAR(150),
    ID INT NOT NULL PRIMARY KEY,
    peso FLOAT
);

CREATE TABLE Curso (
    coordenador VARCHAR(150),
    Periodo VARCHAR(150),
    carga_horaria TIME,
    nome VARCHAR(150),
    codigo_curso INT NOT NULL PRIMARY KEY
);

-- Inserção de dados nas tabelas
INSERT INTO Alunos (nome_aluno, data_nascimento_aluno, fk_Avaliacao_ID)
VALUES ('João', '1995-05-15', 1),
       ('Maria', '1998-12-10', 2),
       ('Pedro', '1997-07-25', 1),
       ('Ana', '1996-02-03', 3),
       ('Lucas', '1999-09-18', 2);

CREATE TABLE Notas (
    disciplinas_nome VARCHAR(150),
    avaliacoes_individuais DECIMAL(5,1) NOT NULL,
    medias_finais DECIMAL(5,2) NOT NULL,
    codigo_notas INT NOT NULL PRIMARY KEY,
    fk_Curso_codigo_curso INT,
    fk_Disciplina_codigo_disciplina INT,
    fk_Avaliacao_ID INT,
    periodo VARCHAR(20) NOT NULL,
    notas_trabalhos DECIMAL(5,2) NOT NULL,
    bimestre INT NOT NULL,
    FOREIGN KEY (fk_Curso_codigo_curso) REFERENCES Curso(codigo_curso),
    FOREIGN KEY (fk_Disciplina_codigo_disciplina) REFERENCES Disciplina(codigo_disciplina),
    FOREIGN KEY (fk_Avaliacao_ID) REFERENCES Avaliacao(ID)
);



INSERT INTO Professor (nome_prof, matricula_prof, data_nascimento, disciplina_prof)
VALUES ('Carlos', 1001, '1978-09-05', 'Matemática'),
       ('Laura', 1002, '1985-07-12', 'História'),
       ('Fernanda', 1003, '1976-03-20', 'Física'),
       ('Ricardo', 1004, '1982-11-28', 'Química'),
       ('Mariana', 1005, '1990-04-15', 'Geografia');

INSERT INTO Avaliacao (tipologia, ID, peso)
VALUES ('Prova', 1, 0.6),
       ('Trabalho', 2, 0.4);


INSERT INTO Curso (coordenador, Periodo, carga_horaria, nome, codigo_curso)
VALUES ('Maria Silva', '2023/1', '08:00:00', 'Engenharia', 1),
       ('João Santos', '2023/2', '14:30:00', 'Letras', 2);

-- Criação da tabela Disciplina
CREATE TABLE Disciplina (
    codigo_disciplina INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_disciplina VARCHAR(150),
    fk_Curso_codigo_curso INT,
    fk_Professor_matricula_prof INT,
    FOREIGN KEY (fk_Curso_codigo_curso) REFERENCES Curso(codigo_curso),
    FOREIGN KEY (fk_Professor_matricula_prof) REFERENCES Professor(matricula_prof)
);

-- Inserção de dados na tabela Disciplina
INSERT INTO Disciplina (nome_disciplina, fk_Curso_codigo_curso, fk_Professor_matricula_prof)
VALUES ('Matemática', 1, 1001),
       ('História', 2, 1002),
       ('Física', 1, 1003),
       ('Química', 1, 1004),
       ('Geografia', 2, 1005);

-- Adicionar campos na tabela "Notas"
ALTER TABLE Notas
ADD COLUMN periodo VARCHAR(20) NOT NULL,
ADD COLUMN notas_trabalhos DECIMAL(5,2) NOT NULL;

-- Adicionar campos na tabela "Alunos"
ALTER TABLE Alunos
ADD COLUMN media_final_bimestral DECIMAL(5,2) NOT NULL,
ADD COLUMN media_anual DECIMAL(5,2) NOT NULL;

ALTER TABLE Notas ADD COLUMN bimestre INT NOT NULL;

UPDATE Notas SET bimestre = 1 WHERE codigo_notas IN (1, 2, 3, 4, 5);

-- Adicionar coluna na tabela Alunos
ALTER TABLE Alunos ADD COLUMN fk_Curso_codigo_curso INT, 
ADD CONSTRAINT fk_Curso_Aluno FOREIGN KEY (fk_Curso_codigo_curso) REFERENCES Curso(codigo_curso);

ALTER TABLE Notas ADD COLUMN fk_Curso_codigo_curso INT, ADD CONSTRAINT fk_Curso_Notas FOREIGN KEY (fk_Curso_codigo_curso) REFERENCES Curso(codigo_curso);

-- Remova a coluna fk_Curso_nome da tabela Notas
ALTER TABLE Notas DROP COLUMN fk_Curso_codigo_curso;

-- Adicione a coluna fk_Disciplina_codigo_disciplina na tabela Notas
ALTER TABLE Notas ADD COLUMN fk_Disciplina_codigo_disciplina INT,
ADD CONSTRAINT fk_Disciplina_Notas FOREIGN KEY (fk_Disciplina_codigo_disciplina) REFERENCES Disciplina(codigo_disciplina);

CREATE TABLE Atribui (
    codigo_atribui INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_Notas_codigo_notas INT,
    fk_Professor_matricula_prof INT,
    FOREIGN KEY (fk_Notas_codigo_notas) REFERENCES Notas(codigo_notas),
    FOREIGN KEY (fk_Professor_matricula_prof) REFERENCES Professor(matricula_prof)
);

CREATE TABLE tem (
    fk_Aluno_matricula_aluno INT,
    fk_Curso_codigo_curso INT,
    FOREIGN KEY (fk_Aluno_matricula_aluno) REFERENCES Alunos(matricula_aluno),
    FOREIGN KEY (fk_Curso_codigo_curso) REFERENCES Curso(codigo_curso)
);

ALTER TABLE Notas ADD COLUMN fk_Disciplina_codigo_disciplina INT, ADD CONSTRAINT fk_Disciplina_Notas FOREIGN KEY (fk_Disciplina_codigo_disciplina) REFERENCES Disciplina(codigo_disciplina);


-- Remova a coluna fk_Curso_nome da tabela Notas
ALTER TABLE Notas DROP COLUMN fk_Curso_codigo_curso;

-- Adicione a coluna fk_Curso_codigo_curso na tabela Notas
-- Remova a coluna fk_Curso_codigo_curso da tabela Notas
ALTER TABLE Notas DROP COLUMN fk_Curso_codigo_curso;

-- Adicione a coluna fk_Curso_codigo_curso na tabela Notas com a referência correta
ALTER TABLE Notas ADD COLUMN fk_Curso_codigo_curso INT,
ADD CONSTRAINT fk_Curso_Notas FOREIGN KEY (fk_Curso_codigo_curso) REFERENCES Curso(codigo_curso);


-- Adicione a coluna fk_Disciplina_codigo_disciplina na tabela Notas
ALTER TABLE Notas ADD COLUMN fk_Disciplina_codigo_disciplina INT,
ADD CONSTRAINT fk_Disciplina_Notas FOREIGN KEY (fk_Disciplina_codigo_disciplina) REFERENCES Disciplina(codigo_disciplina);


ALTER TABLE Notas ADD COLUMN avaliacoes_individuais DECIMAL(5,1) NOT NULL;

ALTER TABLE Notas ADD COLUMN medias_finais DECIMAL(5,2) NOT NULL;

-- Adicione a coluna fk_Disciplina_codigo_disciplina na tabela tem
ALTER TABLE tem ADD COLUMN fk_Disciplina_codigo_disciplina INT,
ADD CONSTRAINT fk_Disciplina_tem FOREIGN KEY (fk_Disciplina_codigo_disciplina) REFERENCES Disciplina(codigo_disciplina);

-- Junção das tabelas
SELECT Alunos.nome_aluno, Alunos.data_nascimento_aluno, Professor.nome_prof, Professor.data_nascimento, Curso.nome, Disciplina.nome_disciplina, Avaliacao.tipologia
FROM Alunos
JOIN tem ON Alunos.matricula_aluno = tem.fk_Aluno_matricula_aluno
JOIN Curso ON tem.fk_Curso_codigo_curso = Curso.codigo_curso
JOIN Disciplina ON tem.fk_Disciplina_codigo_disciplina = Disciplina.codigo_disciplina
JOIN Notas ON Disciplina.codigo_disciplina = Notas.fk_Disciplina_codigo_disciplina
JOIN Atribui ON Notas.codigo_notas = Atribui.fk_Notas_codigo_notas
JOIN Professor ON Atribui.fk_Professor_matricula_prof = Professor.matricula_prof
JOIN Avaliacao ON Notas.fk_Avaliacao_ID = Avaliacao.ID;


SELECT *
FROM tem
WHERE fk_Disciplina_codigo_disciplina = 1;

-- Remova a tabela tem
DROP TABLE tem;

-- Crie a tabela aluno_disciplina
CREATE TABLE aluno_disciplina (
    fk_Aluno_matricula_aluno INT,
    fk_Disciplina_codigo_disciplina INT,
    FOREIGN KEY (fk_Aluno_matricula_aluno) REFERENCES Alunos(matricula_aluno),
    FOREIGN KEY (fk_Disciplina_codigo_disciplina) REFERENCES Disciplina(codigo_disciplina)
);



-- Criação da tabela Medias
CREATE TABLE Medias (
    codigo_medias INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_Aluno_matricula_aluno INT,
    fk_Disciplina_codigo_disciplina INT,
    bimestre INT NOT NULL,
    media_bimestral DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (fk_Aluno_matricula_aluno) REFERENCES Alunos(matricula_aluno),
    FOREIGN KEY (fk_Disciplina_codigo_disciplina) REFERENCES Disciplina(codigo_disciplina)
);

-- Cálculo das médias bimestrais e inserção na tabela Medias
INSERT INTO Medias (fk_Aluno_matricula_aluno, fk_Disciplina_codigo_disciplina, bimestre, media_bimestral)
SELECT Alunos.matricula_aluno, Disciplina.codigo_disciplina, Notas.bimestre, (Notas.notas_trabalhos * 0.4) + (Notas.avaliacoes_individuais * 0.6)
FROM Alunos
JOIN aluno_disciplina ON Alunos.matricula_aluno = aluno_disciplina.fk_Aluno_matricula_aluno
JOIN Disciplina ON aluno_disciplina.fk_Disciplina_codigo_disciplina = Disciplina.codigo_disciplina
JOIN Notas ON Disciplina.codigo_disciplina = Notas.fk_Disciplina_codigo_disciplina;

-- Atualização da tabela Alunos com as médias bimestrais
UPDATE Alunos
SET media_final_bimestral = (
    SELECT AVG(media_bimestral)
    FROM Medias
    WHERE Medias.fk_Aluno_matricula_aluno = Alunos.matricula_aluno
      AND Medias.bimestre = 1
)
WHERE matricula_aluno IN (SELECT DISTINCT fk_Aluno_matricula_aluno FROM Medias WHERE bimestre = 1);

UPDATE Alunos
SET media_final_bimestral = (
    SELECT AVG(media_bimestral)
    FROM Medias
    WHERE Medias.fk_Aluno_matricula_aluno = Alunos.matricula_aluno
      AND Medias.bimestre = 2
)
WHERE matricula_aluno IN (SELECT DISTINCT fk_Aluno_matricula_aluno FROM Medias WHERE bimestre = 2);

UPDATE Alunos
SET media_final_bimestral = (
    SELECT AVG(media_bimestral)
    FROM Medias
    WHERE Medias.fk_Aluno_matricula_aluno = Alunos.matricula_aluno
      AND Medias.bimestre = 3
)
WHERE matricula_aluno IN (SELECT DISTINCT fk_Aluno_matricula_aluno FROM Medias WHERE bimestre = 3);

UPDATE Alunos
SET media_final_bimestral = (
    SELECT AVG(media_bimestral)
    FROM Medias
    WHERE Medias.fk_Aluno_matricula_aluno = Alunos.matricula_aluno
      AND Medias.bimestre = 4
)
WHERE matricula_aluno IN (SELECT DISTINCT fk_Aluno_matricula_aluno FROM Medias WHERE bimestre = 4);

-- Cálculo da média anual e atualização da tabela Alunos
UPDATE Alunos
SET media_anual = (
    SELECT SUM(media_final_bimestral) / 4
)
WHERE matricula_aluno IN (SELECT DISTINCT fk_Aluno_matricula_aluno FROM Medias);

-- Atualização da tabela Alunos com as médias bimestrais
UPDATE Alunos
SET media_final_bimestral = (
    SELECT AVG(media_bimestral)
    FROM Medias
    WHERE Medias.fk_Aluno_matricula_aluno = Alunos.matricula_aluno
      AND Medias.bimestre = 1
)
WHERE matricula_aluno IN (SELECT DISTINCT fk_Aluno_matricula_aluno FROM Medias WHERE bimestre = 1);

UPDATE Alunos
SET media_final_bimestral = (
    SELECT AVG(media_bimestral)
    FROM Medias
    WHERE Medias.fk_Aluno_matricula_aluno = Alunos.matricula_aluno
      AND Medias.bimestre = 2
)
WHERE matricula_aluno IN (SELECT DISTINCT fk_Aluno_matricula_aluno FROM Medias WHERE bimestre = 2);

UPDATE Alunos
SET media_final_bimestral = (
    SELECT AVG(media_bimestral)
    FROM Medias
    WHERE Medias.fk_Aluno_matricula_aluno = Alunos.matricula_aluno
      AND Medias.bimestre = 3
)
WHERE matricula_aluno IN (SELECT DISTINCT fk_Aluno_matricula_aluno FROM Medias WHERE bimestre = 3);

INSERT INTO Curso (coordenador, Periodo, carga_horaria, nome, codigo_curso)
VALUES ('Daniel', '2023/1', '12:00:00', 'Redes de Computadores', 3),
       ('Fabricio', '2023/2', '9:30:00', 'Comércio', 4),
       ('Magnolia', '2023/2', '10:30:00', 'Agronegócio', 5),
       ('Cicero', '2023/2', '9:30:00', 'Administração', 6);
       

CREATE TABLE curso_aluno (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fk_alunos_matricula_aluno INT,
  fk_curso_codigo_curso INT,
  FOREIGN KEY (fk_alunos_matricula_aluno) REFERENCES alunos (matricula_aluno),
  FOREIGN KEY (fk_curso_codigo_curso) REFERENCES curso (codigo_curso)
);

select * from Curso