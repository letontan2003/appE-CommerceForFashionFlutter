package com.projecttrain;

import io.github.cdimascio.dotenv.Dotenv;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.mongodb.config.EnableMongoAuditing;

@SpringBootApplication
@EnableMongoAuditing
public class BeTrainApplication {

    private static final Logger log = LoggerFactory.getLogger(BeTrainApplication.class);

    public static void main(String[] args) {
        // Load environment variables from .env file into System properties
        try {
            Dotenv dotenv = Dotenv.configure()
                    .ignoreIfMissing()
                    .load();

            dotenv.entries().forEach(entry -> {
                if (System.getProperty(entry.getKey()) == null) {
                    System.setProperty(entry.getKey(), entry.getValue());
                }
            });
            log.info("Loaded .env file successfully.");
        } catch (Exception e) {
            log.warn("Could not load .env file: {}. Continuing with existing system env.", e.getMessage());
        }

        SpringApplication.run(BeTrainApplication.class, args);
    }
}
