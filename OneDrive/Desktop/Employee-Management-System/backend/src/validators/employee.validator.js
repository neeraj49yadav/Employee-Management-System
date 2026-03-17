import { body } from "express-validator"

export const createEmployeeValidator = [
 body("name")
  .notEmpty()
  .withMessage("Name is required"),

 body("email")
  .isEmail()
  .withMessage("Valid email required"),

 body("department")
  .notEmpty()
  .withMessage("Department is required"),

 body("salary")
  .isNumeric()
  .withMessage("Salary must be a number")
]


export const updateEmployeeValidator = [
 body("email")
  .optional()
  .isEmail()
  .withMessage("Valid email required"),

 body("salary")
  .optional()
  .isNumeric()
  .withMessage("Salary must be a number")
]