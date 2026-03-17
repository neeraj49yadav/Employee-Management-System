import mongoose from "mongoose"
import logger from "../utils/logger.js"

const connectDB = async () => {
  try {
    if (!process.env.MONGO_URI) {
      throw new Error("MONGO_URI not defined")
    }

    await mongoose.connect(process.env.MONGO_URI, {
      autoIndex: process.env.NODE_ENV !== "production"
    })

    logger.info({ message: "MongoDB connected successfully" })

    mongoose.connection.on("error", (err) => {
      logger.error({ message: "MongoDB runtime error", error: err.message })
    })

    mongoose.connection.on("disconnected", () => {
      logger.warn({ message: "MongoDB disconnected" })
    })

  } catch (error) {
    logger.error({ message: "MongoDB connection failed", error: error.message })
    process.exit(1)
  }
}

export default connectDB
