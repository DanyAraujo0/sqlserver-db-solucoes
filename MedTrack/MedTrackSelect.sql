USE MedTrack;

/*  Consulta para obter informações sobre o ultimo paciente que foi atendido  */
SELECT TOP 1
    a.IdAtendimento,
    a.DataHora,
    p.IdPaciente,
    p.NomePaciente,
    p.CPF,
    p.DataNascimento,
    f.NomeFuncionario AS MedicoResponsavel,
    e.TipoEspecialidade,
    s.DescricaoSintoma
FROM Pacientes p
JOIN Atendimentos a ON p.IdPaciente = a.IdPaciente
JOIN Funcionarios f ON a.IdFuncionario = f.IdFuncionario
JOIN Especialidades e ON f.IdEspecialidade = e.IdEspecialidade
LEFT JOIN Sintomas s ON a.IdSintoma = s.IdSintoma
ORDER BY a.DataHora DESC;

/*  Consulta para obter informações dos pacientes que possuem alergia e os medicamentos aplicado    */
SELECT
    p.NomePaciente,
    p.Alergias,
    m.NomeMedicamento AS MedicamentoPrescrito,
    a.DataHora,
    f.NomeFuncionario AS MedicoResponsavel
FROM Pacientes p
JOIN Atendimentos a ON p.IdPaciente = a.IdPaciente
JOIN Prontuarios pr ON a.IdAtendimento = pr.IdAtendimento
JOIN ProntuarioMedicamentos pm ON pr.IdProntuario = pm.IdProntuario
JOIN Medicamentos m ON pm.IdMedicamento = m.IdMedicamento
JOIN Funcionarios f ON a.IdFuncionario = f.IdFuncionario
WHERE p.Alergias IS NOT NULL
    AND pm.IdMedicamento IS NOT NULL
    AND p.Alergias LIKE CONCAT('%', m.NomeMedicamento, '%');

/*  Consulta para encontrar quais profissionais podem realizar o procedimento de curativo   */
SELECT
    p.NomeProcedimento,
    f.NomeFuncionario,
    e.TipoEspecialidade
FROM Procedimentos p
JOIN EspecialidadesProcedimentos ep ON p.IdProcedimento=ep.IdProcedimento
JOIN Especialidades e ON ep.IdEspecialidade=e.IdEspecialidade
JOIN Funcionarios f ON e.IdEspecialidade=f.IdEspecialidade
WHERE p.NomeProcedimento LIKE 'Curativo'
ORDER BY f.NomeFuncionario ASC;

/* Consulta para obter o numero de paciente atendidos no dia 24/06/2025 */
SELECT 
    COUNT(DISTINCT(IdAtendimento)) AS TotalDeAtendimentos
FROM Atendimentos
WHERE CAST(DataHora AS DATE) = '2025-06-24';
