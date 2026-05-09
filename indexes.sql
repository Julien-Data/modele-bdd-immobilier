
/*
=====================================================
PERFORMANCE LAYER - DATAIMMO PROJECT

Objectif :
- optimiser les requêtes analytiques sur la base DVF
- accélérer les jointures et filtres fréquents
- améliorer les performances des analyses SQL

Auteur : AUCLAIR JULIEN
=====================================================
*/


/* -----------------------------------------------------
INDEX : jointure principale Vente → Bien
Objectif : accélérer toutes les analyses reliant les ventes aux biens
----------------------------------------------------- */
CREATE INDEX idx_vente_id_bien
ON vente (Id_bien);


/* -----------------------------------------------------
INDEX : jointure Bien → Commune
Objectif : optimiser les analyses géographiques (commune, département, région)
----------------------------------------------------- */
CREATE INDEX idx_bien_commune
ON bien (id_codedep_codecommune);


/* -----------------------------------------------------
INDEX : filtrage temporel des ventes
Objectif : accélérer les analyses d'évolution du marché dans le temps
----------------------------------------------------- */
CREATE INDEX idx_vente_date_mutation
ON vente (Date_mutation);


/* -----------------------------------------------------
INDEX : segmentation par type de bien
Objectif : optimiser les analyses par typologie (Appartement / Maison)
----------------------------------------------------- */
CREATE INDEX idx_bien_type_local
ON bien (Type_local);


/* -----------------------------------------------------
INDEX composite : analyse prix + surface (optionnel mais puissant)
Objectif : améliorer les requêtes de prix au m² et analyses de valeur immobilière
----------------------------------------------------- */
CREATE INDEX idx_prix_surface
ON vente (Valeur_fonciere, Id_bien);