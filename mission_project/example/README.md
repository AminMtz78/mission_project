# Mission Management App (Flutter + GetX)

A mission management application built with **Flutter** using **GetX** for state management and **JSON Server** as a mock backend.

## Features
- Role-based access (Admin / User)
- Create, edit, and manage missions
- Mission status handling (Free, In Progress, Done, Expired)
- Dynamic filtering:
    - Price range
    - Status
    - Deadline sorting
    - Tag-based filtering
- Tag management and selection using chips
- Mission requests and request count per mission
- Reactive UI with GetX (`Obx`)
- Clean MVC-style architecture

## Tech Stack
- Flutter
- GetX
- JSON Server
- RESTful API

## Project Structure
- Controllers handle business logic
- Repositories manage API communication
- Views are fully reactive and UI-focused

## How to Run
1. Run JSON Server:
```bash
json-server --watch db.json 
