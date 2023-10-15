package com.example.pathfinder.Mapper;

import com.example.pathfinder.dto.BookmarkDTO;
import com.example.pathfinder.dto.CertificationDTO;
import com.example.pathfinder.dto.TourCertificateDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ITourMapper {

//     완주한 종주코스 등록 및 조회
    void regCertificate(TourCertificateDTO pDTO) throws Exception;

//    List<TourCertificateDTO> getCertificate(TourCertificateDTO pDTO) throws Exception;

    List<TourCertificateDTO> getStamp(TourCertificateDTO bDTO) throws Exception;
}
