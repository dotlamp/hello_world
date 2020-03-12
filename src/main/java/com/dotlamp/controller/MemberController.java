package com.dotlamp.controller;

import com.dotlamp.domain.*;
import com.dotlamp.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        if(member.getAttachList() != null){
            member.getAttachList().forEach(attach -> log.info(attach));
        }
        rttr.addFlashAttribute("result", member.getId());
        return "home";
    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("mno") int mno,  @ModelAttribute("cri") Criteria cri, Model model){
        model.addAttribute("member", service.get(mno));
    }

    @PostMapping("modify")
    public String modify(MemberVO member, RedirectAttributes rttr){
        if(service.modify(member)){
            rttr.addAttribute("result","success");
        }
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


    @RequestMapping(value = "/passwordChange", method = RequestMethod.GET)
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
        log.warn("aaa");
        service.toggleRole(mno, auth);
        log.warn("ccc");
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

