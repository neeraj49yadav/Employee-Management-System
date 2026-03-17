import Audit from "../models/audit.model.js"
import { Parser } from "json2csv"

export const getAuditLogs = async (req, res, next) => {
  try {
    const {
      page = 1,
      limit = 20,
      action,
      user,
      startDate,
      endDate
    } = req.query

    const query = {}

    if (action) query.action = action
    if (user) query.performedBy = user

    if (startDate || endDate) {
      query.createdAt = {}
      if (startDate) query.createdAt.$gte = new Date(startDate)
      if (endDate) query.createdAt.$lte = new Date(endDate)
    }

    const logs = await Audit.find(query)
      .sort({ createdAt: -1 })
      .skip((page - 1) * limit)
      .limit(Number(limit))

    const total = await Audit.countDocuments(query)

    res.json({
      total,
      page: Number(page),
      pages: Math.ceil(total / limit),
      data: logs
    })
  } catch (error) {
    next(error)
  }
}

export const exportAuditLogs = async (req, res, next) => {
  try {
    const { action, user, startDate, endDate } = req.query

    const query = {}

    if (action) query.action = action
    if (user) query.performedBy = user

    if (startDate || endDate) {
      query.createdAt = {}
      if (startDate) query.createdAt.$gte = new Date(startDate)
      if (endDate) query.createdAt.$lte = new Date(endDate)
    }

    const logs = await Audit.find(query)
      .sort({ createdAt: -1 })
      .lean()

    const fields = [
      "_id",
      "action",
      "performedBy",
      "targetId",
      "createdAt"
    ]

    const parser = new Parser({ fields })
    const csv = parser.parse(logs)

    res.header("Content-Type", "text/csv")
    res.attachment("audit_logs.csv")
    res.send(csv)

  } catch (error) {
    next(error)
  }
}
