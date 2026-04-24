const express = require("express");
const router = express.Router();

router.get("/", async (req, res) => {
  const db = req.db;
  let topPlayers = [];
  let gameStats = {};
  let dbConnected = !!db;

  try {
    if (db) {
      // Top 3 overall players by ratio
      topPlayers = await db
        .collection("users")
        .find({ total_wins: { $gt: 0 } })
        .sort({ total_ratio: -1 })
        .limit(3)
        .toArray();

      // Count games played per game type
      const [bsStats, bjStats, c4Stats] = await Promise.all([
        db.collection("battleship").find({}).toArray(),
        db.collection("blackjack").find({}).toArray(),
        db.collection("connect_four").find({}).toArray(),
      ]);

      gameStats = {
        battleship: bsStats.reduce((a, u) => a + u.wins + u.losses, 0),
        blackjack: bjStats.reduce((a, u) => a + u.wins + u.losses, 0),
        connect_four: c4Stats.reduce((a, u) => a + u.wins + u.losses, 0),
      };
    }
  } catch (err) {
    console.error("Route error:", err.message);
  }

  res.render("index", {
    title: "Home",
    topPlayers,
    gameStats,
    dbConnected,
  });
});

module.exports = router;
