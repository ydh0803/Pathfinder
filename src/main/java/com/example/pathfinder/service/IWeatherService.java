package com.example.pathfinder.service;

import com.example.pathfinder.dto.WeatherDTO;

import java.util.List;
import java.util.Map;

public interface IWeatherService {

    String apiURL = "https://api.openweathermap.org/data/3.0/onecall";
    WeatherDTO getWeather(WeatherDTO pDTO) throws Exception;


}