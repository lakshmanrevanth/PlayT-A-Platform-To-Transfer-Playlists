require("dotenv").config();
const User = require("../models/auth_model");
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const registerUserController = async (req, res) => {
  try {
    const { username, email, password } = req.body;

    const checkusername = await User.findOne({ username });

    if (checkusername) {
      res.status(401).json({
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

    const checkaccount = await User.findOne({ username });

    if (checkaccount) {
      const comparepassword = await bcrypt.compare(
        password,
        checkaccount.password
      );

      if (comparepassword) {
        const accesstoken = jwt.sign(
          {
            userId: checkaccount._id,
            username: checkaccount.username,
            email: checkaccount.email,
          },
          process.env.JWT_SECRET_KEY,
          {
            expiresIn: "10m",
          }
        );
        console.log("success");

        res.status(201).json({
          token: accesstoken,
          message: "log in successfully...",
        });
      } else {
        res.status(501).json({
          message: "password wrong...",
        });
      }
    } else {
      res.status(401).json({
        message: "username not found try again with other username...",
      });
    }
  } catch (e) {
    console.log(e);
  }
};

module.exports = { registerUserController, loginUserController };
