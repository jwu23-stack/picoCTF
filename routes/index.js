var express = require('express');
var router = express.Router();
var db = require('../db')

router.get('/', function (req, res, next) {
  res.send(`Yes I am working!`);
});

router.get('/showTables', (req, res, next) => {
  try {
    let query = "show tables;"
    db.executeQueryAsPromise(query, null)
      .then((queryResults) => {
        if (queryResults.length == 0) {
          queryResults = "No results found"
        }
        res.send(queryResults)
      }).catch((err) => { next(err) })
  }
  catch (err) { next(err) }
})

//************************************ */
//************CREATE ROUTES*********** */
//************************************ */

router.post("/addOrUpdateUser", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `user` (id, `name`, `ageGroup`, `email`, `countryOfResidence`, `gender`, `profileAvatar`, `schoolInfo`) VALUES \
    (?, ?, ?, ?, ?, ?, ?, ?) \
    ON DUPLICATE KEY UPDATE name = VALUES(name), ageGroup = VALUES(ageGroup), email = VALUES(email), countryOfResidence = VALUES(countryOfResidence), \
    gender = VALUES(gender), profileAvatar = VALUES(profileAvatar), schoolInfo = VALUES(schoolInfo);\
    \
    SELECT * FROM `user`"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateChallenge", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `challenge` (id, `title`, `points`, `rating`, `solution`, `description`, userId, eventlistId) VALUES \
    (?, ?, ?, ?, ?, ?, ?, ?) \
    ON DUPLICATE KEY UPDATE title = VALUES(title), points = VALUES(points), rating = VALUES(rating), solution = VALUES(solution), \
    description = VALUES(description), userId = VALUES(userId), eventlistId = VALUES(eventlistId);\
    \
    SELECT * FROM challenge;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateClassroom", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `classroom` (id, `name`, `inviteCode`, `setting`, userId) VALUES \
    (?, ?, ?, ?, ?) \
    ON DUPLICATE KEY UPDATE name = VALUES(name), inviteCode = VALUES(inviteCode), setting = VALUES(setting), userId = VALUES(userId);\
    \
    SELECT * FROM classroom;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateEventlist", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `eventlist` (id, `title`, classroomId) VALUES \
    (?, ?, ?) \
    ON DUPLICATE KEY UPDATE title = VALUES(title), classroomId = VALUES(classroomId);\
    \
    SELECT * FROM eventlist;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateHint", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `hint` (id, `description`, `challengeProblem`, challengeId) VALUES \
    (?, ?, ?, ?) \
    ON DUPLICATE KEY UPDATE description = VALUES(description), challengeProblem = VALUES(challengeProblem), challengeId = VALUES(challengeId);\
    \
    SELECT * FROM hint;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

//************************************ */
//*********RETRIEVE ROUTES************ */
//************************************ */
//Select queries can be done as gets

router.get('/getEventlistChallenges/:eventlistId', (req, res, next) => {
  const inputs = [req.params.eventlistId]
  const query = "\
    SELECT eventlist.id AS `Event list Id`, eventlist.title AS `Event list title`, challenge.id AS `Challenge Id`, challenge.points AS `Points`, \
          challenge.solved AS `Solved`, challenge.bookmark AS `Bookmarked`, challenge.attemptsMade AS `Total made attempts`, \
          challenge.rating AS `Challenge rating` \
    FROM eventlist\
    JOIN challenge ON challenge.eventlistId = eventlist.id\
    WHERE eventlist.id = ?;"
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})

router.get('/getClassroomUsers/:classroomId', (req, res, next) => {
  const inputs = [req.params.classroomId]
  const query = "\
    SELECT classroom.id AS `Classroom Id`, classroom.name AS `Classroom name`, classroom.inviteCode AS `Classroom invite code`, \
           user.id AS `User Id`, user.name AS `User's Name`, user.ageGroup AS `User's age group`, user.gender AS `User's gender`, \
           `user-classroom`.role AS `User's role in classroom` \
    FROM classroom\
    JOIN `user-classroom` ON `user-classroom`.classroomId = classroom.id\
    JOIN user ON user.id = `user-classroom`.userId\
    WHERE classroom.id = ?;"
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})

router.get('/getChallenge/:challengeId', (req, res, next) => {
  const challengeId = req.params.challengeId
  const inputs = [challengeId, challengeId, challengeId, challengeId, challengeId, challengeId]
  const query = "\
    SELECT * FROM challenge WHERE id = ?;\
    \
    SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, hint.id AS `Hint Id`, \
	         hint.description AS `Hint description`, hint.challengeProblem AS `Referenced challenge` \
    FROM challenge\
    JOIN hint ON hint.challengeId = challenge.id\
    WHERE challenge.id = ?;\
    \
    SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, author.id AS `Author Id`, \
	         CONCAT(author.firstName, ' ', COALESCE(author.lastName, '')) AS `Author's Name` \
    FROM challenge\
    JOIN `challenge-author` ON `challenge-author`.challengeId = challenge.id\
    JOIN author ON author.id = `challenge-author`.authorId\
    WHERE challenge.id = ?;\
    \
    SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, category.id AS `Category Id`, \
	         category.type AS `Category type` \
    FROM challenge\
    JOIN `category-challenge` ON `category-challenge`.challengeId = challenge.id\
    JOIN category ON category.id = `category-challenge`.categoryId\
    WHERE challenge.id = ?;\
    \
    SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, user.id AS `User Id`, \
	         user.name AS `User's name` \
    FROM challenge\
    JOIN user ON user.id = challenge.userId\
    WHERE challenge.id = ?;\
    \
    SELECT challenge.id AS `Challenge Id`, challenge.title AS `Challenge title`, eventlist.id AS `Event list Id`, \
           eventlist.title AS `Event list title` \
    FROM challenge\
    JOIN eventlist ON eventlist.id = challenge.eventlistId\
    WHERE challenge.id = ?;"
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})

//************************************ */
//***********UPDATE ROUTES************ */
//************************************ */
//Update queries can be done as posts

router.post("/updateBookmark", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
      UPDATE challenge SET `bookmark` = ? WHERE id = ?; \
      \
      SELECT * FROM challenge;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/updateSolved", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
      UPDATE challenge SET `solved` = ? WHERE id = ?; \
      \
      SELECT * FROM challenge;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/updateAttemptsMade", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
      UPDATE challenge SET `attemptsMade` = `attemptsMade` + 1 WHERE id = ?; \
      \
      SELECT * FROM challenge;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/updateClassroomInviteCode", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
      UPDATE classroom SET `inviteCode` = ? WHERE id = ?; \
      \
      SELECT * FROM classroom;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

//************************************ */
//***********DELETE ROUTES*********** */
//************************************ */

router.post("/deleteUser", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
      DELETE FROM user WHERE id = ?; \
      \
      SELECT * FROM user;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deleteChallenge", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
      DELETE FROM challenge WHERE id = ?; \
      \
      SELECT * FROM challenge;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deleteClassroom", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
      DELETE FROM classroom WHERE id = ?; \
      \
      SELECT * FROM classroom;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deleteEventlist", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
      DELETE FROM eventlist WHERE id = ?; \
      \
      SELECT * FROM eventlist;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})


//************************************ */
//***********GENERIC ROUTES*********** */
//************************************ */
//These routes take care of any calls you make that are spelled wrong or have the wrong type
//No need to mess with them unless you are an experienced programmer

router.get('/*', (req, res, next) => {
  res.send(`The route you used:${req.originalUrl} was not found. Was it supposed to be a POST?`)
})
router.post('/*', (req, res, next) => {
  res.send(`The route you used:${req.originalUrl} was not found. Was it supposed to be a GET?`)
})


//************************************ */
//***********SUPPORTING CODES********* */
//************************************ */
//This code is used by the routes.
//No need to mess with it unless you are an experienced programmer

function rowsToHtmlTable(results) {
  const tableStyle = '"border:1px solid black;padding:5px"'
  const cellStyle = '"border:1px solid black;padding:5px"'
  const cellStyleFirstRow = '"font-weight:600"'
  const htmlRows = results.map((row, index) => {
    const columns = Object.keys(row).map((columnName) => {
      return { columnName, columnValue: row[columnName] }
    })
    let htmlColumns = null
    if (index == 0) {
      htmlColumns = columns.map((column) => {
        return `<th style=${cellStyleFirstRow}>${column.columnName}</th>`
      })
    } else {
      htmlColumns = columns.map((column) => {
        return `<td style=${cellStyle}>${column.columnValue}</td>`
      })
    }
    return `<tr>${htmlColumns.join("")}</tr>`
  })
  return `<table style=${tableStyle}>${htmlRows.join("")}</table>`
}

function validateAndFormatInputs(inputs) {
  let results = { inputsAreValid: true, validations: [], placeholders: [] }
  if (typeof (inputs) !== "object") {
    results.inputsAreValid = false
    results.validations.push({ error: true, message: `Expecting an object, got: ${typeof (inputs)}` })
  }
  Object.keys(inputs).forEach((input) => {
    let valueOfInput = inputs[input]
    switch (input) {
      //add a case for any input that you want to validate
      case "id":
        if (valueOfInput != null && !Number.isInteger(valueOfInput)) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `In id value expecting null or an integer, got: ${valueOfInput}` })
        }
        break
      case "dateAdded":
        if (valueOfInput === "*fillInCurrentDate*") valueOfInput = mysqlTimestamp()
        if (isNaN(Date.parse(valueOfInput))) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `This is not a valid date: ${valueOfInput}` })
        }
        break
      case "email":
        if (!valueOfInput.includes("@")) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `There needs to be an @ in your email input, got: ${valueOfInput}` })
        }
        break
    }
    results.placeholders.push(valueOfInput)
  })
  return results
}

mysqlTimestamp = () => {
  var date = new Date(Date.now());
  var yyyy = date.getFullYear();
  var mm = date.getMonth() + 1;
  var dd = date.getDate();
  var hh = date.getHours();
  var min = date.getMinutes();
  var ss = date.getSeconds();
  var mysqlDateTime = yyyy + '-' + mm + '-' + dd + ' ' + hh + ':' + min + ':' + ss;
  return mysqlDateTime;
}
module.exports = router;
