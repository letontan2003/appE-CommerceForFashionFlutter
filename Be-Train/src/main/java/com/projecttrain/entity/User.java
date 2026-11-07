package com.projecttrain.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Document(collection = "users")
public class User {

    @Id
    private String maKH;

    private String tenKH;

    @Indexed(unique = true)
    private String email;

    private String passWord;

    @Builder.Default
    private String role = "USER";

    @CreatedDate
    @Builder.Default
    private LocalDateTime ngayTao = LocalDateTime.now();

    @Builder.Default
    private Integer diemThuong = 0;

    @Builder.Default
    private String trangThai = "Active";
}
