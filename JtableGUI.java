import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class JtableGUI extends JFrame {

    private DefaultTableModel model;
    private JTable table;
    
    public JtableGUI() {
        // Setup the main frame
        setTitle("Main Frame");
        setSize(500, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null);
        
        // Create the table with model
        model = new DefaultTableModel();
        model.addColumn("N I M");
        model.addColumn("Nama Mahasiswa");
        model.addColumn("Nilai");

        // Create the JTable
        table = new JTable(model);
        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.setBounds(20, 120, 450, 100); // Position and size of table
        add(scrollPane);

        // Text fields for user input
        JTextField nimField = new JTextField();
        nimField.setBounds(150, 20, 200, 25);
        add(nimField);

        JTextField nameField = new JTextField();
        nameField.setBounds(150, 50, 200, 25);
        add(nameField);

        JTextField nilaiField = new JTextField();
        nilaiField.setBounds(150, 80, 200, 25);
        add(nilaiField);

        // Labels for the text fields
        JLabel nimLabel = new JLabel("N I M");
        nimLabel.setBounds(50, 20, 100, 25);
        add(nimLabel);

        JLabel nameLabel = new JLabel("Nama Mahasiswa");
        nameLabel.setBounds(50, 50, 100, 25);
        add(nameLabel);

        JLabel nilaiLabel = new JLabel("Nilai");
        nilaiLabel.setBounds(50, 80, 100, 25);
        add(nilaiLabel);

        // Button to add data to the table
        JButton addButton = new JButton("TABEL");
        addButton.setBounds(360, 50, 100, 25);
        add(addButton);

        // Action for button
        addButton.addActionListener(e -> {
            String nim = nimField.getText();
            String name = nameField.getText();
            String nilai = nilaiField.getText();
            Object[] row = {nim, name, nilai};
            model.addRow(row);
        });

        // Create another frame button
        JButton showFrameButton = new JButton("PANGGIL FRAME");
        showFrameButton.setBounds(180, 230, 150, 25);
        add(showFrameButton);

        // Action for showing another frame
        showFrameButton.addActionListener(e -> {
            // Create the second frame
            SecondFrame secondFrame = new SecondFrame();
            secondFrame.setVisible(true);
        });
    }

    // Second Frame class
    class SecondFrame extends JFrame {
        public SecondFrame() {
            setTitle("Frame Yang Dipanggil");
            setSize(400, 200);
            setLayout(null);
            setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

            // NIM and Name fields
            JTextField nimField = new JTextField();
            nimField.setBounds(150, 30, 200, 25);
            add(nimField);

            JTextField nameField = new JTextField();
            nameField.setBounds(150, 60, 200, 25);
            add(nameField);

            // Labels for the second frame
            JLabel nimLabel = new JLabel("N I M");
            nimLabel.setBounds(50, 30, 100, 25);
            add(nimLabel);

            JLabel nameLabel = new JLabel("Nama Mahasiswa");
            nameLabel.setBounds(50, 60, 100, 25);
            add(nameLabel);
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            JtableGUI mainFrame = new JtableGUI();
            mainFrame.setVisible(true);
        });
    }
}