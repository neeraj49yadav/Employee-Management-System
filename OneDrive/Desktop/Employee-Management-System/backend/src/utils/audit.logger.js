import Audit from "../models/audit.model.js"

export const logAudit = async ({
 userId,
 action,
 resource,
 resourceId = null,
 metadata = {}
}) => {

 try {

  await Audit.create({
   user: userId,
   action,
   resource,
   resourceId,
   metadata
  })

 } catch (error) {

  console.error("Audit log failed:", error)

 }

}