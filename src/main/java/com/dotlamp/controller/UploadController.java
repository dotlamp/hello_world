package com.dotlamp.controller;

import com.dotlamp.domain.AttachFileDTO;
import com.dotlamp.domain.AttachVO;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@Log4j
@RequestMapping("/upload/*")
public class UploadController {

/*    @GetMapping("/uploadForm")
    public void uploadForm() {
        log.info("uploadForm");
    }

    @PostMapping("/uploadFormAction")
    public void uploadFoemPost(MultipartFile[] uploadFile, Model model) {
        String uploadFolder = "c:\\dotlamp\\upload";
        for(MultipartFile multipartFile : uploadFile) {
            log.info("upload File Name:"+multipartFile.getOriginalFilename());
            log.info("upload File Size:"+multipartFile.getSize());
            File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
            try {
                multipartFile.transferTo(saveFile);
            }catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }*/

    @GetMapping("/uploadAjax")
    public void uploadAjax() {
        log.info("upload ajax");
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
//	public void uploadAjaxPost(MultipartFile[] uploadFile) {
    public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
        log.info("update ajax post.........");
        List<AttachFileDTO> list = new ArrayList<>();
        String uploadFolder = "C:\\dotlamp\\hello_world\\src\\main\\webapp\\resources\\img";

        String uploadFolderPath = "profile";
        File uploadPath = new File(uploadFolder, "profile"); //C:\dotlamp\hello_world\src\main\webapp\resources\img\profile
       if(uploadPath.exists() == false) {
            uploadPath.mkdirs();
            log.info("make folder:"+uploadPath);
        }

        for (MultipartFile multipartFile : uploadFile) {
            AttachFileDTO attachDTO = new AttachFileDTO();
            log.info("-------------------------------------");
            log.info("Upload File Name: " + multipartFile.getOriginalFilename());
            log.info("Upload File Size: " + multipartFile.getSize()+"Byte");

            String uploadFileName = multipartFile.getOriginalFilename();

            // IE has file path
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
            attachDTO.setFileName(uploadFileName);

            // uuid 생성 (파일 중복 방지)
            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;
            log.info("only file name: " + uploadFileName);

            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachDTO.setUuid(uuid.toString());
                attachDTO.setUploadPath(uploadFolderPath);
                if(checkImageType(saveFile)) {
                    attachDTO.setImage(true);
                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+ uploadFileName));
                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
                    thumbnail.close();
                }
                list.add(attachDTO);
            } catch (Exception e) {
                e.printStackTrace();
            } // end catch
        } // end for
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping("/uploadAjax2")
    public void uploadAjax2() {
        log.info("upload ajax");
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/uploadAjaxAction2", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
//	public void uploadAjaxPost(MultipartFile[] uploadFile) {
    public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost2(MultipartFile[] uploadFile) {
        log.info("update ajax post.........");
        List<AttachFileDTO> list = new ArrayList<>();
        String uploadFolder = "C:\\dotlamp\\hello_world\\src\\main\\webapp\\resources\\img";

        String uploadFolderPath = getFolder();
        File uploadPath = new File(uploadFolder, getFolder()); //C:\dotlamp\hello_world\src\main\webapp\resources\img\yyyy\mm\dd
        if(uploadPath.exists() == false) {
            uploadPath.mkdirs();
            log.info("make folder:"+uploadPath);
        }

        for (MultipartFile multipartFile : uploadFile) {
            AttachFileDTO attachDTO = new AttachFileDTO();
            log.info("-------------------------------------");
            log.info("Upload File Name: " + multipartFile.getOriginalFilename());
            log.info("Upload File Size: " + multipartFile.getSize()+"Byte");

            String uploadFileName = multipartFile.getOriginalFilename();

            // IE has file path
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
            attachDTO.setFileName(uploadFileName);

            // uuid 생성 (파일 중복 방지)
            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;
            log.info("only file name: " + uploadFileName);

            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachDTO.setUuid(uuid.toString());
                attachDTO.setUploadPath(uploadFolderPath);
                if(checkImageType(saveFile)) {
                    attachDTO.setImage(true);
                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+ uploadFileName));
                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
                    thumbnail.close();
                }
                list.add(attachDTO);
            } catch (Exception e) {
                e.printStackTrace();
            } // end catch
        } // end for
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping("/display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String fileName) { //getFIle : 파일의 경로가 포함이 된,  fileName을 받음
        log.info("fileName: " + fileName); //profile/s_@@@_###.png
        File file = new File("C:\\dotlamp\\hello_world\\src\\main\\webapp\\resources\\img\\"+fileName);
        log.info("file: " + file);
        ResponseEntity<byte[]> result = null;
        try {
            HttpHeaders header = new HttpHeaders();
            header.add("Content-Type", Files.probeContentType(file.toPath()));
            /* probeContentType : MIME 타입 데이터를 Http 헤더 메시지에 포함되도록 처리 */
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    @GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
        Resource resource = new FileSystemResource("C:\\dotlamp\\hello_world\\src\\main\\webapp\\resources\\img\\"+fileName);
        if(resource.exists() == false) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        String resourceName = resource.getFilename();

        String resourceOringalName = resourceName.substring(resourceName.indexOf("_")+1);
        HttpHeaders headers = new HttpHeaders();

        try {
            String downloadName = null;
            if(userAgent.contains("Trident")) {
                log.info("IE browser");
                downloadName = URLEncoder.encode(resourceOringalName, "UTF-8").replaceAll("\\+", " ");
            }else if(userAgent.contains("Edge")) {
                log.info("Edge browser");
                downloadName = URLEncoder.encode(resourceOringalName, "UTF-8");
            }else {
                log.info("other browser");
                downloadName = new String(resourceOringalName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1);
            }

            headers.add("Content-Disposition", "attachment; filename="+downloadName);
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/deleteFile")
    @ResponseBody
    public ResponseEntity<String> deleteFile(String fileName, String type) {
        log.info("deleteFile: " + fileName);
        File file;
        try {
            file = new File("C:\\dotlamp\\hello_world\\src\\main\\webapp\\resources\\img\\" + URLDecoder.decode(fileName, "UTF-8"));
            file.delete();
            if (type.equals("image")) {
                String largeFileName = file.getAbsolutePath().replace("s_", "");
                log.info("largeFileName: " + largeFileName);
                file = new File(largeFileName);
                file.delete();
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<String>("deleted", HttpStatus.OK);
    }

    private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        return str.replace("-", File.separator);
    }

    private boolean checkImageType(File file) {
        try {
            String contentType = Files.probeContentType(file.toPath());
            return contentType.startsWith("image");
        }catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
} //UploadController
