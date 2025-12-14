/* =====================================================
   DATAImmo – Analyses SQL du marché immobilier français
   Auteur : AUCLAIR JULIEN
   Objectif : Analyses décisionnelles pour Laplace Immo
   ===================================================== */


/* -----------------------------------------------------
   1. Volume de ventes d’appartements (S1 2020)
   ----------------------------------------------------- */
SELECT 
    COUNT(*) AS nb_appartements_vendus
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
WHERE b.Type_local = 'Appartement'
  AND v.Date_mutation BETWEEN '2020-01-01' AND '2020-06-30';


/* -----------------------------------------------------
   2. Répartition des ventes d’appartements par région
   (S1 2020)
   ----------------------------------------------------- */
SELECT 
    r.reg_nom AS region,
    COUNT(*) AS nb_ventes
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.Id_codedep_codecommune = c.Id_codedep_codecommune
JOIN Departement d ON c.dep_code = d.dep_code
JOIN Region r ON d.reg_code = r.reg_code
WHERE b.Type_local = 'Appartement'
  AND v.Date_mutation BETWEEN '2020-01-01' AND '2020-06-30'
GROUP BY r.reg_nom
ORDER BY nb_ventes DESC;


/* -----------------------------------------------------
   3. Distribution des ventes par nombre de pièces
   (appartements)
   ----------------------------------------------------- */
SELECT
    b.Nombre_pieces_principales AS nb_pieces,
    ROUND(
        COUNT(*) * 100.0 /
        (
            SELECT COUNT(*)
            FROM Vente v2
            JOIN Bien b2 ON v2.Id_bien = b2.Id_bien
            WHERE b2.Type_local = 'Appartement'
        ),
        2
    ) AS pourcentage
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
WHERE b.Type_local = 'Appartement'
GROUP BY b.Nombre_pieces_principales
ORDER BY nb_pieces;


/* -----------------------------------------------------
   4. Top 10 départements – prix moyen au m²
   ----------------------------------------------------- */
SELECT 
    d.dep_nom AS departement,
    ROUND(AVG(v.Valeur_fonciere / b.Surface_Carrez_du_1er_lot), 2) AS prix_m2_moyen
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.Id_codedep_codecommune = c.Id_codedep_codecommune
JOIN Departement d ON c.dep_code = d.dep_code
WHERE b.Surface_Carrez_du_1er_lot > 0
  AND v.Valeur_fonciere > 0
GROUP BY d.dep_nom
ORDER BY prix_m2_moyen DESC
LIMIT 10;


/* -----------------------------------------------------
   5. Prix moyen au m² des maisons en Île-de-France
   ----------------------------------------------------- */
SELECT 
    ROUND(AVG(v.Valeur_fonciere / b.Surface_Carrez_du_1er_lot), 2) AS prix_m2_maison_idf
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.Id_codedep_codecommune = c.Id_codedep_codecommune
JOIN Departement d ON c.dep_code = d.dep_code
JOIN Region r ON d.reg_code = r.reg_code
WHERE b.Type_local = 'Maison'
  AND r.reg_nom = 'Île-de-France'
  AND b.Surface_Carrez_du_1er_lot > 0
  AND v.Valeur_fonciere > 0;


/* -----------------------------------------------------
   6. Top 10 des ventes d’appartements les plus élevées
   ----------------------------------------------------- */
SELECT 
    v.Id_vente,
    v.Valeur_fonciere,
    r.reg_nom AS region,
    b.Surface_Carrez_du_1er_lot AS surface_m2
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.Id_codedep_codecommune = c.Id_codedep_codecommune
JOIN Departement d ON c.dep_code = d.dep_code
JOIN Region r ON d.reg_code = r.reg_code
WHERE b.Type_local = 'Appartement'
  AND v.Valeur_fonciere > 0
  AND b.Surface_Carrez_du_1er_lot > 0
ORDER BY v.Valeur_fonciere DESC
LIMIT 10;


/* -----------------------------------------------------
   7. Évolution du nombre de ventes (T1 vs T2 2020)
   ----------------------------------------------------- */
SELECT 
    ROUND(
        (
            (SELECT COUNT(*) FROM Vente WHERE Date_mutation BETWEEN '2020-04-01' AND '2020-06-30')
            -
            (SELECT COUNT(*) FROM Vente WHERE Date_mutation BETWEEN '2020-01-01' AND '2020-03-31')
        ) * 100.0
        /
        (SELECT COUNT(*) FROM Vente WHERE Date_mutation BETWEEN '2020-01-01' AND '2020-03-31'),
        2
    ) AS taux_evolution_ventes_pourcent;


/* -----------------------------------------------------
   8. Prix moyen au m² des appartements > 4 pièces
   par région
   ----------------------------------------------------- */
SELECT 
    r.reg_nom AS region,
    ROUND(AVG(v.Valeur_fonciere / b.Surface_Carrez_du_1er_lot), 2) AS prix_m2_moyen
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.Id_codedep_codecommune = c.Id_codedep_codecommune
JOIN Departement d ON c.dep_code = d.dep_code
JOIN Region r ON d.reg_code = r.reg_code
WHERE b.Type_local = 'Appartement'
  AND b.Nombre_pieces_principales > 4
  AND b.Surface_Carrez_du_1er_lot > 0
  AND v.Valeur_fonciere > 0
GROUP BY r.reg_nom
ORDER BY prix_m2_moyen DESC;


/* -----------------------------------------------------
   9. Communes avec un volume élevé de ventes (T1 2020)
   ----------------------------------------------------- */
SELECT 
    c.com_nom AS commune,
    COUNT(*) AS nb_ventes
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.Id_codedep_codecommune = c.Id_codedep_codecommune
WHERE v.Date_mutation BETWEEN '2020-01-01' AND '2020-03-31'
GROUP BY c.com_nom
HAVING COUNT(*) >= 50
ORDER BY nb_ventes DESC;


/* -----------------------------------------------------
   10. Top 3 communes par département
   (CTE + fonction analytique)
   ----------------------------------------------------- */
WITH top3 AS (
    SELECT 
        d.dep_code,
        c.com_nom AS commune,
        AVG(v.Valeur_fonciere) AS valeur_moyenne,
        ROW_NUMBER() OVER (
            PARTITION BY d.dep_code
            ORDER BY AVG(v.Valeur_fonciere) DESC
        ) AS rn
    FROM Vente v
    JOIN Bien b ON v.Id_bien = b.Id_bien
    JOIN Commune c ON b.Id_codedep_codecommune = c.Id_codedep_codecommune
    JOIN Departement d ON c.dep_code = d.dep_code
    WHERE d.dep_code IN ('06', '13', '33', '59', '69')
    GROUP BY d.dep_code, c.com_nom
)
SELECT 
    dep_code,
    commune,
    ROUND(valeur_moyenne, 2) AS valeur_moyenne
FROM top3
WHERE rn <= 3
ORDER BY dep_code, valeur_moyenne DESC;
