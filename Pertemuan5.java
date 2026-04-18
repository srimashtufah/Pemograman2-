import java.sql.*;
import java.util.Scanner;

public class Pertemuan5 {

    public static void main(String[] args) {
        try {
            // Memanggil driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Membuat koneksi ke database
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mhs?user=root&password=");

            // Menyiapkan pernyataan SQL
            PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO datamhs (nim, nama, semester, kelas) VALUES (?, ?, ?, ?)"
            );

            // Membuat scanner untuk mengambil input
            Scanner input = new Scanner(System.in);

            // Input data mahasiswa
            System.out.print("Masukkan NIM: ");
            String nim = input.nextLine();  // Ambil input NIM

            System.out.print("Masukkan Nama: ");
            String nama = input.nextLine();  // Ambil input Nama

            System.out.print("Masukkan Semester: ");
            int semester = input.nextInt();  // Ambil input Semester

            System.out.print("Masukkan Kelas: ");
            String kelas = input.next();  // Ambil input Kelas

            // Mengatur parameter untuk PreparedStatement
            statement.setString(1, nim);
            statement.setString(2, nama);
            statement.setInt(3, semester);
            statement.setString(4, kelas);

            // Mengeksekusi pernyataan SQL untuk menyimpan data
            statement.executeUpdate();

            // Menutup koneksi
            statement.close();
            connection.close();

            input.close(); // Tutup scanner

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}