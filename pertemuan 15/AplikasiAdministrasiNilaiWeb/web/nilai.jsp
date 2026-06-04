<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght=300;400;500;600&display=swap" rel="stylesheet">
        <link href='style.css' rel='stylesheet' type='text/css' />
        <title>Transaksi Nilai Mahasiswa</title>
        <style>
            .form-group { margin-bottom: 15px; }
            .form-group label { display: block; margin-bottom: 5px; font-weight: 500; color: #334155; }
            .form-control { width: 100%; padding: 8px 12px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; }
            .btn-simpan { background-color: #2563eb; color: white; padding: 10px 20px; border: none; border-radius: 6px; cursor: pointer; font-weight: 500; }
            .btn-simpan:hover { background-color: #1d4ed8; }
            .table-data { width: 100%; border-collapse: collapse; margin-top: 20px; }
            .table-data th, .table-data td { padding: 10px; border: 1px solid #e2e8f0; text-align: left; }
            .table-data th { background-color: #f1f5f9; color: #475569; }
        </style>
    </head>
    <body>
        <%
            String userName = "";
            String menu = "<div class='menu-section'>Master Data</div>"
                    + "<a href='mahasiswa.jsp' class='menu-link'>Mahasiswa</a>"
                    + "<a href='matakuliah.jsp' class='menu-link'>Mata Kuliah</a>"
                    + "<div class='menu-section'>Transaksi</div>"
                    + "<a href='nilai.jsp' class='menu-link'>Nilai</a>"
                    + "<div class='menu-section'>Laporan</div>"
                    + "<a href='laporan.jsp' class='menu-link'>Nilai</a>"
                    + "<div class='menu-section'>Aksen</div>"
                    + "<a href=LoginController class='menu-link login-btn'>Login</a>";

            if (!session.isNew() && session.getAttribute("userName") != null) {
                userName = session.getAttribute("userName").toString();
                if (session.getAttribute("menu") != null) {
                    menu = session.getAttribute("menu").toString();
                }
            }

            String topMenu = "<nav class='navbar'><ul>"
                    + "<li><a href='index.jsp'>Home</a></li>"
                    + "<li><a href=#>Master Data</a>"
                    + "  <ul>"
                    + "    <li><a href='mahasiswa.jsp'>Mahasiswa</a></li>"
                    + "    <li><a href='matakuliah.jsp'>Mata Kuliah</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href=#>Transaksi</a>"
                    + "  <ul>"
                    + "    <li><a href='nilai.jsp'>Nilai</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href=#>Laporan</a>"
                    + "  <ul>"
                    + "    <li><a href='laporan.jsp'>Nilai</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href=LoginController>Login</a></li>"
                    + "</ul></nav>";
        %>

        <div class='app-container'>
            <header class='app-header'>
                <h2>Informasi Nilai Mahasiswa</h2>
                <h1>UNIVERSITAS PAMULANG</h1>
                <p>Jl. Surya Kencana No. 1 Pamulang, Tangerang Selatan, Banten</p>
            </header>
            <div class='main-layout'>
                <aside class='sidebar'>
                    <%=menu %>
                </aside>
                <main class='content-area'>
                    <%=topMenu %>
                    <div class='card-body' style='text-align: left;'>
                        <h1>Input Nilai Mahasiswa</h1>
                        <p class='sub-konten'>Halaman untuk memasukkan dan mengelola nilai akademis mahasiswa per semester.</p>
                        <hr style='border: 0; border-top: 1px solid #e2e8f0; margin: 20px 0;'>
                        
                        <%
                            String resStatus = (String) session.getAttribute("resStatus");
                            if (resStatus != null && resStatus.equals("sukses")) {
                                out.println("<script>alert('SUKSES: Data Transaksi Nilai berhasil disimpan!');</script>");
                                session.removeAttribute("resStatus");
                            } else if (resStatus != null && resStatus.equals("gagal")) {
                                out.println("<script>alert('GAGAL: Terjadi kesalahan saat menyimpan data.');</script>");
                                session.removeAttribute("resStatus");
                            }
                        %>

                       <form action="NilaiController" method="POST" style="background: #f8fafc; padding: 20px; border-radius: 8px; border: 1px solid #cbd5e1; margin-bottom: 30px;">
                            <input type="hidden" name="action" value="tambah">

                            <form action="NilaiController" method="POST" style="background: #f8fafc; padding: 20px; border-radius: 8px; border: 1px solid #cbd5e1; margin-bottom: 30px;">
                            <input type="hidden" name="action" value="tambah">
                            
                            <div class="form-group">
                                <label>NIM Mahasiswa :</label>
                                <input type="text" name="nim" class="form-control" placeholder="Masukkan NIM (Contoh: 201011400001)" required>
                            </div>
                            
                            <div class="form-group">
                                <label>Kode Mata Kuliah :</label>
                                <input type="text" name="kd_matakuliah" class="form-control" placeholder="Masukkan Kode MK (Contoh: MK002)" required>
                            </div>
                            
                            <div style="display: flex; gap: 15px;">
                                <div class="form-group" style="flex: 1;">
                                    <label>Nilai Tugas / Hadir (Nilai 1) :</label>
                                    <input type="number" name="nilai1" class="form-control" min="0" max="100" placeholder="0-100" required>
                                </div>
                                <div class="form-group" style="flex: 1;">
                                    <label>Nilai UTS / UAS (Nilai 2) :</label>
                                    <input type="number" name="nilai2" class="form-control" min="0" max="100" placeholder="0-100" required>
                                </div>
                            </div>
                            
                            <div style="margin-top: 10px;">
                                <button type="submit" class="btn-simpan">Simpan Data Nilai</button>
                            </div>
                        </form> 

                        <h2>Daftar Nilai Akademik</h2>
                        <table class="table-data">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>NIM</th>
                                    <th>Kode MK</th>
                                    <th>Nilai 1</th>
                                    <th>Nilai 2</th>
                                    <th>Rata-Rata</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    java.sql.Connection conn = null;
                                    java.sql.Statement stmt = null;
                                    java.sql.ResultSet rs = null;
                                    try {
                                        conn = com.unpam.model.Koneksi.getKoneksi();
                                        if (conn != null) {
                                            stmt = conn.createStatement();
                                            String sql = "SELECT * FROM nilai";
                                            rs = stmt.executeQuery(sql);
                                            
                                            int no = 1;
                                            while (rs.next()) {
                                %>
                                                <tr>
                                                    <td><%= no++ %></td>
                                                    <td><%= rs.getString("nim") %></td>
                                                    <td><%= rs.getString("kd_matakuliah") %></td>
                                                    <td><%= rs.getDouble("nil1") %></td>
                                                    <td><%= rs.getDouble("nil2") %></td>
                                                    <td><strong><%= rs.getDouble("rata") %></strong></td>
                                                </tr>
                                <%
                                            }
                                            if (no == 1) {
                                                out.println("<tr><td colspan='6' style='text-align:center;'>Belum ada data nilai di database.</td></tr>");
                                            }
                                        } else {
                                            out.println("<tr><td colspan='6' style='text-align:center; color:red;'>Koneksi gagal. Objek koneksi database null.</td></tr>");
                                        }
                                    } catch (Exception e) {
                                        out.println("<tr><td colspan='6' style='text-align:center; color:red;'>Error memuat tabel: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (Exception e) {}
                                        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                                    }
                                %>
                            </tbody>
                        </table>

                    </div>
                </main>
            </div>
            <footer class='app-footer'>
                <p>Copyright &copy; 2026 Universitas Pamulang</p>
            </footer>
        </div>
    </body>
</html>