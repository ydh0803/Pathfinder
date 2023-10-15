package com.example.pathfinder.service.impl;

import com.example.pathfinder.Mapper.ITourMapper;
import com.example.pathfinder.dto.BookmarkDTO;
import com.example.pathfinder.dto.TourCertificateDTO;
import com.example.pathfinder.service.ITourService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@Service
public class TourService implements ITourService {

    @Autowired
    private ITourMapper tourMapper;

    public void insertCertificate(TourCertificateDTO pDTO) throws Exception {
        tourMapper.regCertificate(pDTO);

    }

    public List<TourCertificateDTO> getStamp(TourCertificateDTO bDTO) throws Exception{
        log.info(this.getClass().getName() + ".stamp select start");
        log.info(String.valueOf(bDTO));
        return tourMapper.getStamp(bDTO);

    }

//    public List<TourCertificateDTO> selectCertificate(TourCertificateDTO pDTO) throws Exception {
//        return tourMapper.getCertificate(pDTO);
//    }


}
