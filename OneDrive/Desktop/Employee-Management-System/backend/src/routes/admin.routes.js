import express from "express"
import {
  getUserSessions,
  revokeSession,
  revokeAllSessions
} from "../controllers/admin.controller.js"
import authMiddleware from "../middleware/auth.middleware.js"
import roleMiddleware from "../middleware/role.middleware.js"

const router = express.Router()

router.get(
  "/sessions/:userId",
  authMiddleware,
  roleMiddleware("Admin"),
  getUserSessions
)

router.delete(
  "/sessions/:tokenId",
  authMiddleware,
  roleMiddleware("Admin"),
  revokeSession
)

router.delete(
  "/sessions/user/:userId",
  authMiddleware,
  roleMiddleware("Admin"),
  revokeAllSessions
)

export default router
