import employeeQueue from "../queues/employee.queue.js"
import Employee from "../models/employee.model.js"

employeeQueue.process(async (job) => {
  const { employees } = job.data

  await Employee.insertMany(employees)

  return { inserted: employees.length }
})
