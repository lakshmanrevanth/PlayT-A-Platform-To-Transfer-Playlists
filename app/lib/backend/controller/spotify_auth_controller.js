const { default: axios } = require("axios");

const initiateSpotifyAuth = (req, res) => {
  try {
    console.log("initiate spotify auth is working");
    const clientid = "846dd3afac5c4528aa4697e638e1431b";
    const redirecturl =
      "https://playt-a-platform-to-transfer-playlists.onrender.com/Play-T/transfer/api/spotify/auth/callback";

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
    "https://playt-a-platform-to-transfer-playlists.onrender.com/Play-T/transfer/api/spotify/auth/callback";

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

    const { access_token } = response.data;

    console.log(access_token);

    res.redirect(`myapp://auth/callback?token=${access_token}`);
  } catch (e) {
    console.log(e);
    res.status(500).send("Error during Spotify authentication");
  }
};

module.exports = {
  initiateSpotifyAuth,
  handleSpotifyAuth,
};
