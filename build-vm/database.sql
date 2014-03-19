-- Don't look here for answers you cheater.
-- Go out there and actually hack those sites!


-- Recreate webshop user
-- (really long procedure for non existing 'DROP USER IF EXISTS' construct in MySQL)
-- See: http://bugs.mysql.com/bug.php?id=19166
CREATE DATABASE IF NOT EXISTS temp;
DROP PROCEDURE IF EXISTS `temp`.`drop_user_if_exists` ;
DELIMITER $$
CREATE PROCEDURE `temp`.`drop_user_if_exists`(username VARCHAR(100))
BEGIN
  DECLARE foo BIGINT DEFAULT 0 ;
  SELECT COUNT(*)
  INTO foo
    FROM `mysql`.`user`
      WHERE `User` = username;

  IF foo > 0 THEN
      SELECT CONCAT('DROP USER ', GROUP_CONCAT(CONCAT(QUOTE(username), '@', QUOTE('localhost'))))
      INTO @sql;
      PREPARE stmt FROM @sql;
      EXECUTE stmt;
  END IF;
END ;$$
DELIMITER ;
CALL `temp`.`drop_user_if_exists`('webshop') ;
CALL `temp`.`drop_user_if_exists`('bank') ;
CALL `temp`.`drop_user_if_exists`('nieuws') ;
DROP DATABASE temp;

CREATE USER 'webshop'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON  `webshop`.* TO  'webshop'@'localhost';

DROP DATABASE IF EXISTS webshop;
CREATE DATABASE webshop;
USE webshop;

CREATE TABLE `gebruikers` (
  `id` int(11) NOT NULL,
  `gebruikersnaam` varchar(255) NOT NULL,
  `wachtwoord` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `gebruikers` (`id`, `gebruikersnaam`, `wachtwoord`) VALUES
(1, 'Admin', 'ikbenzoslim'),
(2, 'Paul', 'wachtwoord12345'),
(3, 'Wim', '1337hacker'),
(4, 'Marco', 'apple4ever');

CREATE TABLE `producten` (
  `id` int(11) NOT NULL,
  `naam` varchar(255) NOT NULL,
  `prijs` decimal(10,2) NOT NULL,
  `beschrijving` text NOT NULL,
  `afbeelding` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `producten` (`id`, `naam`, `prijs`, `beschrijving`, `afbeelding`) VALUES
(1, 'Kraan Deluxe', 100.00, 'Onze beste kraan! Past perfect bij elk interieur', 'deluxe.jpg'),
(2, 'Kraan Basis', 5.00, 'Kraan zonder poespas', 'basis.jpg'),
(3, 'Geldkraan', 30.00, 'Lastig open te draaien, maar makkelijk om dicht te draaien. Betaalt zichzelf terug', 'geld.jpg'),
(4, 'Dubbel afsluitbare kraan', 40.00, 'Voor als u nog zekerder wilt zijn dat uw kraan niet lekt', 'kurk.jpg');


CREATE USER 'bank'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON `bank`.* TO 'bank'@'localhost';

DROP DATABASE IF EXISTS bank;
CREATE DATABASE bank;
USE bank;

CREATE TABLE `gebruikers` (
  `gebruikersnaam` varchar(255) NOT NULL,
  `wachtwoord` varchar(255) NOT NULL,
  `balans` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden uitgevoerd voor tabel `gebruikers`
--

INSERT INTO `gebruikers` (`gebruikersnaam`, `wachtwoord`, `balans`) VALUES
('Alice', 'fluviusmaximus', 2600.00),
('Bob', '123456', 10.00),
('Carol', 'cuteasabuttonintheeyes', 42.00);

CREATE USER 'nieuws'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON  `nieuws`.* TO  'nieuws'@'localhost';

DROP DATABASE IF EXISTS nieuws;
CREATE DATABASE nieuws;
USE nieuws;

CREATE TABLE `commentaar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auteur` varchar(255) NOT NULL,
  `bericht` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

INSERT INTO `commentaar` (`id`, `auteur`, `bericht`) VALUES
(1, 'Paul', 'Hoera!');


CREATE TABLE `gebruikers` (
  `gebruikersnaam` varchar(255) NOT NULL,
  `wachtwoord` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `gebruikers` (`gebruikersnaam`, `wachtwoord`) VALUES
('Hank', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('John', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('Pete', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('Bob', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('Thomas', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('Hansel', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('William', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('Harry', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('Martin', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('Charles', 'eb25f9edd38c8ac53380cb5d898dd2e0a33921b1'),
('Admin', 'b56261f2bd5e758a55a1865c1b54e7ed947253e5');
