package com.example.pathfinder.Mapper;

import com.example.pathfinder.dto.CalendarDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ICalendarMapper {

    List<CalendarDTO> getCalendarList(CalendarDTO pDTO) throws Exception;

    int insertCalendar(CalendarDTO pDTO) throws Exception;

    int deleteCalendar(CalendarDTO pDTO) throws Exception;

    int updateCalendar(CalendarDTO pDTO) throws Exception;

}