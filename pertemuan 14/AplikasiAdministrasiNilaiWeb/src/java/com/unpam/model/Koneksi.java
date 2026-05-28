package com.unpam.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Koneksi {
    private static Connection koneksi;

    public static Connection getKoneksi() {
        if (koneksi == null) {
            try {
                String url = "jdbc:mysql://localhost:3306/db_akademik"; // Sesuaikan nama DB jika berbeda
                String user = "root";
                String pass = ""; // Kosongkan jika menggunakan XAMPP standar
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                koneksi = DriverManager.getConnection(url, user, pass);
                System.out.println("Koneksi database BERHASIL!");
            } catch (ClassNotFoundException | SQLException e) {
                System.out.println("Koneksi ke database GAGAL: " + e.getMessage());
            }
        }
        return koneksi;
    }
}