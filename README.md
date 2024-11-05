# Game of Life

A web implementation of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) built with Ruby on Rails.

> [!NOTE]
> A live demo can be found at [gol.mattia-malnis.dev](https://gol.mattia-malnis.dev/)

## Description

The Game of Life is a cellular automaton that simulates the evolution of a population of cells according to simple mathematical rules. This implementation allows you to:

- Load an initial configuration from a file
- Create a configuration manually
- Watch the evolution generation by generation
- Save and share configurations

## Local Development Setup

### Requirements

* Ruby 3.3.5 (see .ruby-version file)
* PostgreSQL 16+

### Installation

1. Clone the repository
2. Run `bundle install` to install dependencies
3. Run `bin/setup` to prepare the database
4. Execute `bin/dev` to start the development server
5. Visit `http://localhost:3000`

## Features

### Configuration Input

You can initialize a new simulation in two ways:

1. **File Upload**: Load a text file with the initial configuration
2. **Direct Input**: Create a matrix directly through the web interface

### File Format

The input file must specify:
- Current generation number
- Grid dimensions
- Population state using:
  - `*` for live cells
  - `.` for dead cells

Example of a valid input file:

```
Generation 1:
4 8
..**....
....*...
...*.*..
.....***
```

## Testing

Test the application with RSpec by running the command `bundle exec rspec`.

## Screenshots

![immagine](https://github.com/user-attachments/assets/c3981ecd-294a-4a6f-b208-e8f3f4fb52b2)

---

![immagine](https://github.com/user-attachments/assets/8a5a3efe-1914-460f-a4f8-faa27c6346f4)

---

https://github.com/user-attachments/assets/b375eb9a-c3ed-4278-b22f-6dbc5f9ce772

