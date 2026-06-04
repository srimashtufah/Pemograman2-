package com.unpam.controller;

import com.unpam.model.Koneksi;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MahasiswaController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if (action != null && action.equalsIgnoreCase("tambah")) {
            String nim = request.getParameter("nim");
            String nama = request.getParameter("nama");
            String kelas = request.getParameter("kelas");
            String semester = request.getParameter("semester");
            
            Connection conn = null;
            PreparedStatement ps = null;
            
            try {
                conn = Koneksi.getKoneksi();
                
                if (conn != null) {
                    String sql = "INSERT INTO mahasiswa (nim, nama, kelas, semester) VALUES (?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, nim);
                    ps.setString(2, nama);
                    ps.setString(3, kelas);
                    ps.setInt(4, Integer.parseInt(semester));
                    
                    int rowsInserted = ps.executeUpdate();
                    if (rowsInserted > 0) {
                        // Menggunakan Session agar data status "sukses" tetap terbawa saat redirect
                        request.getSession().setAttribute("resStatus", "sukses");
                        request.getSession().setAttribute("resAction", "tambah");
                    }
                } else {
                    request.getSession().setAttribute("resStatus", "gagal");
                    System.out.println("Gagal simpan: Koneksi database null.");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("resStatus", "gagal");
                System.out.println("Gagal simpan data: " + e.getMessage());
            } finally {
                if (ps != null) try { ps.close(); } catch (Exception e) {}
            }
            
            // Setelah proses tambah data selesai, paksa browser redirect agar halaman refresh sempurna
            response.sendRedirect("MahasiswaController");
            return; // Hentikan eksekusi method agar tidak bentrok dengan forward di bawah
        }
        
        // Jika request biasa (tanpa action tambah / hanya GET), langsung buka halaman mahasiswa.jsp
        request.getRequestDispatcher("mahasiswa.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}