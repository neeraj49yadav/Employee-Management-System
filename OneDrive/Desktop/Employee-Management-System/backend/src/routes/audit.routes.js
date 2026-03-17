import express from "express"
import {
  getAuditLogs,
  exportAuditLogs
} from "../controllers/audit.controller.js"
import authMiddleware from "../middleware/auth.middleware.js"
import roleMiddleware from "../middleware/role.middleware.js"

const router = express.Router()

router.get(
  "/",
  authMiddleware,
  roleMiddleware("Admin"),
  getAuditLogs
)

router.get(
  "/export",
  authMiddleware,
  roleMiddleware("Admin"),
  exportAuditLogs
)

export default router
