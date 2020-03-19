package com.dotlamp.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class MemberVO {

    private int mno;
    private String id;
    private String password;
    private String name;
    private boolean enabled;
    private String gender;
    private String birth;
    private String email;
    private String tel1;
    private String tel2;
    private String tel3;
    private String post;
    private String adr1;
    private String adr2;
    private String adr3;

    private Date regDate;
    private Date updateDate;

    private int dno;

    private List<AttachVO> attachList;
    private List<MemberAuthVO> authList;



    public   boolean hasAuth(String role){
        for(MemberAuthVO auth : authList){
            if(auth.isAuth(role)){
                return true;
            }
        }
        return false;
    }

}
