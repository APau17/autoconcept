DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `nouveau_proprietaire`(IN `parent` INT, IN `imma` TEXT)
    NO SQL
UPDATE Voiture_client SET parent_id=parent WHERE  immatriculation=imma AND parent_id IS NULL AND id!=parent$$
DELIMITER ;
