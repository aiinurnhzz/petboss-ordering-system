package com.petboss.model;

import java.sql.Date;

public class Order {

    private String orderId;

    // Foreign keys
    private String supplierId;
    private String staffId;

    // Joined display fields
    private String supplierName;
    private String staffName;

    // yyyy-MM-dd
    private Date orderDate;

    // Maps to DB column: total_amount
    private double total;
    
    private String status;

    // =========================
    // GETTERS
    // =========================
    public String getOrderId() {
        return orderId;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public String getStaffId() {
        return staffId;
    }

    public String getStaffName() {
        return staffName;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public double getTotal() {
        return total;
    }
    
    public String getStatus() {
        return status;
    }

    // =========================
    // SETTERS
    // =========================
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public void setTotal(double total) {
        this.total = total;
    }

	public void setStatus(String status) {
		this.status = status;
		
	}
}
