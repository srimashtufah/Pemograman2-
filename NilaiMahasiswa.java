import java.util.Scanner;

public class NilaiMahasiswa {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);

        System.out.print("Masukkan nama mahasiswa: ");
        String nama = input.nextLine();

        System.out.print("Masukkan nilai tugas: ");
        double tugas = input.nextDouble();

        System.out.print("Masukkan nilai UTS: ");
        double uts = input.nextDouble();

        System.out.print("Masukkan nilai UAS: ");
        double uas = input.nextDouble();

        // Menghitung nilai akhir (bobot contoh)
        double nilaiAkhir = (tugas * 0.3) + (uts * 0.3) + (uas * 0.4);

        // Menentukan grade
        String grade;
        if (nilaiAkhir >= 85) {
            grade = "A";
        } else if (nilaiAkhir >= 70) {
            grade = "B";
        } else if (nilaiAkhir >= 55) {
            grade = "C";
        } else if (nilaiAkhir >= 40) {
            grade = "D";
        } else {
            grade = "E";
        }

        // Output
        System.out.println("\n=== HASIL NILAI MAHASISWA ===");
        System.out.println("Nama        : " + nama);
        System.out.println("Nilai Akhir : " + nilaiAkhir);
        System.out.println("Grade       : " + grade);

        input.close();
    }
}