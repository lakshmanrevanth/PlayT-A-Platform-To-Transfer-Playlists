require("dotenv").config();
const express = require("express");
const dbconnection = require("./database/database_connection");
const auth_controllers = require("./routes/auth_routes");
const app = express();
const port = 3000;
dbconnection();

app.use(express.json());
app.use("/Play-T", auth_controllers);

app.listen(port, () => {
  console.log("server has started listening");
});
