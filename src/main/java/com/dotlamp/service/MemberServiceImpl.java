package com.dotlamp.service;

import com.dotlamp.domain.AttachVO;
import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.MemberAuthVO;
import com.dotlamp.domain.MemberVO;
import com.dotlamp.mapper.AttachMapper;
import com.dotlamp.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

    @Setter(onMethod_ = @Autowired)
    private MemberMapper mapper;

    @Setter(onMethod_ = @Autowired)
    private AttachMapper attachMapper;

    @Setter(onMethod_ = @Autowired)
    PasswordEncoder passwordEncoder;

    @Override
    public List<MemberVO> getList(Criteria cri) {
        return mapper.getList(cri);
    }

    @Override
    public MemberVO get(int mno) {
        return mapper.get(mno);
    }

    @Transactional
    @Override
    public void register(MemberVO member) {
        /* 패스워드 암호화 */
        String rowPassword = member.getPassword();
        String encodedPassword = new BCryptPasswordEncoder().encode(rowPassword);
        /*log.info(encodedPassword);*/
        member.setPassword(encodedPassword);
        /* 회원 정보 */
        mapper.insert(member);
        /*회원 권한 */

        /*일반사용자 권한 부여 */
        mapper.insertAuth(member.getMno(), "ROLE_USER");

        /*첨부파일 */
        if(member.getAttachList() == null || member.getAttachList().size() <= 0){
            return;
        }
        member.getAttachList().forEach(attach->{
            attach.setMno(member.getMno());
        System.out.println(attach);
           attachMapper.m_insert(attach);
        });
    }

    @Override
    public boolean remove(int no) {
        /*log.info("remove : "+ id);*/
        attachMapper.m_deleteAll(no);
        mapper.deleteAllAuth(no);
        return mapper.delete(no) == 1;
    }

    @Override
    public int getTotalCount(Criteria cri) {
        return mapper.getTotalCount(cri);
    }

    @Override
    public boolean passwordChange(MemberVO member) {
        String rowPassword = member.getPassword();
        String encodedPassword = new BCryptPasswordEncoder().encode(rowPassword);
        member.setPassword(encodedPassword);
        boolean pwChangeResult = mapper.passwordChange(member) == 1;
        return pwChangeResult;
    }

    @Override
    public boolean passwordCheck(MemberVO member) {
        String rowPassword = member.getPassword();
        log.warn(rowPassword);
        final MemberVO memberGet = mapper.get(member.getMno());
        String dbPassword = memberGet.getPassword();
        boolean resultPassword = passwordEncoder.matches(rowPassword, dbPassword);
        return resultPassword;
    }

    @Override
    public List<AttachVO> getAttachList(int no) {
        return attachMapper.m_findByNo(no);
    }

    @Override
    public int idCheck(String id) {
        return mapper.idCheck(id);
    }

    @Override
    public boolean modify(MemberVO member) {

        attachMapper.m_deleteAll(member.getMno());
        boolean modifyResult = mapper.modify(member) == 1;
        if(modifyResult && member.getAttachList() != null || member.getAttachList().size() <= 0){
            member.getAttachList().forEach(attach -> {
                attach.setMno(member.getMno());
                attachMapper.m_insert(attach);
            });
        }
        return modifyResult;
    }

    @Override
    public MemberVO read(String id) {
        return mapper.read(id);
    }

    @Override
    public MemberVO toggleRole(int mno, String auth) {
        MemberVO member = mapper.get(mno);
        log.warn(member.getMno());
        log.warn(member.hasAuth(auth));
        if(!member.hasAuth(auth)){
            mapper.insertAuth(member.getMno(), "ROLE_"+auth.toUpperCase());
            log.warn("Bok");
        }else{
            mapper.deleteAuth(member.getMno(), "ROLE_"+auth.toUpperCase());
            log.warn("Dok");
        }
        return mapper.read(member.getId());
    }

  /*  private void toggleRole(int userId, String role) {
        User user = userMapper.selectUserById(userId);
        if (! user.hasRole(role))
            userMapper.insertAuthority(user.getEmail(), "ROLE_" + role.toUpperCase());
        else
            userMapper.deleteAuthority(user.getEmail(), "ROLE_" + role.toUpperCase());
    }*/

} //MemberServiceImpl


