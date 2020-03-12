package dotlamp.mapper;


import java.util.List;
import java.util.stream.IntStream;

import com.dotlamp.mapper.ReplyMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.dotlamp.config.RootConfig.class})
@Log4j
public class ReplyMapperTests {

	@Autowired
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	private Long[] bnoArr = {499L, 498L, 497L, 496L, 495L};
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i->{
			ReplyVO vo = new ReplyVO();

			vo.setBno(41);
			vo.setReply("댓글테스트"+i);
			vo.setReplyer(112);

			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead() {

		ReplyVO vo = mapper.read(9);
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		int targetRno = 8;
		mapper.delete(targetRno);
	}
	
	@Test
	public void testUpdate() {
		int targetRno = 9;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("updateReply");
		mapper.modify(vo);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 61);
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2, 10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 61);
		replies.forEach(reply -> log.info(reply));
	}
}
