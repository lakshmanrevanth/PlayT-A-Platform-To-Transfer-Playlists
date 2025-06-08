const mongoose = require("mongoose");

const spotifyUserToken = new mongoose.Schema(
  {
    accessToken: String,
    refreshToken: String,
    expiryAt: Date,
  },
  { _id: false }
);

const userSchema = new mongoose.Schema({
  username: String,
  email: String,
  password: String,
  spotifytoken: {
    type: spotifyUserToken,
    default: null,
  },
});

const User = mongoose.model("users", userSchema);

module.exports = User;
