#------------------------------------------------------------
# Table: Unite
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Unite  (
        id int (11) Auto_increment  NOT NULL,

        nom Varchar (25) NOT NULL UNIQUE,

        ratio Float,
        COMMENT 'Ratio entre les unites',
) ENGINE=InnoDB;
