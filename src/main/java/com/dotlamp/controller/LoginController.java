package com.dotlamp.controller;

import com.dotlamp.service.MemberService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Log4j
public class LoginController {

    @Setter(onMethod_ = @Autowired)
    private MemberService service;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginInput(String error,Model model){
        if(error != null){
            model.addAttribute("error", "아이디 또는 패스워드 확인바랍니다.");
        }
        return "/login";
    }


    @GetMapping("/sample/all")
    public void all() {
        log.info("all");
    }
    @GetMapping("/sample/admin")
    public void getadmin() {
        log.info("get admin");
    }
    @PostMapping("/sample/admin")
    public void poasadmin() {
        log.info("post admin");
    }

    @GetMapping("/sample/member")
    public void getmember(){
        log.info("get member");
    }
    @PostMapping("/sample/member")
    public void postmember() {
        log.info("post member");
    }

    @GetMapping("/accessError")
    public void accessDeined(Authentication auth, Model model){
        model.addAttribute("msg", "접근 권한이 없습니다.");
    }
}
