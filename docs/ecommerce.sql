-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-12-2024 a las 06:16:17
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ecommerce`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

CREATE TABLE `bitacora` (
  `bitacoracod` int(11) NOT NULL,
  `bitacorafch` datetime DEFAULT NULL,
  `bitprograma` varchar(255) DEFAULT NULL,
  `bitdescripcion` varchar(255) DEFAULT NULL,
  `bitobservacion` mediumtext DEFAULT NULL,
  `bitTipo` char(3) DEFAULT NULL,
  `bitusuario` bigint(18) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carretilla`
--

CREATE TABLE `carretilla` (
  `usercod` bigint(10) NOT NULL,
  `productId` int(11) NOT NULL,
  `crrctd` int(5) NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `CitaID` int(11) NOT NULL,
  `usercod` bigint(10) NOT NULL,
  `FechaCita` datetime NOT NULL,
  `ExamenID` int(11) NOT NULL,
  `EstadoCita` varchar(50) NOT NULL DEFAULT 'Pendiente',
  `FechaCreacion` datetime DEFAULT current_timestamp(),
  `FechaModificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`CitaID`, `usercod`, `FechaCita`, `ExamenID`, `EstadoCita`, `FechaCreacion`, `FechaModificacion`, `telefono`, `email`) VALUES
(4, 1, '2024-12-11 15:36:00', 8, 'Confirmada', '2024-12-02 15:36:34', '2024-12-03 10:40:35', '96680148', 'ingerlinabrego@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funciones`
--

CREATE TABLE `funciones` (
  `fncod` varchar(255) NOT NULL,
  `fndsc` varchar(255) DEFAULT NULL,
  `fnest` char(3) DEFAULT NULL,
  `fntyp` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `funciones`
--

INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Agendar Cita', 'Agendar Cita', 'ACT', 'MNU'),
('citas_Confirmar_enabled', 'citas_Confirmar_enabled', 'ACT', 'FNC'),
('citas_DEL_enabled', 'citas_DEL_enabled', 'ACT', 'FNC'),
('citas_FechaCreacion', 'citas_FechaCreacion', 'ACT', 'FNC'),
('citas_FechaCreacion_enabled', 'citas_FechaCreacion_enabled', 'ACT', 'FNC'),
('citas_INS_enabled', 'citas_INS_enabled', 'ACT', 'FNC'),
('citas_MostrarDatos_enabled', 'citas_MostrarDatos_enabled', 'ACT', 'FNC'),
('citas_Pagar_enabled', 'citas_Pagar_enabled', 'ACT', 'FNC'),
('citas_UPD_enabled', 'citas_UPD_enabled', 'ACT', 'FNC'),
('Controllers\\Checkout\\Checkout', 'Controllers\\Checkout\\Checkout', 'ACT', 'CTR'),
('Controllers\\Citas\\CitasForm', 'Controllers\\Citas\\CitasForm', 'ACT', 'CTR'),
('Controllers\\Citas\\CitasList', 'Controllers\\Citas\\CitasList', 'ACT', 'CTR'),
('Menu_PaymentCheckout', 'Menu_PaymentCheckout', 'ACT', 'MNU');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funciones_roles`
--

CREATE TABLE `funciones_roles` (
  `rolescod` varchar(128) NOT NULL,
  `fncod` varchar(255) NOT NULL,
  `fnrolest` char(3) DEFAULT NULL,
  `fnexp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `funciones_roles`
--

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES
('Admin', 'citas_Confirmar_enabled', 'ACT', '2024-12-31 00:08:21'),
('Admin', 'citas_DEL_enabled', 'ACT', '2024-12-31 00:08:21'),
('Admin', 'citas_INS_enabled', 'ACT', '2024-12-31 00:08:21'),
('Admin', 'citas_MostrarDatos_enabled', 'ACT', '2024-12-31 00:08:21'),
('Admin', 'citas_UPD_enabled', 'ACT', '2024-12-31 00:08:21'),
('Admin', 'Controllers\\Checkout\\Checkout', 'ACT', '2024-12-31 00:08:21'),
('Admin', 'Controllers\\Citas\\CitasForm', 'ACT', '2024-12-31 00:08:21'),
('Admin', 'Controllers\\Citas\\CitasList', 'ACT', '2024-12-31 00:07:34'),
('Admin', 'Menu_PaymentCheckout', 'ACT', '2024-12-31 00:08:21'),
('Cliente', 'citas_INS_enabled', 'ACT', '2024-12-31 00:08:21'),
('Cliente', 'citas_Pagar_enabled', 'ACT', '2024-12-31 00:08:21'),
('Cliente', 'Controllers\\Checkout\\Checkout', 'ACT', '2024-12-31 00:08:21'),
('Cliente', 'Controllers\\Citas\\CitasForm', 'ACT', '2024-12-31 00:08:21'),
('Cliente', 'Controllers\\Citas\\CitasList', 'ACT', '2024-12-31 00:07:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productDescription` text NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productImgUrl` varchar(255) NOT NULL,
  `productStock` int(11) NOT NULL DEFAULT 0,
  `productStatus` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rolescod` varchar(128) NOT NULL,
  `rolesdsc` varchar(45) DEFAULT NULL,
  `rolesest` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rolescod`, `rolesdsc`, `rolesest`) VALUES
('Admin', 'Admin del laboratorio', 'ACT'),
('Cliente', 'Cliente del laboratorio', 'ACT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_usuarios`
--

CREATE TABLE `roles_usuarios` (
  `usercod` bigint(10) NOT NULL,
  `rolescod` varchar(128) NOT NULL,
  `roleuserest` char(3) DEFAULT NULL,
  `roleuserfch` datetime DEFAULT NULL,
  `roleuserexp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `roles_usuarios`
--

INSERT INTO `roles_usuarios` (`usercod`, `rolescod`, `roleuserest`, `roleuserfch`, `roleuserexp`) VALUES
(1, 'Admin', 'ACT', '2024-12-02 00:06:00', '2024-12-31 00:06:00'),
(2, 'Cliente', 'ACT', '2024-12-02 00:06:00', '2024-12-31 00:06:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposdeexamenes`
--

CREATE TABLE `tiposdeexamenes` (
  `ExamenID` int(11) NOT NULL,
  `Codigo` varchar(50) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tiposdeexamenes`
--

INSERT INTO `tiposdeexamenes` (`ExamenID`, `Codigo`, `Nombre`, `Precio`) VALUES
(1, 'ACI0002', 'Ácido Úrico', 10.00),
(2, 'ALT0009', 'ALT/TGP Transaminasa Pirúvica', 15.00),
(3, 'AST00035', 'AST o TGO - Transaminasa Oxalacética', 20.00),
(4, 'COL00062', 'Colesterol Total', 12.00),
(5, 'CRE00073', 'Creatinina en sangre', 18.00),
(6, 'EG00094', 'E.G.O - Examen General Orina', 25.00),
(7, 'GLU000111', 'Glucosa en ayunas', 10.00),
(8, 'HDL000116', 'HDL - Colesterol Alta Densidad', 13.00),
(9, 'HEM000120', 'Hemograma Completo', 30.00),
(10, 'LDL000138', 'LDL - Colesterol Baja Densidad', 14.00),
(11, 'NIT000146', 'Nitrógeno Ureico', 20.00),
(12, 'TRI000194', 'Triglicéridos', 17.00),
(13, 'T3000179', 'T3 libre - Tiroxina Libre', 28.00),
(14, 'T3000180', 'T3 total - Tiroxina Total', 27.00),
(15, 'T4000181', 'T4 libre - Tiroxina Libre', 26.00),
(16, 'T4000182', 'T4 total - Tiroxina Total', 25.00),
(17, 'TSH000196', 'TSH - Hormona Estimulante de la Ti', 22.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usercod` bigint(10) NOT NULL,
  `useremail` varchar(80) DEFAULT NULL,
  `username` varchar(80) DEFAULT NULL,
  `userpswd` varchar(128) DEFAULT NULL,
  `userfching` datetime DEFAULT NULL,
  `userpswdest` char(3) DEFAULT NULL,
  `userpswdexp` datetime DEFAULT NULL,
  `userest` char(3) DEFAULT NULL,
  `useractcod` varchar(128) DEFAULT NULL,
  `userpswdchg` varchar(128) DEFAULT NULL,
  `usertipo` char(3) DEFAULT NULL COMMENT 'Tipo de Usuario, Normal, Consultor o Cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usercod`, `useremail`, `username`, `userpswd`, `userfching`, `userpswdest`, `userpswdexp`, `userest`, `useractcod`, `userpswdchg`, `usertipo`) VALUES
(1, 'erlinabrego0@gmail.com', 'Erlin Abrego', '$2y$10$YlUr84GpV00Y6GY7A4dKCujPAH2YobBUzU07Pk6J9RJFWUj.g0gzy', '2024-12-02 00:03:39', 'ACT', '2025-03-02 00:00:00', 'ACT', '45b5739cb5a5e79eadf9def06572314784d5cc8776497cc98feaf28e1cbf59de', '2024-12-02 00:03:39', 'ADM'),
(2, 'joselopez@gmail.com', 'John Doe', '$2y$10$4QcSG4vouUkXi4ilIwmBOOWxJsLhoFRWM3EZtHM5oV.LURJ3I5mTe', '2024-12-02 00:04:17', 'ACT', '2025-03-02 00:00:00', 'ACT', '0d5542eb4819f9ab61ce1e39c2095060e7e1b7c08aedaa5d0176417df0c025ef', '2024-12-02 00:04:17', 'PBL');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  ADD PRIMARY KEY (`bitacoracod`);

--
-- Indices de la tabla `carretilla`
--
ALTER TABLE `carretilla`
  ADD PRIMARY KEY (`usercod`,`productId`),
  ADD KEY `productId_idx` (`productId`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`CitaID`),
  ADD KEY `ExamenID` (`ExamenID`),
  ADD KEY `usercod` (`usercod`);

--
-- Indices de la tabla `funciones`
--
ALTER TABLE `funciones`
  ADD PRIMARY KEY (`fncod`);

--
-- Indices de la tabla `funciones_roles`
--
ALTER TABLE `funciones_roles`
  ADD PRIMARY KEY (`rolescod`,`fncod`),
  ADD KEY `rol_funcion_key_idx` (`fncod`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rolescod`);

--
-- Indices de la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD PRIMARY KEY (`usercod`,`rolescod`),
  ADD KEY `rol_usuario_key_idx` (`rolescod`);

--
-- Indices de la tabla `tiposdeexamenes`
--
ALTER TABLE `tiposdeexamenes`
  ADD PRIMARY KEY (`ExamenID`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usercod`),
  ADD UNIQUE KEY `useremail_UNIQUE` (`useremail`),
  ADD KEY `usertipo` (`usertipo`,`useremail`,`usercod`,`userest`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `bitacoracod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `CitaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tiposdeexamenes`
--
ALTER TABLE `tiposdeexamenes`
  MODIFY `ExamenID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usercod` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carretilla`
--
ALTER TABLE `carretilla`
  ADD CONSTRAINT `carretilla_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `carretilla_user_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`ExamenID`) REFERENCES `tiposdeexamenes` (`ExamenID`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`);

--
-- Filtros para la tabla `funciones_roles`
--
ALTER TABLE `funciones_roles`
  ADD CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION;

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `EliminarCitasPendientes` ON SCHEDULE EVERY 15 MINUTE STARTS '2024-12-03 16:12:24' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM citas
  WHERE EstadoCita = 'Pendiente'
  AND TIMESTAMPDIFF(MINUTE, FechaCreacion, NOW()) > 60$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
