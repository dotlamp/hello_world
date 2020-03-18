package com.dotlamp.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import com.dotlamp.domain.*;
import com.dotlamp.service.BoardService;
import com.dotlamp.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
@AllArgsConstructor
public class BoardController {

    /* @AllArgsConstructor사용으로 @Autowired 미사용 */
//	@Autowired
    private BoardService service;

    private ReplyService replyService;

    @GetMapping("/list")
    public void list(Criteria cri, Model model) {
        model.addAttribute("list", service.getList(cri));

        int total = service.getTotal(cri); //전체글갯수
        log.info("total : "+total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));
    }

    @GetMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public void register() {

    }

    @PostMapping("/register")
    @PreAuthorize("isAuthenticated()") //로그인 유저만 사용할 수있는 권한 부여
    public String register(BoardVO board, RedirectAttributes rttr) {
        log.info("register"+board);
        if(board.getAttachList() != null) {
            board.getAttachList().forEach(attach -> log.info(attach));
        }
        service.register(board);
        rttr.addFlashAttribute("result", board.getBno());
        return "redirect:/board/get?bno="+board.getBno();
    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) {
        log.info("get or modify");
        model.addAttribute("board", service.get(bno));
        model.addAttribute("replyList", replyService.getListPage(cri, bno));

        int total = replyService.getTotal(cri, bno);
        log.info("total : "+total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));

    }

    @PostMapping("/modify")
    @PreAuthorize("isAuthenticated() and ((principal.member.mno == #board.writer) or hasRole('ROLE_ADMIN'))")
    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        log.info("modify"+board);
        if(service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());
        return "redirect:/board/get?amount="+cri.getAmount()+"&type="+cri.getType()+"&pageNum="+cri.getPageNum()+"&keyword="+cri.getKeyword()+"&bno="+board.getBno();
    }

    /* Authorize - bno로 받으니 로그인정보와 비교가 불가능.*/
    @PostMapping("/remove")
    public String remove(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        log.info("remove"+bno);

        List<AttachVO> attachList = service.getAttachList(bno);
        if(service.remove(bno)) {
            deleteFiles(attachList);
            rttr.addFlashAttribute("result", "success");
        }
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
