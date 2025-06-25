USE MedTrack;

/*	Criando view para consultar o prontuario completo do paciente	*/

CREATE VIEW vw_ProntuarioCompleto AS
SELECT 
    pa.NomePaciente AS Paciente,
    a.DataHora AS Entrada,
    pr.DataSaida AS Saida,
    f.NomeFuncionario AS Profissional,
    s.DescricaoSintoma,
    pr.Diagnostico,
    s.CID,
    pr.Receita,
    m.NomeMedicamento,
    po.NomeProcedimento,
    pr.Encaminhamento 
FROM Pacientes pa
LEFT JOIN Atendimentos a ON pa.IdPaciente = a.IdPaciente
LEFT JOIN Prontuarios pr ON a.IdAtendimento = pr.IdAtendimento
LEFT JOIN Sintomas s ON a.IdSintoma = s.IdSintoma
LEFT JOIN Funcionarios f ON a.IdFuncionario = f.IdFuncionario
LEFT JOIN ProntuarioMedicamentos pm ON pr.IdProntuario = pm.IdProntuario
LEFT JOIN ProntuarioProcedimentos pp ON pr.IdProntuario = pp.IdProntuario
LEFT JOIN Medicamentos m ON pm.IdMedicamento = m.IdMedicamento
LEFT JOIN Procedimentos po ON pp.IdProcedimento = po.IdProcedimento;

/*  Consulta do prontuario do paciente usando a View   */
SELECT * FROM vw_ProntuarioCompleto
WHERE Paciente LIKE 'Carlos Andrade';

/*  Criando view para consultar possiveis alergia do Paciente e sua data de nascimento */

CREATE VIEW vw_AlergiaPaciente AS
SELECT 
    IdPaciente,
    NomePaciente AS Paciente,
    DataNascimento,
    Alergias
FROM Pacientes pa;

/*  Consulta usando a view de n para descobrir se o paciente pode fazer uso da medicação    */
SELECT * FROM vw_AlergiaPaciente
WHERE Paciente LIKE 'Beatriz%';

