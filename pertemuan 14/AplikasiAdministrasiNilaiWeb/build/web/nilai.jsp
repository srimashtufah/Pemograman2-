<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href='style.css' rel='stylesheet' type='text/css' />
        <title>Transaksi Nilai Mahasiswa</title>
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
                        
                        <div style='padding: 20px; background: #f8fafc; border-radius: 8px; border: 1px dashed #cbd5e1; text-align: center; color: #64748b;'>
                            [ Konten Form Input Nilai Akan Dibuat Di Sini Pada Pertemuan Selanjutnya ]
                        </div>
                    </div>
                </main>
            </div>
            <footer class='app-footer'>
                <p>Copyright &copy; 2026 Universitas Pamulang</p>
            </footer>
        </div>
    </body>
</html>