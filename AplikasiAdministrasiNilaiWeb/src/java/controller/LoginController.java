package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Jika user mengakses langsung/klik tombol login, arahkan ke halaman login.jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mengambil data yang diketik user di form login
        String user = request.getParameter("txtUsername");
        String pass = request.getParameter("txtPassword");
        
        HttpSession session = request.getSession();
        
        // VALIDASI SEDERHANA: Password diset wajib "admin123"
        if (pass != null && pass.equals("admin123")) {
            
            // Membuat menu dinamis untuk halaman utama setelah login
                       String menuDinamis = "<div class='menu-section'>Master Data</div>"
        + "<a href='mahasiswa.jsp' class='menu-link'>Mahasiswa</a>"
        + "<a href='matakuliah.jsp' class='menu-link'>Mata Kuliah</a>"
        + "<div class='menu-section'>Transaksi</div>"
        + "<a href='nilai.jsp' class='menu-link'>Nilai</a>"
        + "<div class='menu-section'>Laporan</div>"
        + "<a href='laporan.jsp' class='menu-link'>Nilai</a>"
        + "<div class='menu-section'>Sesi</div>"
        + "<a href='logout.jsp' class='menu-link login-btn' style='background:#64748b;'>Logout</a>"; // <-- PASTIKAN INI logout.jsp
            
            // Simpan data login ke session agar dibaca index.jsp
            session.setAttribute("userName", user.toUpperCase());
            session.setAttribute("menu", menuDinamis);
            
            // Kembalikan ke halaman utama
            response.sendRedirect("index.jsp");
        } else {
            // Jika salah, kembali ke login.jsp dengan pesan error
            request.setAttribute("pesan", "Username atau Password Anda Salah!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}