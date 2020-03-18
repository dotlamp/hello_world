package com.dotlamp.service;

import com.dotlamp.domain.Criteria;
import com.dotlamp.domain.DepartmentVO;
import com.dotlamp.mapper.DepartmentMapper;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public class DepartmentsServiceImpl implements DepartmentsService {

    @Setter(onMethod_ = @Autowired)
    private DepartmentMapper mapper;

    @Transactional
    @Override
    public void register(DepartmentVO departmentVO) {
        mapper.insert(departmentVO);
    }

    @Override
    public DepartmentVO get(int dno) {
        return mapper.read(dno);
    }

    @Transactional
    @Override
    public boolean modify(DepartmentVO departmentVO) {
        boolean modifyResult = mapper.update(departmentVO) ==1;
        return modifyResult;
    }

    @Transactional
    @Override
    public boolean remove(int dno) {
        return mapper.delete(dno) ==1;
    }

    @Override
    public List<DepartmentVO> getList(Criteria cri) {
        return mapper.getListWithPaging(cri);
    }

    @Override
    public int getTotal(Criteria cri) {
        return mapper.getTotalCount(cri);
    }
}
