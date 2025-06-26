USE SchoolBD;

/*  Criando uma tabela para guardar as notas e frequencia finais dos alunos */

CREATE TABLE BoletimFinal (
    IdBoletim INT PRIMARY KEY IDENTITY(1,1),
    Ano INT NOT NULL,
    IdMatricula INT NOT NULL,
    IdDisciplina SMALLINT NOT NULL,
    MediaFinal DECIMAL(4,2),
    PercentualFrequencia DECIMAL(5,2),
    SituacaoFinal VARCHAR(10),
    DataConsolidacao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IdMatricula) REFERENCES Alunos(IdMatricula),
    FOREIGN KEY (IdDisciplina) REFERENCES Disciplinas(IdDisciplina)
);

/*  Criando uma procedure como que ira preencher o boletim dos alunos no final do ano letivo */

CREATE PROCEDURE sp_FecharAnoLetivo
    @AnoLetivo INT,
    @MediaAprovacao DECIMAL(4,2) = 7.0, --Simulando que a media é 7.0 para aprovação
    @FrequenciaMinima DECIMAL(5,2) = 75.0 --Simulando que a frequencia é 75 para aprovação 
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        WITH MediasFinais AS (
            SELECT
                n.IdMatricula,
                n.IdDisciplina,
                AVG(n.Nota) AS Media
            FROM Notas n
            JOIN Disciplinas d ON n.IdDisciplina = d.IdDisciplina
            JOIN Turmas t ON d.IdTurma = t.IdTurma
            WHERE t.Ano = @AnoLetivo
            GROUP BY n.IdMatricula, n.IdDisciplina
        ),
        FrequenciaFinal AS (
            SELECT
                f.IdMatricula,
                f.IdDisciplina,
                (SUM(CASE WHEN f.Situacao = 'P' THEN 1.0 ELSE 0.0 END) * 100) / COUNT(f.IdFrequencia) AS Percentual
            FROM Frequencias f
            JOIN Disciplinas d ON f.IdDisciplina = d.IdDisciplina
            JOIN Turmas t ON d.IdTurma = t.IdTurma
            WHERE t.Ano = @AnoLetivo
            GROUP BY f.IdMatricula, f.IdDisciplina
        )

        INSERT INTO BoletimFinal (Ano, IdMatricula, IdDisciplina, MediaFinal, PercentualFrequencia, SituacaoFinal)
        SELECT
            @AnoLetivo,
            a.IdMatricula,
            d.IdDisciplina,
            mf.Media,
            ff.Percentual,
            CASE
                WHEN mf.Media >= @MediaAprovacao AND ff.Percentual >= @FrequenciaMinima THEN 'Aprovado'
                ELSE 'Reprovado'
            END AS SituacaoFinal
        FROM Alunos a
        JOIN Turmas t ON a.IdTurma = t.IdTurma
        JOIN Disciplinas d ON t.IdTurma = d.IdTurma
        LEFT JOIN MediasFinais mf ON a.IdMatricula = mf.IdMatricula AND d.IdDisciplina = mf.IdDisciplina
        LEFT JOIN FrequenciaFinal ff ON a.IdMatricula = ff.IdMatricula AND d.IdDisciplina = ff.IdDisciplina
        WHERE t.Ano = @AnoLetivo AND a.Status = 'Ativo';

        -- Limpando as tabelas transacionais para o próximo ano letivo para não acumule dados desnecessarios
        TRUNCATE TABLE Notas;
        TRUNCATE TABLE Frequencias;
        COMMIT TRANSACTION;
        PRINT 'Ano letivo ' + CAST(@AnoLetivo AS VARCHAR) + ' fechado e consolidado com sucesso!';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

/*  Agora com a procedure pronta será necessário realizar um agendamento para executar-la todo fim do semestre por exemplo dia 20 de dezembro   */

-- Executando a procedure para o ano letivo de 2025

EXEC sp_FecharAnoLetivo @AnoLetivo = 2025;

/*  Podemos criar um view para vizualizar o boletim    */

CREATE VIEW vw_boletimfinal AS
SELECT 
    b.IdBoletim,
    b.Ano,
    a.NomeAluno,
    d.NomeDisciplina,
    b.MediaFinal,
    b.PercentualFrequencia,
    b.SituacaoFinal,
    b.DataConsolidacao
FROM BoletimFinal b
JOIN Alunos a ON b.IdMatricula = a.IdMatricula
JOIN Disciplinas d ON b.IdDisciplina = d.IdDisciplina;

-- Usando a view
SELECT * FROM vw_boletimfinal;
