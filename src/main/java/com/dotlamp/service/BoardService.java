package com.dotlamp.service;

import com.dotlamp.domain.AttachVO;
import com.dotlamp.domain.BoardVO;
import com.dotlamp.domain.Criteria;

import java.util.List;

public interface BoardService {

	void register(BoardVO board);
	
	BoardVO get(int bno);
	
	boolean modify(BoardVO board);
	
	boolean remove(int bno);
	
	List<BoardVO> getList(Criteria cri);
	
	int getTotal(Criteria cri); //전체글갯수
	
	List<AttachVO> getAttachList(int bno);
}
