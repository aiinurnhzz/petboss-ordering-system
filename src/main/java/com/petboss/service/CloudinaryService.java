package com.petboss.service;

import com.cloudinary.Cloudinary;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.servlet.http.Part;

import java.util.Map;

@ApplicationScoped
public class CloudinaryService {

    @Inject
    private Cloudinary cloudinary;

    public String uploadProductImage(Part imagePart, String productId) {

        try {
            Map uploadResult = cloudinary.uploader().upload(
                imagePart.getInputStream(),
                Map.of(
                    "folder", "products",
                    "public_id", productId,
                    "overwrite", true
                )
            );

            return uploadResult.get("secure_url").toString();

        } catch (Exception e) {
            throw new RuntimeException("Cloudinary upload failed", e);
        }
    }
}
