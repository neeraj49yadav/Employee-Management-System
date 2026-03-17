import fs from "fs"
import { parse } from "csv-parse"

export const parseCSV = (filePath) => {
  return new Promise((resolve, reject) => {
    const rows = []

    fs.createReadStream(filePath)
      .pipe(
        parse({
          columns: true,
          trim: true,
          skip_empty_lines: true
        })
      )
      .on("data", (row) => {
        const normalizedRow = {}

        Object.keys(row).forEach((key) => {
          normalizedRow[key.trim().toLowerCase()] =
            typeof row[key] === "string"
              ? row[key].trim()
              : row[key]
        })

        rows.push(normalizedRow)
      })
      .on("end", () => resolve(rows))
      .on("error", (error) => reject(error))
  })
}
