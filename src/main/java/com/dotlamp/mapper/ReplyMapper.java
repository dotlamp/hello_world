package com.dotlamp.mapper;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.ReplyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReplyMapper {
	
	int insert(ReplyVO vo);
	
	ReplyVO read(int rno);
	
	int delete(int rno);

	int deleteAll(int bno);
	
	int modify(ReplyVO vo);
	
	List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") int bno);
	
	int getCountByBno(int bno);

	List<ReplyVO> getList(@Param("bno") int bno);

	
}
