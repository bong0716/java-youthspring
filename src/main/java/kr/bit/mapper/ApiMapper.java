package kr.bit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.bit.entity.ApiDataDto;
import kr.bit.entity.Member;

public interface ApiMapper {
	
	public void dataInsert(ApiDataDto vo);
     public List<ApiDataDto> getList(String userId);
     public void dataDelete(@Param("userId") String userId, @Param("bizId") String bizId);
     public List<ApiDataDto> getHotList();

}
