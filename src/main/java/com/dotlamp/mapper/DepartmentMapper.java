package com.dotlamp.mapper;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.DepartmentVO;

import java.util.List;

public interface DepartmentMapper {

    List<DepartmentVO> getListWithPaging(Criteria cri);

    void insert(DepartmentVO departmentVO);

    DepartmentVO read(int dno);

    int delete(int dno);

    int update(DepartmentVO departmentVO);

    int getTotalCount(Criteria cri);
}
