package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        session.setAttribute("userName", "Administrator");
        
        // Menyusun Menu Samping (Sidebar) dengan tanda kutip lurus standar HTML
        String menuAktif = "<br><b>Master Data</b><br>"
                + "<a href=\"MahasiswaController\">Mahasiswa</a><br>"
                + "<a href=\"MataKuliahController\">Mata Kuliah</a><br><br>"
                + "<b>Transaksi</b><br>"
                + "<a href=\"NilaiController?aksi=input\">Nilai</a><br><br>"
                + "<b>Laporan</b><br>"
                + "<a href=\"NilaiController?aksi=laporan\">Nilai</a><br><br>"
                + "<a href=\"LogoutController\">Logout</a><br><br>";
        
        session.setAttribute("menu", menuAktif);
        
        // Menyusun Menu Atas (Dropdown) dengan tanda kutip lurus standar HTML
        String topMenuAktif = "<nav><ul>"
                + "<li><a href=\"index.jsp\">Home</a></li>"
                + "<li><a href=\"#\">Master Data</a>"
                + "    <ul>"
                + "        <li><a href=\"MahasiswaController\">Mahasiswa</a></li>"
                + "        <li><a href=\"MataKuliahController\">Mata Kuliah</a></li>"
                + "    </ul>"
                + "</li>"
                + "<li><a href=\"#\">Transaksi</a>"
                + "    <ul>"
                + "        <li><a href=\"NilaiController?aksi=input\">Nilai</a></li>"
                + "    </ul>"
                + "</li>"
                + "<li><a href=\"#\">Laporan</a>"
                + "    <ul>"
                + "        <li><a href=\"NilaiController?aksi=laporan\">Nilai</a></li>"
                + "    </ul>"
                + "</li>"
                + "<li><a href=\"LogoutController\">Logout</a></li>"
                + "</ul></nav>";
                
        session.setAttribute("topMenu", topMenuAktif);
        
        response.sendRedirect("index.jsp");
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