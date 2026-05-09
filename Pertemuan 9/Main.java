public class Main {
    public static void main(String[] args) {
        ConnectDatabase.getConnection();
        new MainMenu().setVisible(true);
    }
}