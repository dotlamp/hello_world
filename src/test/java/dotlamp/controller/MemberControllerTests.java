package dotlamp.controller;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {com.dotlamp.config.RootConfig.class, com.dotlamp.config.ServletConfig.class})
@Log4j
public class MemberControllerTests {

    @Setter(onMethod_ = @Autowired)
    private WebApplicationContext ctx;

    private MockMvc movcMvc;

    @Before
    public void setUp() {
        this.movcMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }

    @Test
    public  void testList() throws Exception{
        log.info(
                movcMvc.perform(MockMvcRequestBuilders.get("/member/list"))
                    .andReturn().getModelAndView().getModelMap()
        );
    }

    @Test
    public void testRegister() throws  Exception{
        String resultPage = movcMvc.perform(MockMvcRequestBuilders.post("/member/register")
            .param("userid", "admin")
            .param("userpw", "admin")
            .param("username", "tester02")
            ).andReturn().getModelAndView().getViewName();
    }

    @Test
    public void testGet() throws Exception{
        log.info(movcMvc.perform(MockMvcRequestBuilders.get("/member/get")
            .param("userid", "test02"))
        .andReturn().getModelAndView().getModelMap());
    }

    @Test
    public void testModify() throws Exception{
        String resultPage = movcMvc.perform(MockMvcRequestBuilders.post("/member/password")
            .param("password", "pw03")
            .param("id", "test02"))
                .andReturn().getModelAndView().getViewName();
        log.info(resultPage);
    }

    @Test
    public void testRemove() throws Exception{
        String resultPage = movcMvc.perform(MockMvcRequestBuilders.post("/member/remove")
            .param("userid", "test02")
            ).andReturn().getModelAndView().getViewName();
    }

} // MemberControllerTests


/*//	@Test
//	public void testRemove() throws Exception {
//		// 삭제전 데이터베이스에 게시물 번호 확인할 것
//		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
//			.param("bno", "505"))
//			.andReturn().getModelAndView().getViewName();
//		log.info(resultPage);
//	}*/