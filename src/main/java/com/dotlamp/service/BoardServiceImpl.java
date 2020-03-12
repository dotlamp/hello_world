package com.dotlamp.service;

import com.dotlamp.domain.AttachVO;
import com.dotlamp.domain.BoardVO;
import com.dotlamp.domain.Criteria;
import com.dotlamp.mapper.AttachMapper;
import com.dotlamp.mapper.BoardMapper;
import com.dotlamp.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {
//	@AllArgsConstructor /* 모든 파라미터를 이용하는 생성자를 자동 생성 */

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private AttachMapper attachMapper;

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;


	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register"+board);
//		mapper.insert(board); /* 게시글번호 조회 안됨 */
		mapper.insertSelectKey(board); //게시글 번호
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.b_insert(attach);
		});
	}

	@Override
	public BoardVO get(int bno) {
		log.info("get"+bno);
		mapper.viewCnt(bno, 1);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify"+board);
		attachMapper.b_deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board) == 1;
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0 ) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.b_insert(attach);
			});
		}//if
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(int bno) {
		log.info("remove"+bno);
		attachMapper.b_deleteAll(bno);
		replyMapper.deleteAll(bno);
		return mapper.delete(bno) == 1 ; //true
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
//		log.info("getList : " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("getTotalCount");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<AttachVO> getAttachList(int bno) {
		log.info("get Attach list by bno"+bno);
		return attachMapper.b_findByNo(bno);
	}
	
	
}
