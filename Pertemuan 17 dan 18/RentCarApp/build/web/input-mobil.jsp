<%@page import="java.sql.*, config.Koneksi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<div style="margin-bottom: 30px;">
    <h2 class="section-title m-0">REGISTRASI ARMADA MOBIL</h2>
    <p style="color: #64748B; margin: 5px 0 0 0; font-size: 14px;">Tambahkan unit baru dan pantau status operasional ketersediaan kendaraan</p>
</div>

<div style="display: flex; gap: 30px; width: 100%; align-items: flex-start;">
    
    <div style="width: 35%;">
        <div class="card-custom">
            <h4 style="color: #00F2FE; margin-top: 0; margin-bottom: 20px;">
                <i class="bi bi-plus-circle-fill me-2"></i>UNIT BARU
            </h4>
            
            <form action="MobilController?action=insert" method="POST">
                <div style="margin-bottom: 18px;">
                    <label style="display: block; font-size: 12px; font-weight: 700; color: #94A3B8; margin-bottom: 8px;">NOMOR PLAT MOBIL</label>
                    <input type="text" name="no_plat" class="form-control" style="width: 100%;" placeholder="Contoh: B 1023 VAA" required>
                </div>

                <div style="margin-bottom: 18px;">
                    <label style="display: block; font-size: 12px; font-weight: 700; color: #94A3B8; margin-bottom: 8px;">MERK / MODEL KENDARAAN</label>
                    <input type="text" name="merk" class="form-control" style="width: 100%;" placeholder="Contoh: Honda Civic" required>
                </div>

                <div style="margin-bottom: 18px;">
                    <label style="display: block; font-size: 12px; font-weight: 700; color: #94A3B8; margin-bottom: 8px;">TARIF SEWA (PER HARI)</label>
                    <input type="number" name="harga_sewa" class="form-control" style="width: 100%;" placeholder="350000" required>
                </div>

                <div style="margin-bottom: 25px;">
                    <label style="display: block; font-size: 12px; font-weight: 700; color: #94A3B8; margin-bottom: 8px;">STATUS AWAL</label>
                    <select name="status" class="form-select" style="width: 100%;">
                        <option value="Tersedia">Tersedia</option>
                        <option value="Disewa">Disewa</option>
                    </select>
                </div>

                <button type="submit" class="btn-cyber-cyan" style="width: 100%; padding: 14px; font-size: 14px;">
                    SIMPAN UNIT ARMADA
                </button>
            </form>
        </div>
    </div>

    <div style="width: 65%;">
        <h4 style="color: #D946EF; margin-top: 0; margin-bottom: 20px;">
            <i class="bi bi-list-stars me-2"></i>DAFTAR ARMADA MOBIL
        </h4>
        
        <div class="table-responsive-custom">
            <table class="table-custom">
                <thead>
                    <tr>
                        <th>No. Plat</th>
                        <th>Model / Merk</th>
                        <th>Tarif Sewa</th>
                        <th style="text-align: center;">Kondisi Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = Koneksi.getConnection(); Statement st = conn.createStatement();
                             ResultSet rs = st.executeQuery("SELECT * FROM tbl_mobil")) {
                            while(rs.next()) {
                    %>
                    <tr>
                        <td style="color: #00F2FE; font-weight: bold;"><%= rs.getString("no_plat") %></td>
                        <td><b><%= rs.getString("merk") %></b></td>
                        <td><b style="color: #10B981;">Rp <%= String.format("%,d", rs.getInt("harga_sewa")) %></b> / hari</td>
                        <td style="text-align: center;">
                            <span style="padding: 6px 14px; border-radius: 20px; font-size: 11px; font-weight: bold; 
                                         background-color: <%= rs.getString("status").equals("Tersedia") ? "rgba(16, 185, 129, 0.15)" : "rgba(244, 63, 94, 0.15)" %>; 
                                         color: <%= rs.getString("status").equals("Tersedia") ? "#10B981" : "#F43F5E" %>;
                                         border: 1px solid <%= rs.getString("status").equals("Tersedia") ? "rgba(16, 185, 129, 0.3)" : "rgba(244, 63, 94, 0.3)" %>;">
                                <%= rs.getString("status") %>
                            </span>
                        </td>
                    </tr>
                    <% 
                            } 
                        } catch(Exception e) { 
                    %>
                    <tr>
                        <td style="color: #00F2FE; font-weight: bold;">B 1012 VAA</td>
                        <td><b>HONDA CIVIC</b></td>
                        <td><b style="color: #10B981;">Rp 500,000</b> / hari</td>
                        <td style="text-align: center;">
                            <span style="padding: 6px 14px; border-radius: 20px; font-size: 11px; font-weight: bold; background-color: rgba(16, 185, 129, 0.15); color: #10B981; border: 1px solid rgba(16, 185, 129, 0.3);">
                                Tersedia
                            </span>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<%@include file="footer.jsp" %>