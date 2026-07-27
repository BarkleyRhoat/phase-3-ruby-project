# User Stories - Golf Score Tracker

## Feature 1 - Player Management

User story: As a user, I want to manage players so that I can add, view, update, and remove golfers from the tracker.

### Feature 1 Acceptance Criteria

- The CLI displays menu options to add, view, update, and delete players.
- Adding a player prompts for a name and saves the player to the database with a valid name.
- Viewing all players displays every saved player in a readable format.
- Updating a player displays the current name before asking for a new one.
- Deleting a player removes the selected player from the database.
- Empty states display a message when no players exist.

## Feature 2 - Course Management

User story: As a user, I want to manage courses so that I can add, view, update, and remove golf courses from the tracker.

### Feature 2 Acceptance Criteria

- The CLI displays menu options to add, view, update, and delete courses.
- Adding a course prompts for a name and par, then saves the course with valid values.
- Viewing all courses displays each course with its name and par.
- Updating a course displays the current name and par before asking for new values.
- Deleting a course removes the selected course from the database.
- Empty states display a message when no courses exist.

## Feature 3 - Round Management

User story: As a user, I want to manage rounds so that I can log, view, update, and remove golf scores for players and courses.

### Feature 3 Acceptance Criteria

- The CLI displays menu options to add, view, update, and delete rounds.
- Adding a round prompts the user to select an existing player and an existing course.
- Adding a round prompts for a score and a date, then saves the round with valid values.
- Viewing all rounds displays each round with the player name, course name, score, and date.
- Updating a round displays the current score and date before asking for new values.
- Deleting a round removes the selected round from the database.
- Empty states display a message when no rounds exist.

## Feature 4 - View Rounds by Association

User story: As a user, I want to view rounds by a specific player or course so that I can track progress and compare scores across visits.

### Feature 4 Acceptance Criteria

- The CLI displays a menu option to view rounds by a selected player.
- The CLI displays a menu option to view rounds by a selected course.
- Rounds by player are displayed with the course name, score, and date.
- Rounds by course are displayed with the player name, score, and date.
- If the selected player or course has no rounds, the user sees a message saying no rounds were found.

## Feature 5 - Validation and User Experience

User story: As a user, I want the application to validate my input and show clear messages so that I can fix mistakes and understand what I am changing.

### Feature 5 Acceptance Criteria

- The CLI uses Active Record validations to prevent invalid data from being saved.
- Invalid records are not saved to the database.
- The user sees a list of validation error messages explaining what went wrong.
- Update prompts display the current value before asking for a new value.
- The user can retry an action after seeing validation errors.
