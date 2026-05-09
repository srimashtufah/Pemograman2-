import java.awt.*;
import javax.swing.*;

public class MainMenu extends JFrame {

    JButton btnBarang = new JButton("Data Barang");
    JButton btnCustomer = new JButton("Data Customer");
    JButton btnSupplier = new JButton("Data Supplier");
    JButton btnTransaksi = new JButton("Transaksi");
    btnReport.addActionListener(e -> {
    String[] pilihan = {
        "Laporan Transaksi",
        "Laporan Inventory"
    };

    String pilih = (String) JOptionPane.showInputDialog(
        null,
        "Pilih Report",
        "Report",
        JOptionPane.PLAIN_MESSAGE,
        null,
        pilihan,
        pilihan[0]
    );

    if(pilih == null) return;

    if(pilih.equals("Laporan Transaksi")) {
        ReportViewer.show("laporan_transaksi.jasper");
    } else {
        ReportViewer.show("laporan_inventory.jasper");
    }
});

    public MainMenu() {
        setTitle("Aplikasi Penjualan");
        setSize(500, 300);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new GridLayout(5,1,10,10));

        add(btnBarang);
        btnBarang.addActionListener(e -> new FormBarang().setVisible(true));
        add(btnCustomer);
        btnCustomer.addActionListener(e -> new FormCustomer().setVisible(true));
        add(btnSupplier);
        btnSupplier.addActionListener(e -> new FormSupplier().setVisible(true));
        add(btnTransaksi);
        btnTransaksi.addActionListener(e -> new FormTransaksi().setVisible(true));
        add(btnReport);
    }
}