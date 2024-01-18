package kr.bit.entity;

import lombok.Data;

@Data
public class ApiDataDto {
	private String userId;
	private String bizId; //정책ID
	private String polyItcnCn; //정책소개
    private String polyBizSjnm; //정책명
    private String rqutPrdCn; //신청기간
    private String rqutUrla; //기관 URL
    private String cnsgNmor; //신청기관 명
    private String ageInfo; //신청연령
    private String sporCn; //지원내용
    private String rqutProcCn; //신청절차
    private String jdgnPresCn; //심사발표
    private String empmSttsCn; //취업상태
    private String accrRqisCn; //학력
    private String majrRqisCn; //전공
    private String splzRlmRqisCn; //특화분야
}
