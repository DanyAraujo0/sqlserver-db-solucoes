USE SchoolBD;

/*  Consulta para ver a media dos alunos em determinada disciplina  */

SELECT
    d.NomeDisciplina,
    t.NomeTurma,
    p.NomeProfessor,
    CAST(AVG(n.nota) AS DECIMAL(4,2)) AS MediaAluno
FROM Disciplinas d
JOIN Turmas t ON d.IdTurma = t.IdTurma
JOIN Notas n ON d.IdDisciplina = n.IdDisciplina
JOIN Professores p ON d.IdProfessor = p.IdProfessor
GROUP BY NomeDisciplina, NomeTurma, NomeProfessor
ORDER BY NomeDisciplina ASC;


/* Consulta para saber o aluno que possui a maior nota da turma em cada disciplina */

WITH MaiorNota AS (
    SELECT 
        a.NomeAluno,
        t.NomeTurma,
        d.NomeDisciplina,
        n.Nota,
        RANK() OVER (PARTITION BY d.IdDisciplina ORDER BY n.Nota DESC) AS Posicao
    FROM Notas n
    JOIN Alunos a ON n.IdMatricula = a.IdMatricula
    JOIN Turmas t ON a.IdTurma = t.IdTurma
    JOIN Disciplinas d ON n.IdDisciplina = d.IdDisciplina
)
SELECT * FROM MaiorNota
WHERE Posicao = 1 AND NomeTurma LIKE '9%';

/* Consulta para achar os alunos reprovados e o contato do responsável */

SELECT 
    a.NomeAluno,
    d.NomeDisciplina,
    CAST(AVG(n.Nota) AS DECIMAL(4,2)) AS Media,
r.NomeResponsavel,
r.Telefone AS TelefoneResponsavel
FROM Notas n
JOIN Alunos a ON n.IdMatricula = a.IdMatricula
JOIN Disciplinas d ON n.IdDisciplina = d.IdDisciplina
JOIN Responsaveis r ON a.IdResponsavel = r.IdResponsavel
GROUP BY a.NomeAluno, d.NomeDisciplina, r.NomeResponsavel, r.Telefone
HAVING AVG(n.Nota) < 6;

/* Consulta para saber a frequência do Aluno em cada disciplina */

SELECT 
    a.NomeAluno,
    d.NomeDisciplina,
    COUNT(f.IdFrequencia) AS QuantidadeAulas,
    SUM(CASE WHEN f.Situacao LIKE 'p' THEN 1 ELSE 0 END) AS QuantidadePresencas,
    CAST(SUM(CASE WHEN f.Situacao LIKE 'p' THEN 1.0 ELSE 0 END) * 100.0 / COUNT(f.IdFrequencia) AS DECIMAL(5,2)) AS PercentualPresenca
FROM Frequencias f
JOIN Alunos a ON f.IdMatricula = a.IdMatricula
JOIN Disciplinas d ON f.IdDisciplina = d.IdDisciplina
GROUP BY a.NomeAluno, d.NomeDisciplina;
