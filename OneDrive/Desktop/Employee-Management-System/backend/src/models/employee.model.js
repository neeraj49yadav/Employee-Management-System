import mongoose from "mongoose"

const employeeSchema = new mongoose.Schema(
 {
  name: {
   type: String,
   required: true,
   trim: true
  },

  email: {
   type: String,
   required: true,
   unique: true,
   lowercase: true,
   trim: true
  },

  department: {
   type: String,
   required: true,
   trim: true
  },

  position: {
   type: String,
   default: ""
  },

  salary: {
   type: Number,
   default: 0
  },

  createdBy: {
   type: mongoose.Schema.Types.ObjectId,
   ref: "User"
  }
 },
 {
  timestamps: true
 }
)

export default mongoose.model("Employee", employeeSchema)