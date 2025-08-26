-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:4306
-- Généré le : dim. 24 août 2025 à 23:03
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
-- Base de données : `nails_waad`
--


DROP TABLE IF EXISTS `avis_clients`;
DROP TABLE IF EXISTS `categories_services`;
DROP TABLE IF EXISTS `categories_services_translations`;
DROP TABLE IF EXISTS `clients`;
DROP TABLE IF EXISTS `client_login_attempts`;
DROP TABLE IF EXISTS `client_sessions`;
DROP TABLE IF EXISTS `client_verification_tokens`;
DROP TABLE IF EXISTS `creneaux_horaires`;
DROP TABLE IF EXISTS `fermetures_exceptionnelles`;
DROP TABLE IF EXISTS `inventaire`;
DROP TABLE IF EXISTS `memberships`;
DROP TABLE IF EXISTS `memberships_translations`;
DROP TABLE IF EXISTS `parametres_salon`;
DROP TABLE IF EXISTS `parametres_salon_translations`;
DROP TABLE IF EXISTS `password_reset_tokens`;
DROP TABLE IF EXISTS `promotions`;
DROP TABLE IF EXISTS `reservations`;
DROP TABLE IF EXISTS `reservation_items`;
DROP TABLE IF EXISTS `security_settings`;
DROP TABLE IF EXISTS `services`;
DROP TABLE IF EXISTS `services_translations`;
DROP TABLE IF EXISTS `utilisateurs`;

-- --------------------------------------------------------

--
-- Structure de la table `avis_clients`
--

CREATE TABLE `avis_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `note` decimal(2,1) NOT NULL,
  `commentaire` text DEFAULT NULL,
  `date_avis` datetime NOT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `reponse_admin` text DEFAULT NULL,
  `date_reponse` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Enforce `note` range with a CHECK constraint (MariaDB 10.4+ supports CHECK):
ALTER TABLE `avis_clients`
  ADD CONSTRAINT `chk_avis_note` CHECK (`note` >= 1 AND `note` <= 5);


--
-- Déchargement des données de la table `avis_clients`
--

INSERT INTO `avis_clients` (`id`, `client_id`, `note`, `commentaire`, `date_avis`, `visible`, `reponse_admin`, `date_reponse`, `created_at`, `updated_at`) VALUES
(1, 1, 5.0, 'Service excellent, très professionnel!', '2025-08-13 09:59:19', 1, NULL, NULL, '2025-08-13 09:59:19', '2025-08-13 09:59:19'),
(2, 2, 4.5, 'Très satisfaite du résultat, je recommande!', '2025-08-13 09:59:19', 1, NULL, NULL, '2025-08-13 09:59:19', '2025-08-13 09:59:19');

-- --------------------------------------------------------

--
-- Structure de la table `categories_services`
--

CREATE TABLE `categories_services` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text  NULL,
  `couleur_theme` varchar(7) DEFAULT '#2e4d4c',
  `ordre_affichage` int(11) DEFAULT 0,
  `actif` tinyint(1) DEFAULT 1,
  `date_creation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories_services`
--

INSERT INTO `categories_services` (`id`, `nom`, `description`, `couleur_theme`, `ordre_affichage`, `actif`, `date_creation`) VALUES
(1, 'Manucure', 'Services complets de manucure avec soin des cuticules et pose de vernis', '#d4789b', 1, 1, '2025-07-17 13:10:31'),
(2, 'Pédicure', 'Soins des pieds complets avec ponçage, hydratation et pose de vernis', '#f4c2c2', 2, 1, '2025-07-17 13:10:31'),
(3, 'Nail Art', 'Créations artistiques sur ongles avec designs personnalisés et décors', '#b85a7a', 3, 1, '2025-07-17 13:10:31'),
(4, 'Extensions', 'Pose de capsules et faux ongles avec gel ou résine', '#e4a5c7', 4, 1, '2025-07-17 13:10:31'),
(5, 'Soins des Ongles', 'Traitements spécialisés pour renforcer et soigner les ongles', '#fdf2f4', 5, 1, '2025-07-17 13:10:31'),
(6, 'Packages', 'Forfaits combinés pour une expérience beauté complète', '#8b4361', 6, 1, '2025-07-17 13:10:31');

-- --------------------------------------------------------

--
-- Structure de la table `categories_services_translations`
--

CREATE TABLE `categories_services_translations` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories_services_translations`
--

INSERT INTO `categories_services_translations` (`id`, `category_id`, `language_code`, `nom`, `description`, `date_creation`, `date_modification`) VALUES
(1, 1, 'fr', 'Manucure', 'Services complets de manucure avec soin des cuticules et pose de vernis', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(2, 2, 'fr', 'Pédicure', 'Soins des pieds complets avec ponçage, hydratation et pose de vernis', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(3, 3, 'fr', 'Nail Art', 'Créations artistiques sur ongles avec designs personnalisés et décors', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(4, 4, 'fr', 'Extensions', 'Pose de capsules et faux ongles avec gel ou résine', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(5, 5, 'fr', 'Soins des Ongles', 'Traitements spécialisés pour renforcer et soigner les ongles', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(6, 6, 'fr', 'Packages', 'Forfaits combinés pour une expérience beauté complète', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(8, 1, 'en', 'Manicure', 'Complete manicure services with cuticle care and polish application', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(9, 2, 'en', 'Pedicure', 'Complete foot care with filing, moisturizing and polish application', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(10, 3, 'en', 'Nail Art', 'Artistic nail creations with custom designs and decorations', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(11, 4, 'en', 'Extensions', 'Nail extensions with tips and gel or acrylic application', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(12, 5, 'en', 'Nail Treatments', 'Specialized treatments to strengthen and care for nails', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(13, 6, 'en', 'Packages', 'Combined packages for a complete beauty experience', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(14, 1, 'ar', 'مانيكير', 'خدمات مانيكير كاملة مع العناية بالجليدة ووضع الطلاء', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(15, 2, 'ar', 'بيديكير', 'العناية الكاملة بالقدمين مع البرد والترطيب ووضع الطلاء', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(16, 3, 'ar', 'فن الأظافر', 'إبداعات فنية على الأظافر مع تصاميم مخصصة وزخارف', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(17, 4, 'ar', 'إطالة الأظافر', 'تركيب أطراف الأظافر الصناعية والجل أو الأكريليك', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(18, 5, 'ar', 'علاجات الأظافر', 'علاجات متخصصة لتقوية والعناية بالأظافر', '2025-08-04 13:16:48', '2025-08-17 18:07:11'),
(19, 6, 'ar', 'باقات', 'باقات مدمجة لتجربة جمال كاملة', '2025-08-04 13:16:48', '2025-08-17 18:07:11');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL COMMENT 'Bcrypt hashed password for client authentication',
  `email_verifie` tinyint(1) DEFAULT 0 COMMENT 'Email verification status',
  `langue_preferee` varchar(5) DEFAULT 'fr' COMMENT 'Client preferred language (fr, en, ar)',
  `statut` enum('actif','inactif') DEFAULT 'actif' COMMENT 'Simplified client account status',
  `telephone` varchar(20) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `adresse` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `actif` tinyint(1) DEFAULT 1,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Simplified client table - removed unused security features';

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `prenom`, `nom`, `email`, `mot_de_passe`, `email_verifie`, `langue_preferee`, `statut`, `telephone`, `date_naissance`, `adresse`, `notes`, `actif`, `date_creation`, `date_modification`) VALUES
(1, 'Marie', 'Dupont', 'marie.dupont@email.com', NULL, 1, 'fr', 'actif', '514-555-0123', NULL, NULL, NULL, 1, '2025-07-17 13:10:32', '2025-08-04 13:16:32'),
(2, 'Yassine', 'FRIGUI', 'friguiyassine750@gmail.com', NULL, 1, 'fr', 'actif', '111111111111', NULL, NULL, NULL, 1, '2025-07-17 19:31:32', '2025-08-13 21:52:31'),
(3, 'User', 'Test', 'test@example.com', '$2a$12$OxMRvS0TtDBXo4orwxeLwe2nJjp1bpI3FbCcGNzh8IgjbULXUJYQ2', 0, 'fr', 'actif', '12345678', NULL, NULL, NULL, 1, '2025-08-13 11:40:58', '2025-08-13 21:21:07'),
(4, 'User2', 'Test2', 'test2@example.com', '$2a$12$caV6dfVcBNyCmTl4u55pRuIaMTQUKkPO/DQel4j4eoG27fJOhvk1m', 0, 'fr', 'actif', '1234567890', NULL, NULL, NULL, 1, '2025-08-13 11:42:56', '2025-08-13 11:42:56'),
(5, 'Yassine', 'test', 'testfinal@example.com', '$2a$12$5Y.q3PdcgooixeL6K5GRlOKavxJNA0NjF25rFpu3rjbMiEp5tBBdm', 1, 'fr', 'actif', '111111111111', NULL, NULL, NULL, 1, '2025-08-13 11:48:58', '2025-08-15 16:30:58'),
(6, 'te', 'ts', 'riff3183@gmail.com', '$2a$12$jZQkXwT46JwSVV4yd4rsDeivFf79yQJ8O4vGayRq8IiUqShAm/emK', 1, 'fr', 'actif', '87654321', NULL, NULL, NULL, 1, '2025-08-13 18:10:54', '2025-08-17 18:49:09'),
(10, 'User', 'Draft', 'draft@example.com', NULL, 0, 'fr', 'actif', '87654321', NULL, NULL, NULL, 1, '2025-08-13 21:22:02', '2025-08-13 21:22:02'),
(11, 'Test', 'Email', 'yassinematoussi42@gmail.com', NULL, 0, 'fr', 'actif', '12345678', NULL, NULL, NULL, 1, '2025-08-13 21:31:25', '2025-08-13 21:31:25'),
(12, 'Yassine', 'Frigui', 'yassinefrigui9@gmail.com', '$2a$12$LvD27O7YwzZFmeSzFiD9Du5c9JaqJUfGMQHbDtFqVim5XA9ou9fLa', 1, 'fr', 'actif', '+21653278997', NULL, NULL, NULL, 1, '2025-08-13 22:44:35', '2025-08-13 22:44:35'),
(13, 'test', 'test', 'test@gmail.com', NULL, 0, 'fr', 'actif', '1111111111111', NULL, NULL, NULL, 1, '2025-08-15 13:36:30', '2025-08-17 18:30:00'),
(14, 'Sonia', 'Najjar', 'sonyta-n-uk@hotmail.fr', NULL, 0, 'fr', 'actif', '0021629361740', NULL, NULL, NULL, 1, '2025-08-15 15:56:26', '2025-08-15 15:56:26'),
(15, 'testerr', 'testerr', 'testing123456@gmail.com', NULL, 0, 'fr', 'actif', '99999999', NULL, NULL, NULL, 1, '2025-08-15 16:02:21', '2025-08-15 16:02:21'),
(16, 'test', 'test', '123@gmail.com', NULL, 0, 'fr', 'actif', '1111111111111', NULL, NULL, NULL, 1, '2025-08-15 16:03:29', '2025-08-15 16:03:29'),
(17, 'Rourou', 'Ziadi', 'rahmaziadi25@gmail.com', NULL, 0, 'fr', 'actif', '52768613', NULL, NULL, NULL, 1, '2025-08-15 16:29:51', '2025-08-15 16:29:51');

--
-- Déclencheurs `clients`
--

-- --------------------------------------------------------

--
-- Structure de la table `client_login_attempts`
--

CREATE TABLE `client_login_attempts` (
  `id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `success` tinyint(1) NOT NULL DEFAULT 0,
  `attempted_at` datetime NOT NULL,
  `user_agent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Login attempt tracking for security';

--
-- Déchargement des données de la table `client_login_attempts`
--

INSERT INTO `client_login_attempts` (`id`, `client_id`, `ip_address`, `success`, `attempted_at`, `user_agent`) VALUES
(1, 5, '::1', 1, '2025-08-13 11:49:12', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `client_sessions`
--

CREATE TABLE `client_sessions` (
  `id` varchar(128) NOT NULL COMMENT 'Session ID',
  `client_id` int(11) NOT NULL COMMENT 'Client ID',
  `data` text DEFAULT NULL COMMENT 'Session data in JSON format',
  `expires` datetime NOT NULL COMMENT 'Session expiration timestamp',
  `ip_address` varchar(45) DEFAULT NULL COMMENT 'Client IP address',
  `user_agent` text DEFAULT NULL COMMENT 'Client user agent string',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `token` varchar(512) DEFAULT NULL COMMENT 'JWT token',
  `expires_at` datetime NOT NULL COMMENT 'Alternative expiration field'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Client sessions for authentication';

--
-- Déchargement des données de la table `client_sessions`
--

INSERT INTO `client_sessions` (`id`, `client_id`, `data`, `expires`, `ip_address`, `user_agent`, `created_at`, `updated_at`, `token`, `expires_at`) VALUES
('a81cc0b1-629b-4c4c-a357-401dcb2a6af2', 5, NULL, '2025-08-13 11:49:12', '::1', 'curl/8.13.0', '2025-08-13 11:49:12', '2025-08-13 11:49:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRJZCI6NSwidHlwZSI6ImNsaWVudCIsImlhdCI6MTc1NTA4NTc1MiwiZXhwIjoxNzU1NjkwNTUyfQ.b3ZMcTlRr3KZFLUiRUS9qM_EFeGbM3UwH4eGz60P26k', '2025-08-20 11:49:12');

-- --------------------------------------------------------

--
-- Structure de la table `client_verification_tokens`
--

CREATE TABLE `client_verification_tokens` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `type` enum('email','password_reset') NOT NULL DEFAULT 'email',
  `expires_at` datetime NOT NULL,
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Client verification tokens for email verification and password reset';

--
-- Déchargement des données de la table `client_verification_tokens`
--

INSERT INTO `client_verification_tokens` (`id`, `client_id`, `token`, `type`, `expires_at`, `used_at`, `created_at`) VALUES
(1, 3, '0c1f7ff97af7bf4f56b9c4ddf9fbccfac03019ba6b2ad0f097f32cbdf88f0ecd', 'email', '2025-08-14 11:40:58', NULL, '2025-08-13 11:40:58'),
(2, 4, 'dae556bef576530f4ca22247cc42fd7cee17c90f486f465464595a6140b6fbf1', 'email', '2025-08-14 11:42:56', NULL, '2025-08-13 11:42:56');

-- --------------------------------------------------------

--
-- Structure de la table `creneaux_horaires`
--

CREATE TABLE `creneaux_horaires` (
  `id` int(11) NOT NULL,
  `jour_semaine` enum('lundi','mardi','mercredi','jeudi','vendredi','samedi','dimanche') NOT NULL,
  `heure_debut` time NOT NULL,
  `heure_fin` time NOT NULL,
  `actif` tinyint(1) DEFAULT 1,
  `date_creation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `creneaux_horaires`
--

INSERT INTO `creneaux_horaires` (`id`, `jour_semaine`, `heure_debut`, `heure_fin`, `actif`, `date_creation`) VALUES
(1, 'lundi', '09:00:00', '19:00:00', 1, '2025-07-17 13:10:32'),
(2, 'mardi', '09:00:00', '19:00:00', 1, '2025-07-17 13:10:32'),
(3, 'mercredi', '09:00:00', '19:00:00', 1, '2025-07-17 13:10:32'),
(4, 'jeudi', '09:00:00', '20:00:00', 1, '2025-07-17 13:10:32'),
(5, 'vendredi', '09:00:00', '20:00:00', 1, '2025-07-17 13:10:32'),
(6, 'samedi', '09:00:00', '18:00:00', 1, '2025-07-17 13:10:32');

-- --------------------------------------------------------

--
-- Structure de la table `fermetures_exceptionnelles`
--

CREATE TABLE `fermetures_exceptionnelles` (
  `id` int(11) NOT NULL,
  `date_fermeture` date NOT NULL,
  `raison` varchar(255) DEFAULT NULL,
  `toute_journee` tinyint(1) DEFAULT 1,
  `heure_debut` time DEFAULT NULL,
  `heure_fin` time DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `inventaire`
--

CREATE TABLE `inventaire` (
  `id` int(11) NOT NULL,
  `nom_produit` varchar(150) NOT NULL,
  `marque` varchar(100) DEFAULT NULL COMMENT 'Product brand',
  `type_produit` varchar(50) DEFAULT NULL COMMENT 'Product type/category',
  `couleur` varchar(50) DEFAULT NULL COMMENT 'Product color',
  `code_produit` varchar(50) DEFAULT NULL COMMENT 'Product code/SKU',
  `quantite_stock` int(11) DEFAULT 0,
  `quantite_minimum` int(11) DEFAULT 0,
  `prix_achat` decimal(10,2) DEFAULT NULL COMMENT 'Purchase price',
  `prix_vente` decimal(10,2) DEFAULT NULL COMMENT 'Selling price',
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  `fournisseur` varchar(100) DEFAULT NULL,
  `date_achat` date DEFAULT NULL COMMENT 'Purchase date',
  `date_expiration` date DEFAULT NULL,
  `emplacement` varchar(100) DEFAULT NULL COMMENT 'Storage location',
  `notes` text DEFAULT NULL COMMENT 'Additional notes',
  `actif` tinyint(1) DEFAULT 1,
  `date_creation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `memberships`
--

CREATE TABLE `memberships` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prix_mensuel` decimal(10,2) NOT NULL,
  `prix_3_mois` decimal(10,2) DEFAULT NULL,
  `services_par_mois` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `avantages` text DEFAULT NULL,
  `actif` tinyint(1) DEFAULT 1,
  `date_creation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `memberships`
--

INSERT INTO `memberships` (`id`, `nom`, `prix_mensuel`, `prix_3_mois`, `services_par_mois`, `description`, `avantages`, `actif`, `date_creation`) VALUES
(1, 'SILVER NAILS', 210.00, NULL, 3, '3 services ongles par mois', 'Choix parmi: Manucure Classique, Pédicure Classique, Nail Art Simple, Soin Fortifiant', 1, '2025-07-17 13:10:32'),
(2, 'GOLD NAILS', 325.00, 280.00, 5, '5 services ongles par mois', 'Tous services + 1 Package Beauté Mains gratuit par mois avec engagement 3 mois', 1, '2025-07-17 13:10:32'),
(3, 'PLATINUM NAILS', 480.00, 445.00, 8, '8 services ongles par mois', 'Accès complet + choix 1 Package Complet gratuit (150min) ou Extensions Gel avec engagement 3 mois', 1, '2025-07-17 13:10:32'),
(4, 'VIP NAILS', 750.00, 660.00, 12, 'Jusqu\'à 12 visites par mois', 'Accès illimité + Package Complet mensuel gratuit + 1 service Premium mensuel + 3 surclassements Nail Art + 15% réduction add-ons + réservation prioritaire + événements exclusifs', 1, '2025-07-17 13:10:32');

-- --------------------------------------------------------

--
-- Structure de la table `memberships_translations`
--

CREATE TABLE `memberships_translations` (
  `id` int(11) NOT NULL,
  `membership_id` int(11) NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `avantages` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `memberships_translations`
--

INSERT INTO `memberships_translations` (`id`, `membership_id`, `language_code`, `nom`, `description`, `avantages`, `date_creation`, `date_modification`) VALUES
(1, 1, 'fr', 'SILVER NAILS', '3 services ongles par mois', 'Choix parmi: Manucure Classique, Pédicure Classique, Nail Art Simple, Soin Fortifiant', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(2, 2, 'fr', 'GOLD NAILS', '5 services ongles par mois', 'Tous services + 1 Package Beauté Mains gratuit par mois avec engagement 3 mois', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(3, 3, 'fr', 'PLATINUM NAILS', '8 services ongles par mois', 'Accès complet + choix 1 Package Complet gratuit (150min) ou Extensions Gel avec engagement 3 mois', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(4, 4, 'fr', 'VIP NAILS', 'Jusqu\'à 12 visites par mois', 'Accès illimité + Package Complet mensuel gratuit + 1 service Premium mensuel + 3 surclassements Nail Art + 15% réduction add-ons + réservation prioritaire + événements exclusifs', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(8, 1, 'en', 'SILVER NAILS', '3 nail services per month', 'Choose from: Classic Manicure, Classic Pedicure, Simple Nail Art, Strengthening Treatment', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(9, 2, 'en', 'GOLD NAILS', '5 nail services per month', 'All services + 1 Free Hand Beauty Package per month with 3-month commitment', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(10, 3, 'en', 'PLATINUM NAILS', '8 nail services per month', 'Full access + choice of 1 Free Complete Package (150min) or Gel Extensions with 3-month commitment', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(11, 4, 'en', 'VIP NAILS', 'Up to 12 visits per month', 'Unlimited access + Free Complete Package monthly + 1 Premium service monthly + 3 Nail Art upgrades + 15% discount on add-ons + priority booking + exclusive events', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(12, 1, 'ar', 'فضي الأظافر', '3 خدمات أظافر شهرياً', 'اختر من: مانيكير كلاسيكي، بيديكير كلاسيكي، فن أظافر بسيط، علاج مقوي', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(13, 2, 'ar', 'ذهبي الأظافر', '5 خدمات أظافر شهرياً', 'جميع الخدمات + 1 باقة جمال اليدين مجانية شهرياً مع التزام 3 أشهر', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(14, 3, 'ar', 'بلاتيني الأظافر', '8 خدمات أظافر شهرياً', 'وصول كامل + اختيار 1 باقة كاملة مجانية (150 دقيقة) أو إطالة جل مع التزام 3 أشهر', '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(15, 4, 'ar', 'في آي بي الأظافر', 'حتى 12 زيارة شهرياً', 'وصول غير محدود + باقة كاملة شهرية مجانية + 1 خدمة مميزة شهرياً + 3 ترقيات فن أظافر + خصم 15% على الإضافات + حجز مميز + فعاليات حصرية', '2025-08-04 13:16:48', '2025-08-17 18:07:15');

-- --------------------------------------------------------

--
-- Structure de la table `parametres_salon`
--

CREATE TABLE `parametres_salon` (
  `id` int(11) NOT NULL,
  `nom_salon` varchar(150) DEFAULT 'ZenShe Spa',
  `adresse` text,
  `telephone` varchar(20) DEFAULT '905-605-1188',
  `email` varchar(255) DEFAULT 'info@zenshe.ca',
  `site_web` varchar(255) DEFAULT 'https://zenshe.ca',
  `horaires_ouverture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin CHECK (json_valid(`horaires_ouverture`)),
  `couleur_principale` varchar(7) DEFAULT '#2e4d4c',
  `couleur_secondaire` varchar(7) DEFAULT '#4a6b69',
  `logo_url` varchar(500) DEFAULT '/images/zenshe_logo.png',
  `message_accueil` text,
  `politique_annulation` text,
  `cgv` text,
  `date_modification` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `parametres_salon`
--

INSERT INTO `parametres_salon` (`id`, `nom_salon`, `adresse`, `telephone`, `email`, `site_web`, `horaires_ouverture`, `couleur_principale`, `couleur_secondaire`, `logo_url`, `message_accueil`, `politique_annulation`, `cgv`, `date_modification`) VALUES
(1, 'Beauty Nails - Chez Waad', 'Tunis, Tunisia', '+216 24 157 715', 'contact@beauty-nails-waad.tn', 'https://beauty-nails-waad.tn', '{\"lundi\":\"9h-19h\",\"mardi\":\"9h-19h\",\"mercredi\":\"9h-19h\",\"jeudi\":\"9h-20h\",\"vendredi\":\"9h-20h\",\"samedi\":\"9h-18h\",\"dimanche\":\"Fermé\"}', '#d4789b', '#f4c2c2', '/images/zenshe_logo.png', 'Salon de manucure et beauté des ongles premium offrant des services de qualité avec des produits haut de gamme', 'Annulation gratuite jusqu\'à 24h avant le rendez-vous.', NULL, '2025-08-17 18:07:15');

-- --------------------------------------------------------

--
-- Structure de la table `parametres_salon_translations`
--

CREATE TABLE `parametres_salon_translations` (
  `id` int(11) NOT NULL,
  `parametre_id` int(11) NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `nom_salon` varchar(150) DEFAULT NULL,
  `message_accueil` text DEFAULT NULL,
  `politique_annulation` text DEFAULT NULL,
  `cgv` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `parametres_salon_translations`
--

INSERT INTO `parametres_salon_translations` (`id`, `parametre_id`, `language_code`, `nom_salon`, `message_accueil`, `politique_annulation`, `cgv`, `date_creation`, `date_modification`) VALUES
(1, 1, 'fr', 'Beauty Nails - Chez Waad', 'Salon de manucure et beauté des ongles premium offrant des services de qualité avec des produits haut de gamme', 'Annulation gratuite jusqu\'à 24h avant le rendez-vous.', NULL, '2025-08-04 13:16:48', '2025-08-17 18:07:15'),
(2, 1, 'en', 'ZenShe Spa', 'Welcome to ZenShe Spa, your destination for intimate wellness and holistic healing.', 'Free cancellation up to 24 hours before appointment.', NULL, '2025-08-04 13:16:48', '2025-08-04 13:16:48'),
(3, 1, 'ar', 'سبا زين شي', 'مرحباً بكم في سبا زين شي، وجهتكم للعافية الحميمة والشفاء الشامل.', 'إلغاء مجاني حتى 24 ساعة قبل الموعد.', NULL, '2025-08-04 13:16:48', '2025-08-04 13:16:48');

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `token_hash` varchar(255) NOT NULL,
  `verification_code` varchar(6) DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `client_id`, `token_hash`, `verification_code`, `expires_at`, `used_at`, `created_at`) VALUES
(1, 5, 'dda566f0c43fc4f1136462bf76e78dbb93c4f7528288539e3a2c9ebb8a28e10f', NULL, '2025-08-13 18:43:49', NULL, '2025-08-13 17:13:49'),
(2, 6, '32814cd8bf164987a179883f83fb9b10d00c458a63e96d27d5faed7e716ddf0d', NULL, '2025-08-13 19:41:33', NULL, '2025-08-13 18:11:33'),
(3, 6, '485fdc700c576be4cdbd8ee6db915f8cac5d34d6f95f0c4c29ccf08c5a91798b', NULL, '2025-08-13 20:00:41', NULL, '2025-08-13 18:30:41'),
(4, 6, '74e1233a06eff49b19a8b051b541bb081af5f097164a57fc09b8e1ada5d3941e', NULL, '2025-08-13 20:03:52', NULL, '2025-08-13 18:33:52'),
(5, 6, 'daaec4a9cf6c7e5e2ef8cb62f3e5eaf0a46f962c7f4eba815260fa6f211c7192', NULL, '2025-08-13 20:16:23', NULL, '2025-08-13 18:46:23'),
(6, 6, '6f0b735796e739c752b43b4654c392003151078ba8fc467e65d253a46060ac6c', NULL, '2025-08-13 20:16:56', NULL, '2025-08-13 18:46:56'),
(7, 6, 'cf44769076d90e4694abf28a330679c5259d92172bab5cbf04d0c61c40ffa758', NULL, '2025-08-13 20:18:49', NULL, '2025-08-13 18:48:49'),
(8, 6, '978bfbeddb3606890af4a43c23435bedab81d4d4fec3d46b85bbc5c6c1b6b104', NULL, '2025-08-13 20:25:33', NULL, '2025-08-13 18:55:33');

-- --------------------------------------------------------

--
-- Structure de la table `promotions`
--

CREATE TABLE `promotions` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `type_reduction` enum('pourcentage','montant_fixe') NOT NULL,
  `valeur_reduction` decimal(10,2) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `code_promo` varchar(50) DEFAULT NULL,
  `montant_minimum` decimal(10,2) DEFAULT 0.00,
  `service_id` int(11) DEFAULT NULL,
  `categorie_id` int(11) DEFAULT NULL,
  `nombre_utilisations_max` int(11) DEFAULT NULL,
  `nombre_utilisations_actuelles` int(11) DEFAULT 0,
  `actif` tinyint(1) DEFAULT 1,
  `date_creation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `service_id` int(11) NOT NULL,
  `date_reservation` date NOT NULL,
  `heure_debut` time NOT NULL,
  `heure_fin` time NOT NULL,
  `statut` enum('en_attente','confirmee','en_cours','terminee','annulee','no_show','draft') DEFAULT 'en_attente',
  `reservation_status` enum('draft','reserved','confirmed','cancelled') DEFAULT 'draft',
  `prix_service` decimal(10,2) NOT NULL DEFAULT 0.00,
  `prix_final` decimal(10,2) NOT NULL DEFAULT 0.00,
  `client_nom` varchar(100) DEFAULT NULL,
  `client_prenom` varchar(100) DEFAULT NULL,
  `client_telephone` varchar(20) DEFAULT NULL,
  `client_email` varchar(255) DEFAULT NULL,
  `notes_client` text DEFAULT NULL,
  `verification_code` varchar(6) DEFAULT NULL,
  `verification_token` varchar(64) DEFAULT NULL,
  `session_id` varchar(100) DEFAULT NULL,
  `couleurs_choisies` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Client reservations';

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`id`, `client_id`, `service_id`, `date_reservation`, `heure_debut`, `heure_fin`, `statut`, `reservation_status`, `prix_service`, `prix_final`, `client_nom`, `client_prenom`, `client_telephone`, `client_email`, `notes_client`, `verification_code`, `verification_token`, `session_id`, `couleurs_choisies`, `date_creation`, `date_modification`) VALUES
(5, NULL, 6, '2025-08-23', '15:00:00', '16:05:00', 'en_attente', 'reserved', 130.00, 130.00, 'Frigui', 'Yassine', '22222222', 'friguiyassine750@gmail.com', NULL, '808485', NULL, NULL, NULL, '2025-08-13 21:00:46', '2025-08-13 21:00:46'),
(7, NULL, 6, '2025-08-23', '09:30:00', '10:35:00', 'en_attente', 'reserved', 130.00, 130.00, 'Frigui', 'Yassine', '22222222', 'friguiyassine750@gmail.com', NULL, '455009', NULL, NULL, NULL, '2025-08-13 21:06:38', '2025-08-13 21:06:39'),
(8, NULL, 10, '2025-08-22', '15:30:00', '15:30:00', 'en_attente', 'reserved', 160.00, 160.00, 'Frigui', 'Yassine', '33112233', 'friguiyassine750@gmail.com', '', '218789', NULL, NULL, NULL, '2025-08-13 21:19:53', '2025-08-13 21:21:35'),
(9, 3, 1, '2025-08-25', '10:00:00', '10:10:00', 'en_attente', 'reserved', 40.00, 40.00, 'Test', 'User', '12345678', 'test@example.com', 'Test reservation', '382460', NULL, NULL, NULL, '2025-08-13 21:21:07', '2025-08-13 21:21:08'),
(10, 10, 1, '2025-08-26', '11:00:00', '00:00:00', 'en_attente', 'reserved', 40.00, 40.00, 'Draft', 'User', '87654321', 'draft@example.com', 'Draft test', '533985', NULL, NULL, NULL, '2025-08-13 21:22:02', '2025-08-13 21:22:02'),
(11, 11, 1, '2025-08-27', '14:00:00', '14:10:00', 'en_attente', 'reserved', 40.00, 40.00, 'Email', 'Test', '12345678', 'yassinematoussi42@gmail.com', 'Email test reservation', '221838', '9913d7d7d2f0fce794b1a6d243a6fca69aeb3469b4de9ad8dace312e93597c2f', NULL, NULL, '2025-08-13 21:31:25', '2025-08-13 21:31:47'),
(12, 2, 5, '2025-08-30', '17:00:00', '17:00:00', 'confirmee', 'confirmed', 80.00, 80.00, 'FRIGUI', 'Yassine', '111111111111', 'yassinefrigui9@gmail.com', '', '968720', 'b635c61d30c70282c08fd384b51d609066ea669bb251d9cf662acdcec56e61bd', NULL, NULL, '2025-08-13 21:42:40', '2025-08-13 21:43:53'),
(13, 2, 3, '2025-08-30', '14:30:00', '14:30:00', 'confirmee', 'confirmed', 140.00, 140.00, 'FRIGUI', 'Yassine', '111111111111', 'friguiyassine750@gmail.com', '', '581149', NULL, NULL, NULL, '2025-08-13 21:50:56', '2025-08-13 22:02:04'),
(14, NULL, 4, '2025-07-15', '09:00:00', '09:30:00', 'draft', 'draft', 0.00, 0.00, '', '', '55555555', '', '', NULL, NULL, 'booking_1755188649658_6vbexnnekw3', NULL, '2025-08-14 16:24:27', '2025-08-14 16:36:42'),
(15, 13, 11, '2025-09-02', '17:00:00', '17:00:00', 'en_attente', 'reserved', 320.00, 320.00, 'test', 'test', '111111111111', 'test@gmail.com', '', '218622', 'd906ca63cc1df11091e2f73a69c05d5d52166ab70a7e7ffd4b0a6d0ce7275901', NULL, NULL, '2025-08-15 13:36:25', '2025-08-15 13:37:30'),
(16, 15, 5, '2025-08-28', '17:00:00', '17:00:00', 'en_attente', 'reserved', 80.00, 80.00, 'testerr', 'testerr', '99999999', 'testing123456@gmail.com', '', '965742', 'dea6e47e1cb36471f0000ef201d23c946a5dead8da82496f32a9403eb3d24cf4', NULL, NULL, '2025-08-15 14:13:17', '2025-08-15 16:02:22'),
(17, 14, 1, '2025-08-16', '11:00:00', '11:00:00', 'confirmee', 'confirmed', 40.00, 40.00, 'Najjar', 'Sonia', '0021629361740', 'sonyta-n-uk@hotmail.fr', '', '865445', '15bf3e76b2141d73afdd54440e60f2f00cd6c7697535aa2470088912bd5473b8', NULL, NULL, '2025-08-15 15:56:04', '2025-08-15 15:57:04'),
(18, 16, 3, '2025-08-20', '17:00:00', '17:00:00', 'en_attente', 'reserved', 140.00, 140.00, 'test', 'test', '1111111111111', '123@gmail.com', '', '957227', 'c36dc94c84767312642c678c6ab040d3055d1176b03d5cf6058a9904d5e4fe12', NULL, NULL, '2025-08-15 16:03:21', '2025-08-15 16:03:31'),
(19, 17, 3, '2025-08-26', '17:30:00', '17:30:00', 'en_attente', 'reserved', 140.00, 140.00, 'Ziadi', 'Rourou', '52768613', 'rahmaziadi25@gmail.com', '', '204666', '9ee0ea706408e48cbb5c40c11f6785999c29fa4b022e2e409b510313eceec686', NULL, NULL, '2025-08-15 16:29:28', '2025-08-15 16:29:53'),
(20, 5, 9, '2025-08-19', '17:30:00', '17:30:00', 'en_attente', 'reserved', 130.00, 130.00, 'test', 'Yassine', '111111111111', 'testfinal@example.com', '', '668593', '3d43b3ee07c0a2f9c0f571eddf8617af0dfd939bca099cbc0be1b93a8d423bd8', NULL, NULL, '2025-08-15 16:30:51', '2025-08-15 16:30:59'),
(21, 13, 11, '2025-07-15', '09:00:00', '09:30:00', 'en_attente', 'reserved', 320.00, 320.00, 'test', 'Yassine', '22222222222222', 'test@gmail.com', '', '219951', '0d50be28f585b5ebe1edd7ee70861761bb072523fed9f8b5eb2884db131234ec', NULL, NULL, '2025-08-15 16:37:00', '2025-08-15 16:37:40'),
(22, 13, 1, '2025-08-29', '18:00:00', '18:00:00', 'en_attente', 'reserved', 25.00, 25.00, 'test', 'test', '1111111111111', 'test@gmail.com', '', '187340', '076d320e241c50d83e00c803b8d0d962f2f21e03dff0f09e703306ddcb71997f', NULL, NULL, '2025-08-17 18:29:55', '2025-08-17 18:30:00'),
(23, 6, 6, '2025-08-30', '11:30:00', '11:30:00', 'en_attente', 'reserved', 40.00, 40.00, 'ttt', 'ttt', '12345678', 'riff3183@gmail.com', '', '779487', '4ca9ffa09509186a7bf3f3419cf9d153dcd80c91f769b54f4dec2415feb09975', NULL, NULL, '2025-08-17 18:33:22', '2025-08-17 18:33:42'),
(24, 6, 1, '2025-08-29', '15:30:00', '15:30:00', 'en_attente', 'reserved', 25.00, 25.00, 'ts', 'te', '87654321', 'riff3183@gmail.com', '', '840825', '2c22fe408d96cb6c33249ea531ff489e1210f97c4903d01ee6bc31dd85b03d53', NULL, NULL, '2025-08-17 18:49:03', '2025-08-17 18:49:09');

-- --------------------------------------------------------

--
-- Structure de la table `reservation_items`
--

CREATE TABLE `reservation_items` (
  `id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `item_type` enum('main','addon') NOT NULL DEFAULT 'main',
  `prix` decimal(10,2) NOT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `security_settings`
--

CREATE TABLE `security_settings` (
  `id` int(11) NOT NULL,
  `setting_name` varchar(100) NOT NULL COMMENT 'Setting name',
  `setting_value` text NOT NULL COMMENT 'Setting value',
  `description` text DEFAULT NULL COMMENT 'Setting description',
  `date_modification` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Security settings for the application';

--
-- Déchargement des données de la table `security_settings`
--

INSERT INTO `security_settings` (`id`, `setting_name`, `setting_value`, `description`, `date_modification`) VALUES
(3, 'password_reset_token_expiry_hours', '24', 'Password reset token expiry in hours', '2025-08-04 13:16:32'),
(5, 'session_timeout_hours', '24', 'Client session timeout in hours', '2025-08-04 13:16:32'),
(6, 'require_email_verification', '1', 'Require email verification for new accounts', '2025-08-04 13:16:32'),
(7, 'min_password_length', '8', 'Minimum password length', '2025-08-04 13:16:32'),
(8, 'require_password_complexity', '1', 'Require complex passwords (uppercase, lowercase, number, special char)', '2025-08-04 13:16:32'),
(11, 'jwt_secret_rotation_days', '30', 'Days between JWT secret rotation', '2025-08-10 18:34:05'),
(12, 'session_cleanup_interval_hours', '24', 'Hours between session cleanup runs', '2025-08-10 18:34:05'),
(13, 'max_login_attempts', '5', 'Maximum login attempts before temporary lockout', '2025-08-10 18:34:24'),
(14, 'lockout_duration_minutes', '15', 'Duration of temporary lockout in minutes', '2025-08-10 18:34:24');

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `description_detaillee` text DEFAULT NULL,
  `service_type` enum('base','variant','package','addon') NOT NULL DEFAULT 'base',
  `parent_service_id` int(11) DEFAULT NULL,
  `categorie_id` int(11) DEFAULT NULL,
  `prix` decimal(10,2) NOT NULL,
  `duree` int(11) NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `inclus` text DEFAULT NULL,
  `contre_indications` text DEFAULT NULL,
  `conseils_apres_soin` text DEFAULT NULL,
  `nombre_sessions` int(11) DEFAULT NULL,
  `prix_par_session` decimal(10,2) DEFAULT NULL,
  `validite_jours` int(11) DEFAULT NULL,
  `actif` tinyint(1) DEFAULT 1,
  `populaire` tinyint(1) DEFAULT 0,
  `nouveau` tinyint(1) DEFAULT 0,
  `ordre_affichage` int(11) DEFAULT 0,
  `date_creation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Spa services offered';

--
-- Déchargement des données de la table `services`
--

INSERT INTO `services` (`id`, `nom`, `description`, `description_detaillee`, `service_type`, `parent_service_id`, `categorie_id`, `prix`, `duree`, `image_url`, `inclus`, `contre_indications`, `conseils_apres_soin`, `nombre_sessions`, `prix_par_session`, `validite_jours`, `actif`, `populaire`, `nouveau`, `ordre_affichage`, `date_creation`) VALUES
(1, 'Manucure Classique', 'Soin complet des ongles avec pose de vernis', 'Manucure traditionnelle incluant limage, soin des cuticules et pose de vernis', 'base', NULL, 1, 25.00, 45, NULL, 'Limage, soin cuticules, vernis base + couleur + top coat', NULL, 'Éviter l\'eau chaude pendant 2h', NULL, NULL, NULL, 1, 1, 0, 1, '2025-08-17 18:07:14'),
(2, 'Manucure Gel', 'Manucure avec vernis gel longue tenue', 'Manucure premium avec vernis gel semi-permanent', 'base', NULL, 1, 35.00, 60, NULL, 'Préparation ongles, vernis gel, séchage UV/LED', NULL, 'Ne pas arracher le vernis, utiliser dissolvant spécial', NULL, NULL, NULL, 1, 1, 0, 2, '2025-08-17 18:07:14'),
(3, 'Manucure Express', 'Manucure rapide pour retouches', 'Service rapide de remise en forme des ongles', 'base', NULL, 1, 15.00, 30, NULL, 'Limage et pose de vernis classique', NULL, 'Éviter l\'eau chaude pendant 1h', NULL, NULL, NULL, 1, 0, 0, 3, '2025-08-17 18:07:14'),
(4, 'Pédicure Classique', 'Soin complet des pieds et ongles', 'Pédicure traditionnelle avec bain de pieds relaxant', 'base', NULL, 2, 30.00, 60, NULL, 'Bain de pieds, gommage, soin cuticules, limage, vernis', NULL, 'Hydrater quotidiennement', NULL, NULL, NULL, 1, 1, 0, 1, '2025-08-17 18:07:14'),
(5, 'Pédicure Spa', 'Pédicure luxe avec massage et masque', 'Pédicure premium avec soins relaxants', 'base', NULL, 2, 45.00, 90, NULL, 'Bain aromatique, gommage, masque hydratant, massage 15min, vernis', NULL, 'Porter des chaussures ouvertes, éviter efforts intenses', NULL, NULL, NULL, 1, 1, 1, 2, '2025-08-17 18:07:14'),
(6, 'Pédicure Gel', 'Pédicure avec vernis gel semi-permanent', 'Pédicure avec vernis gel longue durée', 'base', NULL, 2, 40.00, 75, NULL, 'Soin complet + vernis gel + séchage UV', NULL, 'Ne pas gratter le vernis, utiliser dissolvant adapté', NULL, NULL, NULL, 1, 0, 0, 3, '2025-08-17 18:07:14'),
(7, 'Nail Art Simple', 'Décoration simple sur ongles', 'Motifs simples et élégants', 'base', NULL, 3, 5.00, 15, NULL, 'Décoration sur 2-5 ongles, motifs au choix', NULL, 'Laisser sécher complètement', NULL, NULL, NULL, 1, 1, 0, 1, '2025-08-17 18:07:14'),
(8, 'Nail Art Élaboré', 'Créations artistiques complexes', 'Designs artistiques sur tous les ongles', 'base', NULL, 3, 15.00, 45, NULL, 'Designs personnalisés, strass, paillettes', NULL, 'Éviter les chocs, porter des gants pour le ménage', NULL, NULL, NULL, 1, 1, 1, 2, '2025-08-17 18:07:14'),
(9, 'Nail Art 3D', 'Décorations en relief et bijoux d\'ongles', 'Créations 3D avec éléments en relief', 'base', NULL, 3, 25.00, 60, NULL, 'Sculptures 3D, bijoux d\'ongles, effets spéciaux', NULL, 'Manipulation délicate, éviter les chocs', NULL, NULL, NULL, 1, 0, 1, 3, '2025-08-17 18:07:14'),
(10, 'Pose Capsules', 'Extensions avec capsules plastique', 'Allongement des ongles avec capsules', 'base', NULL, 4, 40.00, 90, NULL, 'Capsules, limage forme, vernis ou gel', NULL, 'Retouches nécessaires toutes les 3-4 semaines', NULL, NULL, NULL, 1, 1, 0, 1, '2025-08-17 18:07:14'),
(11, 'Extensions Gel', 'Extensions modelées au gel', 'Extensions naturelles modelées au gel UV', 'base', NULL, 4, 55.00, 120, NULL, 'Modelage gel, forme au choix, finition parfaite', NULL, 'Entretien professionnel obligatoire', NULL, NULL, NULL, 1, 1, 0, 2, '2025-08-17 18:07:14'),
(12, 'Remplissage Extensions', 'Retouche et entretien des extensions', 'Comblement de la repousse des extensions', 'base', NULL, 4, 30.00, 75, NULL, 'Limage repousse, remplissage, finition', NULL, 'À refaire toutes les 3-4 semaines', NULL, NULL, NULL, 1, 0, 0, 3, '2025-08-17 18:07:14'),
(13, 'Soin Fortifiant', 'Traitement pour ongles fragiles', 'Soin réparateur pour ongles abîmés', 'base', NULL, 5, 20.00, 30, NULL, 'Soin fortifiant, massage cuticules, vernis traitement', NULL, 'Appliquer l\'huile cuticules quotidiennement', NULL, NULL, NULL, 1, 0, 0, 1, '2025-08-17 18:07:14'),
(14, 'Réparation Ongle Cassé', 'Réparation d\'urgence ongle abîmé', 'Réparation professionnelle avec patch', 'base', NULL, 5, 10.00, 20, NULL, 'Patch de réparation, limage, finition discrète', NULL, 'Éviter les chocs sur l\'ongle réparé', NULL, NULL, NULL, 1, 0, 0, 2, '2025-08-17 18:07:14'),
(15, 'Dépose Vernis Gel', 'Retrait professionnel vernis gel', 'Dépose douce sans abîmer l\'ongle', 'base', NULL, 5, 15.00, 30, NULL, 'Dépose professionnelle, soin hydratant', NULL, 'Laisser respirer les ongles 24h', NULL, NULL, NULL, 1, 0, 0, 3, '2025-08-17 18:07:14'),
(16, 'Package Beauté Mains', 'Manucure + nail art + soin', 'Forfait complet pour des mains parfaites', 'package', NULL, 6, 45.00, 90, NULL, 'Manucure gel + nail art simple + soin cuticules', NULL, 'Entretenir avec crème mains quotidiennement', NULL, NULL, NULL, 1, 1, 0, 1, '2025-08-17 18:07:14'),
(17, 'Package Beauté Pieds', 'Pédicure + nail art + massage', 'Forfait relaxation pour les pieds', 'package', NULL, 6, 55.00, 120, NULL, 'Pédicure spa + nail art + massage prolongé', NULL, 'Porter chaussures confortables', NULL, NULL, NULL, 1, 1, 0, 2, '2025-08-17 18:07:14'),
(18, 'Package Complet', 'Manucure + pédicure + nail art', 'Expérience beauté complète mains et pieds', 'package', NULL, 6, 70.00, 150, NULL, 'Manucure gel + pédicure classique + nail art au choix', NULL, 'Suivre conseils d\'entretien pour chaque soin', NULL, NULL, NULL, 1, 1, 1, 3, '2025-08-17 18:07:14');

-- --------------------------------------------------------

--
-- Structure de la table `services_translations`
--

CREATE TABLE `services_translations` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `description_detaillee` text DEFAULT NULL,
  `inclus` text DEFAULT NULL,
  `contre_indications` text DEFAULT NULL,
  `conseils_apres_soin` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `services_translations`
--

INSERT INTO `services_translations` (`id`, `service_id`, `language_code`, `nom`, `description`, `description_detaillee`, `inclus`, `contre_indications`, `conseils_apres_soin`, `date_creation`, `date_modification`) VALUES
(1, 1, 'fr', 'Manucure Classique', 'Soin complet des ongles avec pose de vernis', 'Manucure traditionnelle incluant limage, soin des cuticules et pose de vernis', 'Limage, soin cuticules, vernis base + couleur + top coat', NULL, 'Éviter l\'eau chaude pendant 2h', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(2, 2, 'fr', 'Manucure Gel', 'Manucure avec vernis gel longue tenue', 'Manucure premium avec vernis gel semi-permanent', 'Préparation ongles, vernis gel, séchage UV/LED', NULL, 'Ne pas arracher le vernis, utiliser dissolvant spécial', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(3, 3, 'fr', 'Manucure Express', 'Manucure rapide pour retouches', 'Service rapide de remise en forme des ongles', 'Limage et pose de vernis classique', NULL, 'Éviter l\'eau chaude pendant 1h', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(4, 4, 'fr', 'Pédicure Classique', 'Soin complet des pieds et ongles', 'Pédicure traditionnelle avec bain de pieds relaxant', 'Bain de pieds, gommage, soin cuticules, limage, vernis', NULL, 'Hydrater quotidiennement', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(5, 5, 'fr', 'Pédicure Spa', 'Pédicure luxe avec massage et masque', 'Pédicure premium avec soins relaxants', 'Bain aromatique, gommage, masque hydratant, massage 15min, vernis', NULL, 'Porter des chaussures ouvertes, éviter efforts intenses', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(6, 6, 'fr', 'Pédicure Gel', 'Pédicure avec vernis gel semi-permanent', 'Pédicure avec vernis gel longue durée', 'Soin complet + vernis gel + séchage UV', NULL, 'Ne pas gratter le vernis, utiliser dissolvant adapté', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(7, 7, 'fr', 'Nail Art Simple', 'Décoration simple sur ongles', 'Motifs simples et élégants', 'Décoration sur 2-5 ongles, motifs au choix', NULL, 'Laisser sécher complètement', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(8, 8, 'fr', 'Nail Art Élaboré', 'Créations artistiques complexes', 'Designs artistiques sur tous les ongles', 'Designs personnalisés, strass, paillettes', NULL, 'Éviter les chocs, porter des gants pour le ménage', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(9, 9, 'fr', 'Nail Art 3D', 'Décorations en relief et bijoux d\'ongles', 'Créations 3D avec éléments en relief', 'Sculptures 3D, bijoux d\'ongles, effets spéciaux', NULL, 'Manipulation délicate, éviter les chocs', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(10, 10, 'fr', 'Pose Capsules', 'Extensions avec capsules plastique', 'Allongement des ongles avec capsules', 'Capsules, limage forme, vernis ou gel', NULL, 'Retouches nécessaires toutes les 3-4 semaines', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(11, 11, 'fr', 'Extensions Gel', 'Extensions modelées au gel', 'Extensions naturelles modelées au gel UV', 'Modelage gel, forme au choix, finition parfaite', NULL, 'Entretien professionnel obligatoire', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(12, 12, 'fr', 'Remplissage Extensions', 'Retouche et entretien des extensions', 'Comblement de la repousse des extensions', 'Limage repousse, remplissage, finition', NULL, 'À refaire toutes les 3-4 semaines', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(13, 13, 'fr', 'Soin Fortifiant', 'Traitement pour ongles fragiles', 'Soin réparateur pour ongles abîmés', 'Soin fortifiant, massage cuticules, vernis traitement', NULL, 'Appliquer l\'huile cuticules quotidiennement', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(14, 14, 'fr', 'Réparation Ongle Cassé', 'Réparation d\'urgence ongle abîmé', 'Réparation professionnelle avec patch', 'Patch de réparation, limage, finition discrète', NULL, 'Éviter les chocs sur l\'ongle réparé', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(15, 15, 'fr', 'Dépose Vernis Gel', 'Retrait professionnel vernis gel', 'Dépose douce sans abîmer l\'ongle', 'Dépose professionnelle, soin hydratant', NULL, 'Laisser respirer les ongles 24h', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(16, 16, 'fr', 'Package Beauté Mains', 'Manucure + nail art + soin', 'Forfait complet pour des mains parfaites', 'Manucure gel + nail art simple + soin cuticules', NULL, 'Entretenir avec crème mains quotidiennement', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(17, 17, 'fr', 'Package Beauté Pieds', 'Pédicure + nail art + massage', 'Forfait relaxation pour les pieds', 'Pédicure spa + nail art + massage prolongé', NULL, 'Porter chaussures confortables', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(18, 18, 'fr', 'Package Complet', 'Manucure + pédicure + nail art', 'Expérience beauté complète mains et pieds', 'Manucure gel + pédicure classique + nail art au choix', NULL, 'Suivre conseils d\'entretien pour chaque soin', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(19, 1, 'en', 'Classic Manicure', 'Complete nail care with polish application', 'Traditional manicure including filing, cuticle care and polish application', 'Filing, cuticle care, base + color + top coat', NULL, 'Avoid hot water for 2 hours', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(20, 2, 'en', 'Gel Manicure', 'Manicure with long-lasting gel polish', 'Premium manicure with semi-permanent gel polish', 'Nail preparation, gel polish, UV/LED curing', NULL, 'Do not peel off polish, use special remover', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(21, 3, 'en', 'Express Manicure', 'Quick manicure for touch-ups', 'Fast nail shaping service', 'Filing and classic polish application', NULL, 'Avoid hot water for 1 hour', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(22, 4, 'en', 'Classic Pedicure', 'Complete foot and nail care', 'Traditional pedicure with relaxing foot bath', 'Foot bath, scrub, cuticle care, filing, polish', NULL, 'Moisturize daily', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(23, 5, 'en', 'Spa Pedicure', 'Luxury pedicure with massage and mask', 'Premium pedicure with relaxing treatments', 'Aromatic bath, scrub, moisturizing mask, 15min massage, polish', NULL, 'Wear open shoes, avoid intense activity', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(24, 6, 'en', 'Gel Pedicure', 'Pedicure with semi-permanent gel polish', 'Pedicure with long-lasting gel polish', 'Complete care + gel polish + UV curing', NULL, 'Do not scratch polish, use proper remover', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(25, 7, 'en', 'Simple Nail Art', 'Simple nail decoration', 'Simple and elegant patterns', 'Decoration on 2-5 nails, choice of patterns', NULL, 'Let dry completely', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(26, 8, 'en', 'Elaborate Nail Art', 'Complex artistic creations', 'Artistic designs on all nails', 'Custom designs, rhinestones, glitter', NULL, 'Avoid impact, wear gloves for cleaning', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(27, 9, 'en', '3D Nail Art', 'Relief decorations and nail jewelry', '3D creations with relief elements', '3D sculptures, nail jewelry, special effects', NULL, 'Handle delicately, avoid impact', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(28, 10, 'en', 'Nail Tips Application', 'Extensions with plastic tips', 'Nail lengthening with tips', 'Tips, shape filing, polish or gel', NULL, 'Touch-ups needed every 3-4 weeks', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(29, 11, 'en', 'Gel Extensions', 'Gel sculpted extensions', 'Natural extensions sculpted with UV gel', 'Gel sculpting, choice of shape, perfect finish', NULL, 'Professional maintenance required', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(30, 12, 'en', 'Extension Fill', 'Extension touch-up and maintenance', 'Filling nail regrowth on extensions', 'Regrowth filing, filling, finishing', NULL, 'Redo every 3-4 weeks', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(31, 13, 'en', 'Strengthening Treatment', 'Treatment for fragile nails', 'Restorative treatment for damaged nails', 'Strengthening treatment, cuticle massage, treatment polish', NULL, 'Apply cuticle oil daily', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(32, 14, 'en', 'Broken Nail Repair', 'Emergency repair for damaged nail', 'Professional repair with patch', 'Repair patch, filing, discreet finishing', NULL, 'Avoid impact on repaired nail', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(33, 15, 'en', 'Gel Polish Removal', 'Professional gel polish removal', 'Gentle removal without damaging nail', 'Professional removal, moisturizing treatment', NULL, 'Let nails breathe for 24h', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(34, 16, 'en', 'Hand Beauty Package', 'Manicure + nail art + treatment', 'Complete package for perfect hands', 'Gel manicure + simple nail art + cuticle treatment', NULL, 'Maintain with daily hand cream', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(35, 17, 'en', 'Foot Beauty Package', 'Pedicure + nail art + massage', 'Relaxation package for feet', 'Spa pedicure + nail art + extended massage', NULL, 'Wear comfortable shoes', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(36, 18, 'en', 'Complete Package', 'Manicure + pedicure + nail art', 'Complete beauty experience for hands and feet', 'Gel manicure + classic pedicure + choice of nail art', NULL, 'Follow maintenance advice for each treatment', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(37, 1, 'ar', 'مانيكير كلاسيكي', 'العناية الكاملة بالأظافر مع وضع الطلاء', 'مانيكير تقليدي يشمل البرد والعناية بالجليدة ووضع الطلاء', 'برد، عناية بالجليدة، طلاء أساس + لون + طلاء علوي', NULL, 'تجنب الماء الساخن لمدة ساعتين', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(38, 2, 'ar', 'مانيكير جل', 'مانيكير بطلاء جل طويل المفعول', 'مانيكير مميز بطلاء جل شبه دائم', 'تحضير الأظافر، طلاء جل، تجفيف بالأشعة فوق البنفسجية', NULL, 'لا تنزعي الطلاء، استخدمي مزيل خاص', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(39, 3, 'ar', 'مانيكير سريع', 'مانيكير سريع للمس النهائي', 'خدمة سريعة لتشكيل الأظافر', 'برد ووضع طلاء كلاسيكي', NULL, 'تجنب الماء الساخن لمدة ساعة', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(40, 4, 'ar', 'بيديكير كلاسيكي', 'العناية الكاملة بالقدمين والأظافر', 'بيديكير تقليدي مع حمام قدمين مريح', 'حمام قدمين، تقشير، عناية بالجليدة، برد، طلاء', NULL, 'رطبي يومياً', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(41, 5, 'ar', 'بيديكير سبا', 'بيديكير فاخر مع تدليك وقناع', 'بيديكير مميز مع علاجات مريحة', 'حمام عطري، تقشير، قناع مرطب، تدليك 15 دقيقة، طلاء', NULL, 'ارتدي أحذية مفتوحة، تجنبي النشاط المكثف', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(42, 6, 'ar', 'بيديكير جل', 'بيديكير بطلاء جل شبه دائم', 'بيديكير بطلاء جل طويل المدى', 'عناية كاملة + طلاء جل + تجفيف بالأشعة', NULL, 'لا تخدشي الطلاء، استخدمي مزيل مناسب', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(43, 7, 'ar', 'فن أظافر بسيط', 'زخرفة بسيطة على الأظافر', 'أنماط بسيطة وأنيقة', 'زخرفة على 2-5 أظافر، اختيار الأنماط', NULL, 'اتركيه يجف تماماً', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(44, 8, 'ar', 'فن أظافر معقد', 'إبداعات فنية معقدة', 'تصاميم فنية على جميع الأظافر', 'تصاميم مخصصة، أحجار راين، بريق', NULL, 'تجنبي الصدمات، ارتدي قفازات للتنظيف', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(45, 9, 'ar', 'فن أظافر ثلاثي الأبعاد', 'زخارف بارزة ومجوهرات أظافر', 'إبداعات ثلاثية الأبعاد مع عناصر بارزة', 'منحوتات ثلاثية الأبعاد، مجوهرات أظافر، تأثيرات خاصة', NULL, 'تعاملي بحذر، تجنبي الصدمات', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(46, 10, 'ar', 'تركيب أطراف', 'إطالة بأطراف بلاستيكية', 'إطالة الأظافر بالأطراف', 'أطراف، برد الشكل، طلاء أو جل', NULL, 'تحتاج لمس كل 3-4 أسابيع', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(47, 11, 'ar', 'إطالة جل', 'إطالة مشكلة بالجل', 'إطالة طبيعية مشكلة بجل الأشعة فوق البنفسجية', 'نحت بالجل، اختيار الشكل، لمسة نهائية مثالية', NULL, 'صيانة احترافية مطلوبة', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(48, 12, 'ar', 'ملء الإطالة', 'لمسة وصيانة الإطالة', 'ملء نمو الأظافر في الإطالة', 'برد النمو، ملء، لمسة نهائية', NULL, 'يعاد كل 3-4 أسابيع', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(49, 13, 'ar', 'علاج مقوي', 'علاج للأظافر الهشة', 'علاج ترميمي للأظافر التالفة', 'علاج مقوي، تدليك الجليدة، طلاء علاجي', NULL, 'ضعي زيت الجليدة يومياً', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(50, 14, 'ar', 'إصلاح ظفر مكسور', 'إصلاح طارئ لظفر تالف', 'إصلاح احترافي برقعة', 'رقعة إصلاح، برد، لمسة نهائية خفية', NULL, 'تجنبي الصدمات على الظفر المصلح', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(51, 15, 'ar', 'إزالة طلاء الجل', 'إزالة احترافية لطلاء الجل', 'إزالة لطيفة دون إتلاف الظفر', 'إزالة احترافية، علاج مرطب', NULL, 'اتركي الأظافر تتنفس لمدة 24 ساعة', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(52, 16, 'ar', 'باقة جمال اليدين', 'مانيكير + فن أظافر + علاج', 'باقة كاملة لأيدي مثالية', 'مانيكير جل + فن أظافر بسيط + علاج الجليدة', NULL, 'حافظي بكريم اليدين يومياً', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(53, 17, 'ar', 'باقة جمال القدمين', 'بيديكير + فن أظافر + تدليك', 'باقة استرخاء للقدمين', 'بيديكير سبا + فن أظافر + تدليك ممتد', NULL, 'ارتدي أحذية مريحة', '2025-08-17 18:07:14', '2025-08-17 18:07:14'),
(54, 18, 'ar', 'باقة كاملة', 'مانيكير + بيديكير + فن أظافر', 'تجربة جمال كاملة لليدين والقدمين', 'مانيكير جل + بيديكير كلاسيكي + فن أظافر حسب الاختيار', NULL, 'اتبعي نصائح الصيانة لكل علاج', '2025-08-17 18:07:14', '2025-08-17 18:07:14');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('admin','employe','super_admin') DEFAULT 'employe',
  `actif` tinyint(1) DEFAULT 1,
  `date_creation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `nom`, `email`, `mot_de_passe`, `role`, `actif`, `date_creation`) VALUES
(1, 'Admin ZenShe', 'admin@zenshe.ca', '$2b$12$rOz8kWKKU5PjU7eGBEtNruQcL4M2FT8Vh5XGjGVOhKQnhK5M4C4sO', 'super_admin', 1, '2025-07-17 13:10:32');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `avis_clients`
-- Index pour la table `avis_clients`
--
ALTER TABLE `avis_clients`
  ADD KEY `idx_client_avis` (`client_id`),
  ADD KEY `idx_date_avis` (`date_avis`),
  ADD KEY `idx_visible` (`visible`);

--
-- Index pour la table `categories_services`
--
ALTER TABLE `categories_services`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `categories_services_translations`
--
ALTER TABLE `categories_services_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_category_language` (`category_id`,`language_code`),
  ADD KEY `idx_category_id` (`category_id`),
  ADD KEY `idx_language_code` (`language_code`),
  ADD KEY `idx_category_language` (`category_id`,`language_code`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  -- primary key already defined in CREATE TABLE
  
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_unique` (`email`),
  ADD KEY `idx_clients_email_mot_de_passe` (`email`,`mot_de_passe`),
  ADD KEY `idx_clients_statut` (`statut`),
  ADD KEY `idx_clients_langue_preferee` (`langue_preferee`),
  ADD KEY `idx_clients_statut_simple` (`statut`);

--
-- Index pour la table `client_login_attempts`
--
ALTER TABLE `client_login_attempts`
  -- primary key already defined in CREATE TABLE
  
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_ip_address` (`ip_address`),
  ADD KEY `idx_attempted_at` (`attempted_at`),
  ADD KEY `idx_success` (`success`);

--
-- Index pour la table `client_sessions`
--
ALTER TABLE `client_sessions`
  -- primary key already defined in CREATE TABLE
  ADD KEY `idx_client_sessions_client_id` (`client_id`),
  ADD KEY `idx_client_sessions_expires` (`expires`),
  ADD KEY `idx_client_sessions_created_at` (`created_at`),
  ADD KEY `idx_token` (`token`(255)),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Index pour la table `client_verification_tokens`
--
ALTER TABLE `client_verification_tokens`
  -- primary key already defined in CREATE TABLE
  ADD UNIQUE KEY `unique_token` (`token`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_token_type` (`token`,`type`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Index pour la table `creneaux_horaires`
--
ALTER TABLE `creneaux_horaires`
  -- primary key already defined in CREATE TABLE
  ;

--
-- Index pour la table `fermetures_exceptionnelles`
--
ALTER TABLE `fermetures_exceptionnelles`
  -- primary key already defined in CREATE TABLE
  ADD KEY `idx_date` (`date_fermeture`);

--
-- Index pour la table `inventaire`
--
ALTER TABLE `inventaire`
  -- primary key already defined in CREATE TABLE
  ADD UNIQUE KEY `unique_code_produit` (`code_produit`),
  ADD KEY `idx_marque` (`marque`),
  ADD KEY `idx_type_produit` (`type_produit`),
  ADD KEY `idx_stock_status` (`quantite_stock`,`quantite_minimum`),
  ADD KEY `idx_fournisseur` (`fournisseur`);

--
-- Index pour la table `memberships`
--
ALTER TABLE `memberships`
  -- primary key already defined in CREATE TABLE
  ;

--
-- Index pour la table `memberships_translations`
--
ALTER TABLE `memberships_translations`
  -- primary key already defined in CREATE TABLE
  ADD UNIQUE KEY `unique_membership_language` (`membership_id`,`language_code`),
  ADD KEY `idx_membership_id` (`membership_id`),
  ADD KEY `idx_language_code` (`language_code`),
  ADD KEY `idx_membership_language` (`membership_id`,`language_code`);

--
-- Index pour la table `parametres_salon`
--
ALTER TABLE `parametres_salon`
  -- primary key already defined in CREATE TABLE
  ;

--
-- Index pour la table `parametres_salon_translations`
--
ALTER TABLE `parametres_salon_translations`
  -- primary key already defined in CREATE TABLE
  ADD UNIQUE KEY `unique_parametre_language` (`parametre_id`,`language_code`),
  ADD KEY `idx_parametre_id` (`parametre_id`),
  ADD KEY `idx_language_code` (`language_code`),
  ADD KEY `idx_parametre_language` (`parametre_id`,`language_code`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  -- primary key already defined in CREATE TABLE
  
  ADD UNIQUE KEY `token_hash` (`token_hash`),
  ADD KEY `idx_token_hash` (`token_hash`),
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Index pour la table `promotions`
--
ALTER TABLE `promotions`
  -- primary key already defined in CREATE TABLE
  
  ADD UNIQUE KEY `code_promo` (`code_promo`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `categorie_id` (`categorie_id`),
  ADD KEY `idx_dates` (`date_debut`,`date_fin`),
  ADD KEY `idx_code` (`code_promo`),
  ADD KEY `idx_actif` (`actif`);

--
-- Index pour la table `reservations`
--
ALTER TABLE `reservations`
  -- primary key already defined in CREATE TABLE
  
  ADD KEY `idx_client_id` (`client_id`),
  ADD KEY `idx_service_id` (`service_id`),
  ADD KEY `idx_date_reservation` (`date_reservation`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_reservation_status` (`reservation_status`),
  ADD KEY `idx_session_id` (`session_id`),
  ADD KEY `idx_client_phone` (`client_telephone`),
  ADD KEY `idx_client_lookup` (`client_telephone`,`client_nom`,`client_prenom`);

--
-- Index pour la table `reservation_items`
--
ALTER TABLE `reservation_items`
  -- primary key already defined in CREATE TABLE
  
  ADD KEY `idx_reservation` (`reservation_id`),
  ADD KEY `idx_service` (`service_id`),
  ADD KEY `idx_type` (`item_type`);

--
-- Index pour la table `security_settings`
--
ALTER TABLE `security_settings`
  -- primary key already defined in CREATE TABLE
  
  ADD UNIQUE KEY `unique_setting_name` (`setting_name`);

--
-- Index pour la table `services`
--
ALTER TABLE `services`
  -- primary key already defined in CREATE TABLE
  
  ADD KEY `idx_service_type` (`service_type`),
  ADD KEY `idx_parent_service` (`parent_service_id`),
  ADD KEY `idx_categorie` (`categorie_id`),
  ADD KEY `idx_actif` (`actif`);

--
-- Index pour la table `services_translations`
--
ALTER TABLE `services_translations`
  -- primary key already defined in CREATE TABLE
  
  ADD UNIQUE KEY `unique_service_language` (`service_id`,`language_code`),
  ADD KEY `idx_service_id` (`service_id`),
  ADD KEY `idx_language_code` (`language_code`),
  ADD KEY `idx_service_language` (`service_id`,`language_code`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  -- primary key already defined in CREATE TABLE
  
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `avis_clients`
--
ALTER TABLE `avis_clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `categories_services`
--
ALTER TABLE `categories_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `categories_services_translations`
--
ALTER TABLE `categories_services_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `client_login_attempts`
--
ALTER TABLE `client_login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `client_verification_tokens`
--
ALTER TABLE `client_verification_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `creneaux_horaires`
--
ALTER TABLE `creneaux_horaires`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `fermetures_exceptionnelles`
--
ALTER TABLE `fermetures_exceptionnelles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `inventaire`
--
ALTER TABLE `inventaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `memberships_translations`
--
ALTER TABLE `memberships_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `parametres_salon`
--
ALTER TABLE `parametres_salon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `parametres_salon_translations`
--
ALTER TABLE `parametres_salon_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `reservation_items`
--
ALTER TABLE `reservation_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `security_settings`
--
ALTER TABLE `security_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `services_translations`
--
ALTER TABLE `services_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `avis_clients`
--
ALTER TABLE `avis_clients`
  ADD CONSTRAINT `avis_clients_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `categories_services_translations`
--
ALTER TABLE `categories_services_translations`
  ADD CONSTRAINT `categories_services_translations_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories_services` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `client_login_attempts`
--
ALTER TABLE `client_login_attempts`
  ADD CONSTRAINT `client_login_attempts_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `client_sessions`
--
ALTER TABLE `client_sessions`
  ADD CONSTRAINT `client_sessions_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `client_verification_tokens`
--
ALTER TABLE `client_verification_tokens`
  ADD CONSTRAINT `client_verification_tokens_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `memberships_translations`
--
ALTER TABLE `memberships_translations`
  ADD CONSTRAINT `memberships_translations_ibfk_1` FOREIGN KEY (`membership_id`) REFERENCES `memberships` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `parametres_salon_translations`
--
ALTER TABLE `parametres_salon_translations`
  ADD CONSTRAINT `parametres_salon_translations_ibfk_1` FOREIGN KEY (`parametre_id`) REFERENCES `parametres_salon` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `promotions`
--
ALTER TABLE `promotions`
  ADD CONSTRAINT `promotions_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `promotions_ibfk_2` FOREIGN KEY (`categorie_id`) REFERENCES `categories_services` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Contraintes pour la table `reservation_items`
--
ALTER TABLE `reservation_items`
  ADD CONSTRAINT `reservation_items_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_items_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categories_services` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `services_ibfk_2` FOREIGN KEY (`parent_service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `services_translations`
--
ALTER TABLE `services_translations`
  ADD CONSTRAINT `services_translations_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
