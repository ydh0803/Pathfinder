package com.example.pathfinder.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Today {
    public static String today(){

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

        Calendar c1 = Calendar.getInstance();

        String strToday = sdf.format(c1.getTime());



        System.out.println("Today=" + strToday);

        return strToday;

    }

}

