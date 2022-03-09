-- User table
DELETE FROM user;
INSERT INTO user (id, name, ageGroup, email, countryOfResidence, gender, profileAvatar, schoolInfo) VALUES 
(1, 'Jerry', '18+', 'jwu23@uw.edu', 'USA', 'Male', 'avatar1.jpg', '{\"player_type\": \"University Student\", \"school_name\": \"UW\", \"school_country\": \"USA\", \"school_postal_code\": 98195}'),
(2, 'Steven', '18+', 'steven@uw.edu', 'USA', 'Male', 'avatar2.jpg', '{\"player_type\": \"University Student\", \"school_name\": \"UW\", \"school_country\": \"USA\", \"school_postal_code\": 98195}'),
(3, 'Jessica', '18+', 'jessica@uw.edu', 'USA', 'Female', 'avatar3.jpg', '{\"player_type\": \"University Student\", \"school_name\": \"UW\", \"school_country\": \"USA\", \"school_postal_code\": 98195}'),
(4, 'David', '13+', 'david@gmail.com', 'USA', 'Male', 'avatar4.jpg', '{\"player_type\": \"High School Student\", \"school_name\": \"Garfield High School \", \"school_country\": \"USA\", \"school_postal_code\": 98122}'),
(5, 'Amy', '13+', 'amy@gmail.com', 'USA', 'Female', 'avatar5.jpg', '{\"player_type\": \"High School Student\", \"school_name\": \"Garfield High School\", \"school_country\": \"USA\", \"school_postal_code\": 98122}');
SELECT * FROM user;

-- Race table
DELETE FROM race;
INSERT INTO race (id, `group`, userId) VALUES (1, 'White', 2), (2, 'White', 3), (3, 'Asian', 1),
(4, 'Native Hawaiian or Pacific Islander', 1), (5, 'Asian', 5), (6, 'White', 4);
SELECT user.*, race.* 
FROM user 
JOIN race ON race.userId = user.id; 

-- Classroom table
DELETE FROM classroom;
INSERT INTO classroom (id, name, inviteCode, setting, userId) VALUES 
(1, 'INFO 310 CTF Practice', 'CmEbqGMeR', '[{\"name\": \"Update Classroom Name\", \"value\": \"example1\"}, {\"name\": \"Change invite code\", \"value\": \"example2\"}, {\"name\": \"Batch Register Users\", \"value\": \"example3\"}]', 1),
(2, 'picoCTF Competition', 'xmbwcw1b5', '[{\"name\": \"Update Classroom Name\", \"value\": \"example1\"}, {\"name\": \"Change invite code\", \"value\": \"example2\"}, {\"name\": \"Batch Register Users\", \"value\": \"example3\"}]', 2),
(3, 'picoCTF Practice', 'ymixw5w0m', '[{\"name\": \"Update Classroom Name\", \"value\": \"example1\"}, {\"name\": \"Change invite code\", \"value\": \"example2\"}, {\"name\": \"Batch Register Users\", \"value\": \"example3\"}]', 3),
(4, 'INFO 310 CTF Practice', 'CmEbqGMeR', '[{\"name\": \"Update Classroom Name\", \"value\": \"example1\"}, {\"name\": \"Change invite code\", \"value\": \"example2\"}, {\"name\": \"Batch Register Users\", \"value\": \"example3\"}]', 2),
(5, 'Future cyberanalysts', 'akjownas6', '[{\"name\": \"Update Classroom Name\", \"value\": \"example1\"}, {\"name\": \"Change invite code\", \"value\": \"example2\"}, {\"name\": \"Batch Register Users\", \"value\": \"example3\"}]', 4);
SELECT user.*, classroom.*
FROM user
JOIN classroom ON classroom.userId = user.id;

-- Report Table
DELETE FROM report;
INSERT INTO report (id, eventType, dateCreated, problemsAssigned, userId, classroomId) VALUES
(1, 'picoGym', '2021-12-18 13:42:30', 5, 1, 1),
(2, 'picoGym', '2021-12-18 13:42:30', 5, 2, 4),
(3, 'picoGym', '2021-11-23 08:35:30', 8, 4, 5),
(4, 'picoGym', '2021-12-18 13:42:30', 8, 5, 5),
(5, 'picoCTF 2021', '2021-09-18 13:42:30', 10, 1, 1),
(6, 'picoCTF 2021', '2021-06-18 09:05:30', 20, 2, 2),
(7, 'Beginner picoMini 2022', '2022-01-12 15:06:30', 10, 3, 3);
SELECT report.*, user.*, classroom.*
FROM report
JOIN user ON report.userId = user.id
JOIN classroom ON report.classroomId = classroom.id;

-- User-classroom table
DELETE FROM `user-classroom`;
INSERT INTO `user-classroom` (userId, classroomId, role) VALUES 
(1, 1, 'leader'),
(2, 4, 'student'),
(2, 2, 'leader'),
(3, 3, 'leader'),
(4, 5, 'leader'),
(5, 5, 'student');
SELECT user.*, classroom.*, `user-classroom`.*
FROM user
JOIN `user-classroom` ON `user-classroom`.userId = user.id
JOIN classroom ON `user-classroom`.classroomId = classroom.id; 

-- Eventlist table
DELETE FROM eventlist;
INSERT INTO eventlist (id, title, classroomId) VALUES 
(1, 'picoCTF 2021', 1),
(2, 'Beginner picoMini 2022', 1),
(3, 'picoCTF 2020 Mini-Competition', 2),
(4, 'picoCTF 2021', 2);
SELECT eventlist.*, classroom.*
FROM eventlist
JOIN classroom ON eventlist.classroomId = classroom.id;

-- Challenge table
DELETE FROM challenge;
INSERT INTO challenge (id, title, points, rating, solution, description, userId, eventlistId) VALUES
(1, 'Mod 26', 10, 0.91, 'picoCTF{example_solution1}', '{\"details\": \"Cryptography can be easy, do you know what ROT13 is?\", \"files\": []}', 1, 1),
(2, 'Nice netcat...', 15, 0.90, 'picoCTF{example_solution2}', '{\"details\": \"There is a nice program that you can talk to by using this command in a shell: $nc mercury.picoctf.net 35652, but it does not speak English\", \"files\": []}', 1, 1),
(3, 'GET aHead', 20, 0.81, 'picoCTF{example_solution3}', '{\"details\": \"Find the flag being held on this server to get ahead of the competition\", \"files\": [{\"type\": \"url\", \"value\": \"http://mercury.picoctf.net:53554\"}]}', 2, 3);
SELECT challenge.*, user.*, eventlist.*
FROM user
JOIN challenge ON challenge.userId = user.id
JOIN eventlist ON challenge.eventlistId = eventlist.id;

-- Category table
DELETE FROM category;
INSERT INTO category (id, type) VALUES (1, 'Web Exploitation'), (2, 'Cryptography'), (3, 'Reverse Engineering'),
(4, 'Forensics'), (5, 'General Skills'), (6, 'Binary Exploitation'), (7, 'Uncategorized');
SELECT * FROM category;

-- Category-challenge table
DELETE FROM `category-challenge`;
INSERT INTO `category-challenge` (categoryId, challengeId) VALUES
(2, 1), (5, 2), (1, 3), (5, 3);
SELECT challenge.*, category.*, `category-challenge`.*
FROM challenge
JOIN `category-challenge` ON `category-challenge`.challengeId = challenge.id
JOIN category ON `category-challenge`.categoryId = category.id;

-- Hint table
DELETE FROM hint;
INSERT INTO hint (id, description, challengeProblem, challengeId) VALUES
(1, 'This can be solved online if you dont want to do it by hand!', null, 1),
(2, 'You can practice using netcat with this picoGym problem:', 'what\'s a netcat?', 2),
(3, 'You can practice reading and writing ASCII with this picoGym problem:', 'Let\'s Warm Up', 2),
(4, 'Maybe you have more than 2 choices', null, 3),
(5, 'Check out tools like Burpsuite to modify your requests and look at the responses', null, 3);
SELECT challenge.*, hint.*
FROM challenge
JOIN hint ON hint.challengeId = challenge.id;

-- Author table
DELETE FROM author;
INSERT INTO author (id, firstName, lastName) VALUES
(1, 'Pandu', null),
(2, 'Syreal', null),
(3, 'Madstacks', null);
SELECT * FROM author;

-- Challenge-author table;
DELETE FROM `challenge-author`;
INSERT INTO `challenge-author` (challengeId, authorId) VALUES
(1, 1), (2, 2), (3, 3);
SELECT challenge.*, author.*, `challenge-author`.*
FROM challenge
JOIN `challenge-author` ON `challenge-author`.challengeId = challenge.id
JOIN author ON `challenge-author`.authorId = author.id;




