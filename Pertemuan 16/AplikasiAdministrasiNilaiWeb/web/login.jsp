<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <link href='style.css' rel='stylesheet' type='text/css' />
        <title>Login - Administrasi Nilai</title>
        <style>
            /* Tambahan gaya khusus untuk kotak login agar estetik */
            .login-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 80vh;
            }
            .login-card {
                background: white;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
                border: 1px solid #e2e8f0;
                width: 100%;
                max-width: 360px;
                text-align: left;
            }
            .login-card h3 { margin: 0 0 5px 0; color: #1e3a8a; font-size: 20px; }
            .login-card p { margin: 0 0 20px 0; color: #64748b; font-size: 13px; }
            .form-group { margin-bottom: 15px; }
            .form-group label { display: block; font-size: 13px; font-weight: 500; color: #475569; margin-bottom: 5px; }
            .form-control { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-family: inherit; font-size: 14px; box-sizing: border-box; }
            .form-control:focus { outline: none; border-color: #3b82f6; }
            .btn-submit { width: 100%; padding: 10px; background: #3b82f6; color: white; border: none; border-radius: 6px; font-weight: 500; font-size: 14px; cursor: pointer; margin-top: 10px; transition: background 0.2s; }
            .btn-submit:hover { background: #1d4ed8; }
            .error-msg { color: #ef4444; font-size: 13px; margin-bottom: 15px; text-align: center; }
        </style>
    </head>
    <body>
        <div class="app-container" style="margin-top: 20px;">
            <header class="app-header">
                <h1>UNIVERSITAS PAMULANG</h1>
                <p>Sistem Informasi Administrasi Nilai Mahasiswa</p>
            </header>
            
            <div class="login-container">
                <div class="login-card">
                    <h3>Selamat Datang  </h3>
                    <p>Silahkan masukkan akun Anda untuk masuk ke sistem.</p>
                    
                    <%
                        // Menampilkan pesan error jika login gagal
                        String pesan = (request.getAttribute("pesan") != null) ? request.getAttribute("pesan").toString() : "";
                        if (!pesan.equals("")) {
                            out.print("<div class='error-msg'>" + pesan + "</div>");
                        }
                    %>
                    
                    <form action="LoginController" method="POST">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="txtUsername" class="form-control" placeholder="Masukkan username" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="txtPassword" class="form-control" placeholder="Masukkan password" required>
                        </div>
                        <button type="submit" class="btn-submit">Masuk Aplikasi</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>