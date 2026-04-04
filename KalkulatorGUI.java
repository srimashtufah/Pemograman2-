import java.awt.event.*;
import javax.swing.*;

public class KalkulatorGUI extends JFrame implements ActionListener {

    JLabel lbl1, lbl2, lbl3;
    JTextField txt1, txt2, txtHasil;
    JButton btnTambah, btnHapus, btnExit;

    public KalkulatorGUI() {
        setTitle("Sri Mashtufah Anjani - 231011401951");
        setSize(400, 250);
        setLayout(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Label
        lbl1 = new JLabel("Angka Pertama");
        lbl1.setBounds(30, 30, 120, 25);
        add(lbl1);

        lbl2 = new JLabel("Angka Kedua");
        lbl2.setBounds(30, 70, 120, 25);
        add(lbl2);

        lbl3 = new JLabel("Hasil");
        lbl3.setBounds(30, 110, 120, 25);
        add(lbl3);

        // TextField
        txt1 = new JTextField();
        txt1.setBounds(150, 30, 150, 25);
        add(txt1);

        txt2 = new JTextField();
        txt2.setBounds(150, 70, 150, 25);
        add(txt2);

        txtHasil = new JTextField();
        txtHasil.setBounds(150, 110, 150, 25);
        txtHasil.setEditable(false);
        add(txtHasil);

        // Button
        btnTambah = new JButton("Tambah");
        btnTambah.setBounds(40, 160, 90, 30);
        add(btnTambah);

        btnHapus = new JButton("Hapus");
        btnHapus.setBounds(150, 160, 90, 30);
        add(btnHapus);

        btnExit = new JButton("Exit");
        btnExit.setBounds(260, 160, 90, 30);
        add(btnExit);

        btnTambah.addActionListener(this);
        btnHapus.addActionListener(this);
        btnExit.addActionListener(this);

        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == btnTambah) {
            try {
                // Parse the numbers from the text fields
                int a = Integer.parseInt(txt1.getText());
                int b = Integer.parseInt(txt2.getText());
                // Perform addition
                int hasil = a + b;
                // Display the result
                txtHasil.setText(String.valueOf(hasil));
            } catch (NumberFormatException ex) {
                // Handle invalid input
                JOptionPane.showMessageDialog(this, "Masukkan angka yang valid!", "Error", JOptionPane.ERROR_MESSAGE);
            }
        }

        if (e.getSource() == btnHapus) {
            // Clear the text fields
            txt1.setText("");
            txt2.setText("");
            txtHasil.setText("");
        }

        if (e.getSource() == btnExit) {
            // Exit the application
            System.exit(0);
        }
    }

    public static void main(String[] args) {
        // Create an instance of KalkulatorGUI
        new KalkulatorGUI();
    }
}