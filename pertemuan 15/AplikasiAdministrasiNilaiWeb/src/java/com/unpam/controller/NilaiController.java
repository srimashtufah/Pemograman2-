package com.unpam.controller;

import com.unpam.model.Nilai;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "NilaiController", urlPatterns = {"/NilaiController"})
public class NilaiController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String aksi = request.getParameter("aksi");
        HttpSession session = request.getSession();
        
        // Mengambil atau membuat list penampung data nilai di dalam session (Simulasi Database)
        List<Nilai> daftarNilai = (List<Nilai>) session.getAttribute("daftarNilai");
        if (daftarNilai == null) {
            daftarNilai = new ArrayList<>();
            // Data awal/default simulasi seperti di jsp sebelumnya
            daftarNilai.add(new Nilai("201011400001", "Budi Raharjo", "Pemrograman 2", 85, 85, 85));
            session.setAttribute("daftarNilai", daftarNilai);
        }

        if (aksi == null || aksi.equals("input")) {
            request.getRequestDispatcher("inputNilai.jsp").forward(request, response);
        } 
        else if (aksi.equals("laporan")) {
            request.getRequestDispatcher("daftarNilai.jsp").forward(request, response);
        } 
        else if (aksi.equals("simpan")) {
            // Ambil data dari form inputNilai.jsp
            String nim = request.getParameter("nim");
            String nama = request.getParameter("nama");
            String matakuliah = request.getParameter("matakuliah");
            double tugas = Double.parseDouble(request.getParameter("tugas"));
            double uts = Double.parseDouble(request.getParameter("uts"));
            double uas = Double.parseDouble(request.getParameter("uas"));

            // Membuat objek model Nilai baru
            Nilai n = new Nilai(nim, nama, matakuliah, tugas, uts, uas);
            
            // Tambahkan ke dalam list data session
            daftarNilai.add(n);
            session.setAttribute("daftarNilai", daftarNilai);

            // Alihkan langsung ke halaman tampilan laporan daftar nilai
            request.getRequestDispatcher("daftarNilai.jsp").forward(request, response);
        }
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