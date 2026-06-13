package controller;

import config.Koneksi;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "MobilController", urlPatterns = {"/MobilController"})
public class MobilController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("insert".equals(action)) {
            String noPlat = request.getParameter("no_plat");
            String merk = request.getParameter("merk");
            int hargaSewa = Integer.parseInt(request.getParameter("harga_sewa"));
            String status = request.getParameter("status");

            try (Connection conn = Koneksi.getConnection()) {
                String sql = "INSERT INTO tbl_mobil (no_plat, merk, harga_sewa, status) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, noPlat);
                ps.setString(2, merk);
                ps.setInt(3, hargaSewa);
                ps.setString(4, status);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("input-mobil.jsp");
        }
    }
}