# SafePassApp

A full-stack password manager built with Ruby on Rails 8. Stores and manages credentials with field-level encryption at rest, a Hotwire-powered SPA-like UI, and a JWT-authenticated JSON API.

## Tech Stack

- **Ruby** 3.3.4 / **Rails** 8.0.2
- **PostgreSQL** — database with Active Record Encryption for credentials at rest
- **Devise** — user authentication (web)
- **Hotwire** (Turbo + Stimulus) — reactive UI without a JavaScript framework
- **JWT** — stateless auth for the JSON API

## Features

- **User accounts** — registration, login, and password reset via Devise
- **Password entries** — create, read, update, and delete stored credentials (name, username, password, URL)
- **Encryption at rest** — `username` and `password` fields encrypted using Active Record Encryption
- **Live search** — filter entries by name with instant Turbo Stream updates
- **Inline editing** — edit individual fields in-place without full page reloads
- **Clipboard copy** — one-click copy for username and password
- **Password visibility toggle** — show/hide password in the detail view
- **JSON API** (`/api/v1`) — JWT-authenticated endpoints for programmatic access

## Getting Started

### Prerequisites

- Ruby 3.3.4
- PostgreSQL
- Node.js / Bun (for JS bundling)

### Setup

```bash
bundle install
bin/rails db:create db:migrate
bin/dev
```

The app will be available at `http://localhost:3000`.

### Seed data

Populate the database with sample entries (requires at least one existing user):

```bash
bin/rails db:seed
```

## JSON API

### Authentication

```
POST /api/v1/auth
Content-Type: application/json

{ "email": "user@example.com", "password": "yourpassword" }
```

Returns `{ "token": "<jwt>" }`. Pass the token as a Bearer token on subsequent requests:

```
Authorization: Bearer <jwt>
```

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `POST` | `/api/v1/auth` | Obtain a JWT |
| `GET` | `/api/v1/entries` | List all entries for the authenticated user |

> The API is intentionally read-only. Entry management (create, update, delete) is handled through the web UI. The API exists to serve the [companion browser extension](https://github.com/lauretteroy/safepass-extension), which only needs to read credentials.

## Project Structure

```
app/
├── controllers/
│   ├── api/v1/               # JWT-authenticated API controllers
│   └── entries_controller.rb
├── models/
│   ├── user.rb               # Devise auth + has_many :entries
│   └── entry.rb              # Encrypted fields, validations, search scope
├── services/
│   └── json_web_token.rb
└── javascript/controllers/
    ├── clipboard_controller.js
    ├── search_controller.js
    ├── toast_controller.js
    └── toggle_password_controller.js
```

## Roadmap

- [ ] Tests (models, controllers, system) *(in progress)*
- [ ] Rate limiting for authentication
- [ ] Password strength requirements
- [ ] Team / shared entries support
- [ ] Update seed file
- [ ] Add duckduckgo favicon lookup
