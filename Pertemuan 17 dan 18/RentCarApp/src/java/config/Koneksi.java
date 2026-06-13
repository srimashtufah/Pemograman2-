package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Koneksi {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Meload driver MySQL modern
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Menghubungkan ke db_rentcar di localhost XAMPP
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_rentcar", "root", "");
            System.out.println("LOG: Koneksi Database Berhasil!");
        } catch (Exception e) {
            System.out.println("LOG GAGAL KONEKSI: " + e.getMessage());
        }
        return conn;
    }
}