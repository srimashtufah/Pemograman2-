<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet" type="text/css" />
        <title>Input Nilai Mahasiswa</title>
    </head>
    <body>
        <%
            // Deklarasi variabel menu default dari session agar konsisten dengan index.jsp
            String userName = (session.getAttribute("userName") != null) ? session.getAttribute("userName").toString() : "";
            String menu = "";
            String topMenu = "";

            if (!userName.equals("")) {
                // Jika sudah login, ambil susunan menu dari session yang sudah rapi
                if (session.getAttribute("menu") != null) {
                    menu = session.getAttribute("menu").toString();
                }
                if (session.getAttribute("topMenu") != null) {
                    topMenu = session.getAttribute("topMenu").toString();
                }
            } else {
                // Menu fallback jika diakses tanpa login
                menu = "<h3>Master Data</h3><ul><li><a href='#'>Mahasiswa</a></li><li><a href='#'>Mata Kuliah</a></li></ul>"
                     + "<h3>Transaksi</h3><ul><li><a href='NilaiController?aksi=input'>Input Nilai</a></li></ul>"
                     + "<h3>Laporan</h3><ul><li><a href='NilaiController?aksi=laporan'>Rekap Nilai</a></li></ul>";
                
                topMenu = "<ul><li><a href='index.jsp'>Home</a></li><li><a href='LoginController'>Login</a></li></ul>";
            }
        %>
        
        <div class="app-container">
            <!-- Header Aplikasi -->
            <header class="app-header">
                <h2>Sistem Informasi Akademik</h2>
                <h1>UNIVERSITAS PAMULANG</h1>
                <p>Jl. Surya Kencana No. 1 Pamulang, Tangerang Selatan, Banten</p>
            </header>

            <!-- Navbar Atas -->
            <nav class="navbar">
                <%= topMenu %>
            </nav>

            <div class="main-layout">
                <!-- Sidebar Kiri -->
                <aside class="sidebar">
                    <%= menu %>
                </aside>

                <!-- Area Konten Utama Form -->
                <main class="content-area">
                    <div class="card-body" style="text-align: left;">
                        <h1 style="margin-bottom: 5px;">Form Input Nilai Mahasiswa</h1>
                        <p class="sub-konten" style="margin-bottom: 25px;">Silakan masukkan data nilai akademis mahasiswa secara lengkap.</p>
                        
                        <form action="NilaiController?aksi=simpan" method="POST" style="max-width: 500px;">
                            <div class="form-group" style="margin-bottom: 15px;">
                                <label style="display: block; margin-bottom: 5px; font-weight: 500;">NIM Mahasiswa</label>
                                <input type="text" name="nim" class="form-control" style="width: 100%; padding: 8px; border: 1px solid #cbd5e1; border-radius: 6px;" required placeholder="Masukkan NIM" />
                            </div>
                            
                            <div class="form-group" style="margin-bottom: 15px;">
                                <label style="display: block; margin-bottom: 5px; font-weight: 500;">Nama Mahasiswa</label>
                                <input type="text" name="nama" class="form-control" style="width: 100%; padding: 8px; border: 1px solid #cbd5e1; border-radius: 6px;" required placeholder="Masukkan Nama Lengkap" />
                            </div>
                            
                            <div class="form-group" style="margin-bottom: 15px;">
                                <label style="display: block; margin-bottom: 5px; font-weight: 500;">Mata Kuliah</label>
                                <select name="matakuliah" class="form-control" style="width: 100%; padding: 8px; border: 1px solid #cbd5e1; border-radius: 6px;">
                                    <option value="Pemrograman 2">Pemrograman 2</option>
                                    <option value="Basis Data">Basis Data</option>
                                    <option value="Rekayasa Perangkat Lunak">Rekayasa Perangkat Lunak</option>
                                </select>
                            </div>
                            
                            <div style="display: flex; gap: 15px; margin-bottom: 20px;">
                                <div class="form-group" style="flex: 1;">
                                    <label style="display: block; margin-bottom: 5px; font-weight: 500;">Nilai Tugas</label>
                                    <input type="number" name="tugas" class="form-control" style="width: 100%; padding: 8px; border: 1px solid #cbd5e1; border-radius: 6px;" min="0" max="100" required />
                                </div>
                                <div class="form-group" style="flex: 1;">
                                    <label style="display: block; margin-bottom: 5px; font-weight: 500;">Nilai UTS</label>
                                    <input type="number" name="uts" class="form-control" style="width: 100%; padding: 8px; border: 1px solid #cbd5e1; border-radius: 6px;" min="0" max="100" required />
                                </div>
                                <div class="form-group" style="flex: 1;">
                                    <label style="display: block; margin-bottom: 5px; font-weight: 500;">Nilai UAS</label>
                                    <input type="number" name="uas" class="form-control" style="width: 100%; padding: 8px; border: 1px solid #cbd5e1; border-radius: 6px;" min="0" max="100" required />
                                </div>
                            </div>
                            
                            <div style="margin-top: 20px;">
                                <input type="submit" value="Simpan Nilai" style="padding: 10px 20px; background-color: #2563eb; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: 500;" />
                                <input type="reset" value="Reset" style="padding: 10px 20px; background-color: #e2e8f0; color: #475569; border: none; border-radius: 6px; cursor: pointer; font-weight: 500; margin-left: 10px;" />
                            </div>
                        </form>
                    </div>
                </main>
            </div>
            
            <!-- Footer -->
            <footer class="app-footer">
                <p>Copyright &copy; 2026 Universitas Pamulang</p>
            </footer>
        </div>
    </body>
</html>