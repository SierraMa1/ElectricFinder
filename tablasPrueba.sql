CREATE DATABASE electricFinder;
USE electricFinder;

-- -------------------------------------------------------------
-- TablePlus 3.11.0(352)
--
-- https://tableplus.com/
--
-- Database: electricFinder
-- Generation Time: 2024-06-01 16:57:28.4550
-- -------------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `tieneFoto` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(100) NOT NULL,
  `typeFoto` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `usuarios` (`id`, `nombre`, `apellidos`, `email`, `ubicacion`, `tieneFoto`, `password`, `typeFoto`) VALUES
(1, 'Juan', 'Pérez', 'juan@example.com', 'Ciudad de México, México', 1, 'contraseña123', 'jpg');
INSERT INTO `usuarios` (`id`, `nombre`, `apellidos`, `email`, `ubicacion`, `tieneFoto`, `password`, `typeFoto`) VALUES
(2, 'María', 'García', 'maria@example.com', 'Madrid, España', 1, 'clave123', 'png');
INSERT INTO `usuarios` (`id`, `nombre`, `apellidos`, `email`, `ubicacion`, `tieneFoto`, `password`, `typeFoto`) VALUES
(3, 'Luis', 'Hernández', 'luis@example.com', 'Buenos Aires, Argentina', 1, 'password123', 'jpg');
INSERT INTO `usuarios` (`id`, `nombre`, `apellidos`, `email`, `ubicacion`, `tieneFoto`, `password`, `typeFoto`) VALUES
(4, 'Ana', 'Martínez', 'ana@example.com', 'Lima, Perú', 1, 'contraseña123', 'jpg'),
(5, 'Carlos', 'Rodríguez', 'carlos@example.com', 'Bogotá, Colombia', 1, 'clave123', 'jpg'),
(6, 'Laura', 'López', 'laura@example.com', 'Santiago, Chile', 1, 'password123', 'jpg'),
(7, 'David', 'Gómez', 'david@example.com', 'Quito, Ecuador', 1, 'contraseña123', 'jpg'),
(8, 'Elena', 'Díaz', 'elena@example.com', 'São Paulo, Brasil', 1, 'clave123', 'jpg'),
(9, 'Sara', 'Ruiz', 'sara@example.com', 'Lisboa, Portugal', 1, 'password123', 'png'),
(10, 'Diego', 'Fernández', 'diego@example.com', 'Barcelona, España', 1, 'contraseña123', 'jpg'),
(25, 'Elena', 'Díaz', 'elena@example.com', 'São Paulo, Brasil', 1, 'clave123', 'jpg'),
(26, 'Sara', 'Ruiz', 'sara@example.com', 'Lisboa, Portugal', 1, 'password123', 'jpg'),
(34, 'María', 'Sierra Sánchez', 'maria.sierra.sanchez@hotmail.com', 'malaga', 1, '123', 'png');

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `electricistas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `apellidos` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `servicios` varchar(255) NOT NULL,
  `nombreEmpresa` varchar(255) NOT NULL,
  `password` varchar(100) NOT NULL,
  `typeFoto` varchar(3) DEFAULT NULL,
  `tieneFoto` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `secondary` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `electricistas` (`id`, `nombre`, `apellidos`, `telefono`, `email`, `ubicacion`, `servicios`, `nombreEmpresa`, `password`, `typeFoto`, `tieneFoto`) VALUES
(1, 'Pablo', 'González', '123456789', 'pablo@example.com', 'Huete, Cuenca', 'Instalación eléctrica, Reparación de cortocircuitos', 'Electricidad González', 'password123', 'png', 1);
INSERT INTO `electricistas` (`id`, `nombre`, `apellidos`, `telefono`, `email`, `ubicacion`, `servicios`, `nombreEmpresa`, `password`, `typeFoto`, `tieneFoto`) VALUES
(2, 'Alejandro', 'Sánchez', '987654321', 'alejandro@example.com', 'Madrid, España', 'Mantenimiento de sistemas eléctricos, Instalación de iluminación', 'Sánchez Electrificaciones', 'clave123', 'png', 1);
INSERT INTO `electricistas` (`id`, `nombre`, `apellidos`, `telefono`, `email`, `ubicacion`, `servicios`, `nombreEmpresa`, `password`, `typeFoto`, `tieneFoto`) VALUES
(3, 'Daniel', 'Montes', '5551234567', 'daniel@example.com', 'Buendía, Cuenca', 'Instalación de paneles solares, Reparación de fallos eléctricos', 'Pérez Energía Renovable', 'contraseña123', 'png', 1);
INSERT INTO `electricistas` (`id`, `nombre`, `apellidos`, `telefono`, `email`, `ubicacion`, `servicios`, `nombreEmpresa`, `password`, `typeFoto`, `tieneFoto`) VALUES
(4, 'Pablo eduardo', 'Martínez', '7779876543', 'eduardo@example.com', 'Villalba del Rey,Cuenca', 'Instalación de sistemas de seguridad eléctrica, Cableado residencial', 'Martínez Electricidad', 'password123', 'jpg', 1),
(5, 'Sofía', 'López', '3334445556', 'sofia@example.com', 'Sacedón, Guadalajara', 'Reparación de electrodomésticos, Instalación de alarmas', 'Sofía Electric', 'clave123', 'png', 1),
(6, 'Manuel', 'Sánchez', '6667778889', 'manuel@example.com', 'Leganés, Madrid', 'Mantenimiento de sistemas de iluminación, Reparación de circuitos eléctricos', 'Gómez Electric', 'contraseña123', 'png', 1),
(7, 'Carmen', 'Fernández', '2223334447', 'carmen@example.com', 'Garcinarro,Cuenca', 'Instalación de sistemas de energía alternativa, Reparación de transformadores', 'Carmen Energías Renovables', 'password123', 'png', 1),
(8, 'Javier', 'Pérez', '9998887775', 'javier@example.com', 'Chillarón, Guadalajara', 'Instalación de sistemas de tierra, Mantenimiento.Cambio cableado integral', 'Electricidad Pérez', 'clave123', 'jpg', 1),
(10, 'Felipe', 'Fernandez', '1231231234', 'felipe@example1.com', 'Huete,Cuenca', 'Instalación de sistemas de domótica, Reparación de sistemas de seguridad electrónica', 'Mario Electric', 'password123', 'jpg', 1),
(45, 'Elena', 'Ruiz', '1112223338', 'elenas@example.com', 'Tendilla,Guadalajara', 'Reparación de sistemas de climatización, Instalación de sistemas de control de acceso', 'Ruiz Energía', 'contraseña123', NULL, NULL),
(46, 'Damian', 'García', '1334535343', 'damian@prueba.es', 'Tendilla, Cuenca', 'Electricidad para tu hogar', 'Damian SA', 'q32ewe', 'jpg', 1),
(50, 'francisco', 'gonzale', '444444444', 'fran@example.com', 'malaga', 'electricidad inetgral', 'fran S.l', '1234', 'png', 1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;





-- -------------------------------------------------------------
-- TablePlus 3.11.0(352)
--
-- https://tableplus.com/
--
-- Database: electricFinder
-- Generation Time: 2024-06-01 16:57:42.4040
-- -------------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `electricistas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `apellidos` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `servicios` varchar(255) NOT NULL,
  `nombreEmpresa` varchar(255) NOT NULL,
  `password` varchar(100) NOT NULL,
  `typeFoto` varchar(3) DEFAULT NULL,
  `tieneFoto` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `secondary` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `electricistas` (`id`, `nombre`, `apellidos`, `telefono`, `email`, `ubicacion`, `servicios`, `nombreEmpresa`, `password`, `typeFoto`, `tieneFoto`) VALUES
(1, 'Pablo', 'González', '123456789', 'pablo@example.com', 'Huete, Cuenca', 'Instalación eléctrica, Reparación de cortocircuitos', 'Electricidad González', 'password123', 'png', 1);
INSERT INTO `electricistas` (`id`, `nombre`, `apellidos`, `telefono`, `email`, `ubicacion`, `servicios`, `nombreEmpresa`, `password`, `typeFoto`, `tieneFoto`) VALUES
(2, 'Alejandro', 'Sánchez', '987654321', 'alejandro@example.com', 'Madrid, España', 'Mantenimiento de sistemas eléctricos, Instalación de iluminación', 'Sánchez Electrificaciones', 'clave123', 'png', 1);
INSERT INTO `electricistas` (`id`, `nombre`, `apellidos`, `telefono`, `email`, `ubicacion`, `servicios`, `nombreEmpresa`, `password`, `typeFoto`, `tieneFoto`) VALUES
(3, 'Daniel', 'Montes', '5551234567', 'daniel@example.com', 'Buendía, Cuenca', 'Instalación de paneles solares, Reparación de fallos eléctricos', 'Pérez Energía Renovable', 'contraseña123', 'png', 1);
INSERT INTO `electricistas` (`id`, `nombre`, `apellidos`, `telefono`, `email`, `ubicacion`, `servicios`, `nombreEmpresa`, `password`, `typeFoto`, `tieneFoto`) VALUES
(4, 'Pablo eduardo', 'Martínez', '7779876543', 'eduardo@example.com', 'Villalba del Rey,Cuenca', 'Instalación de sistemas de seguridad eléctrica, Cableado residencial', 'Martínez Electricidad', 'password123', 'jpg', 1),
(5, 'Sofía', 'López', '3334445556', 'sofia@example.com', 'Sacedón, Guadalajara', 'Reparación de electrodomésticos, Instalación de alarmas', 'Sofía Electric', 'clave123', 'png', 1),
(6, 'Manuel', 'Sánchez', '6667778889', 'manuel@example.com', 'Leganés, Madrid', 'Mantenimiento de sistemas de iluminación, Reparación de circuitos eléctricos', 'Gómez Electric', 'contraseña123', 'png', 1),
(7, 'Carmen', 'Fernández', '2223334447', 'carmen@example.com', 'Garcinarro,Cuenca', 'Instalación de sistemas de energía alternativa, Reparación de transformadores', 'Carmen Energías Renovables', 'password123', 'png', 1),
(8, 'Javier', 'Pérez', '9998887775', 'javier@example.com', 'Chillarón, Guadalajara', 'Instalación de sistemas de tierra, Mantenimiento.Cambio cableado integral', 'Electricidad Pérez', 'clave123', 'jpg', 1),
(10, 'Felipe', 'Fernandez', '1231231234', 'felipe@example1.com', 'Huete,Cuenca', 'Instalación de sistemas de domótica, Reparación de sistemas de seguridad electrónica', 'Mario Electric', 'password123', 'jpg', 1),
(45, 'Elena', 'Ruiz', '1112223338', 'elenas@example.com', 'Tendilla,Guadalajara', 'Reparación de sistemas de climatización, Instalación de sistemas de control de acceso', 'Ruiz Energía', 'contraseña123', NULL, NULL),
(46, 'Damian', 'García', '1334535343', 'damian@prueba.es', 'Tendilla, Cuenca', 'Electricidad para tu hogar', 'Damian SA', 'q32ewe', 'jpg', 1),
(50, 'francisco', 'gonzale', '444444444', 'fran@example.com', 'malaga', 'electricidad inetgral', 'fran S.l', '1234', 'png', 1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;