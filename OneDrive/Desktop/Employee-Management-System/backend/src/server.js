import dotenv from "dotenv"
dotenv.config()

import http from "http"
import mongoose from "mongoose"

import app from "./app.js"
import { seedAdminUser } from "./utils/seedAdmin.js"

const PORT = process.env.PORT || 5000
const MONGO_URI = process.env.MONGO_URI || "mongodb://mongo:27017/employee_db"

async function startServer() {

  try {

    await mongoose.connect(MONGO_URI)

    console.log("MongoDB connected")

    await seedAdminUser()

    const server = http.createServer(app)

    server.listen(PORT, "0.0.0.0", () => {
      console.log(`Server running on http://0.0.0.0:${PORT}`)
    })

  } catch (error) {

    console.error("Database connection failed:", error)

    process.exit(1)
  }
}

startServer()