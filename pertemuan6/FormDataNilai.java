import java.sql.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class FormDataNilai extends JFrame {
    private JTextField txtNim, txtNama, txtNil1, txtNil2, txtRata, txtCari;
    private JButton btnTambah, btnUbah, btnHapus, btnBersih, btnCari, btnTampilSemua;
    private JTable table;
    private DefaultTableModel model;

    public FormDataNilai() {
        setTitle("Aplikasi Data Nilai Mahasiswa - Pemrograman 2");
        setSize(850, 650);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(null);

        // === Input Field ===
        JLabel lNim = new JLabel("NIM:");
        lNim.setBounds(20, 20, 80, 25);
        add(lNim);
        txtNim = new JTextField();
        txtNim.setBounds(100, 20, 150, 25);
        add(txtNim);

        JLabel lNama = new JLabel("Nama:");
        lNama.setBounds(20, 60, 80, 25);
        add(lNama);
        txtNama = new JTextField();
        txtNama.setBounds(100, 60, 250, 25);
        add(txtNama);

        JLabel lNil1 = new JLabel("Nilai 1:");
        lNil1.setBounds(20, 100, 80, 25);
        add(lNil1);
        txtNil1 = new JTextField();
        txtNil1.setBounds(100, 100, 80, 25);
        add(txtNil1);

        JLabel lNil2 = new JLabel("Nilai 2:");
        lNil2.setBounds(20, 140, 80, 25);
        add(lNil2);
        txtNil2 = new JTextField();
        txtNil2.setBounds(100, 140, 80, 25);
        add(txtNil2);

        JLabel lRata = new JLabel("Rata-rata:");
        lRata.setBounds(20, 180, 80, 25);
        add(lRata);
        txtRata = new JTextField();
        txtRata.setBounds(100, 180, 80, 25);
        add(txtRata);

        // === Tombol ===
        btnTambah = new JButton("Tambah");
        btnTambah.setBounds(20, 230, 100, 30);
        add(btnTambah);

        btnUbah = new JButton("Ubah");
        btnUbah.setBounds(130, 230, 100, 30);
        add(btnUbah);

        btnHapus = new JButton("Hapus");
        btnHapus.setBounds(240, 230, 100, 30);
        add(btnHapus);

        btnBersih = new JButton("Bersih");
        btnBersih.setBounds(350, 230, 100, 30);
        add(btnBersih);

        btnTampilSemua = new JButton("Tampil Semua");
        btnTampilSemua.setBounds(470, 230, 130, 30);
        add(btnTampilSemua);

        // === Pencarian ===
        JLabel lCari = new JLabel("Cari Nama:");
        lCari.setBounds(20, 280, 80, 25);
        add(lCari);
        txtCari = new JTextField();
        txtCari.setBounds(100, 280, 250, 25);
        add(txtCari);

        btnCari = new JButton("Cari");
        btnCari.setBounds(360, 280, 100, 25);
        add(btnCari);

        // === Tabel ===
        String[] kolom = {"NIM", "Nama", "Nilai 1", "Nilai 2", "Rata-rata"};
        model = new DefaultTableModel(kolom, 0);
        table = new JTable(model);
        JScrollPane scroll = new JScrollPane(table);
        scroll.setBounds(20, 320, 800, 270);
        add(scroll);

        // Event Listener
        btnTambah.addActionListener(e -> tambahData());
        btnUbah.addActionListener(e -> ubahData());
        btnHapus.addActionListener(e -> hapusData());
        btnBersih.addActionListener(e -> bersihkanForm());
        btnCari.addActionListener(e -> cariData());
        btnTampilSemua.addActionListener(e -> muatDataKeTabel());

        // Muat semua data saat pertama kali dibuka
        muatDataKeTabel();
    }

    private void muatDataKeTabel() {
        model.setRowCount(0);
        try (Connection conn = Koneksi.getKoneksi()) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM datanil ORDER BY nim");

            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getString("nim"),
                    rs.getString("nama"),
                    rs.getInt("nil1"),
                    rs.getInt("nil2"),
                    rs.getFloat("rata")
                });
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Error memuat data: " + ex.getMessage());
        }
    }

    private void tambahData() {
        try (Connection conn = Koneksi.getKoneksi()) {
            String sql = "INSERT INTO datanil (nim, nama, nil1, nil2, rata) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, txtNim.getText());
            ps.setString(2, txtNama.getText());
            ps.setInt(3, Integer.parseInt(txtNil1.getText()));
            ps.setInt(4, Integer.parseInt(txtNil2.getText()));
            ps.setFloat(5, Float.parseFloat(txtRata.getText()));
            ps.executeUpdate();

            JOptionPane.showMessageDialog(this, "Data berhasil ditambahkan!");
            muatDataKeTabel();
            bersihkanForm();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
        }
    }

    private void ubahData() {
        try (Connection conn = Koneksi.getKoneksi()) {
            String sql = "UPDATE datanil SET nama=?, nil1=?, nil2=?, rata=? WHERE nim=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, txtNama.getText());
            ps.setInt(2, Integer.parseInt(txtNil1.getText()));
            ps.setInt(3, Integer.parseInt(txtNil2.getText()));
            ps.setFloat(4, Float.parseFloat(txtRata.getText()));
            ps.setString(5, txtNim.getText());
            ps.executeUpdate();

            JOptionPane.showMessageDialog(this, "Data berhasil diubah!");
            muatDataKeTabel();
            bersihkanForm();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
        }
    }

    private void hapusData() {
        if (txtNim.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Pilih data yang akan dihapus!");
            return;
        }
        int konfirm = JOptionPane.showConfirmDialog(this, "Yakin ingin menghapus data ini?", "Konfirmasi", JOptionPane.YES_NO_OPTION);
        if (konfirm == JOptionPane.YES_OPTION) {
            try (Connection conn = Koneksi.getKoneksi()) {
                String sql = "DELETE FROM datanil WHERE nim=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, txtNim.getText());
                ps.executeUpdate();

                JOptionPane.showMessageDialog(this, "Data berhasil dihapus!");
                muatDataKeTabel();
                bersihkanForm();
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
            }
        }
    }

    private void cariData() {
        String keyword = txtCari.getText().trim();
        
        if (keyword.isEmpty()) {
            muatDataKeTabel();
            return;
        }

        model.setRowCount(0); // Bersihkan tabel

        try (Connection conn = Koneksi.getKoneksi()) {
            Statement st = conn.createStatement();
            String sql = "SELECT * FROM datanil WHERE nama LIKE '%" + keyword + "%'";
            ResultSet rs = st.executeQuery(sql);

            boolean ditemukan = false;
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getString("nim"),
                    rs.getString("nama"),
                    rs.getInt("nil1"),
                    rs.getInt("nil2"),
                    rs.getFloat("rata")
                });
                ditemukan = true;
            }

            if (!ditemukan) {
                JOptionPane.showMessageDialog(this, "Data dengan nama '" + keyword + "' tidak ditemukan!", 
                                            "Informasi", JOptionPane.INFORMATION_MESSAGE);
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Error pencarian: " + ex.getMessage());
        }
    }

    private void bersihkanForm() {
        txtNim.setText("");
        txtNama.setText("");
        txtNil1.setText("");
        txtNil2.setText("");
        txtRata.setText("");
        txtCari.setText("");
    }

    public static void main(String[] args) {
        new FormDataNilai().setVisible(true);
    }
}