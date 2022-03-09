-- ***********************
-- Create (INSERT) Queries
-- ***********************

-- addOrUpdateUser
-- What it does: insert or update user table
SELECT * FROM user;
INSERT INTO `user` (id, `name`, `ageGroup`, `email`, `countryOfResidence`, `gender`, `profileAvatar`, `schoolInfo`) VALUES
(6, 'Bob', '18+', 'bob@gmail.com', 'USA', 'Male', 'avatar6.jpg', null)
ON DUPLICATE KEY UPDATE name = VALUES(name), ageGroup = VALUES(ageGroup), email = VALUES(email), countryOfResidence = VALUES(countryOfResidence), 
gender = VALUES(gender), profileAvatar = VALUES(profileAvatar), schoolInfo = VALUES(schoolInfo);
SELECT * FROM user;

-- addOrUpdateChallenge
-- What it does: insert or update challenge table
SELECT * FROM challenge;
INSERT INTO `challenge` (id, `title`, `points`, `rating`, `solution`, `description`, userId, eventlistId) VALUES
(4, 'information', 10, 0.44, 'picoCTF{example_solution4}', '{\"details\": \"Files can always be changed in a secret way. Can you find the flag?\", \"files\": [{\"type\": \"jpg\", \"value\": \"cat.jpg\"}]}', 1, 1)
ON DUPLICATE KEY UPDATE title = VALUES(title), points = VALUES(points), rating = VALUES(rating), solution = VALUES(solution), 
description = VALUES(description), userId = VALUES(userId), eventlistId = VALUES(eventlistId);
SELECT * FROM challenge;

-- addOrUpdateClassroom
-- What it does: insert or update classroom table
SELECT * FROM classroom;
INSERT INTO `classroom` (id, `name`, `inviteCode`, `setting`, userId) VALUES 
(6, 'Example classroom', 'xyzabc123', '[{\"name\": \"Update Classroom Name\", \"value\": \"example1\"}, {\"name\": \"Change invite code\", \"value\": \"example2\"}, {\"name\": \"Batch Register Users\", \"value\": \"example3\"}]', 5)
ON DUPLICATE KEY UPDATE name = VALUES(name), inviteCode = VALUES(inviteCode), setting = VALUES(setting), userId = VALUES(userId);
SELECT * FROM classroom;

-- addOrUpdateEventlist
-- What it does: insert or update eventlist table
SELECT * FROM eventlist;
INSERT INTO `eventlist` (id, `title`, classroomId) VALUES
(5, 'picoCTF 2019', 1)
ON DUPLICATE KEY UPDATE title = VALUES(title), classroomId = VALUES(classroomId);
SELECT * FROM eventlist;

-- addOrUpdateHint
-- What it does: insert or update hint table
SELECT * FROM hint;
INSERT INTO `hint` (id, `description`, `challengeProblem`, challengeId) VALUES
(6, 'Look at the details of the file', null, 4)
ON DUPLICATE KEY UPDATE description = VALUES(description), challengeProblem = VALUES(challengeProblem), challengeId = VALUES(challengeId);
SELECT * FROM hint;

-- *************************
-- Retireve (SELECT) Queries
-- *************************

-- getEventlistChallenges
-- What it does: select all the challenges on an event list
SELECT eventlist.id AS `Event list Id`, eventlist.title AS `Event list title`, challenge.id AS `Challenge Id`, challenge.points AS `Points`,
       challenge.solved AS `Solved`, challenge.bookmark AS `Bookmarked`, challenge.attemptsMade AS `Total made attempts`, 
       challenge.rating AS `Challenge rating`
FROM eventlist
JOIN challenge ON challenge.eventlistId = eventlist.id
WHERE eventlist.id = 1;

-- getClassroomUsers
-- What it does: select all the users in a classroom
SELECT classroom.id AS `Classroom Id`, classroom.name AS `Classroom name`, classroom.inviteCode AS `Classroom invite code`,
	   user.id AS `User Id`, user.name AS `User's Name`, user.ageGroup AS `User's age group`, user.gender AS `User's gender`,
       `user-classroom`.role AS `User's role in classroom`
FROM classroom
JOIN `user-classroom` ON `user-classroom`.classroomId = classroom.id
JOIN user ON user.id = `user-classroom`.userId
WHERE classroom.id = 5;

-- getChallenge
-- What it does: select all the data in a challenge and its related tables

-- the challenge
SELECT * FROM challenge WHERE id = 1;

-- the hints for the challenge
SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, hint.id AS `Hint Id`, 
	   hint.description AS `Hint description`, hint.challengeProblem AS `Referenced challenge`
FROM challenge
JOIN hint ON hint.challengeId = challenge.id
WHERE challenge.id = 1;

-- the authors of the challenge
SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, author.id AS `Author Id`,
	   CONCAT(author.firstName, ' ', COALESCE(author.lastName, '')) AS `Author's Name`
FROM challenge
JOIN `challenge-author` ON `challenge-author`.challengeId = challenge.id
JOIN author ON author.id = `challenge-author`.authorId
WHERE challenge.id = 1;

-- the categories of the challenge
SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, category.id AS `Category Id`,
	   category.type AS `Category type`
FROM challenge
JOIN `category-challenge` ON `category-challenge`.challengeId = challenge.id
JOIN category ON category.id = `category-challenge`.categoryId
WHERE challenge.id = 1;

-- the user of the challenge
SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, user.id AS `User Id`,
	   user.name AS `User's name`
FROM challenge
JOIN user ON user.id = challenge.userId
WHERE challenge.id = 1;

-- the evenlist of the challenge
SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, eventlist.id AS `Event list Id`,
       eventlist.title AS `Event list title`
FROM challenge
JOIN eventlist ON eventlist.id = challenge.eventlistId
WHERE challenge.id = 1;

-- *****************
-- Update Queries
-- *****************

-- updateBookmark
-- What it does: Update the bookmark column of a challenge row
SELECT * FROM challenge;
UPDATE challenge SET `bookmark` = 1 WHERE id = 1;
SELECT * FROM challenge;

-- updateSolved
-- What it does: Update the solved column of a challenge row
SELECT * FROM challenge;
UPDATE challenge SET `solved` = 1 WHERE id = 1;
SELECT * FROM challenge;

-- updateAttemptsMade
-- What it does: Update the attemptsMade column of a challenge row
SELECT * FROM challenge;
UPDATE challenge SET `attemptsMade` = `attemptsMade` + 1 WHERE id = 1;
SELECT * FROM challenge;

-- updateClassroomInviteCode
-- What it does: Update the inviteCode column of a classroom row
SELECT * FROM classroom;
UPDATE classroom SET `inviteCode` = 'abcdef123' WHERE id = 5;
SELECT * FROM classroom;

-- *****************
-- Delete Queries
-- *****************

-- deleteUser
-- What it does: Delete a user row
SELECT * FROM user;
DELETE FROM user WHERE id = 1;
SELECT * FROM user;

-- deleteChallenge
-- What it does: Delete a challenge row
SELECT * FROM challenge;
DELETE FROM challenge WHERE id = 1;
SELECT * FROM challenge;

-- deleteClassroom
-- What it does: Delete a classroom row
SELECT * FROM classroom;
DELETE FROM classroom WHERE id = 1;
SELECT * FROM classroom;

-- deleteEventlist
-- What it does: Delete a eventlist row
SELECT * FROM eventlist;
DELETE FROM eventlist WHERE id = 1;
SELECT * FROM eventlist;





		




