const express = require("express");
const router = express.Router();
const {
  initiateSpotifyAuth,
  handleSpotifyAuth,
  saveTokenInDatabase,
} = require("../controller/spotify_auth_controller");

router.get("/transfer/api/spotify/auth", initiateSpotifyAuth);

router.get("/transfer/api/spotify/auth/callback", handleSpotifyAuth);

router.get("/transfer/api/spotify/auth/user/token/store", saveTokenInDatabase);

module.exports = router;
