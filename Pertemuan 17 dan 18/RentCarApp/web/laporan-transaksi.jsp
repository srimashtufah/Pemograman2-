<%@page import="java.sql.*, config.Koneksi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
    <div>
        <h2 class="section-title m-0" style="color: #ffffff; font-weight: 800; letter-spacing: 1px; text-shadow: 0 0 10px rgba(0, 242, 254, 0.3);">
            LAPORAN RIWAYAT TRANSAKSI
        </h2>
        <p style="color: #64748B; margin: 5px 0 0 0; font-size: 14px;">Laporan penutupan buku dan kalkulasi omset finansial rental</p>
    </div>
    
    <button onclick="window.print()" style="padding: 12px 24px; font-size: 13px; background: #1E293B; color: #ffffff; border: 1px solid #334155; border-radius: 10px; font-weight: 700; cursor: pointer; display: flex; align-items: center; gap: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.2);">
        <i class="bi bi-printer-fill"></i> Cetak Fisik PDF
    </button>
</div>

<div style="background-color: #0F1626; border: 2px solid #1E293B; border-radius: 14px; padding: 25px; margin-bottom: 35px; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);">
    <form method="GET" style="display: flex; gap: 25px; align-items: flex-end; width: 100%;">
        <div style="flex: 1;">
            <label style="display: block; font-size: 11px; font-weight: 700; color: #94A3B8; margin-bottom: 8px; letter-spacing: 0.5px; text-transform: uppercase;">Mulai Jurnal Tanggal</label>
            <input type="date" name="tgl_mulai" style="width: 100%; background-color: #FFFFFF !important; border: 2px solid #1E293B; color: #000000 !important; padding: 12px; border-radius: 10px; box-sizing: border-box; font-size: 14px; font-weight: 600; color-scheme: light !important; outline: none;">
        </div>
        <div style="flex: 1;">
            <label style="display: block; font-size: 11px; font-weight: 700; color: #94A3B8; margin-bottom: 8px; letter-spacing: 0.5px; text-transform: uppercase;">Sampai Jurnal Tanggal</label>
            <input type="date" name="tgl_sampai" style="width: 100%; background-color: #FFFFFF !important; border: 2px solid #1E293B; color: #000000 !important; padding: 12px; border-radius: 10px; box-sizing: border-box; font-size: 14px; font-weight: 600; color-scheme: light !important; outline: none;">
        </div>
        <div>
            <button type="submit" style="padding: 13px 28px; font-size: 13px; background: linear-gradient(135deg, #00F2FE, #4FACFE) !important; color: #04060A !important; border: none !important; font-weight: 800; border-radius: 10px; cursor: pointer; box-shadow: 0 0 15px rgba(0, 242, 254, 0.4); text-transform: uppercase; letter-spacing: 0.5px; display: flex; align-items: center; gap: 6px;">
                <i class="bi bi-filter"></i> Saring Arsip
            </button>
        </div>
    </form>
</div>

<div style="background-color: #0F1626; border: 2px solid #1E293B; border-radius: 14px; overflow: hidden; box-shadow: 0 8px 25px rgba(0,0,0,0.4);">
    <table style="width: 100%; border-collapse: collapse; margin: 0; background-color: #0F1626;">
        <thead>
            <tr>
                <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">ID ORDER</th>
                <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">PENYEWA</th>
                <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">UNIT MOBIL</th>
                <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">TGL PINJAM</th>
                <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">TGL KEMBALI</th>
                <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">DENDA</th>
                <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">TOTAL OMSET</th>
                <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: center; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">STATUS</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Sistem filter data rentang waktu tanggal pinjam
                String tglMulai = request.getParameter("tgl_mulai");
                String tglSampai = request.getParameter("tgl_sampai");
                
                String query = "SELECT t.*, c.nama, m.merk FROM tbl_transaksi t JOIN tbl_customer c ON t.nik=c.nik JOIN tbl_mobil m ON t.no_plat=m.no_plat";
                if(tglMulai != null && !tglMulai.isEmpty() && tglSampai != null && !tglSampai.isEmpty()) {
                    query += " WHERE t.tgl_pinjam BETWEEN '" + tglMulai + "' AND '" + tglSampai + "'";
                }
                query += " ORDER BY t.id_transaksi DESC";

                try(Connection c = Koneksi.getConnection(); 
                    Statement s = c.createStatement(); 
                    ResultSet r = s.executeQuery(query)) {
                    
                    if (!r.isBeforeFirst()) {
            %>
            <tr>
                <td colspan="8" style="text-align: center; color: #94A3B8; padding: 45px; font-size: 14px; background-color: rgba(4,6,10,0.2);">
                    <i class="bi bi-folder-x" style="margin-right: 6px; color:#F43F5E;"></i> Belum ada arsip riwayat transaksi jurnaling.
                </td>
            </tr>
            <%
                    }
                    while(r.next()) {
                        String status = r.getString("status_transaksi");
                        String badgeBg = status.equalsIgnoreCase("Berjalan") ? "rgba(245, 158, 11, 0.15)" : "rgba(16, 185, 129, 0.15)";
                        String badgeColor = status.equalsIgnoreCase("Berjalan") ? "#F59E0B" : "#10B981";
                        
                        String tglKembali = r.getString("tgl_kembali_realisasi");
                        if(tglKembali == null || tglKembali.isEmpty()) {
                            tglKembali = "-";
                        }
            %>
            <tr style="border-bottom: 1px solid #1E293B; background-color: #0F1626;">
                <td style="color: #00F2FE; font-weight: bold; padding: 18px;"><%= "TRX-00" + r.getInt("id_transaksi") %></td>
                <td style="padding: 18px; color: #ffffff; font-weight: 600;"><%= r.getString("nama") %></td>
                <td style="padding: 18px; color: #E2E8F0;">
                    <span style="font-weight: 600;"><%= r.getString("merk") %></span><br>
                    <small style="color: #64748B;"><%= r.getString("no_plat") %></small>
                </td>
                <td style="padding: 18px; color: #CBD5E1;"><%= r.getString("tgl_pinjam") %></td>
                <td style="padding: 18px; color: #CBD5E1;"><%= tglKembali %></td>
                <td style="padding: 18px; color: #F43F5E; font-weight: 700;">Rp <%= String.format("%,d", r.getInt("denda")) %></td>
                <td style="padding: 18px; color: #10B981; font-weight: 700;">Rp <%= String.format("%,d", r.getInt("total_bayar")) %></td>
                <td style="padding: 18px; text-align: center;">
                    <span style="background-color: <%= badgeBg %>; color: <%= badgeColor %>; padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; display: inline-block;">
                        <%= status %>
                    </span>
                </td>
            </tr>
            <% 
                    } 
                } catch(Exception e) {
                    out.print("<tr><td colspan='8' style='color:#F43F5E; padding:15px;'>Koneksi Gagal: " + e.getMessage() + "</td></tr>");
                } 
            %>
        </tbody>
    </table>
</div>

<%@include file="footer.jsp" %>