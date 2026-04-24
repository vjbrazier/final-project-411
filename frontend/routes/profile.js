const express = require("express");
const router = express.Router();

router.get("/:id", async (req, res) => {
  const db = req.db;
  const userId = parseInt(req.params.id);
  let dbConnected = !!db;

  try {
    if (!db) return res.render("profile", { title: "Profile", player: null, dbConnected });

    const user = await db.collection("users").findOne({ id: userId });
    if (!user) return res.status(404).render("404", { title: "Player Not Found" });

    const [bsData, bjData, c4Data] = await Promise.all([
      db.collection("battleship").findOne({ user_id: userId }),
      db.collection("blackjack").findOne({ user_id: userId }),
      db.collection("connect_four").findOne({ user_id: userId }),
    ]);

    // Compute accuracy for battleship
    let bsAccuracy = 0;
    if (bsData && bsData.total_shots > 0) {
      bsAccuracy = ((bsData.shots_hit / bsData.total_shots) * 100).toFixed(1);
    }

    // Hit vs stand tendency for blackjack
    let bjHitRate = 0;
    if (bjData) {
      const bjTotal = bjData.hits + bjData.stands;
      if (bjTotal > 0) bjHitRate = ((bjData.hits / bjTotal) * 100).toFixed(1);
    }

    const player = {
      ...user,
      battleship: bsData ? { ...bsData, accuracy: bsAccuracy } : null,
      blackjack: bjData ? { ...bjData, hit_rate: bjHitRate } : null,
      connect_four: c4Data || null,
    };

    res.render("profile", { title: `${user.display_name}'s Profile`, player, dbConnected });
  } catch (err) {
    console.error("Profile error:", err.message);
    res.render("profile", { title: "Profile", player: null, dbConnected });
  }
});

module.exports = router;
