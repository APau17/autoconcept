#------------------------------------------------------------
# Table: Unite
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Unite  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar (25) NOT NULL UNIQUE,

        ratio Float
        COMMENT 'Ratio entre les unites',

        # Keys
        Unite_base_id Int
);
