package dotlamp.mapper;

import java.util.List;

import com.dotlamp.mapper.BoardMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dotlamp.domain.BoardVO;
import com.dotlamp.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.dotlamp.config.RootConfig.class})
@Log4j
public class BoardMapperTests {

	@Autowired
//	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board));
	}
	
	@Test /* bno value seq_board.nextval */
	public void testInsert() {
		for(int i=1; i<10; i++) {
			BoardVO board = new BoardVO();
			board.setTitle("제목"+ i);
			board.setContent("내용"+ i);
			board.setWriter(61);

			mapper.insert(board);
			log.info(board);
		}
	}
	
	@Test /* seq_board.nextval 조회 후 bno value #{bno} */
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로작성하는제목");
		board.setContent("새로작성하는내용");
		board.setWriter(112);
		mapper.insertSelectKey(board);
		log.info(board);
	}
	
	@Test
	public void testRead() {
		BoardVO board = mapper.read(61);
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info(mapper.delete(61));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		int i = 61;
		board.setBno(i);
		board.setTitle("수정제목"+ i);
		board.setContent("수정내용"+ i);
		board.setWriter(121);

		int count = mapper.update(board);
		log.info(count);
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("21");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
}
