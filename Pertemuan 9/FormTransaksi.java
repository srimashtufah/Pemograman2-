import java.awt.*;
import java.sql.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class FormTransaksi extends JFrame {

    JComboBox<String> cbCustomer = new JComboBox<>();
    JComboBox<String> cbBarang = new JComboBox<>();

    JTextField txtHarga = new JTextField();
    JTextField txtQty = new JTextField();
    JTextField txtSubtotal = new JTextField();
    JTextField txtTotal = new JTextField();

    JButton btnTambah = new JButton("Tambah");
    JButton btnSimpan = new JButton("Simpan");

    JTable table = new JTable();
    DefaultTableModel model;

    public FormTransaksi() {
        setTitle("Transaksi Penjualan");
        setSize(900, 550);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLayout(new BorderLayout());

        txtHarga.setEditable(false);
        txtSubtotal.setEditable(false);
        txtTotal.setEditable(false);

        JPanel form = new JPanel(new GridLayout(6,2,10,10));
        form.setBorder(BorderFactory.createEmptyBorder(10,10,10,10));

        form.add(new JLabel("Customer"));
        form.add(cbCustomer);

        form.add(new JLabel("Barang"));
        form.add(cbBarang);

        form.add(new JLabel("Harga"));
        form.add(txtHarga);

        form.add(new JLabel("Qty"));
        form.add(txtQty);

        form.add(new JLabel("Subtotal"));
        form.add(txtSubtotal);

        form.add(btnTambah);
        form.add(btnSimpan);

        add(form, BorderLayout.NORTH);

        model = new DefaultTableModel(
            new String[]{
                "ID Barang",
                "Nama Barang",
                "Harga",
                "Qty",
                "Subtotal"
            },0
        );

        table.setModel(model);
        add(new JScrollPane(table), BorderLayout.CENTER);

        JPanel bawah = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        bawah.add(new JLabel("TOTAL : "));
        txtTotal.setPreferredSize(new Dimension(150,30));
        bawah.add(txtTotal);

        add(bawah, BorderLayout.SOUTH);

        loadCustomer();
        loadBarang();

        cbBarang.addActionListener(e -> loadHarga());
        txtQty.addActionListener(e -> hitungSubtotal());
        btnTambah.addActionListener(e -> tambahKeranjang());
        btnSimpan.addActionListener(e -> simpanTransaksi());
    }

    void loadCustomer() {
        try {
            Connection conn = ConnectDatabase.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT nama_customer FROM customer");

            cbCustomer.removeAllItems();

            while(rs.next()) {
                cbCustomer.addItem(rs.getString("nama_customer"));
            }

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this,e.getMessage());
        }
    }

    void loadBarang() {
        try {
            Connection conn = ConnectDatabase.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT nama_barang FROM barang");

            cbBarang.removeAllItems();

            while(rs.next()) {
                cbBarang.addItem(rs.getString("nama_barang"));
            }

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this,e.getMessage());
        }
    }

    int getCustomerId(String nama) {
        try {
            Connection conn = ConnectDatabase.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT id_customer FROM customer WHERE nama_customer=?"
            );
            ps.setString(1,nama);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                return rs.getInt("id_customer");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    int getBarangId(String nama) {
        try {
            Connection conn = ConnectDatabase.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT id_barang FROM barang WHERE nama_barang=?"
            );
            ps.setString(1,nama);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                return rs.getInt("id_barang");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    void loadHarga() {
        try {
            String barang = cbBarang.getSelectedItem().toString();

            Connection conn = ConnectDatabase.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT harga FROM barang WHERE nama_barang=?"
            );

            ps.setString(1,barang);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                txtHarga.setText(rs.getString("harga"));
            }

        } catch(Exception e) {
            txtHarga.setText("");
        }
    }

    void hitungSubtotal() {
        try {
            int harga = Integer.parseInt(txtHarga.getText());
            int qty = Integer.parseInt(txtQty.getText());

            txtSubtotal.setText(String.valueOf(harga * qty));

        } catch(Exception e) {
            txtSubtotal.setText("");
        }
    }

    void tambahKeranjang() {
        hitungSubtotal();

        int idBarang = getBarangId(cbBarang.getSelectedItem().toString());
        String namaBarang = cbBarang.getSelectedItem().toString();
        int harga = Integer.parseInt(txtHarga.getText());
        int qty = Integer.parseInt(txtQty.getText());
        int subtotal = Integer.parseInt(txtSubtotal.getText());

        model.addRow(new Object[]{
            idBarang,
            namaBarang,
            harga,
            qty,
            subtotal
        });

        hitungTotal();

        txtQty.setText("");
        txtSubtotal.setText("");
    }

    void hitungTotal() {
        int total = 0;

        for(int i=0;i<model.getRowCount();i++) {
            total += Integer.parseInt(
                model.getValueAt(i,4).toString()
            );
        }

        txtTotal.setText(String.valueOf(total));
    }

    void simpanTransaksi() {
        try {
            Connection conn = ConnectDatabase.getConnection();
            conn.setAutoCommit(false);

            String sql = "INSERT INTO transaksi(tanggal,id_customer,total) VALUES(CURDATE(),?,?)";

            PreparedStatement ps = conn.prepareStatement(
                sql,
                Statement.RETURN_GENERATED_KEYS
            );

            ps.setInt(1,getCustomerId(cbCustomer.getSelectedItem().toString()));
            ps.setInt(2,Integer.parseInt(txtTotal.getText()));
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            rs.next();

            int idTransaksi = rs.getInt(1);

            for(int i=0;i<model.getRowCount();i++) {

                int idBarang = Integer.parseInt(model.getValueAt(i,0).toString());
                int qty = Integer.parseInt(model.getValueAt(i,3).toString());
                int subtotal = Integer.parseInt(model.getValueAt(i,4).toString());

                PreparedStatement detail = conn.prepareStatement(
                    "INSERT INTO detail_transaksi(id_transaksi,id_barang,qty,subtotal) VALUES(?,?,?,?)"
                );

                detail.setInt(1,idTransaksi);
                detail.setInt(2,idBarang);
                detail.setInt(3,qty);
                detail.setInt(4,subtotal);
                detail.executeUpdate();

                PreparedStatement stok = conn.prepareStatement(
                    "UPDATE barang SET stok = stok - ? WHERE id_barang=?"
                );

                stok.setInt(1,qty);
                stok.setInt(2,idBarang);
                stok.executeUpdate();
            }

            conn.commit();

            JOptionPane.showMessageDialog(this,"Transaksi berhasil");

            model.setRowCount(0);
            txtTotal.setText("");

        } catch(Exception e) {
            JOptionPane.showMessageDialog(this,e.getMessage());
        }
    }
}