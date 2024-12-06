
CREATE TABLE TiposDeExamenes (
    ExamenID INT AUTO_INCREMENT PRIMARY KEY,
    Codigo VARCHAR(50) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL
);
INSERT INTO Citas (Codigo, Nombre, Precio) VALUES
('ACI0002', 'Ácido Úrico', 10.00),
('ALT0009', 'ALT/TGP Transaminasa Pirúvica', 15.00),
('AST00035', 'AST o TGO - Transaminasa Oxalacética', 20.00),
('COL00062', 'Colesterol Total', 12.00),
('CRE00073', 'Creatinina en sangre', 18.00),
('EG00094', 'E.G.O - Examen General Orina', 25.00),
('GLU000111', 'Glucosa en ayunas', 10.00),
('HDL000116', 'HDL - Colesterol Alta Densidad', 13.00),
('HEM000120', 'Hemograma Completo', 30.00),
('LDL000138', 'LDL - Colesterol Baja Densidad', 14.00),
('NIT000146', 'Nitrógeno Ureico', 20.00),
('TRI000194', 'Triglicéridos', 17.00),
('T3000179', 'T3 libre - Tiroxina Libre', 28.00),
('T3000180', 'T3 total - Tiroxina Total', 27.00),
('T4000181', 'T4 libre - Tiroxina Libre', 26.00),
('T4000182', 'T4 total - Tiroxina Total', 25.00),
('TSH000196', 'TSH - Hormona Estimulante de la Ti', 22.00);
