import Token from "../models/token.model.js"

export const getUserSessions = async (req, res, next) => {
  try {
    const sessions = await Token.find({ userId: req.params.userId })
      .select("_id userId createdAt expiresAt")

    res.json(sessions)
  } catch (error) {
    next(error)
  }
}

export const revokeSession = async (req, res, next) => {
  try {
    await Token.findByIdAndDelete(req.params.tokenId)
    res.json({ message: "Session revoked successfully" })
  } catch (error) {
    next(error)
  }
}

export const revokeAllSessions = async (req, res, next) => {
  try {
    await Token.deleteMany({ userId: req.params.userId })
    res.json({ message: "All sessions revoked successfully" })
  } catch (error) {
    next(error)
  }
}
