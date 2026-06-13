package controller;

import config.Koneksi;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    // PROSES LOGIN (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        try (Connection conn = Koneksi.getConnection()) {
            String sql = "SELECT * FROM tbl_admin WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Login Berhasil, Buat Jejak Session di Server
                HttpSession session = request.getSession();
                session.setAttribute("admin_user", rs.getString("username"));
                session.setAttribute("admin_nama", rs.getString("nama_lengkap"));
                
                System.out.println("LOG SYSTEM: Admin '" + user + "' Berhasil Masuk.");
                response.sendRedirect("index.jsp");
            } else {
                // Login Gagal, Kembalikan ke login.jsp dengan Flag Error
                response.sendRedirect("login.jsp?error=failed");
            }
        } catch (Exception e) {
            System.out.println("LOG LOGIN ERROR: " + e.getMessage());
            response.sendRedirect("login.jsp?error=" + e.getMessage());
        }
    }

    // PROSES LOGOUT (GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hancurkan Seluruh Session yang Menempel
        HttpSession session = request.getSession();
        session.invalidate();
        
        System.out.println("LOG SYSTEM: Operator Berhasil Keluar.");
        response.sendRedirect("login.jsp");
    }
}