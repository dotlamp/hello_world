package com.dotlamp.mapper;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.MemberAuthVO;
import com.dotlamp.domain.MemberVO;
import com.dotlamp.domain.MemberVisitVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberMapper {

    /*회원 리스트 (검색, 페이징)*/
    List<MemberVO> getList(Criteria cri);
    /* 회원 로그인*/
    MemberVO read(String id);
    /* 패스워드 변경 */
    int passwordChange(MemberVO member);
    /* 회원 상세 조회 */
    MemberVO get(int mno);
    /* 회원 정보 입력 */
    void insert(MemberVO member);
    /* 회원 정보 수정 */
    int modify(MemberVO member);
    /* 회원 권한 수정 */
    void insertAuth(@Param("mno") int mno, @Param("auth") String auth);
    /* 회원 삭제(영구 -> enabled = 0 으로 변경해야함 ) */
    int delete(int no);
    /* 회원 권한 삭제 */
    void deleteAuth(@Param("mno") int mno, @Param("auth") String auth);

    void deleteAllAuth(int mno);

    /* 회원 인원 조회 */
    int getTotalCount(Criteria cri);
    /* 회원 id 중복 검사 */
    int idCheck(String id);
    /* IP 주소 입력(안됨) */
    void insertIpAdr(MemberVisitVO visitVO);

    int passwordCheck(MemberVO member);

}
