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

@WebServlet(name = "CustomerController", urlPatterns = {"/CustomerController"})
public class CustomerController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("insert".equals(action)) {
            String nik = request.getParameter("nik");
            String nama = request.getParameter("nama");
            String noTelp = request.getParameter("no_telp");
            String alamat = request.getParameter("alamat");

            try (Connection conn = Koneksi.getConnection()) {
                String sql = "INSERT INTO tbl_customer (nik, nama, no_telp, alamat) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, nik);
                ps.setString(2, nama);
                ps.setString(3, noTelp);
                ps.setString(4, alamat);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("input-customer.jsp");
        }
    }
}