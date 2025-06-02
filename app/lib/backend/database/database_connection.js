// // const dotenv = require("dotenv");
// dotenv.config();
const mongoose = require("mongoose");
const mongooseURL =
  "mongodb+srv://revanth3527:1ddZ0WGehoicnLFs@cluster0.8gqzbr2.mongodb.net/";

const dbconnection = async () => {
  try {
    const connection = await mongoose.connect(mongooseURL);
    if (connection) {
      console.log("database connection has succeded");
    }
  } catch (e) {
    console.log(e);
    console.log("database connection has failed TRY AGAIN...");
  }
};

// const dbconnection = mongoose
//   .connect(process.env.mongooseURL)
//   .then(() => {
//     console.log("database connection succesfully");
//   })
//   .catch((e) => {
//     console.log("database connection failed");
//     console.log(e);
//   });

module.exports = dbconnection;
