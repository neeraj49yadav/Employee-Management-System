export const rolePermissions = {
  Admin: [
    "employee:create",
    "employee:update",
    "employee:delete",
    "employee:view",
    "employee:export",
    "audit:view",
    "audit:export",
    "session:view",
    "session:revoke"
  ],
  HR: [
    "employee:create",
    "employee:update",
    "employee:view",
    "employee:export",
    "audit:view"
  ],
  Employee: [
    "employee:view"
  ]
}
