package com.petboss.service;

import com.cloudinary.Cloudinary;
import jakarta.servlet.http.Part;

import java.util.HashMap;
import java.util.Map;

public class CloudinaryService {

    private static final Cloudinary cloudinary;

    static {
        Map<String, String> config = new HashMap<>();
        config.put("cloud_name", System.getenv("CLOUDINARY_CLOUD_NAME"));
        config.put("api_key", System.getenv("CLOUDINARY_API_KEY"));
        config.put("api_secret", System.getenv("CLOUDINARY_API_SECRET"));

        cloudinary = new Cloudinary(config);
    }

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
