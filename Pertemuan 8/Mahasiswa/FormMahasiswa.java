import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.table.DefaultTableModel;

public class FormMahasiswa extends JFrame {
    
    private JTable mahasiswa;
    private DefaultTableModel model;
    private JTextField nimTF, namaTF, jenis_kelaminTF, jurusanTF;
    private JScrollPane scrollPane;
    private JButton btnUpdate, btnTambah, btnHapus;
    Connection connection = ConnectDatabase.getConnectDatabase();

    public FormMahasiswa() {
        setTitle("Data Mahasiswa - UNPAM");
        setSize(600, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        String[] kolom = {"NIM", "Nama", "Jenis Kelamin", "Jurusan"};
        model = new DefaultTableModel(kolom, 0);
        mahasiswa = new JTable(model);
        scrollPane = new JScrollPane(mahasiswa);

        nimTF = new JTextField(10);
        namaTF = new JTextField(10);
        jenis_kelaminTF = new JTextField(10);
        jurusanTF = new JTextField(10);

        // Inisialisasi Tombol
        btnTambah = new JButton("Tambah");
        btnUpdate = new JButton("Update");
        btnHapus = new JButton("Hapus");

        // Panel Input
        JPanel panelInput = new JPanel(new GridLayout(5, 2, 10, 10));
        panelInput.add(new JLabel("NIM:"));
        panelInput.add(nimTF);
        panelInput.add(new JLabel("Nama:"));
        panelInput.add(namaTF);
        panelInput.add(new JLabel("Jenis Kelamin:"));
        panelInput.add(jenis_kelaminTF);
        panelInput.add(new JLabel("Jurusan:"));
        panelInput.add(jurusanTF);
        
        // Panel Tombol
        JPanel panelTombol = new JPanel(new GridLayout(1, 3, 5, 5));
        panelTombol.add(btnTambah);
        panelTombol.add(btnUpdate);
        panelTombol.add(btnHapus);
        panelInput.add(new JLabel("Aksi:"));
        panelInput.add(panelTombol);

        panelInput.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        add(panelInput, BorderLayout.NORTH);
        add(scrollPane, BorderLayout.CENTER);

        // Action Listeners
        btnTambah.addActionListener(e -> prosesTambah());
        btnUpdate.addActionListener(e -> prosesUpdate());
        btnHapus.addActionListener(e -> prosesHapus());

        // Load data awal ke tabel
        refreshTable();
    }

    // Fungsi untuk menampilkan data dari DB ke JTable
    public void refreshTable() {
        model.setRowCount(0);
        try {
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM datadiri");
            while (rs.next()) {
                Object[] row = {
                    rs.getString("nim"),
                    rs.getString("nama"),
                    rs.getString("jenis_kelamin"),
                    rs.getString("jurusan")
                };
                model.addRow(row);
            }
        } catch (SQLException e) {
            System.out.println("Error Load Data: " + e.getMessage());
        }
    }

    public void prosesTambah() {
        if (nimTF.getText().isEmpty() || namaTF.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "NIM dan Nama wajib diisi!");
            return;
        }
        try {
            String sql = "INSERT INTO datadiri (nim, nama, jenis_kelamin, jurusan) VALUES (?, ?, ?, ?)";
            PreparedStatement pS = connection.prepareStatement(sql);
            pS.setString(1, nimTF.getText());
            pS.setString(2, namaTF.getText());
            pS.setString(3, jenis_kelaminTF.getText());
            pS.setString(4, jurusanTF.getText());

            pS.executeUpdate();
            JOptionPane.showMessageDialog(this, "Data Berhasil Ditambah!");
            refreshTable();
            bersihkanField();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Gagal Tambah: " + e.getMessage());
        }
    }

    public void prosesUpdate() {
        try {
            String sql = "UPDATE datadiri SET nama=?, jenis_kelamin=?, jurusan=? WHERE nim=?";
            PreparedStatement pS = connection.prepareStatement(sql);
            pS.setString(1, namaTF.getText());
            pS.setString(2, jenis_kelaminTF.getText());
            pS.setString(3, jurusanTF.getText());
            pS.setString(4, nimTF.getText());

            if (pS.executeUpdate() > 0) {
                JOptionPane.showMessageDialog(this, "Data Berhasil Diupdate!");
                refreshTable();
                bersihkanField();
            } else {
                JOptionPane.showMessageDialog(this, "NIM tidak ditemukan!");
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Gagal Update: " + e.getMessage());
        }
    }

    public void prosesHapus() {
        if (nimTF.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Isi NIM yang ingin dihapus!");
            return;
        }
        int konfirmasi = JOptionPane.showConfirmDialog(this, "Yakin hapus data ini?", "Konfirmasi", JOptionPane.YES_NO_OPTION);
        if (konfirmasi == JOptionPane.YES_OPTION) {
            try {
                String sql = "DELETE FROM datadiri WHERE nim=?";
                PreparedStatement pS = connection.prepareStatement(sql);
                pS.setString(1, nimTF.getText());

                if (pS.executeUpdate() > 0) {
                    JOptionPane.showMessageDialog(this, "Data Berhasil Dihapus!");
                    refreshTable();
                    bersihkanField();
                }
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Gagal Hapus: " + e.getMessage());
            }
        }
    }

    private void bersihkanField() {
        nimTF.setText("");
        namaTF.setText("");
        jenis_kelaminTF.setText("");
        jurusanTF.setText("");
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new FormMahasiswa().setVisible(true);
        });
    }
}