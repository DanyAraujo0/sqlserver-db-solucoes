USE MedTrack;

/*  Procedure para registrar um atendimento completo    */
CREATE OR ALTER PROCEDURE sp_RegistrarAtendimentoCompleto
    @IdPaciente INT,
    @IdFuncionario INT,
    @IdSintoma INT,
    @DataHora DATETIME,
    @TipoRisco VARCHAR(10),
    @Observacoes VARCHAR(MAX),
    @Diagnostico VARCHAR(MAX),
    @Receita VARCHAR(MAX),
    @Encaminhamento VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @NovoIdAtendimento INT;

        INSERT INTO Atendimentos (IdPaciente, IdFuncionario, IdSintoma, DataHora, TipoRisco, Observacoes)
        VALUES (@IdPaciente, @IdFuncionario, @IdSintoma, @DataHora, @TipoRisco, @Observacoes);

        SET @NovoIdAtendimento = SCOPE_IDENTITY();

        INSERT INTO Prontuarios (IdAtendimento, Diagnostico, Receita, Encaminhamento)
        VALUES (@NovoIdAtendimento, @Diagnostico, @Receita, @Encaminhamento);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

/*  Exemplo de como chamar a procedure: */

EXEC sp_RegistrarAtendimentoCompleto
    @IdPaciente = 2,
    @IdFuncionario = 3,
    @IdSintoma = 2,
    @DataHora = '2025-06-25 15:30:00',
    @TipoRisco = 'Baixo',
    @Observacoes = 'Paciente queixa-se de enxaqueca recorrente.',
    @Diagnostico = 'Migrânea crônica',
    @Receita = 'Sumatriptano 50mg em caso de crise.',
    @Encaminhamento = 'Agendar consulta com neurologista.';
