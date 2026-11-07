package com.projecttrain.config;

import com.projecttrain.repository.UserRepository;
import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component
public class MongoConnectionRunner implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(MongoConnectionRunner.class);

    private final MongoTemplate mongoTemplate;
    private final UserRepository userRepository;

    public MongoConnectionRunner(MongoTemplate mongoTemplate, UserRepository userRepository) {
        this.mongoTemplate = mongoTemplate;
        this.userRepository = userRepository;
    }

    @Override
    public void run(String... args) {
        log.info("------------------------------------------------------------");
        log.info(" Đang kiểm tra kết nối tới cơ sở dữ liệu MongoDB...");
        try {
            // Ping MongoDB command
            Document pingResult = mongoTemplate.executeCommand(new Document("ping", 1));
            String dbName = mongoTemplate.getDb().getName();
            Set<String> collections = mongoTemplate.getCollectionNames();
            long userCount = userRepository.count();

            log.info("============================================================");
            log.info("  KẾT NỐI MONGODB THÀNH CÔNG!");
            log.info(" Database Name        : {}", dbName);
            log.info(" Ping Status          : {}", pingResult.get("ok"));
            log.info(" Danh sách Collection : {}", collections);
            log.info(" Tổng số người dùng   : {}", userCount);
            log.info("============================================================");
        } catch (Exception ex) {
            log.error("============================================================");
            log.error("  KẾT NỐI MONGODB THẤT BẠI!");
            log.error(" Chi tiết lỗi: {}", ex.getMessage());
            log.error(" Vui lòng kiểm tra lại MONGODB_URI hoặc IP Whitelist trên MongoDB Atlas.");
            log.error("============================================================");
        }
    }
}
