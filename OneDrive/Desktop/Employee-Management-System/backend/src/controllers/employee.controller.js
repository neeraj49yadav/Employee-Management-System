import Employee from "../models/employee.model.js"
import { writeEmployeeLog } from "../utils/logger.js"
import fs from "fs"
import path from "path"
import csv from "csv-parser"

/*
|--------------------------------------------------------------------------
| Create Employee
|--------------------------------------------------------------------------
*/

export const createEmployee = async (req, res) => {
 try {

  const { name, email, department, position, salary } = req.body

  if (!name || !email || !department) {
   return res.status(400).json({
    success: false,
    message: "Name, email and department are required"
   })
  }

  const existingEmployee = await Employee.findOne({ email })

  if (existingEmployee) {
   return res.status(400).json({
    success: false,
    message: "Employee already exists"
   })
  }

  const employee = await Employee.create({
   name,
   email,
   department,
   position,
   salary,
   createdBy: req.user._id
  })

  writeEmployeeLog("CREATED", employee)

  res.status(201).json({
   success: true,
   employee
  })

 } catch (error) {

  console.error(error)

  res.status(500).json({
   success: false,
   message: "Failed to create employee"
  })

 }
}

/*
|--------------------------------------------------------------------------
| Import Employees CSV
|--------------------------------------------------------------------------
*/

export const importEmployees = async (req, res) => {

 try {

  if (!req.file) {
   return res.status(400).json({
    success: false,
    message: "CSV file is required"
   })
  }

  const results = []

  fs.createReadStream(req.file.path)
   .pipe(csv())
   .on("data", (data) => results.push(data))
   .on("end", async () => {

    const createdEmployees = []

    for (const row of results) {

     const employee = await Employee.create({
      name: row.name,
      email: row.email,
      department: row.department,
      position: row.position || "",
      salary: row.salary || 0,
      createdBy: req.user._id
     })

     writeEmployeeLog("CREATED (CSV)", employee)

     createdEmployees.push(employee)
    }

    fs.unlinkSync(req.file.path)

    res.json({
     success: true,
     message: "Employees imported successfully",
     count: createdEmployees.length
    })

   })

 } catch (error) {

  console.error(error)

  res.status(500).json({
   success: false,
   message: "CSV import failed"
  })

 }
}

/*
|--------------------------------------------------------------------------
| Get Employees (Pagination)
|--------------------------------------------------------------------------
*/

export const getEmployees = async (req, res) => {
 try {

  const page = parseInt(req.query.page) || 1
  const limit = parseInt(req.query.limit) || 10
  const skip = (page - 1) * limit

  const employees = await Employee.find()
   .sort({ createdAt: -1 })
   .skip(skip)
   .limit(limit)

  const total = await Employee.countDocuments()

  res.json({
   success: true,
   page,
   total,
   employees
  })

 } catch (error) {

  console.error(error)

  res.status(500).json({
   success: false,
   message: "Failed to fetch employees"
  })

 }
}

/*
|--------------------------------------------------------------------------
| Get Employee By ID
|--------------------------------------------------------------------------
*/

export const getEmployeeById = async (req, res) => {

 try {

  const employee = await Employee.findById(req.params.id)

  if (!employee) {
   return res.status(404).json({
    success: false,
    message: "Employee not found"
   })
  }

  res.json({
   success: true,
   employee
  })

 } catch (error) {

  res.status(500).json({
   success: false,
   message: "Failed to fetch employee"
  })

 }
}

/*
|--------------------------------------------------------------------------
| Update Employee
|--------------------------------------------------------------------------
*/

export const updateEmployee = async (req, res) => {

 try {

  const employee = await Employee.findByIdAndUpdate(
   req.params.id,
   req.body,
   { new: true }
  )

  if (!employee) {
   return res.status(404).json({
    success: false,
    message: "Employee not found"
   })
  }

  writeEmployeeLog("UPDATED", employee)

  res.json({
   success: true,
   employee
  })

 } catch (error) {

  res.status(500).json({
   success: false,
   message: "Failed to update employee"
  })

 }
}

/*
|--------------------------------------------------------------------------
| Delete Employee
|--------------------------------------------------------------------------
*/

export const deleteEmployee = async (req, res) => {

 try {

  const employee = await Employee.findByIdAndDelete(req.params.id)

  if (!employee) {
   return res.status(404).json({
    success: false,
    message: "Employee not found"
   })
  }

  writeEmployeeLog("DELETED", employee)

  res.json({
   success: true,
   message: "Employee deleted"
  })

 } catch (error) {

  res.status(500).json({
   success: false,
   message: "Failed to delete employee"
  })

 }
}

/*
|--------------------------------------------------------------------------
| Employee Activity Logs
|--------------------------------------------------------------------------
*/

export const getEmployeeActivity = async (req, res) => {

 try {

  const logPath = path.join(process.cwd(), "logs", "employee.log")

  if (!fs.existsSync(logPath)) {
   return res.json({
    success: true,
    activities: []
   })
  }

  const data = fs.readFileSync(logPath, "utf8")

  const lines = data
   .split("\n")
   .filter((l) => l.trim() !== "")
   .reverse()
   .slice(0, 10)

  res.json({
   success: true,
   activities: lines
  })

 } catch (error) {

  res.status(500).json({
   success: false,
   message: "Failed to fetch activity logs"
  })

 }
}

/*
|--------------------------------------------------------------------------
| Export Employees CSV
|--------------------------------------------------------------------------
*/

export const exportEmployeesCSV = async (req, res) => {

 try {

  const employees = await Employee.find()

  let csvData = "Name,Email,Department,Position,Salary\n"

  employees.forEach(emp => {

   const name = emp.name || ""
   const email = emp.email || ""
   const department = emp.department || ""
   const position = emp.position || ""
   const salary = emp.salary || ""

   csvData += `${name},${email},${department},${position},${salary}\n`

  })

  res.setHeader("Content-Type", "text/csv")
  res.setHeader(
   "Content-Disposition",
   "attachment; filename=employees.csv"
  )

  res.status(200).send(csvData)

 } catch (error) {

  console.error("CSV export error:", error)

  res.status(500).json({
   success: false,
   message: "Failed to export employees"
  })

 }
}