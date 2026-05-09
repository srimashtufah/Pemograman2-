import java.awt.*;
import java.sql.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class FormCustomer extends JFrame {

    JTextField txtNama = new JTextField();
    JTextField txtAlamat = new JTextField();
    JTextField txtTelepon = new JTextField();

    JButton btnSave = new JButton("Simpan");
    JButton btnUpdate = new JButton("Update");
    JButton btnDelete = new JButton("Delete");
    JButton btnClear = new JButton("Clear");

    JTable table = new JTable();
    DefaultTableModel model;

    int selectedId = 0;

    public FormCustomer() {
        setTitle("Data Customer");
        setSize(750, 500);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLayout(new BorderLayout());

        JPanel form = new JPanel(new GridLayout(4,2,10,10));
        form.setBorder(BorderFactory.createEmptyBorder(10,10,10,10));

        form.add(new JLabel("Nama Customer"));
        form.add(txtNama);

        form.add(new JLabel("Alamat"));
        form.add(txtAlamat);

        form.add(new JLabel("Telepon"));
        form.add(txtTelepon);

        JPanel btnPanel = new JPanel();
        btnPanel.add(btnSave);
        btnPanel.add(btnUpdate);
        btnPanel.add(btnDelete);
        btnPanel.add(btnClear);

        form.add(new JLabel(""));
        form.add(btnPanel);

        add(form, BorderLayout.NORTH);

        model = new DefaultTableModel(
            new String[]{"ID","Nama","Alamat","Telepon"},
            0
        );

        table.setModel(model);
        add(new JScrollPane(table), BorderLayout.CENTER);

        loadTable();

        btnSave.addActionListener(e -> saveData());
        btnUpdate.addActionListener(e -> updateData());
        btnDelete.addActionListener(e -> deleteData());
        btnClear.addActionListener(e -> clearForm());

        table.getSelectionModel().addListSelectionListener(e -> selectData());
    }

    void loadTable() {
        model.setRowCount(0);

        try {
            Connection conn = ConnectDatabase.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM customer");

            while(rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id_customer"),
                    rs.getString("nama_customer"),
                    rs.getString("alamat"),
                    rs.getString("telepon")
                });
            }

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this,e.getMessage());
        }
    }

    void saveData() {
        try {
            Connection conn = ConnectDatabase.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO customer(nama_customer,alamat,telepon) VALUES(?,?,?)"
            );

            ps.setString(1, txtNama.getText());
            ps.setString(2, txtAlamat.getText());
            ps.setString(3, txtTelepon.getText());
            ps.executeUpdate();

            JOptionPane.showMessageDialog(this,"Data berhasil disimpan");

            clearForm();
            loadTable();

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this,e.getMessage());
        }
    }

    void updateData() {
        if(selectedId == 0) return;

        try {
            Connection conn = ConnectDatabase.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE customer SET nama_customer=?, alamat=?, telepon=? WHERE id_customer=?"
            );

            ps.setString(1, txtNama.getText());
            ps.setString(2, txtAlamat.getText());
            ps.setString(3, txtTelepon.getText());
            ps.setInt(4, selectedId);

            ps.executeUpdate();

            JOptionPane.showMessageDialog(this,"Data berhasil diupdate");

            clearForm();
            loadTable();

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this,e.getMessage());
        }
    }

    void deleteData() {
        if(selectedId == 0) return;

        try {
            Connection conn = ConnectDatabase.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM customer WHERE id_customer=?"
            );

            ps.setInt(1, selectedId);
            ps.executeUpdate();

            JOptionPane.showMessageDialog(this,"Data berhasil dihapus");

            clearForm();
            loadTable();

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this,e.getMessage());
        }
    }

    void selectData() {
        int row = table.getSelectedRow();

        if(row >= 0) {
            selectedId = Integer.parseInt(model.getValueAt(row,0).toString());

            txtNama.setText(model.getValueAt(row,1).toString());
            txtAlamat.setText(model.getValueAt(row,2).toString());
            txtTelepon.setText(model.getValueAt(row,3).toString());
        }
    }

    void clearForm() {
        selectedId = 0;
        txtNama.setText("");
        txtAlamat.setText("");
        txtTelepon.setText("");
    }
}