<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Menghapus seluruh data login yang tersimpan di server (Session)
    session.invalidate();
    
    // 2. Mengembalikan user secara otomatis ke halaman utama (index.jsp)
    response.sendRedirect("index.jsp");
%>