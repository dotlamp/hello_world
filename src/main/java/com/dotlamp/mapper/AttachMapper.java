package com.dotlamp.mapper;

import com.dotlamp.domain.AttachVO;

import java.util.List;

public interface AttachMapper {
    /* 첨부파일 삽입 */
    void m_insert(AttachVO vo);
    /* 첨부파일 삭제 */
    void m_delete(String uuid);
    /* 첨부파일 조회 */
    List<AttachVO> m_findByNo(int no);
    /* 첨부파일 삭제 */
    void m_deleteAll(int no);
    /* DB 비교 누락 파일 */
    List<AttachVO> m_getOldFiles();

    /* 첨부파일 삽입 */
    void b_insert(AttachVO vo);
    /* 첨부파일 삭제 */
    void b_delete(String uuid);
    /* 첨부파일 조회 */
    List<AttachVO> b_findByNo(int no);
    /* 첨부파일 삭제 */
    void b_deleteAll(int no);
    /* DB 비교 누락 파일 */
    List<AttachVO> b_getOldFiles();


} //MemberAttachMapper
