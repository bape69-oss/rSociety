CREATE DATABASE IF NOT EXISTS `fxserver` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `fxserver`;

-- Listage de la structure de table fxserver. society
CREATE TABLE IF NOT EXISTS `society` (
  `society_name` varchar(255) NOT NULL,
  `account` int(255) NOT NULL DEFAULT 0,
  `black_money` int(255) NOT NULL DEFAULT 0,
  PRIMARY KEY (`society_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table fxserver.society : ~20 rows (environ)
INSERT INTO `society` (`society_name`, `account`, `black_money`) VALUES
	('ambulance', 0, 0),
	('auto_repair', 0, 0),
	('bahama', 0, 0),
	('bcsd', 0, 0),
	('burgershot', 0, 0),
	('concess', 0, 0),
	('concess_moto', 0, 0),
	('fourriere', 0, 0),
	('galaxy', 0, 0),
	('immo', 0, 0),
	('lscustom', 0, 0),
	('mecano', 0, 0),
	('police', 208160, 0),
	('tabac', 0, 0),
	('taxi', 0, 0),
	('unicorn', 59000, 0),
	('vcpd', 0, 0),
	('vigneron', 0, 0),
	('weazel', 0, 0),
	('yellow', 0, 0);

-- Listage de la structure de table fxserver. society_data
CREATE TABLE IF NOT EXISTS `society_data` (
  `society_name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  `weight` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(50) DEFAULT 'item',
  PRIMARY KEY (`society_name`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table fxserver.society_data : ~2 rows (environ)
INSERT INTO `society_data` (`society_name`, `label`, `name`, `count`, `weight`, `type`) VALUES
	('police', 'Eau', 'eau', 0, '0.25', 'item'),
	('police', 'Pain', 'pain', 0, '0.25', 'item'),
	('police', 'Pistolet de combat', 'WEAPON_COMBATPISTOL', 0, '2', 'weapon'),
	('police', 'Lampe torche', 'WEAPON_FLASHLIGHT', 0, '2', 'weapon'),
	('police', 'Matraque', 'WEAPON_NIGHTSTICK', 0, '2', 'weapon'),
	('police', 'Pistolet', 'WEAPON_PISTOL', 1, '2', 'weapon'),
	('police', 'Tazer', 'WEAPON_STUNGUN', 0, '2', 'weapon');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
