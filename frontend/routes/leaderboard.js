const express = require("express");
const router = express.Router();

router.get("/", async (req, res) => {
  const db = req.db;
  const game = req.query.game || "overall";
  const sort = req.query.sort || "ratio";

  let players = [];
  let dbConnected = !!db;

  try {
    if (db) {
      const users = await db.collection("users").find({}).toArray();

      if (game === "overall") {
        players = users
          .map((u) => ({
            id: u.id,
            username: u.username,
            display_name: u.display_name,
            wins: u.total_wins,
            losses: u.total_losses,
            ratio: u.total_ratio,
            games_played: u.total_wins + u.total_losses,
          }))
          .sort((a, b) => b[sort] - a[sort]);
      } else {
        const collectionMap = {
          battleship: "battleship",
          blackjack: "blackjack",
          connect_four: "connect_four",
        };
        const col = collectionMap[game];
        if (col) {
          const gameData = await db.collection(col).find({}).toArray();
          players = gameData
            .map((g) => {
              const user = users.find((u) => u.id === g.user_id);
              return {
                id: g.user_id,
                username: user ? user.username : `user_${g.user_id}`,
                display_name: user ? user.display_name : `User ${g.user_id}`,
                wins: g.wins,
                losses: g.losses,
                ratio: g.ratio,
                games_played: g.wins + g.losses,
                extra: g,
              };
            })
            .sort((a, b) => b[sort] - a[sort]);
        }
      }
    }
  } catch (err) {
    console.error("Leaderboard error:", err.message);
  }

  res.render("leaderboard", {
    title: "Leaderboard",
    players,
    game,
    sort,
    dbConnected,
  });
});

module.exports = router;
