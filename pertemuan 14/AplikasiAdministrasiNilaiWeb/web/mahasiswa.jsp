<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href='style.css' rel='stylesheet' type='text/css' />
        <title>Master Data Mahasiswa</title>
        <style>
            /* Layout Kontainer Tabel */
            .table-container {
                background: #ffffff; border-radius: 12px; padding: 24px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); border: 1px solid #f1f5f9; margin-top: 20px;
            }
            .table-header-flex { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
            .table-header-flex h3 { margin: 0; color: #0f172a; font-size: 1.15rem; font-weight: 600; }
            
            /* Tombol Tambah Mahasiswa */
            .btn-tambah {
                background-color: #2563eb; color: white; border: none; padding: 10px 18px;
                border-radius: 8px; font-weight: 500; font-size: 0.9rem; cursor: pointer; font-family: 'Inter', sans-serif;
            }
            .btn-tambah:hover { background-color: #1d4ed8; }
            
            /* Struktur Data Tabel */
            .data-table { width: 100%; border-collapse: collapse; text-align: left; font-size: 0.9rem; }
            .data-table th { background-color: #f8fafc; color: #475569; font-weight: 600; padding: 14px 16px; border-bottom: 2px solid #e2e8f0; }
            .data-table td { padding: 14px 16px; border-bottom: 1px solid #f1f5f9; color: #334155; }
            .data-table tbody tr:hover { background-color: #f8fafc; }
            
            /* Tombol Edit & Hapus di Tabel */
            .action-btn {
                text-decoration: none; padding: 6px 12px; border-radius: 6px; font-size: 0.8rem;
                font-weight: 500; margin-right: 5px; display: inline-block; cursor: pointer; border: none; font-family: 'Inter', sans-serif;
            }
            .edit-btn { background-color: #fef3c7; color: #d97706; }
            .edit-btn:hover { background-color: #fde68a; }
            .delete-btn { background-color: #fee2e2; color: #dc2626; }
            .delete-btn:hover { background-color: #fca5a5; }
            
            /* Pop-up Overlay Form (Modal) */
            .form-overlay {
                display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
                background: rgba(15, 23, 42, 0.4); backdrop-filter: blur(4px); justify-content: center; align-items: center; z-index: 999;
            }
            .form-card { background: white; padding: 30px; border-radius: 16px; width: 380px; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1); }
            .form-group { margin-bottom: 16px; }
            .form-group label { display: block; margin-bottom: 6px; font-size: 0.85rem; font-weight: 500; color: #475569; }
            .form-group input { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 8px; box-sizing: border-box; font-family: 'Inter', sans-serif; }
            .form-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 24px; }
            .btn-batal { background: #f1f5f9; color: #475569; border: none; padding: 10px 16px; border-radius: 8px; cursor: pointer; font-family: 'Inter', sans-serif; }
            .btn-simpan { background: #2563eb; color: white; border: none; padding: 10px 16px; border-radius: 8px; cursor: pointer; font-family: 'Inter', sans-serif; }
        </style>
    </head>
    <body>
        <%
            String menu = "<div class='menu-section'>Master Data</div>"
                    + "<a href='MahasiswaController' class='menu-link'>Mahasiswa</a>"
                    + "<a href='MataKuliahController' class='menu-link'>Mata Kuliah</a>"
                    + "<div class='menu-section'>Transaksi</div>"
                    + "<a href='#' class='menu-link'>Nilai</a>"
                    + "<div class='menu-section'>Laporan</div>"
                    + "<a href='#' class='menu-link'>Nilai</a>"
                    + "<div class='menu-section'>Sesi</div>"
                    + "<a href='LogoutController' class='menu-link login-btn' style='background:#64748b;'>Logout</a>";

            String topMenu = "<nav class='navbar'><ul>"
                    + "<li><a href='index.jsp'>Home</a></li>"
                    + "<li><a href=#>Master Data</a>"
                    + "  <ul>"
                    + "    <li><a href='MahasiswaController'>Mahasiswa</a></li>"
                    + "    <li><a href='MataKuliahController'>Mata Kuliah</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href=#>Transaksi</a>"
                    + "  <ul>"
                    + "    <li><a href='#'>Nilai</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href=#>Laporan</a>"
                    + "  <ul>"
                    + "    <li><a href='#'>Nilai</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href='LogoutController'>Logout</a></li>"
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
                    <div class='card-body' style='text-align: left; padding: 24px;'>
                        <h1 style='margin: 0 0 8px 0; font-size: 1.75rem; color: #0f172a;'>Data Mahasiswa</h1>
                        <p class='sub-konten' style='margin: 0; color: #64748b;'>Halaman untuk mengelola data mahasiswa (Tambah, Edit, dan Hapus data).</p>
                        
                        <div class='table-container'>
                            <div class='table-header-flex'>
                                <h3>Daftar Mahasiswa Aktif</h3>
                                <button type="button" class="btn-tambah" onclick="bukaFormModal('tambah', '', '', '', '')">+ Tambah Mahasiswa</button>
                            </div>
                            <table class='data-table'>
                                <thead>
                                    <tr>
                                        <th style='width: 50px;'>No</th>
                                        <th>NIM</th>
                                        <th>Nama Lengkap</th>
                                        <th>Kelas</th>
                                        <th style='width: 100px;'>Semester</th>
                                        <th style='width: 150px; text-align: center;'>Aksi</th>
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
                                                rs = stmt.executeQuery("SELECT * FROM mahasiswa");
                                                
                                                int no = 1;
                                                boolean adaData = false;
                                                
                                                while(rs.next()) {
                                                    adaData = true;
                                                    String nim = rs.getString("nim");
                                                    String nama = rs.getString("nama");
                                                    String kelas = rs.getString("kelas");
                                                    String semester = rs.getString("semester");
                                    %>
                                                    <tr>
                                                        <td><%= no++ %></td>
                                                        <td style='font-weight: 500; color: #1e293b;'><%= nim %></td>
                                                        <td><%= nama %></td>
                                                        <td><%= kelas %></td>
                                                        <td><%= semester %></td>
                                                        <td style='text-align: center;'>
                                                            <button type="button" class="action-btn edit-btn" 
                                                                    onclick="bukaFormModal('edit', '<%= nim %>', '<%= nama %>', '<%= kelas %>', '<%= semester %>')">Edit</button>
                                                            <button type="button" class="action-btn delete-btn" 
                                                                    onclick="eksekusiHapus('<%= nim %>', '<%= nama %>')">Hapus</button>
                                                        </td>
                                                    </tr>
                                    <%
                                                }
                                                if (!adaData) {
                                                    out.println("<tr><td colspan='6' style='text-align:center; color:#64748b;'>Database kosong. Silakan klik tombol Tambah Mahasiswa!</td></tr>");
                                                }
                                            } else {
                                                out.println("<tr><td colspan='6' style='text-align:center; color:red;'>Gagal terhubung ke database. Cek apakah XAMPP sudah menyala!</td></tr>");
                                            }
                                        } catch (Exception e) {
                                            out.println("<tr><td colspan='6' style='text-align:center; color:red;'>Eror membaca data: " + e.getMessage() + "</td></tr>");
                                        } finally {
                                            if (rs != null) try { rs.close(); } catch (Exception e) {}
                                            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <div class="form-overlay" id="formPopUp">
            <div class="form-card">
                <h2 id="judulForm" style="margin: 0 0 20px 0; color: #0f172a; font-size: 1.2rem;">Tambah Data Mahasiswa</h2>
                
                <form action="MahasiswaController" method="POST">
                    <input type="hidden" name="action" id="aksiForm" value="tambah">
                    
                    <div class="form-group">
                        <label>NIM Mahasiswa</label>
                        <input type="text" name="nim" id="f_nim" required placeholder="Contoh: 201011400001">
                    </div>
                    <div class="form-group">
                        <label>Nama Lengkap</label>
                        <input type="text" name="nama" id="f_nama" required placeholder="Nama Lengkap">
                    </div>
                    <div class="form-group">
                        <label>Kelas</label>
                        <input type="text" name="kelas" id="f_kelas" required placeholder="Contoh: 06TPLM001">
                    </div>
                    <div class="form-group">
                        <label>Semester</label>
                        <input type="number" name="semester" id="f_semester" required placeholder="Contoh: 6">
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn-batal" onclick="tutupFormModal()">Batal</button>
                        <button type="submit" class="btn-simpan">Simpan Data</button>
                    </div>
                </form>
            </div>
        </div>

        <script type="text/javascript">
            function bukaFormModal(tipe, nim, nama, kelas, semester) {
                document.getElementById('formPopUp').style.display = 'flex';
                if (tipe === 'tambah') {
                    document.getElementById('judulForm').innerText = 'Tambah Data Mahasiswa';
                    document.getElementById('aksiForm').value = 'tambah';
                    document.getElementById('f_nim').value = '';
                    document.getElementById('f_nim').removeAttribute('readonly');
                    document.getElementById('f_nama').value = '';
                    document.getElementById('f_kelas').value = '';
                    document.getElementById('f_semester').value = '';
                } else {
                    document.getElementById('judulForm').innerText = 'Edit Data Mahasiswa';
                    document.getElementById('aksiForm').value = 'edit';
                    document.getElementById('f_nim').value = nim;
                    document.getElementById('f_nim').setAttribute('readonly', 'true'); // NIM tidak boleh diubah saat edit
                    document.getElementById('f_nama').value = nama;
                    document.getElementById('f_kelas').value = kelas;
                    document.getElementById('f_semester').value = semester;
                }
            }

            function tutupFormModal() {
                document.getElementById('formPopUp').style.display = 'none';
            }

            function eksekusiHapus(nim, nama) {
                var konfirmasi = confirm("Apakah Anda yakin ingin menghapus data " + nama + " (" + nim + ")?");
                if (konfirmasi) {
                    // Mengarahkan ke Controller dengan membawa parameter action hapus dan nim mahasiswa
                    window.location.href = "MahasiswaController?action=hapus&nim=" + nim;
                }
            }
        </script>

        <%
            String resStatus = (String) request.getAttribute("resStatus");
            String resAction = (String) request.getAttribute("resAction");
            
            if(resStatus != null && resStatus.equals("sukses")) {
                if(resAction.equals("tambah")) {
        %>
                    <script type="text/javascript">alert("SUKSES: Data Mahasiswa baru berhasil ditambahkan!");</script>
        <%
                } else if(resAction.equals("edit")) {
        %>
                    <script type="text/javascript">alert("SUKSES: Perubahan data mahasiswa berhasil diperbarui!");</script>
        <%
                } else if(resAction.equals("hapus")) {
        %>
                    <script type="text/javascript">alert("SUKSES: Data Mahasiswa berhasil dihapus dari sistem!");</script>
        <%
                }
            }
        %>
    </body>
</html>