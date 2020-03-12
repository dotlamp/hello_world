package com.dotlamp.task;

import com.dotlamp.domain.AttachVO;
import com.dotlamp.mapper.AttachMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
@Log4j
public class FileCheckTask {

    @Setter(onMethod_ = @Autowired)
    private AttachMapper attachMapper;

    private String getFolderYesterDay(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        String str = sdf.format(cal.getTime());
        return str.replace("-", File.separator);
    }

    @Scheduled(cron = "0 * * 7 * *") /*s,m,h,day,months,dayofweek,(year)*/
    public void checkFiles() throws Exception{
        log.warn("-----------------------------------------file check run");
        log.warn(new Date());
        List<AttachVO> fileList = attachMapper.m_getOldFiles();

        List<Path> fileListPaths = fileList.stream().map(
                vo -> Paths.get("c:\\dotlamp\\upload", vo.getUploadPath(), vo.getUuid()+"_"+vo.getFileName())
        ).collect(Collectors.toList());

        fileList.stream().map(vo -> Paths.get("c:\\dotlamp\\upload", vo.getUploadPath(), "s_"+vo.getUuid()+"_"+vo.getFileName())
        ).forEach(p -> fileListPaths.add(p));

        log.warn("-----------------------------------------file check");

        fileListPaths.forEach(p -> log.warn(p));

        File targetDir = Paths.get("C:\\dotlamp\\upload", getFolderYesterDay()).toFile();

        File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

        log.warn("-----------------------------------------file remove");
        for (File file : removeFiles) {
            log.warn(file.getAbsolutePath());
            file.delete();
        }

        }
}
