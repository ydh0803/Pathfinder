package com.example.pathfinder.Mapper;

import com.example.pathfinder.model.ChatMessage;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IChatMapper {

    int insertChat(ChatMessage pDTO, String Key) throws Exception;

    int insertJoin(ChatMessage pDTO, String Key) throws Exception;

    List<ChatMessage> fetchChat(String Key) throws Exception;
}