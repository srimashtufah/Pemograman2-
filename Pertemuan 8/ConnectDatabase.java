import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDatabase {
    public static Connection getConnectDatabase() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // FIX

            String url = "jdbc:mysql://localhost:3306/mahasiswa?useSSL=false&serverTimezone=UTC";
            String user = "root";
            String pass = "";

            Connection konek = DriverManager.getConnection(url, user, pass);
            System.out.println("Koneksi ke Database Berhasil!");
            return konek;

        } catch (ClassNotFoundException e) {
            System.err.println(e.getMessage());
            return null;
        } catch (SQLException e) {
            System.err.println("Koneksi Gagal! " + e.getMessage());
            return null;
        }
    }
}