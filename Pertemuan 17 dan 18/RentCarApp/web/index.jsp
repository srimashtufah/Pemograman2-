<%@page import="java.sql.*, config.Koneksi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<%
    // Inisialisasi variabel pencatat data analisis
    int totalMobil = 0;
    int totalCustomer = 0;
    int totalDenda = 0;

    // Ambil data agregat langsung dari database secara real-time
    try (Connection conn = Koneksi.getConnection()) {
        if (conn != null) {
            // 1. Hitung Total Armada Mobil
            try (Statement st = conn.createStatement(); 
                 ResultSet rs = st.executeQuery("SELECT COUNT(*) AS total FROM tbl_mobil")) {
                if (rs.next()) totalMobil = rs.getInt("total");
            }
            
            // 2. Hitung Total Member Terdaftar
            try (Statement st = conn.createStatement(); 
                 ResultSet rs = st.executeQuery("SELECT COUNT(*) AS total FROM tbl_customer")) {
                if (rs.next()) totalCustomer = rs.getInt("total");
            }
            
            // 3. Hitung Akumulasi Total Denda Transaksi
            try (Statement st = conn.createStatement(); 
                 ResultSet rs = st.executeQuery("SELECT SUM(denda) AS total FROM tbl_transaksi")) {
                if (rs.next()) totalDenda = rs.getInt("total");
            }
        }
    } catch (Exception e) {
        System.out.println("LOG DASHBOARD ERROR: " + e.getMessage());
    }
%>

<div class="card-custom" style="background: linear-gradient(135deg, #1E1B4B 0%, #0F1626 100%) !important; margin-bottom: 40px; padding: 40px;">
    <span style="color: #D946EF; font-size: 12px; font-weight: 800; letter-spacing: 2px; text-transform: uppercase;">Enterprise Suite System v4.0</span>
    <h1 style="color: #ffffff; margin: 10px 0 15px 0; font-size: 2.5rem; font-weight: 800; letter-spacing: 0.5px;">
        Sistem Pusat Operasional <span style="color: #00F2FE; text-shadow: 0 0 15px rgba(0,242,254,0.4);">ApexDrive</span>
    </h1>
    <p style="color: #94A3B8; font-size: 15px; max-width: 750px; line-height: 1.6; margin-bottom: 30px;">
        Kelola armada premium, pantau siklus keluar-masuk kendaraan pelanggan, dan review grafik pembukuan keuangan bisnis Anda secara terpusat dan terintegrasi.
    </p>
    
    <div style="display: flex; gap: 15px;">
        <a href="input-sewa.jsp" class="btn-cyber-cyan" style="text-decoration: none; padding: 12px 25px; font-size: 13px; display: inline-flex; align-items: center; gap: 8px;">
            <i class="bi bi-lightning-charge-fill"></i> BUKA KASIR SEWA
        </a>
        <a href="laporan-transaksi.jsp" class="btn-cyber-magenta" style="text-decoration: none; padding: 12px 25px; font-size: 13px; display: inline-flex; align-items: center; gap: 8px;">
            <i class="bi bi-journal-text"></i> BUKA JURNAL LAPORAN
        </a>
    </div>
</div>

<div style="margin-bottom: 20px;">
    <h3 style="color: #ffffff; font-weight: 700; font-size: 18px; margin: 0; display: inline-flex; align-items: center; gap: 10px;">
        <i class="bi bi-graph-up-arrow" style="color: #00F2FE;"></i> Indikator Bisnis Global (Real-time)
    </h3>
</div>

<div style="display: grid; grid-template-columns: repeat(3, 100fr); gap: 20px; width: 100%;">
    
    <div class="card-custom" style="border-left: 4px solid #00F2FE !important; display: flex; justify-content: space-between; align-items: center; padding: 25px;">
        <div>
            <div style="color: #64748B; font-size: 11px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 5px;">TOTAL ARMADA</div>
            <div style="color: #ffffff; font-size: 28px; font-weight: 800;"><%= totalMobil %> <span style="font-size: 16px; color: #94A3B8; font-weight: 500;">Unit</span></div>
        </div>
        <div style="background: rgba(0, 242, 254, 0.1); width: 50px; height: 50px; border-radius: 12px; display: flex; justify-content: center; align-items: center;">
            <i class="bi bi-car-front-fill" style="color: #00F2FE; font-size: 22px;"></i>
        </div>
    </div>

    <div class="card-custom" style="border-left: 4px solid #10B981 !important; display: flex; justify-content: space-between; align-items: center; padding: 25px;">
        <div>
            <div style="color: #64748B; font-size: 11px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 5px;">PELANGGAN REGISTERED</div>
            <div style="color: #ffffff; font-size: 28px; font-weight: 800;"><%= totalCustomer %> <span style="font-size: 16px; color: #94A3B8; font-weight: 500;">Member</span></div>
        </div>
        <div style="background: rgba(16, 185, 129, 0.1); width: 50px; height: 50px; border-radius: 12px; display: flex; justify-content: center; align-items: center;">
            <i class="bi bi-people-fill" style="color: #10B981; font-size: 22px;"></i>
        </div>
    </div>

    <div class="card-custom" style="border-left: 4px solid #F59E0B !important; display: flex; justify-content: space-between; align-items: center; padding: 25px;">
        <div>
            <div style="color: #64748B; font-size: 11px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 5px;">LOG DENDA TERKUMPUL</div>
            <div style="color: #F59E0B; font-size: 24px; font-weight: 800;">Rp <%= String.format("%,d", totalDenda) %></div>
        </div>
        <div style="background: rgba(245, 158, 11, 0.1); width: 50px; height: 50px; border-radius: 12px; display: flex; justify-content: center; align-items: center;">
            <i class="bi bi-cash-stack" style="color: #F59E0B; font-size: 22px;"></i>
        </div>
    </div>

</div>

<%@include file="footer.jsp" %>