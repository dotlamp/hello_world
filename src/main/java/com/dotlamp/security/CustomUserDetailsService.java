package com.dotlamp.security;

import com.dotlamp.domain.MemberVO;
import com.dotlamp.domain.SecurityMember;
import com.dotlamp.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/* 실제 인증과정을 처리하는 클래스 */
@Log4j
@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		log.warn("Load User by UserName : "+id);
		MemberVO vo = memberMapper.read(id);
		log.warn("member mapper :"+vo);
		return vo == null ? null : new SecurityMember(vo);
/*	return Optional.ofNullable(memberMapper.read(id)).filter(m -> m!= null).map(m-> new SecurityMember(m)).get();*/

	}



}
