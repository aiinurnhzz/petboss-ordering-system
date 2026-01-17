package com.petboss.config;

import com.cloudinary.Cloudinary;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;

import java.util.HashMap;
import java.util.Map;

@ApplicationScoped
public class CloudinaryConfig {

    @Produces
    public Cloudinary cloudinary() {

        Map<String, String> config = new HashMap<>();
        config.put("cloud_name", "dj1p3z9ko");
        config.put("api_key", "732371368313435");
        config.put("api_secret", "H2thykIMnyUEi4cvOJ-fRYAfXhE");

        return new Cloudinary(config);
    }
}
