package com.dotlamp.service;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.ReplyPageDTO;
import com.dotlamp.domain.ReplyVO;

import java.util.List;

public interface ReplyService {
	
	boolean register(ReplyVO vo);
	
	ReplyVO get(int rno);

	boolean modify(ReplyVO vo);
	
	boolean remove(int rno);
	
	List<ReplyVO> getList(Criteria cri, int bno);
	
	ReplyPageDTO getListPage(Criteria cri, int bno);

	int getTotal(Criteria cri, int bno);

}
