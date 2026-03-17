import Joi from "joi"

export const createEmployeeSchema = Joi.object({
  name: Joi.string().min(2).max(100).required(),
  email: Joi.string().email().required(),
  department: Joi.string().min(2).max(100).required(),
  role: Joi.string().min(2).max(50).required(),
  salary: Joi.number().min(0).required()
})

export const updateEmployeeSchema = Joi.object({
  name: Joi.string().min(2).max(100),
  email: Joi.string().email(),
  department: Joi.string().min(2).max(100),
  role: Joi.string().min(2).max(50),
  salary: Joi.number().min(0)
})
