<main class="content-area">
    <div class="card-body" style="text-align: left;">
        <h1>Laporan Daftar Nilai</h1>
        <p class="sub-konten">Berikut adalah rekapitulasi nilai mahasiswa yang telah diinput.</p>
        
        <div class="table-container" style="margin-top: 20px;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>NIM</th>
                        <th>Nama Mahasiswa</th>
                        <th>Mata Kuliah</th>
                        <th>Nilai Akhir</th>
                        <th>Grade</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (daftarNilai != null) { 
                        for (Nilai n : daftarNilai) { %>
                        <tr>
                            <td><%= n.getNim() %></td>
                            <td><%= n.getNama() %></td>
                            <td><%= n.getMatakuliah() %></td>
                            <td><%= n.getAkhir() %></td>
                            <td><span class="user-badge"><%= n.getGrade() %></span></td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="5">Belum ada data nilai.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</main>