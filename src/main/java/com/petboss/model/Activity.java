package com.petboss.model;

public class Activity {

    private String staffName;
    private String description;
    private String time;   // 🔹 TAMBAH NI

    // ===== GETTERS & SETTERS =====
    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // 🔹 INI YANG KURANG
    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
