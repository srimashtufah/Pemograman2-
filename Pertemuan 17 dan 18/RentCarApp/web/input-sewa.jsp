<%@page import="java.sql.*, config.Koneksi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<div style="margin-bottom: 30px;">
    <h2 class="section-title m-0" style="color: #ffffff; font-weight: 800; letter-spacing: 1px; text-shadow: 0 0 10px rgba(0, 242, 254, 0.3);">
        OPERASIONAL TERMINAL KASIR SEWA
    </h2>
    <p style="color: #64748B; margin: 5px 0 0 0; font-size: 14px;">Manajemen check-out keberangkatan armada pool dan penutupan transaksi aktif</p>
</div>

<div style="display: flex; gap: 30px; width: 100%; align-items: flex-start; box-sizing: border-box;">
    
    <div style="width: 35%; min-width: 320px; box-sizing: border-box;">
        <div style="background-color: #0F1626; border: 2px solid #1E293B; border-radius: 14px; padding: 25px; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.5);">
            <h4 style="color: #00F2FE; margin-top: 0; margin-bottom: 25px; font-weight: 700; letter-spacing: 0.5px; text-shadow: 0 0 8px rgba(0, 242, 254, 0.5);">
                <i class="bi bi-key-fill" style="margin-right: 8px;"></i>FORM CHECK-OUT
            </h4>
            
            <form action="RentCarController?action=sewa" method="POST">
                
                <div style="margin-bottom: 18px;">
                    <label style="display: block; font-size: 11px; font-weight: 700; color: #94A3B8; margin-bottom: 8px; letter-spacing: 0.5px;">NAMA CUSTOMER</label>
                    <select name="nik" style="width: 100%; background-color: #050911; border: 1px solid #1E293B; color: #ffffff; padding: 12px; border-radius: 10px; font-size: 14px; outline: none;" required>
                        <option value="" disabled selected>-- Pilih Member Pelanggan --</option>
                        <% 
                            try(Connection c = Koneksi.getConnection(); Statement s = c.createStatement(); ResultSet r = s.executeQuery("SELECT nik, nama FROM tbl_customer")) {
                                while(r.next()) { 
                        %> 
                            <option value="<%= r.getString("nik") %>"><%= r.getString("nama") %></option> 
                        <% 
                                } 
                            } catch(Exception e) {} 
                        %>
                    </select>
                </div>

                <div style="margin-bottom: 18px;">
                    <label style="display: block; font-size: 11px; font-weight: 700; color: #94A3B8; margin-bottom: 8px; letter-spacing: 0.5px;">PILIH ARMADA (TERSEDIA)</label>
                    <select name="no_plat" style="width: 100%; background-color: #050911; border: 1px solid #1E293B; color: #ffffff; padding: 12px; border-radius: 10px; font-size: 14px; outline: none;" required>
                        <option value="" disabled selected>-- Pilih Unit Siap Jalan --</option>
                        <% 
                            try(Connection c = Koneksi.getConnection(); Statement s = c.createStatement(); ResultSet r = s.executeQuery("SELECT no_plat, merk FROM tbl_mobil WHERE status='Tersedia'")) {
                                while(r.next()) { 
                        %> 
                            <option value="<%= r.getString("no_plat") %>"><%= r.getString("merk") %> [<%= r.getString("no_plat") %>]</option> 
                        <% 
                                } 
                            } catch(Exception e) {} 
                        %>
                    </select>
                </div>

                <div style="margin-bottom: 18px;">
                    <label style="display: block; font-size: 11px; font-weight: 700; color: #94A3B8; margin-bottom: 8px; letter-spacing: 0.5px;">TANGGAL PINJAM</label>
                    <input type="date" name="tgl_pinjam" 
                           style="width: 100%; background-color: #FFFFFF !important; border: 2px solid #00F2FE !important; color: #000000 !important; padding: 12px; border-radius: 10px; box-sizing: border-box; font-size: 14px; font-weight: 650; color-scheme: light !important; outline: none;" required>
                </div>

                <div style="margin-bottom: 28px;">
                    <label style="display: block; font-size: 11px; font-weight: 700; color: #94A3B8; margin-bottom: 8px; letter-spacing: 0.5px;">TARGET PENGEMBALIAN</label>
                    <input type="date" name="tgl_kembali_estimasi" 
                           style="width: 100%; background-color: #FFFFFF !important; border: 2px solid #00F2FE !important; color: #000000 !important; padding: 12px; border-radius: 10px; box-sizing: border-box; font-size: 14px; font-weight: 650; color-scheme: light !important; outline: none;" required>
                </div>

                <button type="submit" style="width: 100%; padding: 14px; font-size: 13px; background: linear-gradient(135deg, #00F2FE, #4FACFE) !important; color: #04060A !important; border: none !important; font-weight: 800; border-radius: 10px; cursor: pointer; box-shadow: 0 0 15px rgba(0, 242, 254, 0.5); text-transform: uppercase; letter-spacing: 0.5px;">
                    <i class="bi bi-shield-check" style="margin-right: 5px;"></i> Konfirmasi & Lepas Kunci
                </button>
            </form>
        </div>
    </div>

    <div style="width: 65%; box-sizing: border-box;">
        <h4 style="color: #D946EF; margin-top: 0; margin-bottom: 20px; font-weight: 700; letter-spacing: 0.5px; text-shadow: 0 0 8px rgba(217, 70, 239, 0.4);">
            <i class="bi bi-display" style="margin-right: 8px;"></i>DAFTAR KENDARAAN DI JALAN
        </h4>
        
        <div class="table-responsive-custom" style="background-color: #0F1626; border: 2px solid #1E293B; border-radius: 14px; overflow: hidden; box-shadow: 0 8px 25px rgba(0,0,0,0.3);">
            <table class="table-custom" style="width: 100%; border-collapse: collapse; margin: 0;">
                <thead>
                    <tr>
                        <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">ID ORDER</th>
                        <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">NAMA CUSTOMER</th>
                        <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">ARMADA MOBIL</th>
                        <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: left; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">TGL PINJAM</th>
                        <th style="background-color: #04060A; color: #00F2FE; padding: 18px; font-weight: 700; text-transform: uppercase; font-size: 11px; text-align: center; border-bottom: 2px solid #1E293B; letter-spacing: 0.5px;">AKSI TUTUP ORDER</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        try(Connection c = Koneksi.getConnection(); 
                            Statement s = c.createStatement(); 
                            ResultSet r = s.executeQuery("SELECT t.*, c.nama, m.merk FROM tbl_transaksi t JOIN tbl_customer c ON t.nik=c.nik JOIN tbl_mobil m ON t.no_plat=m.no_plat WHERE t.status_transaksi='Berjalan'")) {
                            
                            if (!r.isBeforeFirst()) {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: #94A3B8; padding: 45px; font-size: 14px; background-color: rgba(4,6,10,0.2);">
                            <i class="bi bi-info-circle" style="margin-right: 6px; color:#00F2FE;"></i> Semua unit berada di dalam garasi pool (Kosong).
                        </td>
                    </tr>
                    <%
                            }
                            while(r.next()) {
                    %>
                    <tr>
                        <td style="color: #00F2FE; font-weight: bold; padding: 18px; border-bottom: 1px solid #1E293B;">TRX-00<%= r.getInt("id_transaksi") %></td>
                        <td style="padding: 18px; border-bottom: 1px solid #1E293B; color: #ffffff;"><b><%= r.getString("nama") %></b></td>
                        <td style="padding: 18px; border-bottom: 1px solid #1E293B; color: #E2E8F0;"><%= r.getString("merk") %> <br><small style="color: #64748B;">[<%= r.getString("no_plat") %>]</small></td>
                        <td style="padding: 18px; border-bottom: 1px solid #1E293B; color: #CBD5E1;"><%= r.getString("tgl_pinjam") %></td>
                        <td style="padding: 18px; border-bottom: 1px solid #1E293B; text-align: center;">
                            
                            <form action="RentCarController?action=kembali" method="POST" style="display: flex; gap: 8px; margin: 0; justify-content: center; align-items: center;">
                                <input type="hidden" name="id_transaksi" value="<%= r.getInt("id_transaksi") %>">
                                <input type="hidden" name="no_plat" value="<%= r.getString("no_plat") %>">
                                
                                <input type="date" name="tgl_kembali_realisasi" required 
                                       style="background-color: #FFFFFF !important; border: 1px solid #1E293B; color: #000000 !important; padding: 8px 10px; font-size: 12px; width: 135px; border-radius: 6px; color-scheme: light !important; outline: none; font-weight: 600;">
                                
                                <button type="submit" style="padding: 8px 15px; font-size: 11px; background: linear-gradient(135deg, #F43F5E, #D946EF) !important; color: #ffffff !important; border: none !important; font-weight: 700; border-radius: 6px; cursor: pointer; box-shadow: 0 0 12px rgba(217, 70, 239, 0.4); text-transform: uppercase;">
                                    TUTUP
                                </button>
                            </form>
                            
                        </td>
                    </tr>
                    <% 
                            } 
                        } catch(Exception e) {} 
                    %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<%@include file="footer.jsp" %>