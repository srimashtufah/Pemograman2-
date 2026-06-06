<%@page import="com.unpam.model.Nilai"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet" type="text/css" />
    <title>Rekap Nilai Mahasiswa</title>
    
    <style>
        /* === STYLE SIDEBAR UTAMA === */
        .sidebar {
            background-color: #f8fafc;
            padding: 24px 16px;
            border-right: 1px solid #e2e8f0;
        }
        .sidebar-title {
            font-size: 11px;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-top: 24px;
            margin-bottom: 8px;
            padding-left: 4px;
        }
        .sidebar-title:first-of-type { margin-top: 0; }
        .sidebar-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar-item { margin-bottom: 6px; }
        .sidebar-item a {
            display: block;
            padding: 11px 16px;
            color: #334155;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            border-radius: 8px;
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.02);
            transition: all 0.2s ease;
        }
        .sidebar-item a:hover {
            background-color: #eff6ff;
            color: #1e40af;
            border-color: #bfdbfe;
            transform: translateY(-1px);
        }
        .sidebar-item.logout-menu a {
            background-color: #fef2f2;
            color: #dc2626;
            border-color: #fee2e2;
        }
        .sidebar-item.logout-menu a:hover {
            background-color: #fee2e2;
            color: #991b1b;
        }

        /* === STYLE KONTEN & TABEL (SEPERTI MAHASISWA) === */
        .page-header { margin-bottom: 24px; }
        .page-title { font-size: 26px; font-weight: 700; color: #1e293b; margin: 0 0 6px 0; }
        .page-description { font-size: 14px; color: #64748b; margin: 0; }
        
        .modern-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
        }
        .card-header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .card-subtitle { margin: 0; font-size: 16px; font-weight: 600; color: #334155; }
        
        .btn-pdf {
            background-color: #ef4444;
            color: #ffffff !important;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            transition: background-color 0.2s ease;
        }
        .btn-pdf:hover { background-color: #dc2626; }
        
        .modern-table { width: 100%; border-collapse: collapse; text-align: left; font-size: 14px; }
        .modern-table thead tr { background-color: #f8fafc; border-bottom: 1px solid #e2e8f0; }
        .modern-table th { padding: 14px 16px; font-weight: 600; color: #64748b; }
        .modern-table td { padding: 16px; color: #334155; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
        .modern-table tbody tr:hover { background-color: #f8fafc; }
        
        .grade-badge-green {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 12px;
            background-color: #dcfce7;
            color: #15803d;
        }
    </style>
</head>
<body>
    <%
        List<Nilai> daftarNilai = (List<Nilai>) session.getAttribute("daftarNilai");
    %>

    <div class="app-container">
        <header class="app-header">
            <h2>Laporan Academic</h2>
            <h1>UNIVERSITAS PAMULANG</h1>
        </header>

        <div class="main-layout">
            
            <aside class="sidebar">
                <div class="sidebar-title">Master Data</div>
                <ul class="sidebar-menu">
                    <li class="sidebar-item"><a href="mahasiswa.jsp">👥 Mahasiswa</a></li>
                    <li class="sidebar-item"><a href="matakuliah.jsp">📚 Mata Kuliah</a></li>
                </ul>

                <div class="sidebar-title">Transaksi</div>
                <ul class="sidebar-menu">
                    <li class="sidebar-item"><a href="nilai.jsp">📝 Input Nilai</a></li>
                </ul>

                <div class="sidebar-title">Laporan</div>
                <ul class="sidebar-menu">
                    <li class="sidebar-item"><a href="laporan.jsp">📊 Rekap Nilai</a></li>
                    <li class="sidebar-item logout-menu"><a href="logout.jsp">🚪 Logout</a></li>
                </ul>
            </aside>

            <main class="content-area">
                <div class="page-header">
                    <h1 class="page-title">Data Rekapitulasi Nilai</h1>
                    <p class="page-description">Halaman untuk mengelola dan melihat laporan akademik rekapitulasi nilai mahasiswa.</p>
                </div>
                
                <div class="modern-card">
                    <div class="card-header-flex">
                        <h3 class="card-subtitle">Daftar Rekap Nilai Aktif</h3>
                        <a href="#" onclick="window.print(); return false;" class="btn-pdf">
                         📄 Cetak PDF
                        </a>
                    </div>
                    
                    <table class="modern-table">
                        <thead>
                            <tr>
                                <th style="text-align: center; width: 60px;">No</th>
                                <th style="width: 140px;">NIM</th>
                                <th>Nama Mahasiswa</th>
                                <th>Mata Kuliah</th>
                                <th style="text-align: center; width: 120px;">Nilai Akhir</th>
                                <th style="text-align: center; width: 100px;">Grade</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (daftarNilai != null && !daftarNilai.isEmpty()) {
                                int no = 1;
                                for (Nilai n : daftarNilai) { %>
                                <tr>
                                    <td style="text-align: center; color: #64748b;"><%= no++ %></td>
                                    <td style="font-weight: 600; color: #1e293b;"><%= n.getNim() %></td>
                                    <td><%= n.getNama() %></td>
                                    <td><%= n.getMatakuliah() %></td>
                                    <td style="text-align: center; font-weight: 500;"><%= n.getAkhir() %></td>
                                    <td style="text-align: center;">
                                        <span class="grade-badge-green"><%= n.getGrade() %></span>
                                    </td>
                                </tr>
                            <% } } else { %>
                                <tr>
                                    <td colspan="6" style="text-align: center; padding: 40px; color: #94a3b8;">
                                        Data rekapitulasi nilai belum tersedia.
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>
</body>
</html>