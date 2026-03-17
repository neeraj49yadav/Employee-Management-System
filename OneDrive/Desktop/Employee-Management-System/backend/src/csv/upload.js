import multer from "multer"
import fs from "fs"

const uploadDir = "./uploads"

if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true })
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir)
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname)
  }
})

const fileFilter = (req, file, cb) => {
  if (file.mimetype === "text/csv" || file.originalname.endsWith(".csv")) {
    cb(null, true)
  } else {
    cb(new Error("Only CSV files are allowed"), false)
  }
}

export const upload = multer({
  storage,
  fileFilter
})
