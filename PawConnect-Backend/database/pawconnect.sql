-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2025 at 08:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `straydog`
--

-- --------------------------------------------------------

--
-- Table structure for table `adopt`
--

CREATE TABLE `adopt` (
  `id` int(11) NOT NULL,
  `animal_name` varchar(50) NOT NULL,
  `gender` varchar(25) NOT NULL,
  `city` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(25) NOT NULL,
  `image` varchar(250) NOT NULL,
  `breed_name` varchar(50) NOT NULL,
  `helth_condition` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `age` varchar(50) NOT NULL,
  `color` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adopt`
--

INSERT INTO `adopt` (`id`, `animal_name`, `gender`, `city`, `date`, `status`, `image`, `breed_name`, `helth_condition`, `description`, `age`, `color`) VALUES
(1, 'Mili', 'Female', 'Mangalore', '2023-05-10 18:02:21', '1', 'starter/pet/mili.jpeg', 'Indian Pariah Dog', 'Healthy', 'Mili, the cute eyed pupper will fill your home with her sweetness. She is supaw friendly, and her bonus point is that Mili is so cute. But, her foster parents are no longer able to take care of her. So, she is now looking for a forever home where she can play around and be cute. If you feel you are the one please come forward. Share and spread the word. Pre and post-adoption house checks and other adoption formalities are mandatory. Available for adoption in Gurgaon. ', '8 months and 9 days old', 'Brown'),
(2, 'Luna', 'Choose', 'New Delhi', '2023-05-10 18:02:21', '0', 'starter/pet/Luna.jpeg', 'Indian Pariah Dog', 'Luna is a very nice girl. She\'s playful and friendly, and she\'s currently looking for a forever home', 'Luna is a very nice girl. She\'s playful and friendly, and she\'s currently looking for a forever home where she gets the love, plus the treatos. If you feel you are the one please come forward. Share and spread the word. Pre and post-adoption house checks and other adoption formalities are mandatory. Available for adoption in Delhi/NCR.', ' 5 months and 11 days old', 'White and Bloack'),
(3, 'Chingi', 'Male', 'Mangalore', '2023-05-10 18:02:21', '1', 'starter/pet/Chingi.jpg', 'Indian Pariah Dog', 'Healthy, Vaccinated', 'Chingi is a very pretty girl. She\'s playful and friendly. And she sleeps peacefully in the night. Chingi is currently looking for a forever home. If you feel you are the one please come forward. Share and spread the word. Pre and post-adoption house checks and other adoption formalities are mandatory. Available for adoption in Delhi/NCR.', '4 months and 14 days old', 'White and Brown'),
(4, 'Barfi', 'Female', 'Udupi', '2023-05-10 18:02:21', '1', 'starter/pet/barfi.jpg', 'Indian Pariah Dog', 'Healthy, Dewormed, Vaccin', 'Barfi is a very nice and playful pupper. If you feel you are the one please come forward. Share and spread the word. Pre and post-adoption house checks and other adoption formalities are mandatory. Available for adoption in Delhi/NCR. ', '4 months and 1 day old', 'White and Brown');

-- --------------------------------------------------------

--
-- Table structure for table `adopt_request`
--

CREATE TABLE `adopt_request` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adopt_request`
--

INSERT INTO `adopt_request` (`id`, `user_id`, `pet_id`, `date`, `status`) VALUES
(31, 4, 3, '2025-06-30 10:45:57', 0),
(32, 12, 1, '2025-06-30 11:22:09', 0),
(33, 12, 2, '2025-06-30 11:22:16', 0),
(34, 12, 3, '2025-07-01 08:56:45', 0),
(35, 12, 4, '2025-07-02 07:42:27', 0),
(36, 4, 1, '2025-07-02 11:23:08', 0);

-- --------------------------------------------------------

--
-- Table structure for table `donation`
--

CREATE TABLE `donation` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `amount` int(50) NOT NULL,
  `description` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `donation`
--

INSERT INTO `donation` (`id`, `userid`, `amount`, `description`, `date`, `status`) VALUES
(7, 4, 5000, 'For food.', '2025-06-25 07:14:47', 1),
(8, 4, 1000, 'Buy some meds for the dogs.', '2025-06-25 07:16:17', 1),
(15, 4, 500000, 'For food and medicine', '2025-06-27 09:44:57', 1),
(16, 12, 6000, 'For food', '2025-07-01 09:21:19', 1);

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `image` varchar(500) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `title`, `image`, `date`, `status`) VALUES
(11, 'Rescue Operation in Mumbai', 'starter/gallery/7epzzmhn4a-animal-rescue-services-4-l5vjt.avif', '2025-06-25 05:30:38', 1),
(12, 'Puppy Vaccination Drive', 'starter/gallery/dog-vaccine.jpg', '2025-06-25 05:34:14', 1),
(13, 'Dog Adoption Success Story', 'starter/gallery/success-story.jpeg', '2025-06-25 05:36:34', 1),
(14, 'Rescue Mission – Puppy in Pipe', 'starter/gallery/pipe.jpeg', '2025-07-02 12:04:51', 1);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `type` varchar(10) NOT NULL,
  `path` varchar(500) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `user_id`, `title`, `description`, `date`, `type`, `path`, `status`) VALUES
(1, 1, 'Our Team Did An Amazing Job.', 'This little pit bull, Tig, was found on the side of road. He couldn\'t move or walk on his own, and doctors weren\'t sure he\'d make it through the night. But with Tig\'s will to survive and help from his foster mom, watch him grow up to be the bounciest little pup!', '2023-05-10 18:02:21', 'Image', 'starter/post/happy-dogs-before-after-adoption-73-5a953247bb830__880.jpg', 1),
(10, 1, 'Bruno’s Recovery Journey', 'Bruno was rescued after being hit by a car in Andheri. With help from volunteers and local donors, he underwent surgery and is now ready for adoption. His strength and spirit are truly inspiring!', '2025-06-25 06:46:08', 'Image', 'starter/post/bruno.webp', 1),
(11, 1, 'Feeding 100+ Strays on Diwali', 'Festive nights are tough for strays due to noise and lack of food. On Diwali, our volunteers went around feeding over 100 stray dogs and cats. A special thanks to everyone who donated!', '2025-06-25 07:07:36', 'Image', 'starter/post/stray.avif', 1);

-- --------------------------------------------------------

--
-- Table structure for table `rescue`
--

CREATE TABLE `rescue` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(500) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL,
  `uid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rescue`
--

INSERT INTO `rescue` (`id`, `description`, `image`, `date`, `status`, `uid`) VALUES
(22, 'Injured dog found near surathkal railway station. Looks scared', 'starter/rescue/scaled_1000402170.jpg', '2025-07-02 11:58:42', 0, 4),
(23, 'Two dogs are stuck in drain near Kankandy. Needs immediate rescue.', 'starter/rescue/scaled_1000402171.jpg', '2025-07-02 12:01:27', 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contact` varchar(25) NOT NULL,
  `password` varchar(50) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL,
  `token` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `contact`, `password`, `created_date`, `status`, `token`) VALUES
(4, 'Anish', 'anishpereira05@gmail.com', '9632371841', '123456', '2025-06-17 22:03:33', 1, '1750178014110'),
(13, 'Jeffson', 'jeffsonpreetham77@gmail.com', '3883838388', '1234', '2025-07-02 10:32:52', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `vaccine`
--

CREATE TABLE `vaccine` (
  `id` int(15) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `createddate` datetime NOT NULL DEFAULT current_timestamp(),
  `image` varchar(200) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vaccine`
--

INSERT INTO `vaccine` (`id`, `title`, `description`, `createddate`, `image`, `status`) VALUES
(9, 'Rabies Vaccine', 'Protects against rabies, a fatal virus transmitted through animal bites.', '2025-06-25 05:57:25', 'starter/vaccine/rabies-vaccine.jpg', 1),
(10, 'DHPP Combination Vaccine', 'Covers distemper, hepatitis, parainfluenza, and parvovirus in dogs.', '2025-06-25 06:07:11', 'starter/vaccine/Nobivac-dhppil-dog-vaccine.webp', 1),
(11, 'Lyme Disease Vaccine', 'Protects against Lyme disease spread by ticks, common in grassy areas.', '2025-06-25 06:10:46', 'starter/vaccine/Lyme.webp', 1);

-- --------------------------------------------------------

--
-- Table structure for table `veterinary`
--

CREATE TABLE `veterinary` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `contact` varchar(15) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `veterinary`
--

INSERT INTO `veterinary` (`id`, `name`, `address`, `contact`, `status`, `created_date`) VALUES
(4, 'Dr. Yashaswi Naravi', 'Charles Pinto Compound, behind Karnataka Bank, Kulashekara, Mangaluru, Karnataka 575005', '6568798990', 1, '2025-07-02 12:07:00'),
(5, 'Eela The Vet', 'Eela Veterinary Clinic, 1st Cross Road, Shivbagh, Kadri, Mangaluru, Karnataka 575002', '7678687870', 1, '2025-07-02 12:08:46'),
(6, 'Dr Suresh Shetty', 'SUVI, Old Main Rd, opposite to Bharath Beedi Works Pvt Ltd, Surathkal, Mangaluru, Karnataka 575014', '9878788789', 1, '2025-07-02 12:09:35'),
(7, 'Dr Ashok KR', 'VRRH+FX7, Urwa Marigudi Rd, Urwa Market, Ashok Nagar, Mangaluru, Karnataka 575003', '7766664564', 1, '2025-07-02 12:10:16');

-- --------------------------------------------------------

--
-- Table structure for table `volunteer`
--

CREATE TABLE `volunteer` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `contact` varchar(25) NOT NULL,
  `email` varchar(100) NOT NULL,
  `gender` varchar(25) NOT NULL,
  `date_of_birth` date NOT NULL,
  `address` text NOT NULL,
  `profession` varchar(250) NOT NULL,
  `reason` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `volunteer`
--

INSERT INTO `volunteer` (`id`, `name`, `contact`, `email`, `gender`, `date_of_birth`, `address`, `profession`, `reason`, `date`) VALUES
(1, 'Sundar shay', '8906589658', 'sundar@gmail.com', 'Male', '1990-05-26', 'Bangalore', 'Doctor', 'I want be a social worker', '2021-05-26 18:59:54'),
(3, 'Anish', '9632371841', 'anishpereira05@gmail.com', 'Male', '2002-06-17', 'Katipalla', 'Student', 'Want to help', '2025-06-27 22:00:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adopt`
--
ALTER TABLE `adopt`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adopt_request`
--
ALTER TABLE `adopt_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `donation`
--
ALTER TABLE `donation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rescue`
--
ALTER TABLE `rescue`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vaccine`
--
ALTER TABLE `vaccine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `veterinary`
--
ALTER TABLE `veterinary`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `volunteer`
--
ALTER TABLE `volunteer`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adopt`
--
ALTER TABLE `adopt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `adopt_request`
--
ALTER TABLE `adopt_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `donation`
--
ALTER TABLE `donation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `rescue`
--
ALTER TABLE `rescue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `vaccine`
--
ALTER TABLE `vaccine`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `veterinary`
--
ALTER TABLE `veterinary`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `volunteer`
--
ALTER TABLE `volunteer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
