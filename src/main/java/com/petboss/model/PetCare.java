package com.petboss.model;

import java.sql.Date;

public class PetCare {

    private String productId;
    private String type;
    private Date expiryDate;

    // ===== Getters & Setters =====

    public String getProductId() {
        return productId;
    }
    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }
    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
}
