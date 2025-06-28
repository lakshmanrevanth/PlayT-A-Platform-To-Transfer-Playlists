require("dotenv").config();
const User = require("../models/auth_model");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const registerUserController = async (req, res) => {
  try {
    const { username, email, password } = req.body;

    if (!username || !email || !password) {
      console.log("invalid details");
      return res.status(400).json({
        message: "invalid details or kindly check the details",
      });
    }
    const checkusername = await User.findOne({ username });

    // const checkemail = await User.findOne({ email });

    // if (checkemail) {
    //   console.log("user email already exists");
    //   return res.status(409).json({
    //     message: "user email already registered with another user",
    //   });
    // }
    if (checkusername) {
      res.status(409).json({
        message: "user already exists...",
      });
    } else {
      const salt = await bcrypt.genSalt(10);
      const hashedpassword = await bcrypt.hash(password, salt);

      const createuser = new User({
        username,
        email,
        password: hashedpassword,
      });

      await createuser.save();

      if (createuser) {
        console.log("stored...");

        res.status(201).json({
          message: "stored in database",
          username: createuser.username,
        });
      }
    }

    // res.status(201).json({
    //   message: " successfully implemented the register controller...",
    //   data: createuser,
    //   password: createuser.password,
    // });
  } catch (e) {
    console.log(e);
    console.log("server is down");
    res.status(500).json({
      message: "server is down",
    });
  }
};

// const getallUsersController = async (req, res) => {
//   try {
//     const data = await User.find({});
//     res.status(401).json({
//       data: data,
//     });
//   } catch (e) {
//     console.log(e);
//   }
// };

const loginUserController = async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!username || !password) {
      return res.status(400).json({
        message: "missing fields",
      });
    }

    const account = await User.findOne({ username });

    if (account) {
      const ispasswordcorrect = await bcrypt.compare(
        password,
        account.password
      );

      if (ispasswordcorrect) {
        const accesstoken = jwt.sign(
          {
            userId: account._id,
            username: account.username,
            email: account.email,
          },
          process.env.JWT_SECRET_KEY,
          {
            expiresIn: "10m",
          }
        );
        console.log("success");

        res.status(200).json({
          token: accesstoken,
          message: "log in successfully...",
        });
      } else {
        res.status(401).json({
          message: "password wrong...",
        });
      }
    } else {
      res.status(404).json({
        message: "username not found try again with other username...",
      });
    }
  } catch (e) {
    console.log("server down");
    return res.status(500);
    console.log(e);
  }
};

module.exports = { registerUserController, loginUserController };
