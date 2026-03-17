import mongoose from "mongoose"

const auditSchema = new mongoose.Schema(
{
 user: {
  type: mongoose.Schema.Types.ObjectId,
  ref: "User",
  required: true
 },

 action: {
  type: String,
  required: true
 },

 resource: {
  type: String,
  required: true
 },

 resourceId: {
  type: mongoose.Schema.Types.ObjectId
 },

 metadata: {
  type: Object
 }

},
{
 timestamps: true
}
)

export default mongoose.model("Audit", auditSchema)