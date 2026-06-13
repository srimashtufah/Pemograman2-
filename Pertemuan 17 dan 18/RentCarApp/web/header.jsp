<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ApexDrive — Premium Fleet System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    String uri = request.getRequestURI();
%>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 sidebar p-3 d-flex flex-column justify-content-between no-print">
            <div>
                <div class="brand-title py-3 px-2 mb-4 text-center">
                    <i class="bi bi-speedometer2 text-primary me-2"></i>Apex<span>Drive</span>
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link <%= uri.endsWith("index.jsp")?"active":"" %>" href="index.jsp"><i class="bi bi-grid-1x2-fill me-2"></i> Dashboard</a>
                    </li>
                    <li class="text-uppercase text-muted px-2 my-3 fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">Master Data</li>
                    <li class="nav-item">
                        <a class="nav-link <%= uri.endsWith("input-mobil.jsp")?"active":"" %>" href="input-mobil.jsp"><i class="bi bi-car-front-fill me-2"></i> Data Mobil</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= uri.endsWith("input-customer.jsp")?"active":"" %>" href="input-customer.jsp"><i class="bi bi-people-fill me-2"></i> Data Customer</a>
                    </li>
                    <li class="text-uppercase text-muted px-2 my-3 fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">Transaksi</li>
                    <li class="nav-item">
                        <a class="nav-link <%= uri.endsWith("input-sewa.jsp")?"active":"" %>" href="input-sewa.jsp"><i class="bi bi-front me-2"></i> Rental Mobil</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= uri.endsWith("laporan-transaksi.jsp")?"active":"" %>" href="laporan-transaksi.jsp"><i class="bi bi-file-earmark-bar-graph-fill me-2"></i> Jurnal Laporan</a>
                    </li>
                </ul>
            </div>
            <div class="pt-3 border-top border-secondary">
                <a class="nav-link text-danger w-100 px-3" href="#"><i class="bi bi-box-arrow-left me-2"></i> Keluar</a>
            </div>
        </div>
        
        <div class="col-md-9 col-lg-10 main-content">