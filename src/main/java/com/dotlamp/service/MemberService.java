package com.dotlamp.service;

import com.dotlamp.domain.AttachVO;
import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.MemberAuthVO;
import com.dotlamp.domain.MemberVO;

import java.util.List;

public interface MemberService {
    /* 회원 리스트 (검색, 페이징)*/
    List<MemberVO> getList(Criteria cri);
    /* 회원  로그인(조회) */
    MemberVO read(String id);
    /* 회원 상세 조회 */
    MemberVO get(int mno);
    /* 회원 가입 (패스워드 암호화) */
    void register(MemberVO member);
    /* 회원 정보 수정 */
    boolean modify(MemberVO member);
    /* 회원 삭제 */
    boolean remove(int mno);
    /* 회원 인원 조회 */
    int getTotalCount(Criteria cri);
    /* 회원 비밀번호 변경 */
    boolean passwordChange(MemberVO member);
    /* 회원 첨부파일 */
    List<AttachVO> getAttachList(int mno);
    /* 회원 아이디 중복 확인 */
    int idCheck(String id);

    boolean passwordCheck(MemberVO member);

    MemberVO toggleRole(int mno, String auth);

} //MemberService
