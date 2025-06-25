USE MedTrack;

INSERT INTO Especialidades (TipoEspecialidade) VALUES
('Cardiologia'),       -- IdEspecialidade = 1
('Dermatologia'),      -- IdEspecialidade = 2
('Pediatria'),         -- IdEspecialidade = 3
('Ortopedia'),         -- IdEspecialidade = 4
('Cl�nica Geral');     -- IdEspecialidade = 5

INSERT INTO Procedimentos (NomeProcedimento) VALUES
('Eletrocardiograma'),   -- IdProcedimento = 1
('Sutura Simples'),      -- IdProcedimento = 2
('Raio-X de T�rax'),     -- IdProcedimento = 3
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
('Dor de cabe�a intensa e tontura', 'R51'),   -- IdSintoma = 2
('Corte profundo no bra�o', 'S51.8'),      -- IdSintoma = 3
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
('Dr. Roberto Dias', 'CRM-MG 112233', 'roberto.d@medtrack.com', 5),  -- Cl�nico Geral
('Enf. Marcos Silva', 'COREN-SP 987654', 'marcos.s@medtrack.com', 5); -- Enfermeiro (Cl�nica Geral)

INSERT INTO EspecialidadesProcedimentos (IdEspecialidade, IdProcedimento) VALUES
(1, 1), -- Cardiologia realiza Eletrocardiograma
(1, 4), -- Cardiologia solicita Exame de Sangue
(2, 2), -- Dermatologia realiza Sutura Simples
(4, 3), -- Ortopedia solicita Raio-X de T�rax (exemplo)
(5, 2), -- Cl�nica Geral realiza Sutura Simples
(5, 4), -- Cl�nica Geral solicita Exame de Sangue
(5, 5); -- Cl�nica Geral realiza Curativo

INSERT INTO EspecialidadesMedicamentos (IdEspecialidade, IdMedicamento) VALUES
(1, 1), -- Cardiologia prescreve Dipirona
(2, 5), -- Dermatologia prescreve Loratadina
(3, 4), -- Pediatria prescreve Paracetamol
(5, 1), -- Cl�nica Geral prescreve Dipirona
(5, 2), -- Cl�nica Geral prescreve Amoxicilina
(5, 3); -- Cl�nica Geral prescreve Ibuprofeno

INSERT INTO Atendimentos (DataHora, Observacoes, TipoRisco, IdSintoma, IdPaciente, IdFuncionario) VALUES
-- Atendimento 1: Juliana com dor no peito, atendida pelo Cardiologista
('2025-06-24T10:00:00', 'Paciente relata dor no peito que come�ou h� 2 horas. Nega outros sintomas.', 'Alto', 5, 4, 1),
-- Atendimento 2: Beatriz com manchas na pele, atendida pela Dermatologista
('2025-06-24T11:30:00', 'Paciente apresenta les�es eritematosas e pruriginosas nos bra�os ap�s contato com planta desconhecida.', 'Baixo', 4, 2, 2),
-- Atendimento 3: Carlos com corte no bra�o, atendido pelo Cl�nico Geral
('2025-06-25T09:15:00', 'Corte de aproximadamente 5cm no antebra�o direito, causado por faca de cozinha. Sangramento controlado.', 'M�dio', 3, 1, 3),
-- Atendimento 4: Fernando com febre, atendido pelo Cl�nico Geral
('2025-06-25T14:00:00', 'Crian�a com febre de 38.5�C e dor de garganta. Apetite diminu�do.', 'Baixo', 1, 3, 3);

INSERT INTO Prontuarios (Diagnostico, Receita, Encaminhamento, DataRegistro, IdAtendimento) VALUES
-- Prontu�rio do Atendimento 1
('Angina inst�vel a investigar.', 'Prescrito AAS 100mg. Solicitado exames complementares.', 'Encaminhado para interna��o para monitoramento card�aco.', GETDATE(), 1),
-- Prontu�rio do Atendimento 2
('Dermatite de contato.', 'Receitado Loratadina 10mg, 1 comprimido ao dia por 5 dias. Uso de pomada t�pica.', NULL, GETDATE(), 2),
-- Prontu�rio do Atendimento 3
('Les�o corto-contusa em membro superior.', 'Realizada sutura com 4 pontos. Prescrito Ibuprofeno 400mg para dor, se necess�rio. Orientado sobre cuidados com o curativo.', 'Retorno em 7 dias para retirada dos pontos.', GETDATE(), 3),
-- Prontu�rio do Atendimento 4
('Faringite bacteriana.', 'Prescrito Amoxicilina 500mg, 1 dose a cada 8 horas por 7 dias. Paracetamol para febre.', 'Reavaliar caso n�o haja melhora em 48 horas.', GETDATE(), 4);

INSERT INTO ProntuarioProcedimentos (IdProntuario, IdProcedimento) VALUES
(1, 1), -- Prontu�rio 1 (Angina) -> Realizado Eletrocardiograma
(1, 4), -- Prontu�rio 1 (Angina) -> Solicitado Exame de Sangue
(3, 2); -- Prontu�rio 3 (Corte) -> Realizada Sutura Simples

INSERT INTO ProntuarioMedicamentos (IdProntuario, IdMedicamento) VALUES
(2, 5), -- Prontu�rio 2 (Dermatite) -> Receita de Loratadina
(3, 3), -- Prontu�rio 3 (Corte) -> Receita de Ibuprofeno
(4, 2), -- Prontu�rio 4 (Faringite) -> Receita de Amoxicilina
(4, 4); -- Prontu�rio 4 (Faringite) -> Receita de Paracetamol