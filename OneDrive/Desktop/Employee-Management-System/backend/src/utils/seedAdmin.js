import bcrypt from "bcryptjs"
import User from "../models/user.model.js"

export const seedAdminUser = async () => {
  try {

    const adminExists = await User.findOne({ role: "admin" })

    if (adminExists) {
      console.log("Admin user already exists")
      return
    }

    const hashedPassword = await bcrypt.hash("admin123", 10)

    const admin = await User.create({
      name: "System Admin",
      email: "admin@company.com",
      password: hashedPassword,
      role: "admin"
    })

    console.log("Default admin created")
    console.log("Email: admin@company.com")
    console.log("Password: admin123")

  } catch (error) {
    console.error("Admin seeding failed:", error)
  }
}