package com.dotlamp.domain;

import lombok.Data;

import java.util.Date;

@Data
public class ReplyVO {

	private int rno;
	private int bno;
	
	private String reply;
	private int replyer;
	private Date replyDate;
	private Date updateDate;

	private String id;
	private String name;
}
