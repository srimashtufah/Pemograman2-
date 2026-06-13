<%@page import="java.sql.*, config.Koneksi"%>
<%@include file="header.jsp" %>
<div class="mb-4">
    <h3 class="section-title m-0">Manajemen Data Pelanggan</h3>
    <p class="text-muted small m-0">Kelola informasi data pengenal member/customer</p>
</div>
<div class="row g-4">
    <div class="col-xl-4 col-lg-5">
        <div class="card card-custom p-4 border-0">
            <h5 class="fw-bold mb-3"><i class="bi bi-person-plus-fill text-success me-2"></i>Registrasi Member</h5>
            <hr class="opacity-25 mb-4">
            <form action="CustomerController?action=insert" method="POST">
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Nomor NIK (KTP)</label>
                    <input type="text" name="nik" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Nama Lengkap</label>
                    <input type="text" name="nama" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Nomor Kontak WhatsApp</label>
                    <input type="text" name="no_telp" class="form-control" required>
                </div>
                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">Alamat Rumah Fisik</label>
                    <textarea name="alamat" class="form-control" rows="2" required></textarea>
                </div>
                <button type="submit" class="btn btn-glass-success w-100 py-2.5">
    <i class="bi bi-check-circle-fill"></i> Daftarkan Member
</button>
            </form>
        </div>
    </div>
    <div class="col-xl-8 col-lg-7">
        <div class="table-responsive-custom">
            <table class="table table-custom table-hover align-middle">
                <thead>
                    <tr><th>NIK KTP</th><th>Nama Pelanggan</th><th>No. Kontak</th><th>Alamat Rumah</th></tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = Koneksi.getConnection(); Statement st = conn.createStatement();
                             ResultSet rs = st.executeQuery("SELECT * FROM tbl_customer")) {
                            while(rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("nik") %></td>
                        <td class="fw-bold text-dark"><%= rs.getString("nama") %></td>
                        <td><i class="bi bi-whatsapp text-success me-1"></i><%= rs.getString("no_telp") %></td>
                        <td class="text-muted"><%= rs.getString("alamat") %></td>
                    </tr>
                    <% } } catch(Exception e) {} %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>