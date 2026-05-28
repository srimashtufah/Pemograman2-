<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href='style.css' rel='stylesheet' type='text/css' />
        <title>Informasi Nilai Mahasiswa</title>
    </head>
    <body>
        <%
            // 1. Menu Default Sebelum Login
            String menu = "<div class='menu-section'>Master Data</div>"
                    + "<a href='LoginController' class='menu-link'>Mahasiswa</a>"
                    + "<a href='LoginController' class='menu-link'>Mata Kuliah</a>"
                    + "<div class='menu-section'>Transaksi</div>"
                    + "<a href='LoginController' class='menu-link'>Nilai</a>"
                    + "<div class='menu-section'>Laporan</div>"
                    + "<a href='LoginController' class='menu-link'>Nilai</a>"
                    + "<div class='menu-section'>Aksen</div>"
                    + "<a href='LoginController' class='menu-link login-btn'>Login</a>";

            // 2. Menu Atas Dropdown Default Sebelum Login
            String topMenu = "<nav class='navbar'><ul>"
                    + "<li><a href='index.jsp'>Home</a></li>"
                    + "<li><a href='LoginController'>Master Data</a>"
                    + "  <ul>"
                    + "    <li><a href='LoginController'>Mahasiswa</a></li>"
                    + "    <li><a href='LoginController'>Mata Kuliah</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href='LoginController'>Transaksi</a>"
                    + "  <ul>"
                    + "    <li><a href='LoginController'>Nilai</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href='LoginController'>Laporan</a>"
                    + "  <ul>"
                    + "    <li><a href='LoginController'>Nilai</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href='LoginController'>Login</a></li>"
                    + "</ul></nav>";

            String konten = "<h1>Selamat Datang</h1><p class='sub-konten'>Silahkan login terlebih dahulu untuk mengelola data akademis.</p>";
            String userName = "";

            // 3. Memeriksa Apakah User Sudah Berhasil Login
            if (session != null && session.getAttribute("userName") != null) {
                userName = session.getAttribute("userName").toString();
                konten = "<h1>Selamat Datang " + userName + "</h1><p class='sub-konten'>Anda telah masuk ke sistem. Silahkan gunakan menu di samping atau di atas untuk navigasi.</p>";
                
                // Mengubah isi menu menjadi Menu Dinamis setelah login (Mengarah ke Controller Pertemuan 14)
                menu = "<div class='menu-section'>Master Data</div>"
                        + "<a href='MahasiswaController' class='menu-link'>Mahasiswa</a>"
                        + "<a href='MataKuliahController' class='menu-link'>Mata Kuliah</a>"
                        + "<div class='menu-section'>Transaksi</div>"
                        + "<a href='#' class='menu-link'>Nilai</a>"
                        + "<div class='menu-section'>Laporan</div>"
                        + "<a href='#' class='menu-link'>Nilai</a>"
                        + "<div class='menu-section'>Sesi</div>"
                        + "<a href='LogoutController' class='menu-link login-btn' style='background:#64748b;'>Logout</a>";
                
                topMenu = "<nav class='navbar'><ul>"
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
                        + "<li><a href='LogoutController'>Logout (" + userName + ")</a></li>"
                        + "</ul></nav>";
            }
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
                    <div class='card-body'>
                        <%=konten %>
                    </div>
                </main>
            </div>
            
            <footer class='app-footer'>
                <p>Copyright &copy; 2026 Universitas Pamulang</p>
            </footer>
        </div>
    </body>
</html>