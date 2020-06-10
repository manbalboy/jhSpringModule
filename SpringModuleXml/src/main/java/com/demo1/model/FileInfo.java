package com.demo1.model;

import java.io.File;
import java.nio.file.Paths;



public class FileInfo {
	private String gid; //파일 그룹 아이디
	private String id; //파일 아이디
	private String path; //마운트 디렉트리 이하 패스 - > 업로드시 /마운트티렉토리/path 
	private String fileType; //video,img,doc, ..... 메타 끌어내서 가져올 예정 협의 필요 TBD
	private String fileName; // 리네임된 파일명 -> 저장시 앞에 /
	private String originalName; //업로드시 원본 파일명
	private int fileSize;
	
	public File getFile(String nasPath) {
		System.out.printf("%s/%s/%s" ,nasPath, path, fileName );
		File file = Paths.get(nasPath, path, fileName).toFile(); 
    	if(!file.exists()){
    		System.out.println("not exists " +file.getAbsoluteFile().toPath()); //주석 삭제용
    		file.mkdirs(); 
    	}
    	return file;
	}
	
	public String getGid() {
		return gid;
	}
	public void setGid(String gid) {
		this.gid = gid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

}
