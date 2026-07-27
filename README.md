# Phase 3 Project — Single-Script Active Record CLI

## Learning Goals

- Build a database-backed Ruby application using Active Record
- Design and interact with data models using object-oriented Ruby
- Implement a multi-class CLI frontend
- Practice working with migrations, associations, and validations

## Introduction

Congrats on getting through all the material for Phase 3! You've learned how to work with databases, design models with Active Record, and write object-oriented Ruby. Now it's time to bring those skills together into a full project.

This project will focus on building a Ruby command-line application that reads from and writes to a local SQLite3 database using Active Record — no web server required.

By the end of the project, you'll have a functioning CLI that lets users interact with your data by creating, viewing, updating, and deleting records from the terminal.

## Requirements

### Models

- At least two model classes using `ActiveRecord::Base`
- A one-to-many relationship (`has_many` / `belongs_to`)
- At least one model with validations
- Display associated data where appropriate (e.g. listing a parent record's associated children)

### CLI

- At least two Ruby classes (e.g. a `Menu` class and a model-specific helper)
- A loop or menu interface
- Ability to create, view, update, and delete records
- Update prompts should display the current value before asking for a new one

## Planning

- Plan out your features
- Develop user stories
  - "As [ a user ], I want [ to perform this action ] so that [ I can accomplish this goal ]."
  - Features should not need you there to explain them to users
  - Create a `user-stories.md` file and add your user stories there

## Project Pitches

Before you start working on your project, you'll pitch your project idea to your instructors for approval and feedback.

For your project pitch, you should include:

- The basic story of your application
- The core features of your MVP
- The data you plan to persist and how you will structure it
- Challenges you expect to face
- How you are meeting the requirements of the project

**MVP ASAP** — Focus on getting your minimum viable product working first!

## Example Project Domains

You could build a **Book Tracker** app:

- `Author` has many `Books`
- Users can:
  - Create a new book
  - List all books
  - Update book details
  - Delete a book
  - View books by a specific author

Or a **Workout Log**:

- `WorkoutSession` has many `Exercises`
- Users can:
  - Log a new workout
  - Add exercises
  - Update reps/weights
  - View or delete past workouts

## Getting Started

**Fork and clone** this repository to get started.

Install dependencies:

```bash
bundle install
```

Create and migrate the database:

```bash
bundle exec rake db:create
bundle exec rake db:migrate
```

Optionally seed the database with starter data:

```bash
bundle exec rake seed
```

Run your CLI application:

```bash
ruby cli/main.rb
```

## Other Useful Commands

Open a Pry console with your models loaded:

```bash
bundle exec rake console
```

Generate a new migration:

```bash
bundle exec rake db:create_migration NAME=create_books
```

## Project Structure

```
├── app/
│   └── models/         # Your Active Record model classes go here
├── cli/
│   └── main.rb         # Entry point — your CLI menu lives here
├── config/
│   └── environment.rb  # Loads gems, DB connection, and models
├── db/
│   ├── config.yml      # Database connection settings
│   ├── migrate/        # Migration files
│   └── seeds.rb        # Seed data
└── spec/               # RSpec tests (optional)
```

## Project Tips

- Sketch your domain model first using [dbdiagram.io](https://dbdiagram.io/)
- Use `bundle exec rake console` to test your models before building the CLI
- Use `binding.pry` for debugging
- Use `puts` and `pp` or gems like `tty-table` for formatted CLI output

## Sample Project

A complete implementation is available on the `sample-project` branch. It demonstrates:

- **Pet Tracker** domain with Owners and Pets
- Full CRUD with Active Record and a clean menu-driven CLI
- Object-oriented design with user-friendly output
- All required features including current value prompts for updates

To view the sample:

```bash
git checkout sample-project
```

See `SAMPLE_PROJECT_README.md` for detailed documentation.

## Resources

- [dbdiagram.io](https://dbdiagram.io/)
- [Active Record Basics](https://guides.rubyonrails.org/active_record_basics.html)
- [Active Record Associations](https://guides.rubyonrails.org/association_basics.html)
- [Active Record Validations](https://guides.rubyonrails.org/active_record_validations.html)
