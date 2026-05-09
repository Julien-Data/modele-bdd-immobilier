
/*
=====================================================
DATA QUALITY LAYER - DATAIMMO PROJECT

Objectif :
- garantir la cohérence des données DVF
- éviter les valeurs aberrantes
- renforcer la qualité des données pour analyse décisionnelle

Auteur : AUCLAIR JULIEN
=====================================================
*/


/* -----------------------------------------------------
CONTRAINTE : cohérence des valeurs de vente
Objectif : éviter les transactions nulles ou incohérentes
(ex : prix = 0 ou négatif impossible en réalité)
----------------------------------------------------- */
ALTER TABLE vente
ADD CONSTRAINT chk_valeur_fonciere_positive
CHECK (Valeur_fonciere > 0);


/* -----------------------------------------------------
CONTRAINTE : intégrité temporelle des transactions
Objectif : garantir que chaque vente possède une date valide
(indispensable pour toute analyse temporelle)
----------------------------------------------------- */
ALTER TABLE vente
MODIFY Date_mutation DATE NOT NULL;


/* -----------------------------------------------------
CONTRAINTE : surface Carrez valide
Objectif : éviter les surfaces nulles ou négatives
(utilisé pour calcul du prix au m²)
----------------------------------------------------- */
ALTER TABLE bien
ADD CONSTRAINT chk_surface_carrez_positive
CHECK (Surface_Carrez_du_1er_lot > 0);


/* -----------------------------------------------------
CONTRAINTE : surface bâtie valide
Objectif : garantir une surface physique cohérente du bien
----------------------------------------------------- */
ALTER TABLE bien
ADD CONSTRAINT chk_surface_bati_positive
CHECK (Surface_reelle_bati > 0);


/* -----------------------------------------------------
CONTRAINTE : typologie du bien contrôlée
Objectif : limiter les valeurs à des catégories exploitables
(améliore la qualité des analyses par type de bien)
----------------------------------------------------- */
ALTER TABLE bien
ADD CONSTRAINT chk_type_local
CHECK (Type_local IN ('Appartement', 'Maison'));


/* -----------------------------------------------------
CONTRAINTE : nombre de pièces cohérent
Objectif : éviter les valeurs négatives ou incohérentes
(utilisé pour segmentation des biens)
----------------------------------------------------- */
ALTER TABLE bien
ADD CONSTRAINT chk_nb_pieces_positive
CHECK (Nombre_pieces_principales >= 0);