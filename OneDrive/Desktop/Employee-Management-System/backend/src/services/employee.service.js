import Employee from "../models/employee.model.js";

export const addEmployee = async (payload) => {
  try {
    const employee = new Employee({
      name: payload.name,
      email: payload.email,
      role: payload.role
    });

    const savedEmployee = await employee.save();
    return savedEmployee;
  } catch (error) {
    throw new Error(error.message);
  }
};
