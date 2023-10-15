package com.example.pathfinder.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@JsonInclude(JsonInclude.Include.NON_DEFAULT)
@Getter
@Setter
public class CertificationDTO {
    private String certificationNo;
    private String title;
    private String addr1;

}