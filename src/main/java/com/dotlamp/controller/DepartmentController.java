package com.dotlamp.controller;

import com.dotlamp.domain.AttachVO;
import com.dotlamp.domain.BoardVO;
import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.PageDTO;
import com.dotlamp.service.BoardService;
import com.dotlamp.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
@RequestMapping("/department")
@AllArgsConstructor
public class DepartmentController {

    private BoardService service;

    private ReplyService replyService;

    @GetMapping("/list")
    public void list(Criteria cri, Model model) {
      /*  model.addAttribute("list", service.getList(cri));

        int total = service.getTotal(cri); //전체글갯수
        log.info("total : "+total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));*/
    }

/*    @PreAuthorize("isAuthenticated()")*/
    @GetMapping("/register")
    public void register() {

    }

    @PreAuthorize("isAuthenticated()") //로그인 유저만 사용할 수있는 권한 부여
    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr) {
        log.info("register"+board);
        if(board.getAttachList() != null) {
            board.getAttachList().forEach(attach -> log.info(attach));
        }
        service.register(board);
        rttr.addFlashAttribute("result", board.getBno());
        return "redirect:/board/list";
    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) {
   /*     log.info("get or modify");
        model.addAttribute("board", service.get(bno));
        model.addAttribute("replyList", replyService.getListPage(cri, bno));

        int total = replyService.getTotal(cri, bno);
        log.info("total : "+total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));
*/
    }

    @PreAuthorize("principal.username == #board.writer")
    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        log.info("modify"+board);
        if(service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/board/list";
    }


    @PreAuthorize("principal.username == #writer")
    @PostMapping("/remove")
    public String remove(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        /*log.info("remove"+bno);

        List<AttachVO> attachList = service.getAttachList(bno);
        if(service.remove(bno)) {
            deleteFiles(attachList);
            rttr.addFlashAttribute("result", "success");
        }*/
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/board/list" + cri.getListLink();
    }

    @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttachVO>> getAttachList(int bno){
        log.info("getAttach List :" + bno);
        return new ResponseEntity<List<AttachVO>>(service.getAttachList(bno), HttpStatus.OK);
    }


    private void deleteFiles(List<AttachVO> attachList) {
        if(attachList == null || attachList.size() == 0) {
            return;
        }

        log.info(attachList);

        attachList.forEach(attach -> {
            try {
                Path file = Paths.get("C:\\dotlamp\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
                Files.deleteIfExists(file);

                if(Files.probeContentType(file).startsWith("image")) {
                    Path thumbNail = Paths.get("C:\\dotlamp\\upload\\"+attach.getUploadPath()+"\\s+"+attach.getUuid()+"_"+attach.getFileName());
                    Files.delete(thumbNail);
                }
            } catch (Exception e) {
                log.error("delete file error"+e.getMessage());
            }
        });
    }

}
