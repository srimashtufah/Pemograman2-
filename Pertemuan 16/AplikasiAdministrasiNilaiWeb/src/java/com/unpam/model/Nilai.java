package com.unpam.model;

public class Nilai {
    private String nim;
    private String nama;
    private String matakuliah;
    private double tugas;
    private double uts;
    private double uas;
    private double akhir;
    private String grade;

    // Constructor Kosong
    public Nilai() {
    }

    // Constructor dengan Parameter
    public Nilai(String nim, String nama, String matakuliah, double tugas, double uts, double uas) {
        this.nim = nim;
        this.nama = nama;
        this.matakuliah = matakuliah;
        this.tugas = tugas;
        this.uts = uts;
        this.uas = uas;
        this.hitungNilai();
    }

    // Logika Perhitungan Nilai Akhir & Grade sesuai standar kampus
    private void hitungNilai() {
        this.akhir = (this.tugas * 0.3) + (this.uts * 0.3) + (this.uas * 0.4);
        if (this.akhir >= 80) this.grade = "A";
        else if (this.akhir >= 70) this.grade = "B";
        else if (this.akhir >= 60) this.grade = "C";
        else if (this.akhir >= 50) this.grade = "D";
        else this.grade = "E";
    }

    // Getter dan Setter
    public String getNim() { return nim; }
    public void setNim(String nim) { this.nim = nim; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public String getMatakuliah() { return matakuliah; }
    public void setMatakuliah(String matakuliah) { this.matakuliah = matakuliah; }

    public double getTugas() { return tugas; }
    public void setTugas(double tugas) { this.tugas = tugas; this.hitungNilai(); }

    public double getUts() { return uts; }
    public void setUts(double uts) { this.uts = uts; this.hitungNilai(); }

    public double getUas() { return uas; }
    public void setUas(double uas) { this.uas = uas; this.hitungNilai(); }

    public double getAkhir() { return akhir; }
    public String getGrade() { return grade; }
}