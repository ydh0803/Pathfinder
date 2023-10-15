package com.example.pathfinder.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

@JsonInclude(JsonInclude.Include.NON_DEFAULT)
@Data
public class NewsDTO {

    String image;

    String headline;

    String link;

    String text;

    int newsNo;

}
