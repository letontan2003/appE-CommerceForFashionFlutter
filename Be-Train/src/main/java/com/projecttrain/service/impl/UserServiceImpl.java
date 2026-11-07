package com.projecttrain.service.impl;

import com.projecttrain.dto.request.CreateUserRequest;
import com.projecttrain.dto.request.UpdateUserRequest;
import com.projecttrain.dto.response.UserResponse;
import com.projecttrain.entity.User;
import com.projecttrain.exception.AppException;
import com.projecttrain.exception.ResourceNotFoundException;
import com.projecttrain.repository.UserRepository;
import com.projecttrain.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    private String generateRandomMaKH() {
        String maKH;
        do {
            long number = java.util.concurrent.ThreadLocalRandom.current().nextLong(1000000000L, 10000000000L);
            maKH = String.valueOf(number);
        } while (userRepository.existsById(maKH));
        return maKH;
    }

    @Override
    public UserResponse register(com.projecttrain.dto.request.RegisterRequest request) {
        // 1. Kiểm tra xác nhận mật khẩu nếu có
        if (request.getConfirmPassWord() != null && !request.getConfirmPassWord().isBlank()) {
            if (!request.getPassWord().equals(request.getConfirmPassWord())) {
                throw new AppException("Mật khẩu xác nhận không trùng khớp!", HttpStatus.BAD_REQUEST);
            }
        }

        // 2. Kiểm tra trùng lặp email
        if (Boolean.TRUE.equals(userRepository.existsByEmail(request.getEmail()))) {
            throw new AppException("Email '" + request.getEmail() + "' đã được sử dụng! Vui lòng chọn email khác.", HttpStatus.CONFLICT);
        }

        // 3. Kiểm tra trùng lặp UserName
        if (Boolean.TRUE.equals(userRepository.existsByTenKH(request.getTenKH()))) {
            throw new AppException("Tên người dùng '" + request.getTenKH() + "' đã tồn tại! Vui lòng chọn tên khác.", HttpStatus.CONFLICT);
        }

        // 4. Phát sinh maKH 10 số ngẫu nhiên không trùng lặp
        String maKH = generateRandomMaKH();

        // 5. Băm mật khẩu bằng BCrypt
        String hashedPassword = passwordEncoder.encode(request.getPassWord());

        // 6. Tạo User với các giá trị mặc định theo yêu cầu:
        // maKH: 10 chữ số ngẫu nhiên, role: USER, diemThuong: 0, ngayTao: hiện tại, trangThai: Active
        User user = User.builder()
                .maKH(maKH)
                .tenKH(request.getTenKH())
                .email(request.getEmail())
                .passWord(hashedPassword)
                .role("USER")
                .ngayTao(LocalDateTime.now())
                .diemThuong(0)
                .trangThai("Active")
                .build();

        User savedUser = userRepository.save(user);
        return UserResponse.fromEntity(savedUser);
    }

    @Override
    public UserResponse login(com.projecttrain.dto.request.LoginRequest request) {
        String query = request.getEmailOrUsername().trim();

        // Tìm kiếm theo Email hoặc UserName
        User user = userRepository.findByEmail(query)
                .or(() -> userRepository.findByTenKH(query))
                .orElseThrow(() -> new AppException("Tài khoản hoặc mật khẩu không chính xác!", HttpStatus.UNAUTHORIZED));

        // Kiểm tra khớp mật khẩu
        if (!passwordEncoder.matches(request.getPassWord(), user.getPassWord())) {
            throw new AppException("Tài khoản hoặc mật khẩu không chính xác!", HttpStatus.UNAUTHORIZED);
        }

        // Kiểm tra trạng thái tài khoản
        if (!"Active".equalsIgnoreCase(user.getTrangThai())) {
            throw new AppException("Tài khoản đang bị khóa hoặc không hoạt động!", HttpStatus.FORBIDDEN);
        }

        return UserResponse.fromEntity(user);
    }

    @Override
    public UserResponse createUser(CreateUserRequest request) {
        // Kiểm tra email trùng lặp
        if (Boolean.TRUE.equals(userRepository.existsByEmail(request.getEmail()))) {
            throw new AppException("Email '" + request.getEmail() + "' đã được sử dụng!", HttpStatus.CONFLICT);
        }

        // Băm mật khẩu bằng BCrypt
        String hashedPassword = passwordEncoder.encode(request.getPassWord());

        String userRole = (request.getRole() != null && !request.getRole().isBlank())
                ? request.getRole()
                : "USER";

        User user = User.builder()
                .maKH(generateRandomMaKH())
                .tenKH(request.getTenKH())
                .email(request.getEmail())
                .passWord(hashedPassword)
                .role(userRole)
                .ngayTao(LocalDateTime.now())
                .diemThuong(0)
                .trangThai("Active")
                .build();

        User savedUser = userRepository.save(user);
        return UserResponse.fromEntity(savedUser);
    }

    @Override
    public List<UserResponse> getAllUsers() {
        return userRepository.findAll().stream()
                .map(UserResponse::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public UserResponse getUserById(String id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy khách hàng với mã: " + id));
        return UserResponse.fromEntity(user);
    }

    @Override
    public UserResponse getUserByEmail(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy khách hàng với email: " + email));
        return UserResponse.fromEntity(user);
    }

    @Override
    public UserResponse updateUser(String id, UpdateUserRequest request) {
        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Không tìm thấy khách hàng với mã: " + id));

        if (request.getTenKH() != null && !request.getTenKH().isBlank()) {
            existingUser.setTenKH(request.getTenKH());
        }

        if (request.getPassWord() != null && !request.getPassWord().isBlank()) {
            existingUser.setPassWord(passwordEncoder.encode(request.getPassWord()));
        }

        if (request.getRole() != null && !request.getRole().isBlank()) {
            existingUser.setRole(request.getRole());
        }

        if (request.getDiemThuong() != null) {
            existingUser.setDiemThuong(request.getDiemThuong());
        }

        if (request.getTrangThai() != null && !request.getTrangThai().isBlank()) {
            existingUser.setTrangThai(request.getTrangThai());
        }

        User updatedUser = userRepository.save(existingUser);
        return UserResponse.fromEntity(updatedUser);
    }

    @Override
    public void deleteUser(String id) {
        if (!userRepository.existsById(id)) {
            throw new ResourceNotFoundException("Không tìm thấy khách hàng với mã: " + id);
        }
        userRepository.deleteById(id);
    }
}
