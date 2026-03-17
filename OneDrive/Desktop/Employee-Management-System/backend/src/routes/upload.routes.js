import express from "express"
import { upload } from "../csv/upload.js"
import authMiddleware from "../middleware/auth.middleware.js"
import roleMiddleware from "../middleware/role.middleware.js"
import { importEmployees } from "../controllers/employee.controller.js"

const router = express.Router()

router.post(
  "/employees",
  authMiddleware,
  roleMiddleware("Admin", "HR"),
  upload.single("file"),
  importEmployees
)

export default router
