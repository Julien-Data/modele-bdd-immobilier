/*
=====================================================
DATAIMMO - Creation des tables
Objectif : créer les tables de la base DVF pour le projet DATAImmo
Remarque : contraintes de qualité et index gérés séparément
=====================================================
*/

CREATE TABLE Region (
    reg_code INT NOT NULL,
    reg_nom VARCHAR(100) NOT NULL,
    PRIMARY KEY (reg_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Departement (
    dep_code CHAR(3) NOT NULL,
    reg_code INT NOT NULL,
    dep_nom VARCHAR(100) NOT NULL,
    PRIMARY KEY (dep_code),
    CONSTRAINT region_departement_fk FOREIGN KEY (reg_code)
        REFERENCES Region(reg_code)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Commune (
    id_codedep_codecommune CHAR(5) NOT NULL,
    dep_code CHAR(3) NOT NULL,
    com_nom VARCHAR(100) NOT NULL,
    PTOT INT NOT NULL,
    PRIMARY KEY (id_codedep_codecommune),
    CONSTRAINT departement_commune_fk FOREIGN KEY (dep_code)
        REFERENCES Departement(dep_code)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Bien (
    Id_bien BIGINT NOT NULL AUTO_INCREMENT,
    id_codedep_codecommune CHAR(5) NOT NULL,
    No_voie INT DEFAULT NULL,
    Type_de_voie VARCHAR(100) NOT NULL,
    Voie VARCHAR(100) NOT NULL,
    B_T_Q CHAR(1) NOT NULL,
    Surface_Carrez_du_1er_lot DOUBLE NOT NULL,
    Surface_reelle_bati INT NOT NULL,
    Type_local VARCHAR(20) NOT NULL,
    Nombre_pieces_principales INT NOT NULL,
    PRIMARY KEY (Id_bien),
    CONSTRAINT commune_bien_fk FOREIGN KEY (id_codedep_codecommune)
        REFERENCES Commune(id_codedep_codecommune)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Vente (
    Id_vente BIGINT NOT NULL AUTO_INCREMENT,
    Date_mutation DATE NOT NULL,
    Valeur_fonciere INT NOT NULL,
    Id_bien BIGINT NOT NULL,
    PRIMARY KEY (Id_vente),
    CONSTRAINT bien_vente_fk FOREIGN KEY (Id_bien)
        REFERENCES Bien(Id_bien)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;