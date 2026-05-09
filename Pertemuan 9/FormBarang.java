import java.awt.*;
import java.sql.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class FormBarang extends JFrame {

    JTextField txtNama = new JTextField();
    JTextField txtHarga = new JTextField();
    JTextField txtStok = new JTextField();
    JComboBox<String> cbSupplier = new JComboBox<>();

    JButton btnSave = new JButton("Simpan");
    JButton btnUpdate = new JButton("Update");
    JButton btnDelete = new JButton("Delete");
    JButton btnClear = new JButton("Clear");

    JTable table = new JTable();
    DefaultTableModel model;

    int selectedId = 0;

    public FormBarang() {
        setTitle("Data Barang");
        setSize(800, 500);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLayout(new BorderLayout());

        JPanel form = new JPanel(new GridLayout(5, 2, 10, 10));
        form.setBorder(BorderFactory.createEmptyBorder(10,10,10,10));

        form.add(new JLabel("Nama Barang"));
        form.add(txtNama);

        form.add(new JLabel("Harga"));
        form.add(txtHarga);

        form.add(new JLabel("Stok"));
        form.add(txtStok);

        form.add(new JLabel("Supplier"));
        form.add(cbSupplier);

        JPanel buttonPanel = new JPanel();
        buttonPanel.add(btnSave);
        buttonPanel.add(btnUpdate);
        buttonPanel.add(btnDelete);
        buttonPanel.add(btnClear);

        form.add(new JLabel(""));
        form.add(buttonPanel);

        add(form, BorderLayout.NORTH);

        model = new DefaultTableModel(
            new String[]{"ID", "Nama Barang", "Harga", "Stok", "Supplier"},
            0
        );

        table.setModel(model);
        add(new JScrollPane(table), BorderLayout.CENTER);

        loadSupplier();
        loadTable();

        btnSave.addActionListener(e -> saveData());
        btnUpdate.addActionListener(e -> updateData());
        btnDelete.addActionListener(e -> deleteData());
        btnClear.addActionListener(e -> clearForm());

        table.getSelectionModel().addListSelectionListener(e -> selectData());
    }

    void loadSupplier() {
        try {
            Connection conn = ConnectDatabase.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT nama_supplier FROM supplier");

            cbSupplier.removeAllItems();

            while(rs.next()) {
                cbSupplier.addItem(rs.getString("nama_supplier"));
            }

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        }
    }

    int getSupplierId(String namaSupplier) {
        try {
            Connection conn = ConnectDatabase.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT id_supplier FROM supplier WHERE nama_supplier=?"
            );
            ps.setString(1, namaSupplier);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                return rs.getInt("id_supplier");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    void loadTable() {
        model.setRowCount(0);

        try {
            Connection conn = ConnectDatabase.getConnection();

            String sql = """
                SELECT b.id_barang, b.nama_barang, b.harga, b.stok, s.nama_supplier
                FROM barang b
                LEFT JOIN supplier s ON b.id_supplier = s.id_supplier
            """;

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while(rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id_barang"),
                    rs.getString("nama_barang"),
                    rs.getInt("harga"),
                    rs.getInt("stok"),
                    rs.getString("nama_supplier")
                });
            }

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        }
    }

    void saveData() {
        try {
            Connection conn = ConnectDatabase.getConnection();

            String sql = """
                INSERT INTO barang(nama_barang,harga,stok,id_supplier)
                VALUES(?,?,?,?)
            """;

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, txtNama.getText());
            ps.setInt(2, Integer.parseInt(txtHarga.getText()));
            ps.setInt(3, Integer.parseInt(txtStok.getText()));
            ps.setInt(4, getSupplierId(cbSupplier.getSelectedItem().toString()));

            ps.executeUpdate();

            JOptionPane.showMessageDialog(this, "Data berhasil disimpan");
            clearForm();
            loadTable();

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        }
    }

    void updateData() {
        if(selectedId == 0) return;

        try {
            Connection conn = ConnectDatabase.getConnection();

            String sql = """
                UPDATE barang
                SET nama_barang=?, harga=?, stok=?, id_supplier=?
                WHERE id_barang=?
            """;

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, txtNama.getText());
            ps.setInt(2, Integer.parseInt(txtHarga.getText()));
            ps.setInt(3, Integer.parseInt(txtStok.getText()));
            ps.setInt(4, getSupplierId(cbSupplier.getSelectedItem().toString()));
            ps.setInt(5, selectedId);

            ps.executeUpdate();

            JOptionPane.showMessageDialog(this, "Data berhasil diupdate");
            clearForm();
            loadTable();

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        }
    }

    void deleteData() {
        if(selectedId == 0) return;

        try {
            Connection conn = ConnectDatabase.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM barang WHERE id_barang=?"
            );
            ps.setInt(1, selectedId);
            ps.executeUpdate();

            JOptionPane.showMessageDialog(this, "Data berhasil dihapus");

            clearForm();
            loadTable();

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        }
    }

    void selectData() {
        int row = table.getSelectedRow();

        if(row >= 0) {
            selectedId = Integer.parseInt(model.getValueAt(row, 0).toString());

            txtNama.setText(model.getValueAt(row, 1).toString());
            txtHarga.setText(model.getValueAt(row, 2).toString());
            txtStok.setText(model.getValueAt(row, 3).toString());
            cbSupplier.setSelectedItem(model.getValueAt(row, 4).toString());
        }
    }

    void clearForm() {
        selectedId = 0;
        txtNama.setText("");
        txtHarga.setText("");
        txtStok.setText("");
    }
}