import java.sql.Connection;
import java.sql.DriverManager;

    public class ConnectDatabase {

        private static Connection conn;

        public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                String url = "jdbc:mysql://localhost:3306/db_penjualan";
                String user = "root";
                String password = "";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                System.out.println("Koneksi database berhasil");
            }
        } catch (Exception e) {
            System.out.println("Koneksi gagal : " + e.getMessage());
        }

        return conn;
    }
}