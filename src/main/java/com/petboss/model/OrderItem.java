package com.petboss.model;

public class OrderItem {

    // =========================
    // EXISTING FIELDS
    // =========================
    private String productId;
    private String productName;

    // maps to order_detail.quantity_ordered
    private int quantity;

    // maps to order_detail.unit_price
    private double unitPrice;

    // maps to order_detail.total_price
    private double total;

    // =========================
    // NEW FIELDS (FOR RECEIVE)
    // =========================
    private int orderDetailId;   // orderdetail.orderdetail_id
    private int received;        // total received quantity

    // =========================
    // GETTERS
    // =========================
    public String getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public double getTotal() {
        return total;
    }

    // 🔥 NEW GETTERS
    public int getOrderDetailId() {
        return orderDetailId;
    }

    public int getReceived() {
        return received;
    }

    // =========================
    // SETTERS
    // =========================
    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    // 🔥 NEW SETTERS
    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public void setReceived(int received) {
        this.received = received;
    }
}
