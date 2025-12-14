# Projet DATAImmo – Laplace Immo  
Conception, normalisation et exploitation d’une base de données immobilières

## 1. Contexte
Laplace Immo souhaite développer un modèle prédictif capable d’estimer le prix de vente des biens immobiliers.
Dans ce cadre, le projet **DATAImmo** vise à moderniser et structurer la base de données permettant
l’analyse du marché immobilier français.

La mission confiée consistait à concevoir une base de données relationnelle normalisée (3NF),
intégrant des données de transactions, de population et de référentiel géographique,
afin de faciliter les analyses décisionnelles et statistiques.

---

## 2. Données utilisées
Les données proviennent exclusivement de sources **open data officielles** :

- **DVF** : transactions immobilières
- **INSEE** : données de population
- **data.gouv.fr** : référentiel géographique (communes, départements, régions)

Un **dictionnaire de données** a été réalisé pour chacune de ces sources.

---

## 3. Travaux réalisés

### 3.1. Dictionnaire des données
- Description détaillée des variables clés
- Normalisation des noms et des types
- Vérification de la conformité **RGPD**  
  (absence de données personnelles identifiables)

### 3.2. Modélisation relationnelle (3NF)
- Refonte du schéma pour intégrer les dimensions **Population** et **Région**
- Définition des :
  - clés primaires
  - clés étrangères
  - relations et cardinalités
- Conception du schéma relationnel à l’aide d’un outil de modélisation dédié

### 3.3. Implémentation de la base de données
- Création des tables normalisées
- Mise en place des contraintes d’intégrité
- Chargement et contrôle des données
- Validation de la cohérence et de la complétude des tables

---

## 4. Analyses SQL réalisées
La base de données a été exploitée à travers des **requêtes SQL avancées** afin de produire
des indicateurs utiles à l’analyse du marché immobilier, notamment :

- Volume de ventes par période, type de bien et zone géographique
- Prix moyen au m² par commune, département et région
- Comparaison des prix selon la surface et le nombre de pièces
- Analyse des ventes rapportées à la population
- Évolution temporelle du nombre de transactions

👉 Les requêtes sont disponibles dans le dossier `sql/analysis_queries.sql`.

---

## 5. Livrables
- Dictionnaire des données complet
- Schéma relationnel finalisé et conforme 3NF
- Base de données opérationnelle (SQLite)
- Scripts SQL documentés
- Structure prête pour analyses avancées et modélisation prédictive

---

## 6. Compétences mobilisées
- Modélisation de bases de données relationnelles (3NF)
- SQL avancé (JOIN, sous-requêtes, CTE, fonctions analytiques)
- Analyse exploratoire de données immobilières
- Qualité des données et conformité RGPD
