const express = require("express");
const router = express.Router();
const {
  registerUserController,
  loginUserController,
} = require("../controller/auth_controller");

router.post("/auth/create-user", registerUserController);
router.post("/auth/login-user", loginUserController);
module.exports = router;
