import fs from "fs"

export const logEmployeeActivity = (message) => {

 const log = `${new Date().toISOString()} - ${message}\n`

 fs.appendFileSync("logs/employee.log", log)

}