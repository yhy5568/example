package com.marshmellow.util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;

public class ExcelCellRef {
	/**
	 * Cell에 해당하는 Column Name을 가젼온다(A,B,C..) 만약 Cell이 Null이라면 int cellIndex의 값으로
	 * Column Name을 가져온다.
	 * 
	 * @param cell
	 * @param cellIndex
	 * @return
	 */
	public static String getName(Cell cell, int cellIndex) {
		int cellNum = 0;
		if (cell != null) {
			cellNum = cell.getColumnIndex();
		} else {
			cellNum = cellIndex;
		}

		return CellReference.convertNumToColString(cellNum);
	}

	public static String getValue(Cell cell) {
		String value = "";

		if (cell == null) {
			value = "";
		} else {
			/*if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
				value = cell.getCellFormula();
			} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				value = cell.getNumericCellValue() + "";
			} else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
				value = cell.getStringCellValue();
			} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
				value = cell.getBooleanCellValue() + "";
			} else if (cell.getCellType() == Cell.CELL_TYPE_ERROR) {
				value = cell.getErrorCellValue() + "";
			} else if (cell.getCellType() == Cell.CELL_TYPE_BLANK) {
				value = "";
			} else {
				value = cell.getStringCellValue();
			}*/
			switch(cell.getCellType()){
			case XSSFCell.CELL_TYPE_FORMULA:
				value = cell.getCellFormula();
				break;
			case XSSFCell.CELL_TYPE_NUMERIC:
				// 숫자일 경우, String형으로 변경하여 값을 읽는다.
				cell.setCellType( HSSFCell.CELL_TYPE_STRING );
				value = cell.getStringCellValue();
				break;
			case XSSFCell.CELL_TYPE_STRING:
				value = cell.getStringCellValue();
				break;
			case XSSFCell.CELL_TYPE_BLANK:
				//value = cell.getBooleanCellValue()+"";
				value = " ";
				break;
			case XSSFCell.CELL_TYPE_ERROR:
				value = cell.getErrorCellValue()+"";
				break;
		}
		}

		return value;
	}

}