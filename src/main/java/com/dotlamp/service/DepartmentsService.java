package com.dotlamp.service;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.DepartmentVO;

import java.util.List;

public interface DepartmentsService {

    void register(DepartmentVO departmentVO);

    DepartmentVO get(int dno);

    boolean modify(DepartmentVO departmentVO);

    boolean remove(int dno);

    List<DepartmentVO> getList(Criteria cri);

    int getTotal(Criteria cri); //전체글갯수

}
