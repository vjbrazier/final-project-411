const express = require("express");
const router = express.Router();

router.get("/", async (req, res) => {
  const db = req.db;
  let games = [];
  let dbConnected = !!db;

  try {
    if (db) {
      games = await db.collection("games").find({}).sort({ id: 1 }).toArray();
    }
  } catch (err) {
    console.error("Games error:", err.message);
  }

  res.render("games", { title: "Games", games, dbConnected });
});

module.exports = router;
