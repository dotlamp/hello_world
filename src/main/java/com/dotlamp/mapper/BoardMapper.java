package com.dotlamp.mapper;

import com.dotlamp.domain.BoardVO;
import com.dotlamp.domain.Criteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardMapper {

	List<BoardVO> getListWithPaging(Criteria cri);
	
	void insert(BoardVO board);
	
	void insertSelectKey(BoardVO board);
	
	BoardVO read(int bno);
	
	int delete(int bno); //int -> 1: 삭제O, 0:삭제x(삭제할 게시물x)
	
	int update(BoardVO board);
	
	int getTotalCount(Criteria cri);
	
	void updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount);

	void viewCnt(@Param("bno") int bno, @Param("amount") int amount);
	
}
