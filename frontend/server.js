require("dotenv").config();
const express = require("express");
const { MongoClient } = require("mongodb");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;

// =============================================
// MONGODB CONNECTION
// Replace MONGODB_URI in your .env file with
// your actual MongoDB connection string.
// =============================================
const MONGODB_URI = process.env.MONGODB_URI;
const DB_NAME = process.env.DB_NAME || "boardgame_aficionados";

let db;

async function connectDB() {
  if (!MONGODB_URI || MONGODB_URI === "YOUR_MONGODB_URI_HERE") {
    console.warn(
      "\n⚠️  WARNING: No MongoDB URI set. Please update your .env file.\n" +
      "   Set MONGODB_URI to your MongoDB connection string.\n"
    );
    return;
  }
  try {
    const client = new MongoClient(MONGODB_URI);
    await client.connect();
    db = client.db(DB_NAME);
    console.log(`✅ Connected to MongoDB database: ${DB_NAME}`);
  } catch (err) {
    console.error("❌ MongoDB connection failed:", err.message);
  }
}

// Middleware to inject db into requests
app.use((req, res, next) => {
  req.db = db;
  next();
});

// View engine
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// Static files
app.use(express.static(path.join(__dirname, "public")));
app.use(express.json());

// =============================================
// ROUTES
// =============================================
const indexRouter = require("./routes/index");
const leaderboardRouter = require("./routes/leaderboard");
const profileRouter = require("./routes/profile");
const gamesRouter = require("./routes/games");
const apiRouter = require("./routes/api");

app.use("/", indexRouter);
app.use("/leaderboard", leaderboardRouter);
app.use("/player", profileRouter);
app.use("/games", gamesRouter);
app.use("/api", apiRouter);

// 404 handler
app.use((req, res) => {
  res.status(404).render("404", { title: "Page Not Found" });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).render("error", { title: "Server Error", error: err.message });
});

// Start server
connectDB().then(() => {
  app.listen(PORT, () => {
    console.log(`🎮 Boardgame Aficionados running on http://localhost:${PORT}`);
  });
});
