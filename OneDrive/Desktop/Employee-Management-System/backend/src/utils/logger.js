import fs from "fs"
import path from "path"

const logFilePath = path.join(process.cwd(), "logs", "employee.log")

export const writeEmployeeLog = (action, employee) => {

 const log = `${new Date().toISOString()} | ${action} | ${employee.name} | ${employee.email}\n`

 if (!fs.existsSync("logs")) {
  fs.mkdirSync("logs")
 }

 fs.appendFileSync(logFilePath, log)

}