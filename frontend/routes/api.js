const express = require("express");
const router = express.Router();

// GET /api/users
router.get("/users", async (req, res) => {
  try {
    if (!req.db) return res.json({ error: "Database not connected" });
    const users = await req.db.collection("users").find({}, { projection: { password: 0 } }).toArray();
    res.json(users);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /api/leaderboard/:game
router.get("/leaderboard/:game", async (req, res) => {
  const { game } = req.params;
  const validGames = ["battleship", "blackjack", "connect_four"];
  if (!validGames.includes(game)) return res.status(400).json({ error: "Invalid game" });

  try {
    if (!req.db) return res.json({ error: "Database not connected" });
    const data = await req.db.collection(game).find({}).sort({ ratio: -1 }).toArray();
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /api/player/:id
router.get("/player/:id", async (req, res) => {
  const userId = parseInt(req.params.id);
  try {
    if (!req.db) return res.json({ error: "Database not connected" });
    const user = await req.db.collection("users").findOne({ id: userId }, { projection: { password: 0 } });
    if (!user) return res.status(404).json({ error: "Player not found" });
    const [bs, bj, c4] = await Promise.all([
      req.db.collection("battleship").findOne({ user_id: userId }),
      req.db.collection("blackjack").findOne({ user_id: userId }),
      req.db.collection("connect_four").findOne({ user_id: userId }),
    ]);
    res.json({ user, battleship: bs, blackjack: bj, connect_four: c4 });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /api/stats/summary
router.get("/stats/summary", async (req, res) => {
  try {
    if (!req.db) return res.json({ error: "Database not connected" });
    const [users, bs, bj, c4] = await Promise.all([
      req.db.collection("users").find({}).toArray(),
      req.db.collection("battleship").find({}).toArray(),
      req.db.collection("blackjack").find({}).toArray(),
      req.db.collection("connect_four").find({}).toArray(),
    ]);
    const summary = {
      total_players: users.length,
      total_games_played:
        bs.reduce((a, u) => a + u.wins + u.losses, 0) +
        bj.reduce((a, u) => a + u.wins + u.losses, 0) +
        c4.reduce((a, u) => a + u.wins + u.losses, 0),
      battleship_games: bs.reduce((a, u) => a + u.wins + u.losses, 0),
      blackjack_games: bj.reduce((a, u) => a + u.wins + u.losses, 0),
      connect_four_games: c4.reduce((a, u) => a + u.wins + u.losses, 0),
    };
    res.json(summary);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
