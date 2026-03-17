import express from "express"

import { protect } from "../middleware/auth.middleware.js"
import { upload } from "../middleware/upload.middleware.js"

import {
 createEmployee,
 importEmployees,
 getEmployees,
 getEmployeeById,
 updateEmployee,
 deleteEmployee,
 getEmployeeActivity,
 exportEmployeesCSV
} from "../controllers/employee.controller.js"

const router = express.Router()

/*
|--------------------------------------------------------------------------
| Employee CRUD
|--------------------------------------------------------------------------
*/

router.post("/", protect, createEmployee)

router.get("/", protect, getEmployees)

router.get("/:id", protect, getEmployeeById)

router.put("/:id", protect, updateEmployee)

router.delete("/:id", protect, deleteEmployee)

/*
|--------------------------------------------------------------------------
| CSV Import
|--------------------------------------------------------------------------
*/

router.post(
 "/import",
 protect,
 upload.single("file"),
 importEmployees
)

/*
|--------------------------------------------------------------------------
| CSV Export
|--------------------------------------------------------------------------
*/

router.get("/export", protect, exportEmployeesCSV)

/*
|--------------------------------------------------------------------------
| Activity Logs
|--------------------------------------------------------------------------
*/

router.get("/activity", protect, getEmployeeActivity)

export default router