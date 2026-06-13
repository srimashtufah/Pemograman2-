package controller;

import config.Koneksi;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RentCarController", urlPatterns = {"/RentCarController"})
public class RentCarController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        System.out.println("LOG SYSTEM: Mengakses aksi -> " + action);
        
        try (Connection conn = Koneksi.getConnection()) {
            if (conn == null) {
                System.out.println("LOG SYSTEM: Gagal tersambung ke Database!");
                return;
            }

            // 1. PROSES SIMPAN MOBIL
            if ("insert-mobil".equals(action)) {
                String noPlat = request.getParameter("no_plat");
                String merk = request.getParameter("merk");
                int hargaSewa = Integer.parseInt(request.getParameter("harga_sewa"));
                String status = request.getParameter("status");

                String sql = "INSERT INTO tbl_mobil (no_plat, merk, harga_sewa, status) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, noPlat);
                ps.setString(2, merk);
                ps.setInt(3, hargaSewa);
                ps.setString(4, status);
                ps.executeUpdate();
                response.sendRedirect("input-mobil.jsp");
            }
            
            // 2. PROSES SIMPAN CUSTOMER
            else if ("insert-customer".equals(action)) {
                String nik = request.getParameter("nik");
                String nama = request.getParameter("nama");
                String noTelp = request.getParameter("no_telp");
                String alamat = request.getParameter("alamat");

                String sql = "INSERT INTO tbl_customer (nik, nama, no_telp, alamat) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, nik);
                ps.setString(2, nama);
                ps.setString(3, noTelp);
                ps.setString(4, alamat);
                ps.executeUpdate();
                response.sendRedirect("input-customer.jsp");
            }
            
            // 3. PROSES TRANSAKSI SEWA
            else if ("sewa".equals(action)) {
                String nik = request.getParameter("nik");
                String noPlat = request.getParameter("no_plat");
                String tglPinjam = request.getParameter("tgl_pinjam");
                String tglKembaliEstimasi = request.getParameter("tgl_kembali_estimasi");

                String sqlTransaksi = "INSERT INTO tbl_transaksi (nik, no_plat, tgl_pinjam, tgl_kembali_estimasi, status_transaksi) VALUES (?, ?, ?, ?, 'Berjalan')";
                PreparedStatement psTrans = conn.prepareStatement(sqlTransaksi);
                psTrans.setString(1, nik);
                psTrans.setString(2, noPlat);
                psTrans.setString(3, tglPinjam);
                psTrans.setString(4, tglKembaliEstimasi);
                psTrans.executeUpdate();

                String sqlMobil = "UPDATE tbl_mobil SET status = 'Disewa' WHERE no_plat = ?";
                PreparedStatement psMobil = conn.prepareStatement(sqlMobil);
                psMobil.setString(1, noPlat);
                psMobil.executeUpdate();

                response.sendRedirect("input-sewa.jsp");
            }
            
            // 4. PROSES PENGEMBALIAN MOBIL
            else if ("kembali".equals(action)) {
                int idTransaksi = Integer.parseInt(request.getParameter("id_transaksi"));
                String tglKembaliRealisasi = request.getParameter("tgl_kembali_realisasi");
                String noPlat = request.getParameter("no_plat");
                
                String sqlCari = "SELECT t.tgl_pinjam, t.tgl_kembali_estimasi, m.harga_sewa FROM tbl_transaksi t "
                               + "JOIN tbl_mobil m ON t.no_plat = m.no_plat WHERE t.id_transaksi = ?";
                PreparedStatement psCari = conn.prepareStatement(sqlCari);
                psCari.setInt(1, idTransaksi);
                ResultSet rs = psCari.executeQuery();
                
                if (rs.next()) {
                    LocalDate pinjam = LocalDate.parse(rs.getString("tgl_pinjam"));
                    LocalDate estimasi = LocalDate.parse(rs.getString("tgl_kembali_estimasi"));
                    LocalDate realisasi = LocalDate.parse(tglKembaliRealisasi);
                    int hargaSewa = rs.getInt("harga_sewa");
                    
                    long totalHari = ChronoUnit.DAYS.between(pinjam, realisasi);
                    if (totalHari <= 0) totalHari = 1; 
                    int totalBayar = (int) totalHari * hargaSewa;
                    
                    long keterlambatan = ChronoUnit.DAYS.between(estimasi, realisasi);
                    int denda = 0;
                    if (keterlambatan > 0) {
                        denda = (int) keterlambatan * 100000; // Telat sehari denda 100rb
                        totalBayar += denda;
                    }
                    
                    String sqlUpdateTrans = "UPDATE tbl_transaksi SET tgl_kembali_realisasi = ?, total_bayar = ?, denda = ?, status_transaksi = 'Selesai' WHERE id_transaksi = ?";
                    PreparedStatement psUp = conn.prepareStatement(sqlUpdateTrans);
                    psUp.setString(1, tglKembaliRealisasi);
                    psUp.setInt(2, totalBayar);
                    psUp.setInt(3, denda);
                    psUp.setInt(4, idTransaksi);
                    psUp.executeUpdate();
                    
                    String sqlUpMobil = "UPDATE tbl_mobil SET status = 'Tersedia' WHERE no_plat = ?";
                    PreparedStatement psMob = conn.prepareStatement(sqlUpMobil);
                    psMob.setString(1, noPlat);
                    psMob.executeUpdate();
                }
                response.sendRedirect("laporan-transaksi.jsp");
            }
        } catch (Exception e) {
            System.out.println("LOG ERROR CONTROLLER: " + e.getMessage());
        }
    }
}