package com.dotlamp.controller;


import java.util.List;

import com.dotlamp.domain.AttachVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.ReplyPageDTO;
import com.dotlamp.domain.ReplyVO;
import com.dotlamp.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j
@RequestMapping("/replies")
@AllArgsConstructor
public class ReplyController {

    private ReplyService service;

    @GetMapping(value = "/register")
    public void getRegister(){
    }

    @PostMapping(value="/register")
    public String register(ReplyVO vo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr){
        log.info("reply register");
        if (service.register(vo)) {
            rttr.addFlashAttribute("result", "success");
        }
        rttr.addAttribute("bno", vo.getBno());
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/board/get";
    }

    @PreAuthorize("principal.member.id == #replyer")
    @PostMapping("/remove")
    public String remove(@RequestParam("rno") int rno,
                         @RequestParam("bno") int bno,
                         @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        log.info("remove" + rno);
        if (service.remove(rno)) {
            rttr.addFlashAttribute("result", "success");
        }
        rttr.addAttribute("bno", bno);
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/board/get";
    }

    @PreAuthorize("principal.member.id == #replyer")
    @PostMapping("modify")
    public String modify(ReplyVO vo,
                         @RequestParam("bno") int bno,
                         @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        if(service.modify(vo)){
            rttr.addFlashAttribute("result", "success");
        }

        rttr.addAttribute("bno", bno);
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/board/get";
    }

    @GetMapping(value = "/{rno}",
            produces = { MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<ReplyVO> get(@PathVariable("rno") int rno) {
        log.info("get: " + rno);
        return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
    }

}
