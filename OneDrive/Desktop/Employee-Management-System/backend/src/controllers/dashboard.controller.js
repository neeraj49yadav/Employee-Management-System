import Employee from "../models/employee.model.js"
import { successResponse } from "../utils/response.js"

export const departmentPayroll = async (req, res, next) => {
  try {
    const result = await Employee.aggregate([
      { $match: { isDeleted: false } },
      {
        $group: {
          _id: "$department",
          totalSalary: { $sum: "$salary" },
          count: { $sum: 1 }
        }
      },
      { $sort: { totalSalary: -1 } }
    ])

    return successResponse(
      res,
      "Department payroll fetched",
      result
    )
  } catch (error) {
    next(error)
  }
}

export const salaryDistribution = async (req, res, next) => {
  try {
    const result = await Employee.aggregate([
      { $match: { isDeleted: false } },
      {
        $bucket: {
          groupBy: "$salary",
          boundaries: [0, 20000, 40000, 60000, 80000, 100000],
          default: "100000+",
          output: {
            count: { $sum: 1 }
          }
        }
      }
    ])

    return successResponse(
      res,
      "Salary distribution fetched",
      result
    )
  } catch (error) {
    next(error)
  }
}

export const monthlyHiring = async (req, res, next) => {
  try {
    const result = await Employee.aggregate([
      { $match: { isDeleted: false } },
      {
        $group: {
          _id: {
            year: { $year: "$createdAt" },
            month: { $month: "$createdAt" }
          },
          count: { $sum: 1 }
        }
      },
      { $sort: { "_id.year": 1, "_id.month": 1 } }
    ])

    return successResponse(
      res,
      "Monthly hiring trend fetched",
      result
    )
  } catch (error) {
    next(error)
  }
}

export const topEarners = async (req, res, next) => {
  try {
    const result = await Employee.find({ isDeleted: false })
      .sort({ salary: -1 })
      .limit(5)

    return successResponse(
      res,
      "Top earners fetched",
      result
    )
  } catch (error) {
    next(error)
  }
}

export const employeeGrowth = async (req, res, next) => {
  try {
    const total = await Employee.countDocuments({ isDeleted: false })

    const lastMonth = new Date()
    lastMonth.setMonth(lastMonth.getMonth() - 1)

    const lastMonthCount = await Employee.countDocuments({
      createdAt: { $lte: lastMonth },
      isDeleted: false
    })

    const growth = total - lastMonthCount

    return successResponse(
      res,
      "Employee growth fetched",
      {
        total,
        lastMonthCount,
        growth
      }
    )
  } catch (error) {
    next(error)
  }
}
