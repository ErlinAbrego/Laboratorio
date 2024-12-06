CREATE TABLE Citas (
    CitaID INT PRIMARY KEY AUTO_INCREMENT,
    usercod BIGINT(10) NOT NULL,
    FechaCita DATETIME NOT NULL,
    ExamenID INT NOT NULL,
    EstadoCita VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    FechaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FechaModificacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    telefono VARCHAR(20),
    email VARCHAR(50),
    FOREIGN KEY (ExamenID) REFERENCES TiposDeExamenes(ExamenID),
    FOREIGN KEY (usercod) REFERENCES usuario(usercod)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE Examenes (
    ExamenID INT PRIMARY KEY AUTO_INCREMENT,
    NombreExamen VARCHAR(100),
    Descripcion TEXT,
    Precio DECIMAL(10, 2)
);
CREATE TABLE Resultados (
    ResultadoID INT PRIMARY KEY AUTO_INCREMENT,
    CitaID INT,
    ExamenID INT,
    Resultado TEXT,
    FechaResultado DATETIME,
    FOREIGN KEY (CitaID) REFERENCES Citas(CitaID),
    FOREIGN KEY (ExamenID) REFERENCES Examenes(ExamenID)
);
