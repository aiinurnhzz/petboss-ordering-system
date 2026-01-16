package com.petboss.model;

import java.util.Date;

public class Staff {

    private String staffId;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String role;
    private String pmId;
    private String photo;
    private Date joinedDate;
    private String status;

    // ===== GETTERS & SETTERS =====

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }

    public String getPmId() {
        return pmId;
    }
    
    public void setPmId(String pmId) {
        this.pmId = pmId;
    }

    public String getPhoto() {
        return photo;
    }
    
    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Date getJoinedDate() {
        return joinedDate;
    }
    
    public void setJoinedDate(Date joinedDate) {
        this.joinedDate = joinedDate;
    }

    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
}
