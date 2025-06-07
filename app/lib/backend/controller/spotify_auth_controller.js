const { default: axios } = require("axios");

const initiateSpotifyAuth = (req, res) => {
  try {
    const clientid = "846dd3afac5c4528aa4697e638e1431b";
    const redirecturl =
      "https://localhost:3000/transfer/api/spotify/auth/callback";

    const scope =
      "playlist-read-private playlist-read-collaborative user-read-private";

    const authurl =
      `https://accounts.spotify.com/authorize?` +
      `response_type=code&client_id=${client_id}` +
      `&scope=${encodeURIComponent(scope)}` +
      `&redirect_uri=${encodeURIComponent(redirect_uri)}`;

    res.redirect(authurl);
  } catch {
    console.log(e);
  }
};

const handleSpotifyAuth = async (req, res) => {
  const code = req.query.code;

  const redirecturl =
    "https://localhost:3000/transfer/api/spotify/auth/callback";

  try {
    const response = await axios.post(
      "https://accounts.spotify.com/api/token",
      new URLSearchParams({
        grant_type: "authorization_code",
        code,
        redirect_uri,
        client_id: process.env.SPOTIFY_CLIENT_ID,
        client_secret: process.env.SPOTIFY_CLIENT_SECRET,
      }),
      {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      }
    );

    const { accesstoken } = response.data;

    res.redirect(`myapp://auth/callback?token=${access_token}`);
  } catch {
    console.log(e);
  }
};

module.exports = {
  initiateSpotifyAuth,
  handleSpotifyAuth,
};
