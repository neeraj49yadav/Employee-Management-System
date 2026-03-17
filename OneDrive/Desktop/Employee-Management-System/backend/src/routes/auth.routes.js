import express from "express"

import {
 register,
 login,
 getProfile
} from "../controllers/auth.controller.js"

import { protect } from "../middleware/auth.middleware.js"

const router = express.Router()

/*
|--------------------------------------------------------------------------
| Register
|--------------------------------------------------------------------------
*/

router.post("/register", register)

/*
|--------------------------------------------------------------------------
| Login
|--------------------------------------------------------------------------
*/

router.post("/login", login)

/*
|--------------------------------------------------------------------------
| Profile
|--------------------------------------------------------------------------
*/

router.get("/profile", protect, getProfile)

export default router