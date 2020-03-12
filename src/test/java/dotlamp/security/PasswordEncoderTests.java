package dotlamp.security;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.dotlamp.config.RootConfig.class, com.dotlamp.config.SecurityConfig.class})
@Log4j
public class PasswordEncoderTests {

    @Setter(onMethod_ = @Autowired)
    private PasswordEncoder passwordEncoder;

    @Test
    public void testEncoder(){
        String str = "member";
        String enStr = passwordEncoder.encode(str);
        log.warn(enStr);
        //$2a$10$lbKjR4BWUikzWDZoX/PxrexUvgCz2Lzc6Nj4OZ3EbDeiOy3phRqiy
    }
}
