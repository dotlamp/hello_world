package dotlamp.service.service;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.MemberVO;
import com.dotlamp.service.MemberService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.dotlamp.config.RootConfig.class})
@Log4j
public class MemberServiceTests {

    @Setter(onMethod_ = @Autowired)
    private MemberService service;

    @Test
    public void testExist(){
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testGetList(){
        service.getList(new Criteria(1, 10)).forEach(member -> log.info(member));
    }

    @Test
    public void testGet(){
        log.info(service.get(1));
    }

    @Test
    public  void  testIInsert(){

    }

    @Test
    public void testPasswrodChange(){
        MemberVO member = service.get(1);
        member.setPassword("pw02");
        log.info("changePassword result : "+service.passwordChange(member));
    }

    @Test
    public void testDelete(){
        log.info("remove result : " + service.remove(1));
    }
}
