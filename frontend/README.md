# ♟ Boardgame Aficionados

A bold, colorful leaderboard & stats dashboard for tracking wins, losses, and game stats across Battleship, Blackjack, and Connect 4.

---

## Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Run the Server

```bash
# Production
npm start

# Development (auto-restarts on changes)
npm run dev
```

Visit: **http://localhost:3000**

---

## Pages

| Route | Description |
|---|---|
| `/` | Homepage — hero, game stats, top 3 players |
| `/leaderboard` | Full leaderboard, filterable by game & sort |
| `/player/:id` | Individual player profile with per-game stats |
| `/games` | Game library with tutorials |

## API Endpoints

| Endpoint | Description |
|---|---|
| `GET /api/users` | All users (passwords excluded) |
| `GET /api/leaderboard/:game` | Leaderboard for `battleship`, `blackjack`, or `connect_four` |
| `GET /api/player/:id` | Full stats for one player |
| `GET /api/stats/summary` | Aggregate stats across all games |

---

## Project Structure

```
boardgame-aficionados/
├── server.js              # Entry point, MongoDB connection, route mounting
├── .env                   # ← Put your MongoDB URI here
├── package.json
├── routes/
│   ├── index.js           # Homepage
│   ├── leaderboard.js     # Leaderboard page
│   ├── profile.js         # Player profile page
│   ├── games.js           # Games library
│   └── api.js             # JSON API endpoints
├── views/
│   ├── partials/
│   │   ├── header.ejs     # Nav + HTML head
│   │   └── footer.ejs     # Footer + scripts
│   ├── index.ejs
│   ├── leaderboard.ejs
│   ├── profile.ejs
│   ├── games.ejs
│   ├── 404.ejs
│   └── error.ejs
└── public/
    ├── css/main.css        # Full stylesheet
    └── js/main.js          # Client-side interactions
```

## Collections Expected in MongoDB

- `users` — player accounts & overall stats
- `battleship` — per-player Battleship stats
- `blackjack` — per-player Blackjack stats
- `connect_four` — per-player Connect 4 stats
- `games` — game metadata & tutorials

---

Built with **Node.js**, **Express**, **EJS**, and **MongoDB**.