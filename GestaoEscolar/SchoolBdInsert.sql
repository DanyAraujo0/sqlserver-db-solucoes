USE SchoolBD;

INSERT INTO Turmas (NomeTurma, Capacidade, Ano) VALUES
('8� Ano A', 30, 2025), -- IdTurma = 1
('9� Ano B', 25, 2025), -- IdTurma = 2
('3� Ano Ensino M�dio', 35, 2025); -- IdTurma = 3

INSERT INTO Responsaveis (NomeResponsavel, DataNascimento, Telefone, Email) VALUES
('Marcos Pereira', '1980-05-20', '11987654321', 'marcos.p@email.com'), -- IdResponsavel = 1
('Claudia Oliveira', '1985-09-10', '21912345678', 'claudia.o@email.com'), -- IdResponsavel = 2
('Ricardo Almeida', '1978-02-15', '31988887777', 'ricardo.a@email.com'); -- IdResponsavel = 3

INSERT INTO Professores (NomeProfessor, DataNascimento, CPF, DescricaoFormacao, DataFormacao) VALUES
('Ana Beatriz Santos', '1982-03-12', '12312312311', 'Licenciatura em Matem�tica', '2005-12-10'), -- IdProfessor = 101
('Carlos Eduardo Lima', '1975-11-08', '45645645622', 'Licenciatura em Letras (Portugu�s)', '1999-07-20'), -- IdProfessor = 102
('Fernanda Costa', '1990-01-30', '78978978933', 'Licenciatura em Hist�ria', '2012-06-15'); -- IdProfessor = 103

INSERT INTO Alunos (NomeAluno, CPF, DataNascimento, IdResponsavel, Status, IdTurma) VALUES
('Lucas Pereira', '11122233301', '2011-06-10', 1, 'Ativo', 1), -- IdMatricula = 1001
('Sofia Oliveira', '11122233302', '2011-02-25', 2, 'Ativo', 1), -- IdMatricula = 1002
('Gabriel Almeida', '11122233303', '2010-11-15', 3, 'Ativo', 2), -- IdMatricula = 1003
('Julia Santos', '11122233304', '2008-01-20', 1, 'Ativo', 3); -- IdMatricula = 1004

INSERT INTO Disciplinas (NomeDisciplina, IdTurma, IdProfessor) VALUES
('Matem�tica', 1, 101), -- IdDisciplina = 1 (Matem�tica para 8� A com Prof. Ana)
('Portugu�s', 1, 102), -- IdDisciplina = 2 (Portugu�s para 8� A com Prof. Carlos)
('Hist�ria', 2, 103), -- IdDisciplina = 3 (Hist�ria para 9� B com Prof. Fernanda)
('Matem�tica', 2, 101), -- IdDisciplina = 4 (Matem�tica para 9� B com Prof. Ana)
('Literatura', 3, 102); -- IdDisciplina = 5 (Literatura para 3� EM com Prof. Carlos)

INSERT INTO Notas (IdDisciplina, IdMatricula, Nota, DataLancamento) VALUES
(1, 1001, 8.50, '2025-03-15'), -- Lucas em Matem�tica
(2, 1001, 7.00, '2025-03-16'), -- Lucas em Portugu�s
(1, 1002, 9.50, '2025-03-15'), -- Sofia em Matem�tica
(2, 1002, 9.00, '2025-03-16'), -- Sofia em Portugu�s
(3, 1003, 6.50, '2025-03-18'), -- Gabriel em Hist�ria
(4, 1003, 10.00, '2025-03-18'); -- Gabriel em Matem�tica