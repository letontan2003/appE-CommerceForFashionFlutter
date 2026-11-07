package com.projecttrain.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginRequest {

    @NotBlank(message = "Email hoặc UserName không được để trống")
    private String emailOrUsername;

    @NotBlank(message = "Mật khẩu không được để trống")
    private String passWord;
}
