package com.dotlamp.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class BoardVO {

	private int bno;
	private String title;
	private String content;
	private int writer;
	private Date regDate;
	private Date updateDate;
	private int replyCnt;
	private int viewCnt;
	private List<AttachVO> attachList;
	private List<MemberVO> memberList;
}
