import xlsx from "xlsx";
import { validateRow } from "./validator.js";

export const parseExcel = (filePath) => {
  const workbook = xlsx.readFile(filePath);
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const rows = xlsx.utils.sheet_to_json(sheet);

  const validRows = [];
  const errors = [];

  for (const row of rows) {
    const result = validateRow(row);
    if (result.valid) {
      validRows.push(row);
    } else {
      errors.push({ row, error: result.error });
    }
  }

  return { validRows, errors };
};
