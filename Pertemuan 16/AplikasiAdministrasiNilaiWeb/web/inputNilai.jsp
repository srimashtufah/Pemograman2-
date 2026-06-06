<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet" type="text/css" />
    <title>Input Nilai Mahasiswa</title>
    
    <style>
        /* === STYLE SIDEBAR UTAMA SOLID === */
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

        /* === STYLE LAYOUT KONTEN & CARD === */
        .page-header { margin-bottom: 24px; }
        .page-title { font-size: 26px; font-weight: 700; color: #1e293b; margin: 0 0 6px 0; }
        .page-description { font-size: 14px; color: #64748b; margin: 0; }
        
        .modern-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
        }
        
        /* Desain Tambahan Elemen Form agar Lebih Premium */
        .form-control:focus {
            outline: none;
            border-color: #3b82f6 !important;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }
        .btn-submit {
            padding: 11px 24px;
            background-color: #1e40af;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: background-color 0.2s;
        }
        .btn-submit:hover { background-color: #1d4ed8; }
        .btn-reset {
            padding: 11px 24px;
            background-color: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            margin-left: 10px;
            transition: all 0.2s;
        }
        .btn-reset:hover { background-color: #e2e8f0; }
    </style>
</head>
<body>
    
    <div class="app-container">
        <header class="app-header">
            <h2>Sistem Informasi Akademik</h2>
            <h1>UNIVERSITAS PAMULANG</h1>
            <p>Jl. Surya Kencana No. 1 Pamulang, Tangerang Selatan, Banten</p>
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
                    <li class="sidebar-item"><a href="NilaiController?aksi=input">📝 Input Nilai</a></li>
                </ul>

                <div class="sidebar-title">Laporan</div>
                <ul class="sidebar-menu">
                    <li class="sidebar-item"><a href="NilaiController?aksi=laporan">📊 Rekap Nilai</a></li>
                    <li class="sidebar-item logout-menu"><a href="logout.jsp">🚪 Logout</a></li>
                </ul>
            </aside>

            <main class="content-area">
                
                <div class="page-header">
                    <h1 class="page-title">Form Input Nilai Mahasiswa</h1>
                    <p class="page-description">Silakan masukkan data nilai akademis mahasiswa secara lengkap.</p>
                </div>
                
                <div class="modern-card">
                    <form action="NilaiController?aksi=simpan" method="POST" style="max-width: 550px;">
                        
                        <div class="form-group" style="margin-bottom: 18px;">
                            <label style="display: block; margin-bottom: 7px; font-weight: 600; color: #334155; font-size: 14px;">NIM Mahasiswa</label>
                            <input type="text" name="nim" class="form-control" style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-family: inherit;" required placeholder="Masukkan NIM Mahasiswa" />
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 18px;">
                            <label style="display: block; margin-bottom: 7px; font-weight: 600; color: #334155; font-size: 14px;">Nama Mahasiswa</label>
                            <input type="text" name="nama" class="form-control" style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-family: inherit;" required placeholder="Masukkan Nama Lengkap" />
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 22px;">
                            <label style="display: block; margin-bottom: 7px; font-weight: 600; color: #334155; font-size: 14px;">Mata Kuliah</label>
                            <select name="matakuliah" class="form-control" style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; background-color: white; font-family: inherit;">
                                <option value="Pemrograman 2">Pemrograman 2</option>
                                <option value="Basis Data">Basis Data</option>
                                <option value="Rekayasa Perangkat Lunak">Rekayasa Perangkat Lunak</option>
                            </select>
                        </div>
                        
                        <div style="display: flex; gap: 15px; margin-bottom: 25px;">
                            <div class="form-group" style="flex: 1;">
                                <label style="display: block; margin-bottom: 7px; font-weight: 600; color: #334155; font-size: 14px;">Nilai Tugas</label>
                                <input type="number" name="tugas" class="form-control" style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-family: inherit;" min="0" max="100" required placeholder="0-100" />
                            </div>
                            <div class="form-group" style="flex: 1;">
                                <label style="display: block; margin-bottom: 7px; font-weight: 600; color: #334155; font-size: 14px;">Nilai UTS</label>
                                <input type="number" name="uts" class="form-control" style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-family: inherit;" min="0" max="100" required placeholder="0-100" />
                            </div>
                            <div class="form-group" style="flex: 1;">
                                <label style="display: block; margin-bottom: 7px; font-weight: 600; color: #334155; font-size: 14px;">Nilai UAS</label>
                                <input type="number" name="uas" class="form-control" style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-family: inherit;" min="0" max="100" required placeholder="0-100" />
                            </div>
                        </div>
                        
                        <div style="margin-top: 25px; border-top: 1px solid #f1f5f9; padding-top: 20px;">
                            <input type="submit" value="💾 Simpan Nilai" class="btn-submit" />
                            <input type="reset" value="🔄 Reset" class="btn-reset" />
                        </div>
                    </form>
                </div>
            </main>
        </div>
        
        <footer class="app-footer">
            <p>Copyright &copy; 2026 Universitas Pamulang</p>
        </footer>
    </div>
</body>
</html>