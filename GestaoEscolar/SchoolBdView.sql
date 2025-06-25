USE SchoolBD;

/*  Criando uma View para vizualizar o Boletim do aluno e seus dados */

CREATE VIEW vw_BoletimAluno
AS
SELECT
    a.NomeAluno,
    t.NomeTurma,
    d.NomeDisciplina,
    p.NomeProfessor,
    n.Nota,
    n.DataLancamento,
    r.NomeResponsavel
FROM Alunos a
JOIN Turmas t ON a.IdTurma = t.IdTurma
JOIN Notas n ON a.IdMatricula = n.IdMatricula
JOIN Disciplinas d ON n.IdDisciplina = d.IdDisciplina
JOIN Professores p ON d.IdProfessor = p.IdProfessor
JOIN Responsaveis r ON a.IdResponsavel = r.IdResponsavel
WHERE a.Status = 'Ativo';

/*  Usando a View para vizualizar o boletim */
SELECT * FROM vw_BoletimAluno
WHERE NomeAluno LIKE 'Sofia%';

/*  Criando uma View com as informações do aluno */

CREATE VIEW vw_InformAluno AS
SELECT
    a.NomeAluno,
    t.NomeTurma,
    r.NomeResponsavel,
    r.Telefone AS TelefoneResponsavel,
    a.CPF,
    a.DataNascimento,
    a.Status
FROM Alunos a
JOIN Turmas t ON a.IdTurma = t.IdTurma
JOIN Responsaveis r ON a.IdResponsavel = r.IdResponsavel;

/*  Usando a view para ver os dados pessoais do aluno   */

SELECT * FROM vw_InformAluno
WHERE NomeAluno LIKE 'Lucas%';