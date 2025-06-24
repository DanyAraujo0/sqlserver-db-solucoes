USE MedTrack;

INSERT INTO Especialidades (TipoEspecialidade) VALUES
('Cardiologia'),       -- IdEspecialidade = 1
('Dermatologia'),      -- IdEspecialidade = 2
('Pediatria'),         -- IdEspecialidade = 3
('Ortopedia'),         -- IdEspecialidade = 4
('Clínica Geral');     -- IdEspecialidade = 5

INSERT INTO Procedimentos (NomeProcedimento) VALUES
('Eletrocardiograma'),   -- IdProcedimento = 1
('Sutura Simples'),      -- IdProcedimento = 2
('Raio-X de Tórax'),     -- IdProcedimento = 3
('Exame de Sangue'),     -- IdProcedimento = 4
('Curativo');            -- IdProcedimento = 5

INSERT INTO Medicamentos (NomeMedicamento) VALUES
('Dipirona 500mg'),      -- IdMedicamento = 1
('Amoxicilina 500mg'),   -- IdMedicamento = 2
('Ibuprofeno 400mg'),    -- IdMedicamento = 3
('Paracetamol 750mg'),   -- IdMedicamento = 4
('Loratadina 10mg');     -- IdMedicamento = 5

INSERT INTO Sintomas (DescricaoSintoma, CID) VALUES
('Febre alta e dor de garganta', 'J02.9'), -- IdSintoma = 1
('Dor de cabeça intensa e tontura', 'R51'),   -- IdSintoma = 2
('Corte profundo no braço', 'S51.8'),      -- IdSintoma = 3
('Manchas vermelhas na pele e coceira', 'L23.9'), -- IdSintoma = 4
('Dor no peito e falta de ar', 'R07.4');       -- IdSintoma = 5

INSERT INTO Pacientes (NomePaciente, CPF, DataNascimento, NomeMae, Alergias, Telefone, EmailPaciente) VALUES
('Carlos Andrade', '11122233344', '1985-04-12', 'Maria Andrade', 'Dipirona', '31988776655', 'carlos.a@email.com'),
('Beatriz Lima', '22233344455', '1992-09-20', 'Joana Lima', NULL, '11977665544', 'beatriz.lima@email.com'),
('Fernando Costa', '33344455566', '2018-01-30', 'Ana Costa', 'Penicilina', '21966554433', 'fernando.c@email.com'),
('Juliana Martins', '44455566677', '1970-07-15', 'Helena Martins', 'Nenhuma', '81955443322', 'juliana.m@email.com');

INSERT INTO Funcionarios (NomeFuncionario, CRMCOREN, EmailFuncionario, IdEspecialidade) VALUES
('Dr. Ricardo Borges', 'CRM-SP 123456', 'ricardo.b@medtrack.com', 1), -- Cardiologista
('Dra. Amanda Nunes', 'CRM-RJ 654321', 'amanda.n@medtrack.com', 2),  -- Dermatologista
('Dr. Roberto Dias', 'CRM-MG 112233', 'roberto.d@medtrack.com', 5),  -- Clínico Geral
('Enf. Marcos Silva', 'COREN-SP 987654', 'marcos.s@medtrack.com', 5); -- Enfermeiro (Clínica Geral)

INSERT INTO EspecialidadesProcedimentos (IdEspecialidade, IdProcedimento) VALUES
(1, 1), -- Cardiologia realiza Eletrocardiograma
(1, 4), -- Cardiologia solicita Exame de Sangue
(2, 2), -- Dermatologia realiza Sutura Simples
(4, 3), -- Ortopedia solicita Raio-X de Tórax (exemplo)
(5, 2), -- Clínica Geral realiza Sutura Simples
(5, 4), -- Clínica Geral solicita Exame de Sangue
(5, 5); -- Clínica Geral realiza Curativo

INSERT INTO EspecialidadesMedicamentos (IdEspecialidade, IdMedicamento) VALUES
(1, 1), -- Cardiologia prescreve Dipirona
(2, 5), -- Dermatologia prescreve Loratadina
(3, 4), -- Pediatria prescreve Paracetamol
(5, 1), -- Clínica Geral prescreve Dipirona
(5, 2), -- Clínica Geral prescreve Amoxicilina
(5, 3); -- Clínica Geral prescreve Ibuprofeno

INSERT INTO Atendimentos (DataHora, Observacoes, TipoRisco, IdSintoma, IdPaciente, IdFuncionario) VALUES
-- Atendimento 1: Juliana com dor no peito, atendida pelo Cardiologista
('2025-06-24T10:00:00', 'Paciente relata dor no peito que começou há 2 horas. Nega outros sintomas.', 'Alto', 5, 4, 1),
-- Atendimento 2: Beatriz com manchas na pele, atendida pela Dermatologista
('2025-06-24T11:30:00', 'Paciente apresenta lesões eritematosas e pruriginosas nos braços após contato com planta desconhecida.', 'Baixo', 4, 2, 2),
-- Atendimento 3: Carlos com corte no braço, atendido pelo Clínico Geral
('2025-06-25T09:15:00', 'Corte de aproximadamente 5cm no antebraço direito, causado por faca de cozinha. Sangramento controlado.', 'Médio', 3, 1, 3),
-- Atendimento 4: Fernando com febre, atendido pelo Clínico Geral
('2025-06-25T14:00:00', 'Criança com febre de 38.5°C e dor de garganta. Apetite diminuído.', 'Baixo', 1, 3, 3);

INSERT INTO Prontuarios (Diagnostico, Receita, Encaminhamento, DataRegistro, IdAtendimento) VALUES
-- Prontuário do Atendimento 1
('Angina instável a investigar.', 'Prescrito AAS 100mg. Solicitado exames complementares.', 'Encaminhado para internação para monitoramento cardíaco.', GETDATE(), 1),
-- Prontuário do Atendimento 2
('Dermatite de contato.', 'Receitado Loratadina 10mg, 1 comprimido ao dia por 5 dias. Uso de pomada tópica.', NULL, GETDATE(), 2),
-- Prontuário do Atendimento 3
('Lesão corto-contusa em membro superior.', 'Realizada sutura com 4 pontos. Prescrito Ibuprofeno 400mg para dor, se necessário. Orientado sobre cuidados com o curativo.', 'Retorno em 7 dias para retirada dos pontos.', GETDATE(), 3),
-- Prontuário do Atendimento 4
('Faringite bacteriana.', 'Prescrito Amoxicilina 500mg, 1 dose a cada 8 horas por 7 dias. Paracetamol para febre.', 'Reavaliar caso não haja melhora em 48 horas.', GETDATE(), 4);

INSERT INTO ProntuarioProcedimentos (IdProntuario, IdProcedimento) VALUES
(1, 1), -- Prontuário 1 (Angina) -> Realizado Eletrocardiograma
(1, 4), -- Prontuário 1 (Angina) -> Solicitado Exame de Sangue
(3, 2); -- Prontuário 3 (Corte) -> Realizada Sutura Simples

INSERT INTO ProntuarioMedicamentos (IdProntuario, IdMedicamento) VALUES
(2, 5), -- Prontuário 2 (Dermatite) -> Receita de Loratadina
(3, 3), -- Prontuário 3 (Corte) -> Receita de Ibuprofeno
(4, 2), -- Prontuário 4 (Faringite) -> Receita de Amoxicilina
(4, 4); -- Prontuário 4 (Faringite) -> Receita de Paracetamol