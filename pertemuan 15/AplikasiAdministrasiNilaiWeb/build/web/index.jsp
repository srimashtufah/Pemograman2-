<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet" type="text/css" />
        <title>Informasi Nilai Mahasiswa</title>
    </head>
    <body>
      <%
    String userName = "";
    String menu = "";
    String topMenu = "";
    String konten = "";

    // Cek apakah user sudah login
    Object sessionUser = session.getAttribute("userName");
    
    if (sessionUser != null) {
        userName = sessionUser.toString();
        
        // Menu Sidebar menggunakan struktur list <ul><li> yang standar
        menu = "<h3>Master Data</h3>"
             + "<ul>"
             + "  <li><a href='#'>Mahasiswa</a></li>"
             + "  <li><a href='#'>Mata Kuliah</a></li>"
             + "</ul>"
             + "<h3>Transaksi</h3>"
             + "<ul>"
             + "  <li><a href='NilaiController?aksi=input'>Input Nilai</a></li>"
             + "</ul>"
             + "<h3>Laporan</h3>"
             + "<ul>"
             + "  <li><a href='NilaiController?aksi=laporan'>Rekap Nilai</a></li>"
             + "  <li><a href='LogoutController'>Logout</a></li>"
             + "</ul>";
             
        topMenu = "<ul>"
                + "  <li><a href='index.jsp'>Home</a></li>"
                + "  <li><a href='#'>Profil</a></li>"
                + "  <li><a href='LogoutController'>Logout (" + userName + ")</a></li>"
                + "</ul>";
        
        konten = "<h3>Selamat Datang, " + userName + "</h3>"
               + "<p>Anda berhasil masuk ke sistem. Silakan pilih menu di samping untuk mengelola data nilai mahasiswa.</p>";
    } else {
        // Jika belum login
        menu = "<ul><li><i>Menu terkunci</i></li></ul>";
        topMenu = "<ul><li><a href='login.jsp'>Login</a></li></ul>";
        konten = "<h3>Akses Terbatas</h3>"
               + "<p>Silakan <a href='login.jsp'>Login</a> terlebih dahulu untuk mengakses fitur administrasi nilai.</p>";
    }
%>
        
        <div class="app-container">
            <header class="app-header">
                <h2>Sistem Informasi Akademik</h2>
                <h1>UNIVERSITAS PAMULANG</h1>
            </header>

            <nav class="navbar">
                <%= topMenu %>
            </nav>

            <div class="main-layout">
                <aside class="sidebar">
                    <%= menu %>
                </aside>

                <main class="content-area">
                    <div class="card-body">
                        <%= konten %>
                    </div>
                </main>
            </div>
        </div>
    </body>
</html>