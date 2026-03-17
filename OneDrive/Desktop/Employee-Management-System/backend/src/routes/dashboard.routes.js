import express from "express"
import {
  departmentPayroll,
  salaryDistribution,
  monthlyHiring,
  topEarners,
  employeeGrowth
} from "../controllers/dashboard.controller.js"

import authMiddleware from "../middleware/auth.middleware.js"
import permissionMiddleware from "../middleware/permission.middleware.js"

const router = express.Router()

router.get(
  "/department-payroll",
  authMiddleware,
  permissionMiddleware("employee:view"),
  departmentPayroll
)

router.get(
  "/salary-distribution",
  authMiddleware,
  permissionMiddleware("employee:view"),
  salaryDistribution
)

router.get(
  "/monthly-hiring",
  authMiddleware,
  permissionMiddleware("employee:view"),
  monthlyHiring
)

router.get(
  "/top-earners",
  authMiddleware,
  permissionMiddleware("employee:view"),
  topEarners
)

router.get(
  "/employee-growth",
  authMiddleware,
  permissionMiddleware("employee:view"),
  employeeGrowth
)

export default router
