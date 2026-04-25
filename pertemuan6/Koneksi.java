import java.sql.*;

public class Koneksi {          // ← Nama class harus Koneksi
    public static Connection getKoneksi() {
        Connection conn = null;
        String url = "jdbc:mysql://localhost:3306/db_nilai?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String pass = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);
            System.out.println("✅ Koneksi Berhasil!");
        } catch (Exception e) {
            System.out.println("❌ Gagal Koneksi: " + e.getMessage());
        }
        return conn;
    }
}