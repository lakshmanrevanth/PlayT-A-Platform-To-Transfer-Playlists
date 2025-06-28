const { default: axios } = require("axios");
const { default: mongoose } = require("mongoose");
const User = require("../models/auth_model");

const initiateSpotifyAuth = (req, res) => {
  try {
    console.log("initiate spotify auth is working");
    const clientid = "846dd3afac5c4528aa4697e638e1431b";
    const redirecturl =
      "https://playt-a-platform-to-transfer-playlists.onrender.com/transfer/api/spotify/auth/callback";

    const scope =
      "playlist-read-private playlist-read-collaborative user-read-private";

    const authurl =
      `https://accounts.spotify.com/authorize?` +
      `response_type=code&client_id=${clientid}` +
      `&scope=${encodeURIComponent(scope)}` +
      `&redirect_uri=${encodeURIComponent(redirecturl)}`;
    console.log("initiate spotify auth is completed");

    res.redirect(authurl);
    console.log("res is initiated");
  } catch {
    console.log("hello this funtion not working...");
    console.log(e);
  }
};

const handleSpotifyAuth = async (req, res) => {
  console.log("handle function is initiated");
  const code = req.query.code;

  const redirect_uri =
    "https://playt-a-platform-to-transfer-playlists.onrender.com/transfer/api/spotify/auth/callback";

  try {
    const response = await axios.post(
      "https://accounts.spotify.com/api/token",
      new URLSearchParams({
        grant_type: "authorization_code",
        code,
        redirect_uri,
        client_id: "846dd3afac5c4528aa4697e638e1431b",
        client_secret: "fdbdbe732c9d4d25a5ea1b64a9a7c8a7",
      }),
      {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      }
    );

    const { access_token, refresh_token, expiry_in } = response.data;

    const expiryAt = new Date(Date.now() + expiry_in * 1000);

    console.log(access_token);

    res.redirect(
      `myapp://auth/callback?accessToken=${access_token}&refreshToken=${refresh_token}&expiryAt=${expiryAt.toISOString()}`
    );
  } catch (e) {
    console.log(e);
    res.status(500).send("Error during Spotify authentication");
  }
};

const saveTokenInDatabase = async (req, res) => {
  try {
    const { accessToken, refreshToken, expiryAt, username } = req.body;

    const finduser = await User.findOne({ username });

    if (!finduser) {
      console.log("username does not exists");
      res.status(404).json({
        message: "user does not exists",
      });
    }
    finduser.spotifytoken = {
      accessToken,
      refreshToken,
      expiryAt: new Date(expiryAt),
    };

    await finduser.save();

    console.log(finduser.spotifytoken);

    res.status(200).json({
      message: "successfully updated",
    });
  } catch (e) {
    console.log(e);
  }
};

module.exports = {
  initiateSpotifyAuth,
  handleSpotifyAuth,
  saveTokenInDatabase,
};
