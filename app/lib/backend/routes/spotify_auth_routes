const express = require("express");
const router = express.Router();
const {
  initiateSpotifyAuth,
  handleSpotifyAuth,
} = require("../controller/spotify_auth_controller");

router.get("/transfer/api/spotify/auth", initiateSpotifyAuth);

router.get("/transfer/api/spotify/auth/callback", handleSpotifyAuth);

module.exports = router;
