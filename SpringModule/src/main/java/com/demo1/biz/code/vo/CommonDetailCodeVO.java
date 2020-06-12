package com.demo1.biz.code.vo;

import java.util.Date;

import com.demo1.biz.comm.vo.SearchDefaultVO;

/**
 * <pre>
 * SpringModule (After JDK 11)
 * 1. 클래스명 : CommonDetailCodeVO.java
 * 2. 작성일 : 2020. 6. 13.
 * 3. 작성자 : 정훈
 * 4. 설명 : 공통상세코드 VO 객체
 * </pre>
 */
public class CommonDetailCodeVO extends SearchDefaultVO{
    private static final long serialVersionUID = 1L;

    private String codeId;
    private String code;
    private String codeName;
    private String codeDescription;
    private String useYn;
    private Date registrationDate;
    private String registerId;
    private Date updateDate;
    private String updateUserId;
    private int sort;
    /**
     * @return the codeId
     */
    public String getCodeId() {
        return codeId;
    }
    /**
     * @param codeId the codeId to set
     */
    public void setCodeId(String codeId) {
        this.codeId = codeId;
    }
    /**
     * @return the code
     */
    public String getCode() {
        return code;
    }
    /**
     * @param code the code to set
     */
    public void setCode(String code) {
        this.code = code;
    }
    /**
     * @return the codeName
     */
    public String getCodeName() {
        return codeName;
    }
    /**
     * @param codeName the codeName to set
     */
    public void setCodeName(String codeName) {
        this.codeName = codeName;
    }
    /**
     * @return the codeDescription
     */
    public String getCodeDescription() {
        return codeDescription;
    }
    /**
     * @param codeDescription the codeDescription to set
     */
    public void setCodeDescription(String codeDescription) {
        this.codeDescription = codeDescription;
    }
    /**
     * @return the useYn
     */
    public String getUseYn() {
        return useYn;
    }
    /**
     * @param useYn the useYn to set
     */
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    /**
     * @return the registrationDate
     */
    public Date getRegistrationDate() {
        return registrationDate;
    }
    /**
     * @param registrationDate the registrationDate to set
     */
    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }
    /**
     * @return the registerId
     */
    public String getRegisterId() {
        return registerId;
    }
    /**
     * @param registerId the registerId to set
     */
    public void setRegisterId(String registerId) {
        this.registerId = registerId;
    }
    /**
     * @return the updateDate
     */
    public Date getUpdateDate() {
        return updateDate;
    }
    /**
     * @param updateDate the updateDate to set
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    /**
     * @return the updateUserId
     */
    public String getUpdateUserId() {
        return updateUserId;
    }
    /**
     * @param updateUserId the updateUserId to set
     */
    public void setUpdateUserId(String updateUserId) {
        this.updateUserId = updateUserId;
    }
    /**
     * @return the sort
     */
    public int getSort() {
        return sort;
    }
    /**
     * @param sort the sort to set
     */
    public void setSort(int sort) {
        this.sort = sort;
    }
    /**
     * @return the serialversionuid
     */
    public static long getSerialversionuid() {
        return serialVersionUID;
    }



}
