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
            // Menu Samping Modern
            String menu = "<div class='menu-section'>Master Data</div>"
                    + "<a href='mahasiswa.jsp' class='menu-link'>Mahasiswa</a>"
                    + "<a href='matakuliah.jsp' class='menu-link'>Mata Kuliah</a>"
                    + "<div class='menu-section'>Transaksi</div>"
                    + "<a href='nilai.jsp' class='menu-link'>Nilai</a>"
                    + "<div class='menu-section'>Laporan</div>"
                    + "<a href='laporan.jsp' class='menu-link'>Nilai</a>"
                    + "<div class='menu-section'>Aksen</div>"
                    + "<a href=LoginController class='menu-link login-btn'>Login</a>";

            // Menu Atas Dropdown Modern
            String topMenu = "<nav class='navbar'><ul>"
                    + "<li><a href=.>Home</a></li>"
                    + "<li><a href=#>Master Data</a>"
                    + "  <ul>"
                    + "    <li><a href=.>Mahasiswa</a></li>"
                    + "    <li><a href=.>Mata Kuliah</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href=#>Transaksi</a>"
                    + "  <ul>"
                    + "    <li><a href=.>Nilai</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href=#>Laporan</a>"
                    + "  <ul>"
                    + "    <li><a href=.>Nilai</a></li>"
                    + "  </ul>"
                    + "</li>"
                    + "<li><a href=LoginController>Login</a></li>"
                    + "</ul></nav>";

            String konten = "<h1>Selamat Datang</h1><p class='sub-konten'>Silahkan pilih menu di samping atau di atas untuk mengelola data akademis.</p>";
            String userName = "";

            if (!session.isNew()) {
                try {
                    userName = session.getAttribute("userName").toString();
                } catch (Exception ex) {}

                if (!((userName == null) || userName.equals(""))) {
                    konten += "<div class='user-badge'>User: " + userName + "</div>";
                    try { menu = session.getAttribute("menu").toString(); } catch (Exception ex) {}
                    try { topMenu = session.getAttribute("topMenu").toString(); } catch (Exception ex) {}
                }
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
                <p>Jl. Surya Kencana No. 1 Pamulang, Tangerang Selatan, Banten</p>
            </footer>
        </div>
    </body>
</html>