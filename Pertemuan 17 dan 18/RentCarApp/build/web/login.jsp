<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Login Terminal | CyberDrive</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            margin: 0; padding: 0;
            background: #04060A;
            background-image: radial-gradient(circle at 50% 50%, #1E1B4B 0%, #04060A 100%);
            height: 100vh;
            display: flex; justify-content: center; align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .login-box {
            background: rgba(15, 22, 38, 0.85);
            border: 1px solid rgba(0, 242, 254, 0.3);
            padding: 40px;
            border-radius: 20px;
            width: 360px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.6);
            text-align: center;
        }
        .brand-logo {
            font-size: 26px; font-weight: 800; color: #ffffff;
            margin-bottom: 5px; letter-spacing: 1px;
        }
        .brand-logo span { color: #D946EF; }
        .system-status { color: #64748B; font-size: 12px; margin-bottom: 30px; }
        .form-group { text-align: left; margin-bottom: 20px; }
        label { color: #94A3B8; font-size: 11px; font-weight: 700; text-transform: uppercase; margin-bottom: 8px; display: block; }
        
        .input-cyber {
            width: 100%; background: #FFFFFF !important;
            border: 2px solid #1E293B; color: #000000 !important;
            padding: 14px; border-radius: 10px; box-sizing: border-box;
            outline: none; font-size: 14px; font-weight: 600;
        }
        .input-cyber:focus { border-color: #00F2FE !important; }
        
        .btn-unlock {
            width: 100%; padding: 14px; margin-top: 15px;
            background: linear-gradient(135deg, #00F2FE, #4FACFE) !important; color: #04060A !important;
            border: none !important; border-radius: 10px;
            font-weight: 800; cursor: pointer; text-transform: uppercase; font-size: 13px;
            box-shadow: 0 0 15px rgba(0, 242, 254, 0.4);
        }
        .alert-danger {
            color: #F43F5E; background: rgba(244, 63, 94, 0.1);
            padding: 12px; border-radius: 10px; font-size: 12px; font-weight: 600;
            margin-bottom: 20px; border: 1px solid rgba(244, 63, 94, 0.2);
        }
    </style>
</head>
<body>

    <div class="login-box">
        <div class="brand-logo"><i class="bi bi-cpu-fill"></i> CYBER<span>DRIVE</span></div>
        <div class="system-status">SECURE TERMINAL ACCESS v4.0</div>
        
        <% if(request.getParameter("error") != null) { %>
            <div class="alert-danger">
                ❌ KREDENSIAL SALAH / AKSES DITOLAK!
            </div>
        <% } %>

        <form action="LoginController" method="POST">
            <div class="form-group">
                <label>ID Operator Terminal</label>
                <input type="text" name="username" class="input-cyber" placeholder="Masukkan username" required autocomplete="off">
            </div>
            <div class="form-group">
                <label>Kunci Akses Enkripsi</label>
                <input type="password" name="password" class="input-cyber" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn-unlock">
                Unlock System
            </button>
        </form>
    </div>

</body>
</html>