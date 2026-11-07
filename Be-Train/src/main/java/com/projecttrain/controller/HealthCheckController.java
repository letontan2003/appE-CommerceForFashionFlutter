package com.projecttrain.controller;

import com.projecttrain.dto.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.bson.Document;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/health")
@RequiredArgsConstructor
public class HealthCheckController {

    private final MongoTemplate mongoTemplate;

    @GetMapping
    public ResponseEntity<ApiResponse<Map<String, Object>>> checkHealth() {
        Map<String, Object> details = new HashMap<>();
        details.put("serverStatus", "UP");
        details.put("timestamp", LocalDateTime.now());

        try {
            Document ping = mongoTemplate.executeCommand(new Document("ping", 1));
            details.put("databaseStatus", "UP");
            details.put("databaseName", mongoTemplate.getDb().getName());
            details.put("mongoPingOk", ping.get("ok"));
        } catch (Exception e) {
            details.put("databaseStatus", "DOWN");
            details.put("databaseError", e.getMessage());
        }

        return ResponseEntity.ok(ApiResponse.success(details, "Hệ thống Backend Be-Train đang hoạt động ổn định"));
    }
}
