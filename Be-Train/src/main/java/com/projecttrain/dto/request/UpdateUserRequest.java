package com.projecttrain.dto.request;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UpdateUserRequest {

    private String tenKH;

    @Size(min = 6, message = "Mật khẩu mới phải có ít nhất 6 ký tự")
    private String passWord;

    private String role;

    private Integer diemThuong;

    private String trangThai;
}
