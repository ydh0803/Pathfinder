package com.example.pathfinder.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.example.pathfinder.dto.WeatherDTO;
import com.example.pathfinder.dto.WeatherDailyDTO;
import com.example.pathfinder.service.IWeatherService;
import com.example.pathfinder.util.CmmUtil;
import com.example.pathfinder.util.DateUtil;
import com.example.pathfinder.util.NetworkUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.util.*;

@Slf4j
@Service("WeatherService")
public class WeatherService implements IWeatherService {
    @Value("${weather.api.key}")
    private String apiKey;


    @Override
    public WeatherDTO getWeather(WeatherDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + " weather start");

        String lat = CmmUtil.nvl(pDTO.getLat());
        String lon = CmmUtil.nvl(pDTO.getLon());

        String apiParam = "?lat=" + lat + "&lon=" + lon + "&appid=" + apiKey + "&units=metric" + "&lang=kr";
// + "&lang=kr"
        String json = NetworkUtil.get(IWeatherService.apiURL + apiParam);

        Map<String, Object> rMap = new ObjectMapper().readValue(json, LinkedHashMap.class);

        Map<String, Double> current = (Map<String, Double>) rMap.get("current");


        double currentTemp = current.get("temp");
        log.info("현재기온:" + currentTemp);

        List<Map<String, Object>> dailyList = (List<Map<String, Object>>) rMap.get("daily");



        List<WeatherDailyDTO> pList = new LinkedList<>();
        for (Map<String, Object> dailyMap : dailyList) {
            String day = DateUtil.getLongDateTime(dailyMap.get("dt"), "yyyy-MM-dd");

            WeatherDailyDTO wdDTO = new WeatherDailyDTO();
            String uvi = String.valueOf(dailyMap.get("uvi"));
            String humidity = String.valueOf(dailyMap.get("humidity"));
            String pop = String.valueOf(dailyMap.get("pop"));
            String wind = String.valueOf(dailyMap.get("wind_speed"));
            List<Map<String, Object>> weather = (List<Map<String, Object>>) dailyMap.get("weather");
            for (Map<String, Object> weatherMap : weather){
                String icon = String.valueOf(weatherMap.get("icon"));
                String description = String.valueOf(weatherMap.get("description"));

                log.info(description);
                wdDTO.setIcon(icon);
                wdDTO.setDescription(description);
            }
            wdDTO.setWind(wind);
            wdDTO.setUvi(uvi);
            wdDTO.setHumidity(humidity);
            wdDTO.setPop(pop);

            String sunrise = DateUtil.getLongDateTime(dailyMap.get("sunrise")).substring(11, 16);
            String sunset = DateUtil.getLongDateTime(dailyMap.get("sunset")).substring(11, 16);

            Map<String, Double> dailyTemp = (Map<String, Double>) dailyMap.get("temp");
            String dayTemp = String.valueOf(dailyTemp.get("day"));
            String dayTempMax = String.valueOf(dailyTemp.get("max"));
            String dayTempMin = String.valueOf(dailyTemp.get("min"));
            wdDTO.setDay(day);
            wdDTO.setSunrise(sunrise);
            wdDTO.setSunset(sunset);
            wdDTO.setDayTemp(dayTemp);
            wdDTO.setDayTempMax(dayTempMax);
            wdDTO.setDayTempMin(dayTempMin);
            pList.add(wdDTO);
            wdDTO = null;
        }

        WeatherDTO rDTO = new WeatherDTO();
        rDTO.setLat(lat);
        rDTO.setLon(lon);
        rDTO.setDailyList(pList);
        rDTO.setCurrentTemp(currentTemp);

        return rDTO;
    }



}