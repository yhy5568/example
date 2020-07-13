package com.marshmellow.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.marshmellow.dao.BoardDAO;
import com.marshmellow.util.ExcelRead;
import com.marshmellow.util.ExcelReadOption;
import com.marshmellow.util.FileUtils;
import com.marshmellow.vo.BoardVO;
import com.marshmellow.vo.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Inject
	private BoardDAO dao;
	
	// 게시글 작성
	@Override
	public void write(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
		
		dao.write(boardVO);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(boardVO, mpRequest);
		int size = list.size();
		for(int i=0; i<size; i++) {
			dao.insertFile(list.get(i));
		}
	}

	// 게시물 목록 조회
	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		
		return dao.list(scri);
	}
	
	// 게시물 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		
		return dao.listCount(scri);
	}

	// 게시물 조회
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(int bno) throws Exception {
			dao.boardHit(bno);
		return dao.read(bno);
	}

	// 게시물 수정
	@Override
	public void update(BoardVO boardVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception {
		
		dao.update(boardVO);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(boardVO, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i = 0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				dao.insertFile(tempMap);
			}else {
				dao.updateFile(tempMap);
			}
		}
	}

	// 게시물 삭제
	@Override
	public void delete(int bno) throws Exception {
		
		dao.delete(bno);
	}

	// 첨부파일 조회
	@Override
	public List<Map<String, Object>> selectFileList(int bno) throws Exception {
		return dao.selectFileList(bno);
	}

	// 첨부파일 다운로드
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return dao.selectFileInfo(map);
	}

	// 엑셀 업로드 및 db 업로드
	@SuppressWarnings("unchecked")
	@Override
	public void excelUpload(File destFile) {
		ExcelReadOption excelReadOption = new ExcelReadOption();

		// 파일경로 추가
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		// 추출할 컬럼 명 추가
		excelReadOption.setOutputColumns("A", "B", "C");
		System.out.println("excelReadOption :::: "+excelReadOption.getOutputColumns());
		// 시작 행
		excelReadOption.setStartRow(2);

		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		
		System.out.println("excelContent :::: "+excelContent);
		System.out.println("excelContent.size :::: "+excelContent.size());

		//여기서 마지막 max(num) 가져와서 똑같이 파일 만들자.
		String maxNum = dao.selectMaxNum();
		System.out.println("maxNum ::: "+maxNum);
		
//		((Map<String, Object>) excelContent).put("num", maxNum);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("excelContent", excelContent);
//		System.out.println("excelContent222222 :::: "+excelContent);
		try {
			dao.insertExcel(paramMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 엑셀 다운로드
	@Override
	@Transactional
	public List<BoardVO> selectBoardList() throws Exception {
		return dao.selectBoardList();
	}
	
}