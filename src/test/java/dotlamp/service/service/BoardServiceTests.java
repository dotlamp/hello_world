package dotlamp.service.service;

import static org.junit.Assert.assertNotNull;

import com.dotlamp.service.BoardService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dotlamp.domain.BoardVO;
import com.dotlamp.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.dotlamp.config.RootConfig.class})
@Log4j
public class BoardServiceTests {

	@Autowired
	private BoardService service;
	
	@Test /* BoardService 객체 주입 여부 확인(BoardService 객체 생성 -> BoardMapper 주입) */
	public void testExist() {
		log.info(service); //com.dotlamp.service.BoardServiceImpl@770d0ea6
		assertNotNull(service);
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		long i = 504L;
		board.setTitle("제목"+ i);
		board.setContent("내용"+ i);
		board.setWriter(112);

		service.register(board);
		log.info("생성된 게시물 번호 : "+ board.getBno());
	}
	
	@Test
	public void testGetList() {
		service.getList(new Criteria(3, 10)).forEach(board -> log.info(board));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(61));
	}
	
	@Test
	public void testDelete() {
		log.info("remove result"+service.remove(61));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = service.get(61);
		if(board == null) {
			return;
		}
		board.setTitle("수정제목");
		log.info("modify result"+service.modify(board));
	}
	
	
}
