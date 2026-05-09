# Projet DATAImmo – Laplace Immo

**Conception, normalisation et exploitation d’une base de données immobilières avec optimisation qualité et performance**

## 1. Contexte
Laplace Immo souhaite développer un modèle prédictif capable d’estimer le prix de vente des biens immobiliers.  
Le projet DATAImmo vise à moderniser et structurer la base de données permettant l’analyse du marché immobilier français.  
La mission a consisté à concevoir une base relationnelle normalisée (3NF), intégrer les données de transactions, population et référentiel géographique, et renforcer la qualité et la performance pour analyses décisionnelles et statistiques.

## 2. Données utilisées
Toutes les données proviennent de sources open data officielles :  
- **DVF** : transactions immobilières  
- **INSEE** : données de population  
- **data.gouv.fr** : référentiel géographique (communes, départements, régions)  

Un dictionnaire de données détaillé a été réalisé pour chacune des sources.

## 3. Travaux réalisés

### 3.1. Dictionnaire des données
- Description complète des variables clés  
- Normalisation des noms et types  
- Vérification de la conformité RGPD (absence de données personnelles identifiables)  

### 3.2. Modélisation relationnelle (3NF)
- Intégration des dimensions Population et Région  
- Définition des clés primaires, étrangères, relations et cardinalités  
- Schéma relationnel conçu avec un outil dédié  

### 3.3. Implémentation et qualité des données
- Création des tables normalisées (MySQL)  
- Mise en place des contraintes d’intégrité et de qualité (`constraints_and_quality.sql`) :  
  - Valeurs de vente positives  
  - Surfaces cohérentes  
  - Typologie et nombre de pièces validés  
  - Dates de mutation non nulles  
- Validation de la cohérence et complétude des tables  

### 3.4. Optimisation des performances
- Indexation stratégique (`indexes.sql`) pour accélérer :  
  - Jointures Vente → Bien → Commune → Région  
  - Analyses temporelles  
  - Segmentation par type de bien  
  - Calculs de prix au m²  

### 3.5. Analyses SQL réalisées
- Volume et répartition des ventes par type de bien, commune, département et région  
- Prix moyen au m² et top ventes  
- Évolution temporelle du marché  
- Analyses avancées avec CTE et fonctions analytiques  
- Scripts SQL disponibles dans `sql/analysis_queries.sql`  

## 4. Livrables
- Dictionnaire des données complet  
- Schéma relationnel finalisé (PDF)  
- Base de données opérationnelle MySQL  
- Scripts SQL documentés : création de tables, contraintes qualité, index, analyses  
- Structure prête pour analyses avancées et modélisation prédictive  

## 5. Compétences mobilisées
- Modélisation relationnelle 3NF  
- SQL avancé (JOIN, sous-requêtes, CTE, fonctions analytiques)  
- Data quality et intégrité des données  
- Optimisation des performances SQL  
- Analyse exploratoire et décisionnelle sur données immobilières