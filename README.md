# Phase 3 Project — Single-Script Active Record CLI

## Overview

This project uses **Active Record** and **SQLite3** to build a command-line application that reads from and writes to a local database — no web server required.

Your app will:
- Define at least two models with a one-to-many relationship
- Use Active Record for all database interactions (no raw SQL needed)
- Present a menu-driven CLI that lets users create, view, update, and delete records

## Setup

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

## Running the App

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
│   ├── database.yml    # Database connection settings
│   └── environment.rb  # Loads gems, DB connection, and models
├── db/
│   ├── migrate/        # Migration files
│   └── seeds.rb        # Seed data
└── spec/               # RSpec tests (optional)
```

## Requirements

### Models
- At least two model classes using `ActiveRecord::Base`
- A one-to-many relationship (`has_many` / `belongs_to`)
- At least one model with validations

### CLI
- At least two Ruby classes (e.g. a `Menu` class and a model-specific helper)
- A loop or menu interface
- Ability to create, view, update, and delete records
- Update prompts should display the current value before asking for a new one

### Planning
- Write user stories in `user-stories.md` before building
- Pitch your project domain to your instructor before starting
