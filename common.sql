#------------------------------------------------------------
# Table: Unite
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Unite  (
        id int (11) Auto_increment  NOT NULL,

        nom Varchar (25) NOT NULL UNIQUE,

        ratio Float
        COMMENT 'Ratio entre les unites',

        # Keys
        Unite_base_id Int,
        PRIMARY KEY (id)
) ENGINE=InnoDB;
