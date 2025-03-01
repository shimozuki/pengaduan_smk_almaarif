/*
 Navicat Premium Data Transfer

 Source Server         : my_local
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : Al-marif

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 01/03/2025 12:50:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `categories_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (12, 'Cyberbullying', 'category-images/h9LUFM0HPvB1FCfwZLbxZIyZcwgwzWN1dTaOYi02.jpg', '<p>Laporkan langsung bentuk tindakan bullying yang dilakukan melalui media sosial, pesan teks, atau platform digital lainnya. Cyberbullying dapat melibatkan penghinaan, penyebaran rumor, pelecehan secara online, atau pencemaran nama baik melalui komentar negatif atau gambar yang merendahkan.</p>', 'cyberbullying', '2023-06-06 15:45:39', '2023-06-06 15:45:52');
INSERT INTO `categories` VALUES (13, 'Verbal Bullying', 'category-images/nwAEJm1S62yOVP6UgBVYLBRewLyjlL6ZyzOqO4Bm.png', '<p>Laporkan hal yang melibatkan penghinaan, ejekan, penghinaan, atau pengucilan secara lisan. Ini bisa terjadi dalam percakapan sehari-hari, di kelas, atau dalam kelompok sosial. Contohnya termasuk mengolok-olok penampilan fisik, cerdas, latar belakang etnis, atau agama seseorang.</p>', 'verbal-bullying', '2023-06-06 15:48:03', '2023-06-06 15:48:03');
INSERT INTO `categories` VALUES (14, 'Bullying Fisik', 'category-images/wgFIvo27IFiZZ26SZQjDV3umH9NmBOmRKTET1hBa.jpg', '<p>Laporkanlah Tindakan yang melibatkan penggunaan kekerasan fisik atau ancaman fisik untuk menyakiti atau mengintimidasi seseorang. Ini bisa berupa pukulan, tendangan, dorongan, atau ancaman menggunakan kekuatan fisik.</p>', 'bullying-fisik', '2023-06-06 15:49:38', '2023-06-06 15:49:38');
INSERT INTO `categories` VALUES (15, 'Bullying emosional', 'category-images/1qmUNVAhceaG1DdZRk0nHPeQH2XAqda1qoYFEPGZ.jpg', '<p>Segera beri kabar apabila ada bentuk bullying yang melibatkan penghinaan, pengabaian, isolasi, atau pengucilan yang bertujuan untuk merendahkan atau merusak keadaan emosional seseorang. Ini bisa termasuk mengabaikan seseorang, menyebabkan rasa malu atau cemas, atau membuat seseorang merasa tidak berharga.</p>', 'bullying-emosional', '2023-06-06 15:51:48', '2023-06-06 15:51:48');
INSERT INTO `categories` VALUES (16, 'Bullying Seksual', 'category-images/2XTSIhm8t6SdIfiXiW7Ccf0Tc2t1n7saAfx4CPi9.jpg', '<p>Laporkan langsung apabila mendapati pelaku atau korban yang melibatkan perilaku tidak diinginkan atau tidak pantas yang bersifat seksual, termasuk pelecehan seksual, komentar yang tidak senonoh, atau ancaman untuk memperoleh layanan seksual melalui penekanan atau pemerasan.</p>', 'bullying-seksual', '2023-06-06 15:53:21', '2023-06-06 15:53:21');

-- ----------------------------
-- Table structure for complaints
-- ----------------------------
DROP TABLE IF EXISTS `complaints`;
CREATE TABLE `complaints`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_nik` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `place` enum('out','in') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `privacy` enum('anonymous','public') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `complaints_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `complaints_student_nik_foreign`(`student_nik` ASC) USING BTREE,
  INDEX `complaints_category_id_foreign`(`category_id` ASC) USING BTREE,
  CONSTRAINT `complaints_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `complaints_student_nik_foreign` FOREIGN KEY (`student_nik`) REFERENCES `students` (`student_nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 207 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of complaints
-- ----------------------------
INSERT INTO `complaints` VALUES (201, '2023-06-06', 'Penghinaan', 'penghinaan', '<p>Saya dihina karena kumis saya yang sangat tebal oleh teman kolega saya dikampus.</p>', 'Saya dihina karena kumis saya yang sangat tebal ol ...', '1234561234567890', 12, 'complaint-images/seHwIw8hLUjLKyTSPSeCZn7Podw7oc802VgWk6SZ.jpg', 'out', '0', 'public', '2023-06-06 16:01:55', '2023-06-06 16:01:55');
INSERT INTO `complaints` VALUES (202, '2023-06-05', 'Dicaci dosen', 'dicaci-dosen', '<p>Saya dicaci oleh dosen fisika karena terlalu bodoh. Sehingga saya sangat tidak suka masuk matkulnya</p>', 'Saya dicaci oleh dosen fisika karena terlalu bodoh ...', '1234556789061234', 13, 'complaint-images/eRglbkFtXgVHqkNJiagKrlSUzySVf3IS6XgzXygR.jpg', 'in', '1', 'anonymous', '2023-06-06 16:47:54', '2023-06-06 17:10:04');
INSERT INTO `complaints` VALUES (203, '2023-05-31', 'Bullying Fisik', 'bullying-fisik', '<p>Saya dihajar habis-habisan oleh pasukan PSHT Yogyakarta dimana ketika saya lewat, teman saya yang mengenali saya langsung menunjuk dan menghajar saya</p>', 'Saya dihajar habis-habisan oleh pasukan PSHT Yogya ...', '1234556789061234', 14, 'complaint-images/KQ5wMBsY8PNs4CKlcYwVH0EJ9iFULYAyvSxTKp2o.jpg', 'out', '0', 'public', '2023-06-06 17:56:38', '2023-06-06 17:57:04');
INSERT INTO `complaints` VALUES (204, '2023-06-07', 'Bullying Seksual', 'bullying-seksual', '<p>Saya di anuin sama teman saya angkatan 18</p>', 'Saya di anuin sama teman saya angkatan 18', '1234556789061234', 16, 'complaint-images/A6noxgozlqIdT91HvpUFnU8LyN7cO2vqZHXndbTt.jpg', 'out', '1', 'anonymous', '2023-06-06 17:59:32', '2023-06-06 20:15:37');
INSERT INTO `complaints` VALUES (205, '2023-06-08', 'Bullying Emosional', 'bullying-emosional', '<p>Saya tidak tahan ketika saya dikelas selalu di bentak2 oleh kolega saya yang bernama anu</p>', 'Saya tidak tahan ketika saya dikelas selalu di ben ...', '1234561234567890', 15, 'complaint-images/JVBa6mPt25S23VVC7U0HqGSncEO5fShaUZTVmLs8.jpg', 'in', '0', 'public', '2023-06-06 18:02:20', '2023-06-06 18:02:20');
INSERT INTO `complaints` VALUES (206, '2023-06-06', 'Pelehan Seksual', 'pelehan-seksual', '<p>Saya dilecehkan oleh seorang mahasiswa yang bernama N di tolet anonim. Saya merasa itu sangat memalukan. Tapi saya harus melaporkannya.</p>', 'Saya dilecehkan oleh seorang mahasiswa yang bernam ...', '1293181301244', 16, NULL, 'out', '2', 'public', '2023-06-06 20:10:04', '2023-06-06 20:12:01');

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (5, '2023_03_01_130807_create_students_table', 1);
INSERT INTO `migrations` VALUES (6, '2023_03_01_131123_create_officers_table', 1);
INSERT INTO `migrations` VALUES (7, '2023_03_01_131208_create_categories_table', 1);
INSERT INTO `migrations` VALUES (8, '2023_03_01_131308_create_complaints_table', 1);
INSERT INTO `migrations` VALUES (9, '2023_03_01_131400_create_responses_table', 1);
INSERT INTO `migrations` VALUES (10, '2023_03_02_011825_create_user_triggers', 1);
INSERT INTO `migrations` VALUES (11, '2023_05_23_155835_create_settings_table', 1);

-- ----------------------------
-- Table structure for officers
-- ----------------------------
DROP TABLE IF EXISTS `officers`;
CREATE TABLE `officers`  (
  `officer_nik` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`officer_nik`) USING BTREE,
  UNIQUE INDEX `officers_nip_unique`(`nip` ASC) USING BTREE,
  CONSTRAINT `officers_officer_nik_foreign` FOREIGN KEY (`officer_nik`) REFERENCES `users` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of officers
-- ----------------------------
INSERT INTO `officers` VALUES ('1201234563456789', NULL, NULL, NULL);
INSERT INTO `officers` VALUES ('1234512345667890', NULL, NULL, NULL);
INSERT INTO `officers` VALUES ('1234516678902345', NULL, NULL, NULL);
INSERT INTO `officers` VALUES ('1234567890123456', NULL, NULL, NULL);
INSERT INTO `officers` VALUES ('1238902345451667', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type` ASC, `tokenable_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for responses
-- ----------------------------
DROP TABLE IF EXISTS `responses`;
CREATE TABLE `responses`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint UNSIGNED NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `officer_nik` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `responses_complaint_id_foreign`(`complaint_id` ASC) USING BTREE,
  INDEX `responses_officer_nik_foreign`(`officer_nik` ASC) USING BTREE,
  CONSTRAINT `responses_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `responses_officer_nik_foreign` FOREIGN KEY (`officer_nik`) REFERENCES `officers` (`officer_nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 205 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of responses
-- ----------------------------
INSERT INTO `responses` VALUES (202, 202, '<p>Wah. sangat disayangkan kejadian itu terjadi. Besok tgl 10/06/2023 jam 10.00 WIB segera keruang BK ya IST Akprind ya..</p>', '1234516678902345', '2023-06-06 17:10:04', '2023-06-06 17:10:04');
INSERT INTO `responses` VALUES (203, 206, '<p>Ayo besok segera ke ruang bk yah. semoga masalah bisa diselesaikan</p>', '1234516678902345', '2023-06-06 20:12:01', '2023-06-06 20:12:01');
INSERT INTO `responses` VALUES (204, 204, '<p>segera selesaikan di ruang bk besok yah</p>', '1234567890123456', '2023-06-06 20:15:37', '2023-06-06 20:15:37');

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES (1, 'WEB_TITLE', 'Pengaduan Siswa SMK AL-Ma\'arif', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (2, 'WEB_LOCATION', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3945.83083380562!2d117.42777319999999!3d-8.5158001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dcb93b9def94517%3A0x62064a4c8ae82afa!2sSMK%20Al-Ma&#39;arif%20Sumbawa!5e0!3m2!1sen!2sid!4v1740803695573!5m2!1sen!2sid\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (3, 'WEB_LOGO_WHITE', 'website-settings/xYJqSqinc87j5zdzJAZjslgEmPYki6zulVRqdrma.png', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (4, 'WEB_LOGO', 'website-settings/VwaDCbfhzsacdHgKG8iEVzJapNtkwRwixru4hlaW.png', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (5, 'WEB_FAVICON', 'website-settings/Bi33qFFuGYKEbSVxLTl4GYELXRCaNf1Oc8WIQYnn.png', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (6, 'HERO_TEXT_HEADER', 'Sistem Pengaduan SMK AL-Ma\'arif', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (7, 'HERO_TEXT_DESCRIPTION', 'Membuka Suara: Mendorong Pelaporan Bullying dan Membangun Ruang Aman bagi Siswa melalui Pendekatan Whistleblowing System dengan Website Pengaduan', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (8, 'FOOTER_IMAGE', 'website-settings/cAwvhq5Byk8lAltQBt1DksDVYoXgJFqhLtQpzDRa.png', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (9, 'FOOTER_TEXT_DASHBOARD', 'SMK AL-Ma\'arif', NULL, '2025-03-01 11:41:33');
INSERT INTO `settings` VALUES (10, 'FOOTER_IMAGE_DASHBOARD', 'website-settings/jEDOQebHm8x4BcxgHp7tfCAwgSGOEEAIrsztm6pE.png', NULL, '2025-03-01 11:41:33');

-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students`  (
  `student_nik` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nisn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`student_nik`) USING BTREE,
  UNIQUE INDEX `students_nisn_unique`(`nisn` ASC) USING BTREE,
  CONSTRAINT `students_student_nik_foreign` FOREIGN KEY (`student_nik`) REFERENCES `users` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of students
-- ----------------------------
INSERT INTO `students` VALUES ('1234556789061234', NULL, NULL, NULL);
INSERT INTO `students` VALUES ('1234561234567890', NULL, NULL, NULL);
INSERT INTO `students` VALUES ('1293181301244', NULL, NULL, NULL);
INSERT INTO `students` VALUES ('5678901234561234', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nik` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('L','P') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` enum('student','officer','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_nik_unique`(`nik` ASC) USING BTREE,
  UNIQUE INDEX `users_username_unique`(`username` ASC) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE,
  INDEX `users_nik_index`(`nik` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '1234567890123456', 'Muhammad Adji', 'adji', 'L', 'adji@gmail.com', NULL, NULL, '$2y$10$SS6CIpgbyUCZqL84/pEak.EENRsRfweFZeuSA7AStCUOOsl3bBtNW', 'admin', NULL, '2023-06-06 15:08:20', NULL);
INSERT INTO `users` VALUES (2, '1201234563456789', 'admin', 'nana', 'P', 'admin@gmail.com', NULL, NULL, '$2y$12$bXKtpdICdnlj4u4l2Cl4Se0N/yazqbfo669eBIY7Ibi.ApOhXrZPi', 'admin', NULL, '2023-06-06 15:08:20', NULL);
INSERT INTO `users` VALUES (3, '1234561234567890', 'Adji', 'aji', 'L', 'aji@gmail.com', NULL, NULL, '$2y$10$P0fEUkFu7jWo8iELN6btde5kGybmJ81yIWWmRyI5PDpwZa2XK4E6K', 'student', NULL, '2023-06-06 15:08:20', NULL);
INSERT INTO `users` VALUES (4, '1234556789061234', 'Student', 'student', 'L', 'student@gmail.com', NULL, NULL, '$2y$10$oyv1VfIsd8VPO9oHngUCLuAhLDqcgwIRa0Jg5EVb9Rm4Rc1FkRmrC', 'student', NULL, '2023-06-06 15:08:20', NULL);
INSERT INTO `users` VALUES (5, '5678901234561234', 'Muhammad Pasya', 'pasyaa', 'L', 'pasyaa@gmail.com', NULL, NULL, '$2y$10$Q6JbIbj0KktaJpM6kI4DROkRzQCCFg5OSQAhBMDWl7rEP/bjZJN.O', 'student', NULL, '2023-06-06 15:08:20', NULL);
INSERT INTO `users` VALUES (6, '1234512345667890', 'ajie', 'ajie', 'L', 'ajie@gmail.com', NULL, NULL, '$2y$10$PoANcKGlC7RklpD9mH6cOuNx3Abdnrg5bxZoPrXPg2SvLzqpRFgjm', 'officer', NULL, '2023-06-06 15:08:20', NULL);
INSERT INTO `users` VALUES (7, '1234516678902345', 'officer', 'officer', 'L', 'officer@gmail.com', NULL, NULL, '$2y$12$bXKtpdICdnlj4u4l2Cl4Se0N/yazqbfo669eBIY7Ibi.ApOhXrZPi', 'officer', NULL, '2023-06-06 15:08:20', NULL);
INSERT INTO `users` VALUES (8, '1238902345451667', 'Arif Rahmaanul', 'arif.rahmaanul', 'L', 'arif@gmail.com', NULL, NULL, '$2y$10$0fq4/OcoJ84cFXXg5zJkX.zKkPfomcts.dYmbFuFfsJJYHNcow7gy', 'officer', NULL, '2023-06-06 15:08:20', NULL);
INSERT INTO `users` VALUES (9, '1293181301244', 'Lina', 'lina', 'P', 'lina@gmail.com', NULL, NULL, '$2y$12$bXKtpdICdnlj4u4l2Cl4Se0N/yazqbfo669eBIY7Ibi.ApOhXrZPi', 'student', NULL, NULL, NULL);

-- ----------------------------
-- Triggers structure for table users
-- ----------------------------
DROP TRIGGER IF EXISTS `tr_add_user`;
delimiter ;;
CREATE TRIGGER `tr_add_user` AFTER INSERT ON `users` FOR EACH ROW BEGIN
                IF NEW.level = "student" THEN
                    INSERT INTO students (student_nik)
                    VALUES (NEW.nik);
                ELSEIF NEW.level = "officer" OR NEW.level = "admin" THEN
                    INSERT INTO officers (officer_nik)
                    VALUES (NEW.nik);
                END IF;
            END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
