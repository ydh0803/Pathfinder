package com.example.pathfinder.service;

import com.example.pathfinder.dto.TourCertificateDTO;

import java.util.List;

public interface ITourService {

//    List<TourCertificateDTO> getCertification() throws Exception;

    void insertCertificate(TourCertificateDTO pDTO) throws Exception;
}
