package com.ems.test;
import com.ems.utils.DBConnect;
import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        Connection conn = DBConnect.getConnection();
        if (conn != null) {
            System.out.println("Connection Successful!");
        } else {
            System.out.println("Connection Failed!");
        }
    }
}
