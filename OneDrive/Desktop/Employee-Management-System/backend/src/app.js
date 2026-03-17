import express from "express"
import cors from "cors"
import morgan from "morgan"
import helmet from "helmet"
import rateLimit from "express-rate-limit"
import mongoSanitize from "express-mongo-sanitize"
import hpp from "hpp"

import healthRoutes from "./routes/health.routes.js"
import authRoutes from "./routes/auth.routes.js"
import employeeRoutes from "./routes/employee.routes.js"

import requestId from "./middleware/requestId.middleware.js"
import requestLogger from "./middleware/requestLogger.middleware.js"
import errorHandler from "./middleware/error.middleware.js"

const app = express()

app.use(requestId)

app.use(requestLogger)

app.use(helmet())

const limiter = rateLimit({
 windowMs: 15 * 60 * 1000,
 max: 100
})

app.use("/api", limiter)

app.use(mongoSanitize())

app.use(hpp())

app.use(
 cors({
  origin: "*",
  credentials: true
 })
)

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(morgan("dev"))

app.use("/api/v1", healthRoutes)
app.use("/api/v1/auth", authRoutes)
app.use("/api/v1/employees", employeeRoutes)

app.use((req, res) => {
 res.status(404).json({
  success: false,
  message: "Route not found"
 })
})

app.use(errorHandler)

export default app