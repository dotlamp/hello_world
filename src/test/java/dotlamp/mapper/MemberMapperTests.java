package dotlamp.mapper;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.MemberAuthVO;
import com.dotlamp.domain.MemberVO;
import com.dotlamp.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = {com.dotlamp.config.RootConfig.class})
@Log4j
public class MemberMapperTests {

    @Setter(onMethod_ = @Autowired)
    private MemberMapper mapper;

    @Test
    public void testGetList(){
        Criteria cri = new Criteria();
        /*cri.setKeyword("");*/
        /*cri.setType("");*/
        List<MemberVO> list = mapper.getList(cri);
        list.forEach(member -> log.info(member));
    }

    @Test
    public void read(){
        MemberVO vo = mapper.read("user0");
        log.info(vo);
        vo.getAuthList().forEach(authVO -> log.info(authVO));
    }

    @Test
    public void testInsert(){
        MemberVO member = new MemberVO();
        member.setId("test04");
        member.setPassword("pw01");
        member.setName("tester04");
        mapper.insert(member);
        MemberAuthVO vo = new MemberAuthVO();
        mapper.insertAuth(member.getMno(), "ROLE_USER");
        log.info(member);
    }

     @Test
    public void testPschange(){
        MemberVO member = new MemberVO();
        member.setId("test01");
        member.setPassword("pw02");
        log.info(member);
       int count =  mapper.passwordChange(member);
       log.info(count);
    }

    @Test
    public void  testDelete(){
        log.info(mapper.delete(1));
    }

    @Test
    public  void testTotalCount(Criteria cri){

        log.info(mapper.getTotalCount(cri));
    }

}
