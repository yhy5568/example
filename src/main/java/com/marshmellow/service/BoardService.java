package com.marshmellow.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.marshmellow.vo.BoardVO;
import com.marshmellow.vo.SearchCriteria;

public interface BoardService {

	// 게시글 작성
	public void write(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception;
	
	// 게시물 목록 조회
	public List<BoardVO> list(SearchCriteria scri) throws Exception;
	
	// 게시물 총 갯수
	public int listCount(SearchCriteria scri) throws Exception;
	
	// 게시물 조회
	public BoardVO read(int bno) throws Exception;
	
	// 게시물 수정
	public void update(BoardVO boardVO, 
						String[] files, 
						String[] fileNames, 
						MultipartHttpServletRequest mpRequest) throws Exception;
	// 게시물 삭제
	public void delete(int bno) throws Exception;
	
	// 첨부파일 조회
	public List<Map<String, Object>> selectFileList(int bno) throws Exception;
	
	// 첨부파일 다운로드
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;

	// 엑셀 업로드 및 db업로드
	void excelUpload(File destFile);
	
	// 엑셀 다운로드
	List<BoardVO> selectBoardList() throws Exception;
}