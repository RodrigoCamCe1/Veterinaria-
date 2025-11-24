
CREATE Veterinariafinal1;
GO
USE Veterinariafinal1;
GO

CREATE TABLE Familia (
    FamiliaNo CHAR(10) PRIMARY KEY,
    Apellido VARCHAR(100),
    CuentaBancaria VARCHAR(30),
    Direccion TEXT
);
GO

CREATE TABLE Persona (
    PersonaNo CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion TEXT,
    CI VARCHAR(20)
);
GO

CREATE TABLE FamiliaPersona (
    FamiliaNo CHAR(10),
    PersonaNo CHAR(10),
    PRIMARY KEY (FamiliaNo, PersonaNo),
    FOREIGN KEY (FamiliaNo) REFERENCES Familia(FamiliaNo),
    FOREIGN KEY (PersonaNo) REFERENCES Persona(PersonaNo)
);
GO

CREATE TABLE Mascota (
    MascotaNo CHAR(10) PRIMARY KEY,
    Especie VARCHAR(50),
    Raza VARCHAR(50),
    Color VARCHAR(50),
    FechaNacimiento DATE,
    Alias VARCHAR(50),
    FamiliaNo CHAR(10),
    FOREIGN KEY (FamiliaNo) REFERENCES Familia(FamiliaNo)
);
GO

CREATE TABLE HistorialPeso (
    MascotaNo CHAR(10),
    Fecha DATE,
    Peso DECIMAL(5,2),
    PRIMARY KEY (MascotaNo, Fecha),
    FOREIGN KEY (MascotaNo) REFERENCES Mascota(MascotaNo)
);
GO

CREATE TABLE Vacuna (
    VacunaId CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100)
);
GO

CREATE TABLE Veterinario (
    VetID CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100),
    Telefono VARCHAR(20),
    Sueldo DECIMAL(10,2)
);
GO

CREATE TABLE HistorialVacunacion (
    MascotaNo CHAR(10),
    VacunaId CHAR(10),
    Fecha DATE,
    Comentario TEXT,
    Precio DECIMAL(10,2),
    VetID CHAR(10),
    PRIMARY KEY (MascotaNo, VacunaId, Fecha),
    FOREIGN KEY (MascotaNo) REFERENCES Mascota(MascotaNo),
    FOREIGN KEY (VacunaId) REFERENCES Vacuna(VacunaId),
    FOREIGN KEY (VetID) REFERENCES Veterinario(VetID)
);
GO

CREATE TABLE HistorialMedico (
    MascotaNo CHAR(10),
    Fecha DATE,
    Enfermedad TEXT,
    Rescatado BIT,
    VetID CHAR(10),
    PRIMARY KEY (MascotaNo, Fecha),
    FOREIGN KEY (MascotaNo) REFERENCES Mascota(MascotaNo),
    FOREIGN KEY (VetID) REFERENCES Veterinario(VetID)
);
GO
ALTER TABLE HistorialMedico
DROP COLUMN Telefono;

CREATE TABLE Voluntario (
    VoluntarioId CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100),
    Telefono VARCHAR(20)
);
GO

CREATE TABLE Cuidado (
    MascotaNo CHAR(10),
    Fecha DATE,
    Tipo VARCHAR(100),
    Precio DECIMAL(10,2),
    Comentarios TEXT,
    VoluntarioId CHAR(10),
    VetID CHAR(10),
    PRIMARY KEY (MascotaNo, Fecha),
    FOREIGN KEY (MascotaNo) REFERENCES Mascota(MascotaNo),
    FOREIGN KEY (VoluntarioId) REFERENCES Voluntario(VoluntarioId),
    FOREIGN KEY (VetID) REFERENCES Veterinario(VetID)
);
GO

CREATE TABLE Rescatista (
    RescatistaId CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100),
    Telefono VARCHAR(20)
);
GO

CREATE TABLE Rescatada (
    MascotaNo CHAR(10) PRIMARY KEY,
    RescatistaId CHAR(10),
    FOREIGN KEY (MascotaNo) REFERENCES Mascota(MascotaNo),
    FOREIGN KEY (RescatistaId) REFERENCES Rescatista(RescatistaId)
);
GO

CREATE TABLE PorCobrar (
    HaberId CHAR(10) PRIMARY KEY,
    MascotaNo CHAR(10),
    Fecha DATE,
    Tipo VARCHAR(50),
    Monto DECIMAL(10,2),
    FOREIGN KEY (MascotaNo) REFERENCES Mascota(MascotaNo)
);
GO

CREATE TABLE Factura (
    FacturaId CHAR(10) PRIMARY KEY,
    HaberId CHAR(10),
    EsFondoComun BIT NOT NULL, -- 1 si paga fondo común, 0 si paga cliente
    FamiliaNo CHAR(10),
    FOREIGN KEY (HaberId) REFERENCES PorCobrar(HaberId),
    FOREIGN KEY (FamiliaNo) REFERENCES Familia(FamiliaNo)
);

GO

CREATE TABLE Postulante ( 
    PostulanteId CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100),
    CI VARCHAR(20),
    EspecieDepref VARCHAR(50),
    RazaDepref VARCHAR(50),
    ColorDepref VARCHAR(50)
);



GO

CREATE TABLE Adopcion (
    AdopcionId CHAR(10) PRIMARY KEY,
    MascotaNo CHAR(10),
    PostulanteId CHAR(10),
    Fecha DATE,
    FOREIGN KEY (MascotaNo) REFERENCES Mascota(MascotaNo),
    FOREIGN KEY (PostulanteId) REFERENCES Postulante(PostulanteId)
);
GO
CREATE TABLE Mecenas (
    MecenaId CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100),
    Telefono VARCHAR(20)
);

CREATE TABLE Visita (
    VisitaId CHAR(10) PRIMARY KEY,
    AdopcionId CHAR(10),
    Fecha DATE,
    Observaciones varchar(1200),
    VetID CHAR(10),
    VoluntarioId CHAR(10),
    RescatistaId CHAR(10),
    FOREIGN KEY (AdopcionId) REFERENCES Adopcion(AdopcionId),
    FOREIGN KEY (VetID) REFERENCES Veterinario(VetID),
    FOREIGN KEY (VoluntarioId) REFERENCES Voluntario(VoluntarioId),
    FOREIGN KEY (RescatistaId) REFERENCES Rescatista(RescatistaId)
);



GO

CREATE TABLE FondosComunes (
    DebeId CHAR(10) PRIMARY KEY,
    MecenaId CHAR(10),
    AdopcionId CHAR(10),
    Monto DECIMAL(10,2),
    FOREIGN KEY (MecenaId) REFERENCES Mecenas(MecenaId),
    FOREIGN KEY (AdopcionId) REFERENCES Adopcion(AdopcionId)
);
GO

CREATE TABLE Bonificacion (
    BonificacionID CHAR(10) PRIMARY KEY,
    VetID CHAR(10),
    MascotaNo CHAR(10),
    Monto DECIMAL(10,2),
    FechaRegistro DATE,
    Pagada BIT DEFAULT 0,
    FOREIGN KEY (VetID) REFERENCES Veterinario(VetID),
    FOREIGN KEY (MascotaNo) REFERENCES Mascota(MascotaNo)
);
GO

INSERT INTO Familia (FamiliaNo, Apellido, CuentaBancaria, Direccion) VALUES 
('F0001', 'Ribera', '1234567890', 'Calle Sucre #123'),
('F0002', 'Velásquez', '2345678901', 'Av. Bolívar 456'),
('F0003', 'Osorio', '3456789012', 'Jr. Tarija 78'),
('F0004', 'Flores', '4567890123', 'Calle Real #99'),
('F0005', 'Mendoza', '5678901234', 'Av. La Paz 321');
go
INSERT INTO Persona (PersonaNo, Nombre, Direccion, CI) VALUES 
('P0001', 'Rafaela Ribera', 'Calle Illampu 123', '8234567'),
('P0002', 'José Miguel Velásquez', 'Av. América 456', '7023456'),
('P0003', 'Laura Osorio', 'Jr. Bolívar 789', '8543210'),
('P0004', 'Adrian Flores', 'Av. Sucre 321', '6123456'),
('P0005', 'Ana Mendoza', 'Calle Aroma 12', '7345678'),
('P0006', 'Miguel Mendoza', 'Av. Pando 888', '8654321'),
('P0007', 'Verónica Chávez', 'Jr. Landaeta 15', '7987654'),
('P0008', 'David Flores', 'Av. Villazón 303', '7012345'),
('P0009', 'Carmen Ribera', 'Calle Junín 109', '7234567'),
('P0010', 'Pablo Osorio', 'Av. Mariscal 500', '7890123');
go
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0001', 'P0001');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0003', 'P0002');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0001', 'P0003');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0002', 'P0004');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0001', 'P0005');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0005', 'P0006');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0003', 'P0007');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0004', 'P0008');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0001', 'P0009');
INSERT INTO FamiliaPersona (FamiliaNo, PersonaNo) VALUES ('F0003', 'P0010');
go
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0001', 'Gato', 'Siamés', 'Crema', '2023-11-12', 'Paffi', 'F0005');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0002', 'Gato', 'Russian Blue', 'Gris', '2023-09-26', 'Michi', 'F0004');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0003', 'Gato', 'Persa', 'Blanco', '2025-01-21', 'Rosita', 'F0001');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0004', 'Gato', 'Esfinge', 'Ninguno', '2022-06-28', 'Lomita', 'F0001');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0005', 'Gato', 'Siamés', 'Blanco', '2025-01-06', 'Alaska', 'F0003');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0006', 'Perro', 'BullTerrier', 'Negro', '2025-01-03', 'Rocco', 'F0001');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0007', 'Perro', 'Mezclado', 'Café', '2025-03-27', 'Vaquita', 'F0003');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0008', 'Perro', 'Chihuahua', 'Negro', '2021-05-20', 'Luna', 'F0003');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0009', 'Perro', 'Salchicha', 'Café', '2021-07-04', 'Harry', 'F0004');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0010', 'Perro', 'Salchicha', 'Café', '2022-05-11', 'Principe', 'F0002');
INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo) VALUES ('M0011', 'Gato', 'Smoking', 'Blanco y negro', '2023-05-17', 'Duquesa', 'F0001');


go

INSERT INTO Veterinario (VetID, Nombre, Telefono, Sueldo) VALUES 
('V0001', 'Dr. Carlos Mamani', '78945612', 8500.00),
('V0002', 'Dra. Ana Quispe', '79856234', 9200.00),
('V0003', 'Dr. Luis Condori', '76234578', 7800.00),
('V0004', 'Dra. María Choque', '78123456', 8800.00),
('V0005', 'Dr. Roberto Vargas', '79567890', 9500.00);
go

INSERT INTO Vacuna (VacunaId, Nombre) VALUES 
('VAC001', 'Rabia'),
('VAC002', 'Parvovirus'),
('VAC003', 'Moquillo'),
('VAC004', 'Triple Felina'),
('VAC005', 'Leucemia Felina'),
('VAC006', 'Hepatitis Canina'),
('VAC007', 'Pentavalente'),
('VAC008', 'Antirrábica Refuerzo');
go

INSERT INTO Voluntario (VoluntarioId, Nombre, Telefono) VALUES 
('VOL001', 'Sandra Poma', '78234567'),
('VOL002', 'Miguel Flores', '79345678'),
('VOL003', 'Carla Rojas', '76456789'),
('VOL004', 'Daniel Gutiérrez', '78567890'),
('VOL005', 'Lucía Mamani', '79678901');
go

INSERT INTO Rescatista (RescatistaId, Nombre, Telefono) VALUES 
('RES001', 'Pedro Pascal', '78901234'),
('RES002', 'Harry Styles', '79012345'),
('RES003', 'Emilia Mernes', '76123456'),
('RES004', 'Rosa Rosita', '78234567');
go

INSERT INTO Mecenas (MecenaId, Nombre, Telefono) VALUES 
('MEC001', 'Fundacion Animalitos', '78111222'),
('MEC002', 'Empresa Bolivar S.A.', '79333444'),
('MEC003', 'Familia Paz Estenssoro', '76555666'),
('MEC004', 'Familia Foianini', '78777888');
go
INSERT INTO Postulante (PostulanteId, Nombre, CI, EspecieDepref, RazaDepref, ColorDepref) VALUES 
('POST01', 'Andrea Morales', '8765432', 'Perro', 'Chihuahua', 'Negro'),
('POST02', 'Fernando Silva', '7654321', 'Perro', 'Salchicha', 'Café'),
('POST03', 'Gabriela Torrez', '8123456', 'Gato', 'Esfinge', 'Ninguno'),
('POST04', 'Rodrigo Peña', '7987654',  NULL, NULL, NULL),
('POST05', 'Patricia Vega', '8456789', NULL, NULL, NULL);

go
INSERT INTO Postulante (PostulanteId, Nombre, CI, EspecieDepref, RazaDepref, ColorDepref) VALUES 
('POST07', 'Rafaela Rib', '7883635', 'Gato', null, null),
('POST06', 'Emiliana Rib', '65867881', 'Perro', null, null)
go

-- HISTORIAL DE PESO (datos distribuidos en el tiempo para cada mascota)
INSERT INTO HistorialPeso (MascotaNo, Fecha, Peso) VALUES 
-- Paffi (Gato Siamés)
('M0001', '2024-01-15', 3.2),
('M0001', '2024-06-15', 3.8),
('M0001', '2024-12-15', 4.1),
-- Michi (Russian Blue)
('M0002', '2024-02-10', 4.5),
('M0002', '2024-08-10', 5.2),
('M0002', '2025-01-10', 5.8),
-- Rosita (Persa) - gatita recién nacida
('M0003', '2025-02-21', 0.8),
('M0003', '2025-05-21', 2.1),
-- Lomita (Esfinge)
('M0004', '2023-01-15', 2.8),
('M0004', '2023-12-15', 4.2),
('M0004', '2024-12-15', 4.8),
-- Alaska (Siamés)
('M0005', '2025-02-06', 0.9),
('M0005', '2025-05-06', 2.3),
-- Rocco (Bull Terrier)
('M0006', '2025-02-03', 8.5),
('M0006', '2025-05-03', 15.2),
-- Vaquita (Mezclado)
('M0007', '2025-04-27', 3.8),
('M0007', '2025-05-27', 5.1),
-- Luna (Chihuahua)
('M0008', '2022-01-20', 1.8),
('M0008', '2024-01-20', 2.5),
('M0008', '2025-01-20', 2.8),
-- Harry (Salchicha)
('M0009', '2022-01-04', 4.2),
('M0009', '2024-01-04', 6.8),
('M0009', '2025-01-04', 7.2),
-- Príncipe (Salchicha)
('M0010', '2022-11-11', 3.8),
('M0010', '2024-05-11', 6.2),
('M0010', '2025-05-11', 6.9);
go
-- HISTORIAL DE VACUNACIÓN
INSERT INTO HistorialVacunacion (MascotaNo, VacunaId, Fecha, Comentario, Precio, VetID) VALUES 
('M0001', 'VAC004', '2024-01-20', 'Primera vacuna Triple Felina', 150.00, 'V0001'),
('M0001', 'VAC001', '2024-03-15', 'Vacuna antirrábica anual', 120.00, 'V0002'),
('M0002', 'VAC004', '2024-01-10', 'Triple Felina completa', 150.00, 'V0001'),
('M0002', 'VAC005', '2024-02-15', 'Vacuna Leucemia Felina', 180.00, 'V0003'),
('M0003', 'VAC004', '2025-03-21', 'Primera vacuna del gatito', 150.00, 'V0002'),
('M0004', 'VAC001', '2023-08-15', 'Antirrábica', 120.00, 'V0004'),
('M0004', 'VAC004', '2024-01-20', 'Refuerzo Triple Felina', 150.00, 'V0001'),
('M0005', 'VAC004', '2025-03-06', 'Primera vacuna', 150.00, 'V0003'),
('M0006', 'VAC007', '2025-03-03', 'Pentavalente cachorro', 200.00, 'V0002'),
('M0006', 'VAC001', '2025-04-15', 'Antirrábica', 120.00, 'V0005'),
('M0007', 'VAC007', '2025-05-27', 'Primera vacuna cachorro', 200.00, 'V0004'),
('M0008', 'VAC001', '2022-08-20', 'Antirrábica', 120.00, 'V0001'),
('M0008', 'VAC008', '2024-08-20', 'Refuerzo antirrábica', 120.00, 'V0003'),
('M0009', 'VAC007', '2021-09-04', 'Pentavalente', 200.00, 'V0002'),
('M0009', 'VAC001', '2022-01-04', 'Antirrábica', 120.00, 'V0004'),
('M0010', 'VAC007', '2022-08-11', 'Pentavalente', 200.00, 'V0005'),
('M0010', 'VAC001', '2023-01-11', 'Antirrábica', 120.00, 'V0001');
go
-- MASCOTAS RESCATADAS (algunas mascotas fueron rescatadas)
INSERT INTO Rescatada (MascotaNo, RescatistaId) VALUES 
('M0011','RES001'),
('M0004', 'RES001'), -- Lomita fue rescatada -- a3
('M0007', 'RES002'), -- Vaquita fue rescatada
('M0008', 'RES003'), -- Luna fue rescatada- a1
('M0010', 'RES004'); -- Príncipe fue rescatado -a2
go
-- HISTORIAL MÉDICO
INSERT INTO HistorialMedico (MascotaNo, Fecha, Enfermedad, Rescatado, VetID) VALUES 
('M0001', '2024-03-10', 'Revisión general - Estado saludable',  0, 'V0001'),
('M0002', '2024-05-15', 'Conjuntivitis leve', 0, 'V0002'),
('M0003', '2025-02-25', 'Revisión neonatal', 0, 'V0003'),
('M0004', '2023-01-20', 'Desnutrición severa al rescate', 1, 'V0004'),
('M0004', '2024-06-15', 'Control post-tratamiento - Recuperado', 1, 'V0001'),
('M0005', '2025-02-10', 'Revisión neonatal',  0, 'V0002'),
('M0006', '2025-03-20', 'Revisión de cachorro', 0, 'V0005'),
('M0007', '2025-04-30', 'Tratamiento de parásitos intestinales', 1, 'V0003'),
('M0008', '2022-02-10', 'Fractura de pata trasera (rescate)', 1, 'V0004'),
('M0008', '2024-08-15', 'Control anual - Estado excelente', 1, 'V0001'),
('M0009', '2023-07-20', 'Otitis externa', 0, 'V0002'),
('M0010', '2022-06-15', 'Desparasitación post-rescate',  1, 'V0005');
go
INSERT INTO Cuidado (MascotaNo, Fecha, Tipo, Precio, Comentarios, VoluntarioId, VetID) VALUES 
-- Lomita (M0004) 
('M0004', '2023-02-20', 'Rehabilitación nutricional', 300.00, 'Programa especial post-rescate para desnutrición severa', 'VOL004', 'V0004'),
('M0004', '2023-04-15', 'Cuidado dermatológico', 250.00, 'Tratamiento especializado para piel de esfinge', 'VOL001', 'V0001'),
('M0004', '2024-01-10', 'Control de seguimiento', 150.00, 'Evaluación completa post-rehabilitación', 'VOL003', 'V0004'),
-- Vaquita (M0007)
('M0007', '2025-04-30', 'Desparasitación intensiva', 180.00, 'Tratamiento completo contra parásitos intestinales', 'VOL002', 'V0003'),
('M0007', '2025-05-15', 'Socialización', 100.00, 'Terapia de socialización post-rescate', 'VOL001', 'V0003'),
('M0007', '2025-05-25', 'Rehabilitación conductual', 120.00, 'Trabajo para superar traumas del abandono', 'VOL005', 'V0002'),
-- Luna (M0008) 
('M0008', '2022-02-15', 'Cirugía de fractura', 800.00, 'Operación para reparar fractura de pata trasera', 'VOL004', 'V0004'),
('M0008', '2022-03-20', 'Fisioterapia intensiva', 200.00, 'Rehabilitación post-quirúrgica', 'VOL002', 'V0004'),
('M0008', '2022-05-10', 'Terapia conductual', 150.00, 'Trabajo para superar miedo y agresividad', 'VOL003', 'V0001'),
('M0008', '2022-07-15', 'Control de seguimiento', 120.00, 'Evaluación completa de recuperación', 'VOL001', 'V0002'),
-- Príncipe (M0010) 
('M0010', '2022-06-20', 'Desparasitación completa', 180.00, 'Tratamiento intensivo post-rescate', 'VOL003', 'V0005'),
('M0010', '2022-08-15', 'Rehabilitación nutricional', 220.00, 'Programa para recuperar peso saludable', 'VOL005', 'V0001'),
('M0010', '2022-10-20', 'Socialización canina', 100.00, 'Terapia para mejorar interacción con otros perros', 'VOL002', 'V0003'),
('M0010', '2023-01-15', 'Control final', 80.00, 'Evaluación antes de proceso de adopción', 'VOL004', 'V0005');
go
-- CUENTAS POR COBRAR
INSERT INTO PorCobrar (HaberId, MascotaNo, Fecha, Tipo, Monto) VALUES 
-- Servicios de vacunación
('H0001', 'M0001', '2024-01-20', 'Vacuna Triple Felina', 150.00),
('H0002', 'M0001', '2024-03-15', 'Vacuna Antirrábica', 120.00),
('H0003', 'M0002', '2024-01-10', 'Vacuna Triple Felina', 150.00),
('H0004', 'M0002', '2024-02-15', 'Vacuna Leucemia Felina', 180.00),
('H0005', 'M0003', '2025-03-21', 'Vacuna Triple Felina', 150.00),
('H0006', 'M0004', '2024-01-20', 'Vacuna Triple Felina', 150.00),
('H0007', 'M0005', '2025-03-06', 'Vacuna Triple Felina', 150.00),
('H0008', 'M0006', '2025-03-03', 'Vacuna Pentavalente', 200.00),
('H0009', 'M0006', '2025-04-15', 'Vacuna Antirrábica', 120.00),
('H0010', 'M0007', '2025-05-27', 'Vacuna Pentavalente', 200.00),
('H0011', 'M0008', '2024-08-20', 'Vacuna Antirrábica Refuerzo', 120.00),
('H0012', 'M0009', '2022-01-04', 'Vacuna Antirrábica', 120.00),
('H0013', 'M0010', '2023-01-11', 'Vacuna Antirrábica', 120.00),

-- Servicios médicos
('H0014', 'M0001', '2024-03-10', 'Consulta General', 100.00),
('H0015', 'M0002', '2024-05-15', 'Tratamiento Conjuntivitis', 180.00),
('H0016', 'M0003', '2025-02-25', 'Consulta Neonatal', 120.00),
('H0017', 'M0004', '2023-01-20', 'Tratamiento Desnutrición', 350.00),
('H0018', 'M0004', '2024-06-15', 'Control Post-tratamiento', 150.00),
('H0019', 'M0005', '2025-02-10', 'Consulta Neonatal', 120.00),
('H0020', 'M0006', '2025-03-20', 'Consulta Cachorro', 130.00),
('H0021', 'M0007', '2025-04-30', 'Tratamiento Parásitos', 220.00),
('H0022', 'M0008', '2022-02-10', 'Tratamiento Fractura', 500.00),
('H0023', 'M0008', '2024-08-15', 'Control Anual', 120.00),
('H0024', 'M0009', '2023-07-20', 'Tratamiento Otitis', 180.00),
('H0025', 'M0010', '2022-06-15', 'Desparasitación', 150.00),

-- Servicios de cuidados especiales (solo rescatadas)
('H0026', 'M0004', '2023-02-20', 'Rehabilitación Nutricional', 300.00),
('H0027', 'M0004', '2023-04-15', 'Cuidado Dermatológico', 250.00),
('H0028', 'M0004', '2024-01-10', 'Control Seguimiento', 150.00),
('H0029', 'M0007', '2025-04-30', 'Desparasitación Intensiva', 180.00),
('H0030', 'M0007', '2025-05-15', 'Socialización', 100.00),
('H0031', 'M0007', '2025-05-25', 'Rehabilitación Conductual', 120.00),
('H0032', 'M0008', '2022-02-15', 'Cirugía Fractura', 800.00),
('H0033', 'M0008', '2022-03-20', 'Fisioterapia Intensiva', 200.00),
('H0034', 'M0008', '2022-05-10', 'Terapia Conductual', 150.00),
('H0035', 'M0008', '2022-07-15', 'Control Seguimiento', 120.00),
('H0036', 'M0010', '2022-06-20', 'Desparasitación Completa', 180.00),
('H0037', 'M0010', '2022-08-15', 'Rehabilitación Nutricional', 220.00),
('H0038', 'M0010', '2022-10-20', 'Socialización Canina', 100.00),
('H0039', 'M0010', '2023-01-15', 'Control Final', 80.00);
go

INSERT INTO Factura (FacturaId, HaberId, EsFondoComun, FamiliaNo) VALUES
('FT0091', 'H0001', 0,'F0005'),  -- Pago por cliente
('FT0002', 'H0002', 0, 'F0005'),  --
('FT0003', 'H0017', 1, null);  --fondos comunes

go

INSERT INTO Adopcion (AdopcionId, MascotaNo, PostulanteId, Fecha) VALUES
('A0001', 'M0008', 'POST01', '2024-09-15'),
('A0002', 'M0010', 'POST02', '2024-12-20'),
('A0003', 'M0004', 'POST03', '2025-01-10');
go


INSERT INTO Visita (VisitaId, AdopcionId, Fecha, Observaciones, VetID, VoluntarioId, RescatistaId) VALUES
('VI001', 'A0001', '2024-09-20', 'Chequeo veterinario inicial', 'V0001', NULL, NULL),
('VI002', 'A0001', '2024-09-25', 'Visita voluntario para socialización', NULL, 'VOL001', NULL),
('VI003', 'A0001', '2024-09-30', 'Visita rescatista para seguimiento', NULL, NULL, 'RES003'), 

('VI004', 'A0002', '2024-12-25', 'Chequeo veterinario inicial', 'V0002', NULL, NULL),
('VI005', 'A0002', '2024-12-28', 'Visita voluntario para socialización', NULL, 'VOL002', NULL),
('VI006', 'A0002', '2025-01-02', 'Visita rescatista para seguimiento', NULL, NULL, 'RES004'), 

('VI007', 'A0003', '2025-01-15', 'Chequeo veterinario inicial', 'V0001', NULL, NULL),
('VI008', 'A0003', '2025-01-18', 'Visita voluntario para socialización', NULL, 'VOL001', NULL),
('VI009', 'A0003', '2025-01-22', 'Visita rescatista para seguimiento', NULL, NULL, 'RES001');
select * from visita
go
INSERT INTO FondosComunes (DebeId, MecenaId, AdopcionId, Monto) VALUES
('D0001', 'MEC001', NULL, 500.00),  -- Fondo común pagado por mecena
('D0002', NULL, 'A0001', 150.00),   -- Fondo común pagado por adopción A0001
('D0003', 'MEC002', NULL, 300.00);  -- Otro fondo común por otro mecena

go
-- BONIFICACIONES (Incentivos para veterinarios por casos especiales)
INSERT INTO Bonificacion (BonificacionID, VetID, MascotaNo, Monto, FechaRegistro, Pagada) VALUES 
-- Bonificaciones por rescates exitosos
('BON001', 'V0004', 'M0004', 500.00, '2023-02-15', 1), -- Dr. María por rescate de Lomita
('BON002', 'V0003', 'M0007', 400.00, '2025-05-01', 0), -- Dr. Luis por rescate de Vaquita
('BON003', 'V0004', 'M0008', 600.00, '2022-03-10', 1), -- Dr. María por rescate de Luna
('BON004', 'V0005', 'M0010', 450.00, '2022-07-15', 1), -- Dr. Roberto por rescate de Príncipe

-- Bonificaciones por adopciones exitosas
('BON005', 'V0001', 'M0008', 300.00, '2024-09-20', 1), -- Dr. Carlos por proceso de adopción de Luna
('BON006', 'V0003', 'M0010', 350.00, '2024-12-25', 1), -- Dr. Luis por proceso de adopción de Príncipe
('BON007', 'V0005', 'M0004', 400.00, '2025-01-15', 0), -- Dr. Roberto por proceso de adopción de Lomita

-- Bonificaciones por cuidados especiales
('BON008', 'V0002', 'M0003', 250.00, '2025-04-15', 0), -- Dra. Ana por cuidado neonatal de Rosita
('BON009', 'V0005', 'M0006', 200.00, '2025-04-25', 0), -- Dr. Roberto por adiestramiento de Rocco
('BON010', 'V0002', 'M0002', 180.00, '2024-07-25', 1), -- Dra. Ana por limpieza dental de Michi

-- Bonificaciones por casos complejos
('BON011', 'V0004', 'M0008', 350.00, '2022-05-20', 1), -- Dr. María por fisioterapia de Luna
('BON012', 'V0001', 'M0004', 300.00, '2024-07-20', 1), -- Dr. Carlos por seguimiento de Lomita
('BON013', 'V0003', 'M0007', 220.00, '2025-05-20', 0), -- Dr. Luis por socialización de Vaquita
('BON014', 'V0002', 'M0001', 150.00, '2024-04-20', 1), -- Dra. Ana por cuidado especializado de Paffi
('BON015', 'V0005', 'M0005', 180.00, '2025-03-10', 0); -- Dr. Roberto por cuidado neonatal de Alaska
go

--------------------------------------------------------------------
------ CONSULTAS 1: INSERTAR NASCOTA RESCATADA, CON SU CUIDADO Y ATENCION

CREATE OR ALTER PROCEDURE RegistrarAnimalRescatado
    @Especie VARCHAR(50),
    @Raza VARCHAR(50),
    @Color VARCHAR(50),
    @FechaNacimiento DATE,
    @Alias VARCHAR(50),
    @FamiliaNo CHAR(10),
    @RescatistaId CHAR(10)
AS
BEGIN
    DECLARE @MascotaNo CHAR(5);

    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT @MascotaNo = 
            'M' + RIGHT('0000' + CAST(
                ISNULL(MAX(CAST(SUBSTRING(MascotaNo, 2, LEN(MascotaNo) - 1) AS INT)), 0) + 1 AS VARCHAR), 4)
        FROM Mascota;

        INSERT INTO Mascota (MascotaNo, Especie, Raza, Color, FechaNacimiento, Alias, FamiliaNo)
        VALUES (@MascotaNo, @Especie, @Raza, @Color, @FechaNacimiento, @Alias, @FamiliaNo);

        INSERT INTO Rescatada (MascotaNo, RescatistaId)
        VALUES (@MascotaNo, @RescatistaId);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END;
EXEC RegistrarAnimalRescatado
    @Especie = 'Perro',
    @Raza = 'Bulldog',
    @Color = 'Blanco',
    @FechaNacimiento = '2023-08-15',
    @Alias = 'Rocky',
    @FamiliaNo = 'F0002',
    @RescatistaId = 'RES004';


------------------------- REGISTRRAR CUIDADO RESCATADA

CREATE OR ALTER PROCEDURE RegistrarCuidado
    @MascotaNo CHAR(10),
    @Fecha DATE,
    @Tipo VARCHAR(100),
    @Precio DECIMAL(10,2),
    @Comentarios TEXT,
    @VoluntarioId CHAR(10),
    @VetID CHAR(10)
AS
BEGIN
    BEGIN TRY
        -- Validar que la mascota exista
        IF NOT EXISTS (SELECT 1 FROM Mascota WHERE MascotaNo = @MascotaNo)
        BEGIN
            RAISERROR('La mascota especificada no existe', 16, 1);
            RETURN;
        END

        -- Validar que el veterinario exista
        IF NOT EXISTS (SELECT 1 FROM Veterinario WHERE VetID = @VetID)
        BEGIN
            RAISERROR('El veterinario especificado no existe', 16, 1);
            RETURN;
        END

        -- Validar que el voluntario exista
        IF NOT EXISTS (SELECT 1 FROM Voluntario WHERE VoluntarioId = @VoluntarioId)
        BEGIN
            RAISERROR('El voluntario especificado no existe', 16, 1);
            RETURN;
        END

        -- Insertar el cuidado
        INSERT INTO Cuidado (MascotaNo, Fecha, Tipo, Precio, Comentarios, VoluntarioId, VetID)
        VALUES (@MascotaNo, @Fecha, @Tipo, @Precio, @Comentarios, @VoluntarioId, @VetID);

        PRINT 'Cuidado registrado exitosamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;

EXEC RegistrarCuidado
    @MascotaNo = 'M0012',
    @Fecha = '2025-06-05',
    @Tipo = 'Chequeo general',
    @Precio = 10.00,
    @Comentarios = 'Revisión rutinaria después del rescate',
    @VoluntarioId = 'VOL002',
    @VetID = 'V0001';


---------------------REGISTRAR ATENCION RESCATADA
CREATE OR ALTER PROCEDURE RegistrarAtencion
    @MascotaNo CHAR(10),
    @Fecha DATE,
    @Enfermedad VARCHAR(100),
    @Rescatado BIT,
    @VetID CHAR(10)
AS
BEGIN
    BEGIN TRY
        -- Validar que la mascota exista
        IF NOT EXISTS (SELECT 1 FROM Mascota WHERE MascotaNo = @MascotaNo)
        BEGIN
            RAISERROR('La mascota especificada no existe', 16, 1);
            RETURN;
        END

        -- Validar que el veterinario exista
        IF NOT EXISTS (SELECT 1 FROM Veterinario WHERE VetID = @VetID)
        BEGIN
            RAISERROR('El veterinario especificado no existe', 16, 1);
            RETURN;
        END

        -- Insertar en HistorialMedico
        INSERT INTO HistorialMedico (MascotaNo, Fecha, Enfermedad, Rescatado, VetID)
        VALUES (@MascotaNo, @Fecha, @Enfermedad, @Rescatado, @VetID);
        
        PRINT 'Atención registrada exitosamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO


EXEC RegistrarAtencion
    @MascotaNo = 'M0012',
    @Fecha = '2025-06-05',
    @Enfermedad = 'Vacunación completa',
    @Rescatado = 1,
    @VetID = 'V0001';

---------------------------------------------------------------
----------CONSULTA 2: REGISTRAR ADOPCION Y GENERAR GASTOS
CREATE OR ALTER PROCEDURE RegistrarAdopcionYCuentaGastos
    @MascotaNo CHAR(10),
    @PostulanteId CHAR(10),
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Verificar si la mascota ya fue adoptada
        IF EXISTS (SELECT 1 FROM Adopcion WHERE MascotaNo = @MascotaNo)
        BEGIN
            RAISERROR('La mascota ya fue adoptada', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        DECLARE @NuevoAdopcionId CHAR(10);  

        SELECT @NuevoAdopcionId = 
            'A' + RIGHT('0000' + CAST(ISNULL(MAX(CAST(SUBSTRING(AdopcionId, 2, 4) AS INT)), 0) + 1 AS VARCHAR), 4)
        FROM Adopcion;

        INSERT INTO Adopcion (AdopcionId, MascotaNo, PostulanteId, Fecha)
        VALUES (@NuevoAdopcionId, @MascotaNo, @PostulanteId, @Fecha);

        SELECT 
            'Cuidado' AS TipoGasto,
            c.Fecha,
            c.Tipo,
            c.Precio AS Monto,
            c.Comentarios
        FROM 
            Cuidado c
        WHERE 
            c.MascotaNo = @MascotaNo
            AND c.Fecha <= @Fecha

        UNION ALL

        SELECT
            'Historial Medico' AS TipoGasto,
            pc.Fecha,
            pc.Tipo,
            pc.Monto,
            'Servicio médico' AS Comentarios  
        FROM
            PorCobrar pc
        WHERE 
            pc.MascotaNo = @MascotaNo
            AND pc.Fecha <= @Fecha

        ORDER BY Fecha;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;


EXEC RegistrarAdopcionYCuentaGastos
    @MascotaNo = 'M0007',
    @PostulanteId = 'POST07',
    @Fecha = '2025-06-05';


	Select * from adopcion

-----------------------------------------------------------------------------------------
--------------CONSULTA 3: COMPATIBILIDAD DE POSTULANTES Y RESCATADAS

CREATE OR ALTER PROCEDURE ReporteCompatibilidadAdopciones
AS
BEGIN
    SELECT 
        P.PostulanteId,
        P.Nombre AS Postulante,
        ISNULL(P.EspecieDepref, 'Cualquiera') AS EspeciePreferida,
        ISNULL(P.RazaDepref, 'Cualquiera') AS RazaPreferida,
        ISNULL(P.ColorDepref, 'Cualquiera') AS ColorPreferido,
        M.MascotaNo,
        M.Especie,
        M.Raza,
        M.Color,
        M.Alias AS NombreMascota,
        M.FechaNacimiento,
        DATEDIFF(MONTH, M.FechaNacimiento, GETDATE()) AS EdadMeses,
        CASE 
            WHEN A.MascotaNo IS NULL THEN 'Disponible'
            ELSE 'Adoptada'
        END AS EstadoAdopcion
    FROM Postulante P
    LEFT JOIN Mascota M 
        ON (P.EspecieDepref IS NULL OR M.Especie = P.EspecieDepref)
        AND (P.RazaDepref IS NULL OR M.Raza = P.RazaDepref)
        AND (P.ColorDepref IS NULL OR M.Color = P.ColorDepref)
    LEFT JOIN Adopcion A ON M.MascotaNo = A.MascotaNo
    ORDER BY P.PostulanteId, M.MascotaNo;
END
GO

EXEC ReporteCompatibilidadAdopciones;

------------------------------------------------------------
--------------------CONSULTA 4: BASICA DE LAS VISITAS
SELECT 
    v.VisitaId,
    v.Fecha,
    v.Observaciones,
    a.AdopcionId,
    a.Fecha AS FechaAdopcion,
    p.Nombre AS NombrePostulante,
    p.CI AS CIPostulante,
    m.Alias AS NombreMascota,
    m.Especie,
    m.Raza,
    vet.Nombre AS NombreVeterinario,
    vol.Nombre AS NombreVoluntario,
    r.Nombre AS NombreRescatista
FROM Visita v
INNER JOIN Adopcion a ON v.AdopcionId = a.AdopcionId
INNER JOIN Postulante p ON a.PostulanteId = p.PostulanteId
INNER JOIN Mascota m ON a.MascotaNo = m.MascotaNo
LEFT JOIN Veterinario vet ON v.VetID = vet.VetID
LEFT JOIN Voluntario vol ON v.VoluntarioId = vol.VoluntarioId
LEFT JOIN Rescatista r ON v.RescatistaId = r.RescatistaId
ORDER BY v.Fecha DESC;


------------------------------------------------------------------------
------------------------------------CONSULTA BÁSICA 4 ALTERATIVA
SELECT 
    v.VisitaId AS 'ID Visita',
    v.Fecha AS 'Fecha de Visita',
    v.Observaciones,
    p.Nombre AS 'Adoptante',
    p.CI AS 'CI Adoptante',
    m.Alias AS 'Mascota Adoptada',
    CONCAT(m.Especie, ' - ', m.Raza) AS 'Especie y Raza',
    a.Fecha AS 'Fecha de Adopción',
    DATEDIFF(DAY, a.Fecha, v.Fecha) AS 'Días desde Adopción',
    CASE 
        WHEN v.VetID IS NOT NULL THEN vet.Nombre
        WHEN v.VoluntarioId IS NOT NULL THEN vol.Nombre  
        WHEN v.RescatistaId IS NOT NULL THEN r.Nombre
        ELSE 'No especificado'
    END AS 'Responsable de Visita',
    CASE 
        WHEN v.VetID IS NOT NULL THEN 'Veterinario'
        WHEN v.VoluntarioId IS NOT NULL THEN 'Voluntario'
        WHEN v.RescatistaId IS NOT NULL THEN 'Rescatista'
        ELSE 'No especificado'
    END AS 'Tipo de Responsable'
FROM Visita v
INNER JOIN Adopcion a ON v.AdopcionId = a.AdopcionId
INNER JOIN Postulante p ON a.PostulanteId = p.PostulanteId
INNER JOIN Mascota m ON a.MascotaNo = m.MascotaNo
LEFT JOIN Veterinario vet ON v.VetID = vet.VetID
LEFT JOIN Voluntario vol ON v.VoluntarioId = vol.VoluntarioId
LEFT JOIN Rescatista r ON v.RescatistaId = r.RescatistaId
ORDER BY v.Fecha DESC;
