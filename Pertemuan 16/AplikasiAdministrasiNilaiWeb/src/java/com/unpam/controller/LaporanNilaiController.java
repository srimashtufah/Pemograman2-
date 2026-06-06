package com.unpam.controller; // Sesuaikan dengan nama package di projekmu

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.unpam.model.Nilai;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LaporanNilaiController", urlPatterns = {"/LaporanNilaiController"})
public class LaporanNilaiController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Set tipe konten respons menjadi PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=Rekap_Nilai_Mahasiswa.pdf");

        try {
            // 2. Ambil data list nilai dari session
            HttpSession session = request.getSession();
            List<Nilai> daftarNilai = (List<Nilai>) session.getAttribute("daftarNilai");

            // 3. Inisialisasi Document iText PDF
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // 4. Membuat Header Laporan Kampus
            Font fontHeader Kampus = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
            Font fontSubHeader = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL);
            
            Paragraph title1 = new Paragraph("UNIVERSITAS PAMULANG", fontHeaderKampus);
            title1.setAlignment(Element.ALIGN_CENTER);
            document.add(title1);
            
            Paragraph title2 = new Paragraph("LAPORAN REKAPITULASI NILAI AKADEMIK\n\n", fontSubHeader);
            title2.setAlignment(Element.ALIGN_CENTER);
            document.add(title2);

            // 5. Membuat Tabel PDF (5 Kolom)
            PdfPTable table = new PdfPTable(5); 
            table.setWidthPercentage(100);
            table.setWidths(new float[]{1f, 2f, 4f, 4f, 1.5f}); // Proporsi lebar kolom

            // Kolom Header Tabel
            Font fontTh = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD);
            String[] headers = {"No", "NIM", "Nama Mahasiswa", "Mata Kuliah", "Grade"};
            
            for (String headerText : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(headerText, fontTh));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(8);
                table.addCell(cell);
            }

            // 6. Memasukkan Data Iterasi Nilai ke baris tabel PDF
            if (daftarNilai != null && !daftarNilai.isEmpty()) {
                int no = 1;
                for (Nilai n : daftarNilai) {
                    table.addCell(createCenterCell(String.valueOf(no++)));
                    table.addCell(createCenterCell(n.getNim()));
                    table.addCell(new PdfPCell(new Phrase(n.getNama())));
                    table.addCell(new PdfPCell(new Phrase(n.getMatakuliah())));
                    table.addCell(createCenterCell(n.getGrade()));
                }
            } else {
                PdfPCell emptyCell = new PdfPCell(new Phrase("Data Tidak Tersedia"));
                emptyCell.setColspan(5);
                emptyCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(emptyCell);
            }

            // 7. Masukkan tabel ke dokumen lalu kunci
            document.add(table);
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Helper untuk membuat teks kolom rata tengah otomatis
    private PdfPCell createCenterCell(String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        return cell;
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