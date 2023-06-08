package com.example.pathfinder.controller;

import com.example.pathfinder.util.ApiParse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;

@Controller
public class mainController {
    @RequestMapping("/")
    public String main() throws IOException {

        return "index";
    }
}

