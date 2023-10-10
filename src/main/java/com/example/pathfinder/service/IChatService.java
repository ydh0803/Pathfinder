package com.example.pathfinder.service;

import com.example.pathfinder.model.ChatMessage;

import java.util.List;

public interface IChatService {

    int insertChat(ChatMessage pDTO, String Key) throws Exception;

    int insertJoin(ChatMessage pDTO, String Key) throws Exception;

    List<ChatMessage> fetchChat(String Key) throws Exception;

}