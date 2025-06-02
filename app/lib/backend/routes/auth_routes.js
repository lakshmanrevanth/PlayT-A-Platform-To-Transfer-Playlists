const express = require("express");
const router = express.Router();
const {
  registerUserController,
  loginUserController,
} = require("../controller/auth_controller");

router.post("/register-user", registerUserController);
router.post("/login-user", loginUserController);
module.exports = router;
