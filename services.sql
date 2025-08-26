-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:4306
-- Généré le : lun. 25 août 2025 à 18:45
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `makeup_artist_ibtissem`
--

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `description_detaillee` text DEFAULT NULL,
  `categorie_id` int(11) DEFAULT NULL,
  `prix` decimal(10,2) NOT NULL,
  `duree` int(11) NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `inclus` text DEFAULT NULL,
  `contre_indications` text DEFAULT NULL,
  `conseils_apres_soin` text DEFAULT NULL,
  `actif` tinyint(1) DEFAULT 1,
  `populaire` tinyint(1) DEFAULT 0,
  `nouveau` tinyint(1) DEFAULT 0,
  `peut_etre_addon` tinyint(1) DEFAULT 0,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `services`
--

INSERT INTO `services` (`id`, `nom`, `description`, `description_detaillee`, `categorie_id`, `prix`, `duree`, `image_url`, `inclus`, `contre_indications`, `conseils_apres_soin`, `actif`, `populaire`, `nouveau`, `peut_etre_addon`, `date_creation`) VALUES
(1, 'Maquillage Mariée', 'Maquillage sophistiqué et longue tenue pour le jour de votre mariage.', NULL, 1, 350.00, 120, NULL, 'Essai maquillage, maquillage jour J, retouches', NULL, NULL, 1, 1, 0, 0, '2025-07-14 19:19:58'),
(2, 'Maquillage Soirée', 'Maquillage glamour pour vos événements spéciaux.', NULL, 1, 80.00, 60, NULL, 'Conseils personnalisés, application maquillage', NULL, NULL, 1, 0, 0, 0, '2025-07-14 19:19:58'),
(3, 'Coiffure Mariée', 'Coiffure élégante et personnalisée pour le jour de votre mariage.', NULL, 2, 250.00, 90, NULL, 'Essai coiffure, coiffure jour J', NULL, NULL, 1, 1, 0, 0, '2025-07-14 19:19:58'),
(4, 'Brushing', 'Mise en forme des cheveux pour un look parfait.', NULL, 2, 30.00, 45, NULL, 'Lavage, brushing', NULL, NULL, 1, 0, 0, 0, '2025-07-14 19:19:58'),
(5, 'Manucure Complète', 'Soin des ongles, cuticules et application de vernis.', NULL, 3, 40.00, 45, NULL, 'Limage, soin cuticules, massage, pose vernis', NULL, NULL, 1, 1, 0, 0, '2025-07-14 19:19:58'),
(6, 'Pose de Gel', 'Application de gel pour des ongles résistants et brillants.', NULL, 3, 60.00, 90, NULL, 'Préparation ongles, pose gel, finition', NULL, NULL, 1, 0, 0, 0, '2025-07-14 19:19:58'),
(7, 'Soin Visage Hydratant', 'Nettoyage en profondeur et hydratation intense pour une peau souple.', NULL, 4, 90.00, 60, NULL, 'Nettoyage, gommage, masque, massage, crème hydratante', NULL, NULL, 1, 1, 0, 0, '2025-07-14 19:19:58'),
(8, 'Soin Anti-âge', 'Traitement ciblé pour réduire les signes de l\'âge et raffermir la peau.', NULL, 4, 120.00, 75, NULL, 'Nettoyage, sérum anti-âge, massage liftant, masque, crème', NULL, NULL, 1, 0, 0, 0, '2025-07-14 19:19:58'),
(9, 'Lissage Brésilien', 'Traitement lissant et nourrissant pour des cheveux soyeux et sans frisottis.', NULL, 5, 200.00, 180, NULL, 'Lavage, application produit, lissage, rinçage', NULL, NULL, 1, 1, 0, 0, '2025-07-14 19:19:58'),
(10, 'Botox Capillaire', 'Soin réparateur intense pour cheveux abîmés et cassants.', NULL, 5, 100.00, 90, NULL, 'Lavage, application botox, temps de pose, rinçage', NULL, NULL, 1, 0, 0, 0, '2025-07-14 19:19:58'),
(11, 'Massage Relaxant', 'Massage du corps entier pour une détente profonde et un bien-être absolu.', NULL, 6, 70.00, 60, NULL, 'Huiles essentielles, musique douce, ambiance relaxante', NULL, NULL, 1, 1, 0, 0, '2025-07-14 19:19:58'),
(12, 'Forfait Mariage Complet', 'Maquillage mariée, coiffure mariée, manucure et pédicure.', NULL, 1, 600.00, 240, NULL, 'Tous les services mariage inclus', NULL, NULL, 1, 1, 0, 0, '2025-07-14 19:19:58');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categorie_id` (`categorie_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categories_services` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
