# Projet DATAImmo – Laplace Immo
Modification et normalisation de la base de données immobilières

## 1. Contexte

Laplace Immo souhaite développer un modèle prédictif capable d’estimer le prix de vente des biens immobiliers.  
Dans ce cadre, le projet DATAImmo vise à moderniser la base de données utilisée pour collecter, structurer et analyser les transactions immobilières en France.

La CTO, Clara Daucourt, a confié la conception d’un schéma relationnel complet, conforme à la 3e forme normale (3NF), intégrant de nouvelles sources de données, ainsi que la création de la base de données opérationnelle.

## 2. Données utilisées

Les fichiers fournis contiennent :
- Données DVF (Demandes de valeurs foncières – open data)
- Données INSEE (recensements de population)
- Données géographiques (communes, départements, régions, aires urbaines, etc.)

Un dictionnaire des données devait être créé pour chacune de ces sources à partir du template fourni.

## 3. Travaux réalisés

### 3.1. Dictionnaire des données
- Description détaillée des variables principales  
- Normalisation des noms et types  
- Vérification de la conformité RGPD (suppression/absence de données personnelles)

### 3.2. Schéma relationnel normalisé (3NF)
- Modification du schéma pour intégrer les tables Population et Région  
- Identification pour chaque table :
  - clé primaire  
  - clés étrangères  
  - cardinalités et relations avec les autres tables  
- Réalisation du schéma sous l’outil de modélisation choisi (SQL Power Architect / Draw.io / Looping)

### 3.3. Création de la base de données
- Implémentation de l’ensemble des tables normalisées  
- Typage strict des colonnes  
- Mise en place des contraintes (PRIMARY KEY, FOREIGN KEY)  
- Création des relations inter-tables  
- Chargement intégral des données dans la base  
- Vérification de l’intégrité et de la complétude du chargement

## 4. Livrables obtenus

- Dictionnaire des données complet  
- Schéma relationnel finalisé et conforme 3NF  
- Base de données opérationnelle et entièrement chargée  
- Tables avec clés primaires, clés étrangères et contraintes  
- Structure prête pour exploitation analytique et modélisation prédictive




