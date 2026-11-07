package com.projecttrain.dto.response;

import com.projecttrain.entity.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserResponse {

    private String maKH;
    private String tenKH;
    private String email;
    private String role;
    private LocalDateTime ngayTao;
    private Integer diemThuong;
    private String trangThai;

    public static UserResponse fromEntity(User user) {
        if (user == null) {
            return null;
        }
        return UserResponse.builder()
                .maKH(user.getMaKH())
                .tenKH(user.getTenKH())
                .email(user.getEmail())
                .role(user.getRole())
                .ngayTao(user.getNgayTao())
                .diemThuong(user.getDiemThuong())
                .trangThai(user.getTrangThai())
                .build();
    }
}
