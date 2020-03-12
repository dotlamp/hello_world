package com.dotlamp.service;

import com.dotlamp.domain.BoardVO;
import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.ReplyPageDTO;
import com.dotlamp.domain.ReplyVO;
import com.dotlamp.mapper.BoardMapper;
import com.dotlamp.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	//@Autowired /* spring 4.3이상 자동 주입 */
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	                           
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public boolean register(ReplyVO vo) {
		log.info("register"+vo);
		boolean registerResult = mapper.insert(vo) ==1;
        boardMapper.updateReplyCnt(vo.getBno(), 1);
		return registerResult;
	}

	@Override
	public ReplyVO get(int rno) {
		log.info("get"+rno);
		return mapper.read(rno);
	}

	@Override
	public boolean modify(ReplyVO vo) {
		boolean modifyResult = mapper.modify(vo) == 1;
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(int rno) {
		log.info("remove"+rno);
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno) == 1;
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, int bno) {
		log.info("get Reply List of a Board"+bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, int bno) {
		return new ReplyPageDTO(
				mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}


	@Override
	public int getTotal(Criteria cri, int bno) {
		return mapper.getCountByBno(bno);
	}
}
