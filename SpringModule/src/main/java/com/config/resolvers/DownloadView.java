package com.config.resolvers;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.demo1.model.FileInfo;


public class DownloadView extends AbstractView {
	
	@Value("${config.mnt.dir}")
	private String mntDir;
	public DownloadView() {
		setContentType("applicaiton/download;charset=utf-8");
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.view.AbstractView#renderMergedOutputModel(java.util.Map, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 * 파일 다운로드. response체로 write하는 프로그램
	 * 해더 정보는 학습하면 좋을거 같음...
	 */
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		/*
		 * 비정상 케이스에 대한 처리 필요
		 * 파일없을때 
		 * 권한이 필요할때 등... TBD 
		 */
		FileInfo fileInfo = (FileInfo)model.get("fileInfo");
		File file = fileInfo.getFile(mntDir);

		response.setContentType(getContentType());
		response.setContentLength((int) file.length());

		String fileName = java.net.URLEncoder.encode(fileInfo.getFileName(), "UTF-8");

		response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;

		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e2) {
				}
			}
		}
		out.flush();

	}

}
