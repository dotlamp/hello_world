package com.dotlamp.domain;

import lombok.Data;
import sun.security.krb5.internal.rcache.AuthList;

@Data
public class MemberAuthVO {

    private int mno;
    private String auth;

    public boolean isAuth(String role){
        return auth.equals("ROLE_" + role.toUpperCase());
    }

}
