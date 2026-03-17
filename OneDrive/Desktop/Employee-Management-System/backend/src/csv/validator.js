export const validateRow = (row) => {
  const errors = []

  if (!row.name) errors.push("Name is required")

  if (!row.email) errors.push("Email is required")
  else {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(row.email)) errors.push("Invalid email format")
  }

  if (!row.department) errors.push("Department is required")

  if (!row.salary || isNaN(Number(row.salary)))
    errors.push("Salary must be a number")

  return errors
}
