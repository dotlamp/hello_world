package com.dotlamp.controller;

import com.dotlamp.domain.*;
import com.dotlamp.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.internet.MimeMessage;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/member")
@AllArgsConstructor
public class MemberController {

    @Setter(onMethod_ = @Autowired)
    private MemberService service;

    @Setter(onMethod_ = @Autowired)
    private JavaMailSender mailSender;

    @GetMapping("/list")
    public void list(Criteria cri, Model model){
        model.addAttribute("list",service.getList(cri));
        int total = service.getTotalCount(cri);
        model.addAttribute("pageMaker", new PageDTO(cri, total));
    }

    @GetMapping("/register")
    public void getRegister(){

    }
    @PostMapping("/register")
    public String postRegister(MemberVO member, RedirectAttributes rttr){
        service.register(member);
        return "home";
    }
    @GetMapping({"/get", "/modify"})
    @PreAuthorize("isAuthenticated() and ((principal.member.mno == #mno) or hasRole('ROLE_ADMIN'))")
    public void get(@RequestParam("mno") int mno,  @ModelAttribute("cri") Criteria cri, Model model){
        model.addAttribute("member", service.get(mno));
    }

    @PostMapping("modify")
    @PreAuthorize("isAuthenticated() and ((principal.member.mno == #member.mno) or hasRole('ROLE_ADMIN'))")
    public String modify(MemberVO member, RedirectAttributes rttr){

        if(member.getAttachList() != null){
            member.getAttachList().forEach(attach -> log.info(attach));
        }
        service.modify(member);

        return "home";
    }

    @GetMapping("/password")
    public String passwordGetCheck(String error,Model model){
        if(error != null){
            model.addAttribute("error", "패스워드 확인바랍니다.");
        }
        return "/member/password";
    };

    @PostMapping("/password")
    public String passwordPostCheck(MemberVO member){
        if(!service.passwordCheck(member)){
            return "redirect:/member/password?error";
        }
        return "redirect:/member/passwordChange?success";
    };


    @GetMapping(value = "/passwordChange")
    public String passwordGetChange(String success){
        if(success == null){
            return "redirect:/";
        }
        return "/member/passwordChange";
    }

    @PostMapping("/passwordChange")
    public String passwordChange(MemberVO member, RedirectAttributes rttr){
        if(service.passwordChange(member)){
            rttr.addFlashAttribute("result", "success");
        }
        return "home";
    }

    @GetMapping("/forgetPassword")
    public String getForgetPassword(String error,Model model){
        if(error != null){
            model.addAttribute("error", "아이디 또는 이메일 주소를 확인바랍니다.");
        }
        return "/member/forgetPassword";
    }
    
    @PostMapping(value = "/forgetPassword")
    public String postForgetPassword(@RequestParam("id") String id, @RequestParam("email") String email, RedirectAttributes rttr){
        MemberVO memberVO = service.read(id);
        int password = (int) (Math.random() * 9999) + 1000;
        memberVO.setPassword(Integer.toString(password));
        if(!memberVO.getEmail().equals(email)) {
            return "redirect:/member/forgetPassword?error";
        }else if(memberVO.getEmail().equals(email)){
            if (service.passwordChange(memberVO)) {
                try {
                    MimeMessage message = mailSender.createMimeMessage();
                    MimeMessageHelper messageHelper = new MimeMessageHelper(message,true, "UTF-8");

                    messageHelper.setFrom("nbookgo@gmail.com"); // 보내는사람 생략하면 정상작동을 안함
                    messageHelper.setTo(memberVO.getEmail()); // 받는사람 이메일
                    messageHelper.setSubject("Hello_world 임시비밀번호입니다."); // 메일제목은 생략이 가능하다
                    messageHelper.setText("비밀번호는 : " + password); // 메일 내용

                    mailSender.send(message);
                    log.warn(message);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                rttr.addFlashAttribute("result", "success");
            }
        }

        return "/login";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("mno") int mno, RedirectAttributes rttr){
        if (service.remove(mno)) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/member/list";
    }

    @GetMapping("/idChk")
    @ResponseBody
    public int idCheck(@RequestParam("id") String id){
      return service.idCheck(id);
    }

    @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttachVO>> getAttachList(int mno){
        log.info("getAttach List :" + mno);
        return new ResponseEntity<List<AttachVO>>(service.getAttachList(mno), HttpStatus.OK);
    }

    @RequestMapping(value = "/auth/{mno}/{auth}")
    public String changeRole(@PathVariable int mno, @PathVariable String auth) {
        service.toggleRole(mno, auth);
        return "redirect:/member/list";
    }


    private void deleteFiles(List<AttachVO> attachList) {
        if(attachList == null || attachList.size() == 0) {
            return;
        }
        log.info(attachList);
        attachList.forEach(attach -> {
            try {
                Path file = Paths.get(attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
                Files.deleteIfExists(file);

                if(Files.probeContentType(file).startsWith("image")) {
                    Path thumbNail = Paths.get(attach.getUploadPath()+"\\s+"+attach.getUuid()+"_"+attach.getFileName());
                    Files.delete(thumbNail);
                }
            } catch (Exception e) {
                log.error("delete file error"+e.getMessage());
            }
        });
    }


} //MemberController

