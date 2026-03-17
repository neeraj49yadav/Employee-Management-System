export const ROLES = {
  ADMIN: "admin",
  VIEWER: "viewer"
}

export const PERMISSIONS = {
  CREATE_EMPLOYEE: "create_employee",
  READ_EMPLOYEE: "read_employee",
  UPDATE_EMPLOYEE: "update_employee",
  DELETE_EMPLOYEE: "delete_employee"
}

export const ROLE_PERMISSIONS = {
  admin: [
    PERMISSIONS.CREATE_EMPLOYEE,
    PERMISSIONS.READ_EMPLOYEE,
    PERMISSIONS.UPDATE_EMPLOYEE,
    PERMISSIONS.DELETE_EMPLOYEE
  ],

  viewer: [
    PERMISSIONS.READ_EMPLOYEE
  ]
}

export const hasPermission = (role, permission) => {
  const permissions = ROLE_PERMISSIONS[role] || []
  return permissions.includes(permission)
}