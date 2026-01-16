package com.petboss.model;

public class OrderItemDTO {

    private String productId;
    private int quantity;
    private double unitPrice;
    private double total;

    // ===============================
    // No-argument constructor
    // (REQUIRED by Gson)
    // ===============================
    public OrderItemDTO() {
    }

    // ===============================
    // Optional full constructor
    // ===============================
    public OrderItemDTO(String productId, int quantity,
                        double unitPrice, double total) {
        this.productId = productId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.total = total;
    }

    // ===============================
    // Getters
    // ===============================
    public String getProductId() {
        return productId;
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

    // ===============================
    // Setters
    // ===============================
    public void setProductId(String productId) {
        this.productId = productId;
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
}
