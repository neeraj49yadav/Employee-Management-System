import { rolePermissions } from "../config/roles.js"

const permissionMiddleware = (...requiredPermissions) => {
  return (req, res, next) => {
    const userRole = req.user.role

    if (!userRole) {
      return res.status(403).json({ message: "Access denied" })
    }

    const permissions = rolePermissions[userRole] || []

    const hasPermission = requiredPermissions.every(p =>
      permissions.includes(p)
    )

    if (!hasPermission) {
      return res.status(403).json({ message: "Forbidden" })
    }

    next()
  }
}

export default permissionMiddleware
