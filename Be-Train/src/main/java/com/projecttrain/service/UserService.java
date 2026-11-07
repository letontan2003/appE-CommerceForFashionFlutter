package com.projecttrain.service;

import com.projecttrain.dto.request.CreateUserRequest;
import com.projecttrain.dto.request.UpdateUserRequest;
import com.projecttrain.dto.response.UserResponse;

import java.util.List;

public interface UserService {

    UserResponse register(com.projecttrain.dto.request.RegisterRequest request);

    UserResponse login(com.projecttrain.dto.request.LoginRequest request);

    UserResponse createUser(CreateUserRequest request);

    List<UserResponse> getAllUsers();

    UserResponse getUserById(String id);

    UserResponse getUserByEmail(String email);

    UserResponse updateUser(String id, UpdateUserRequest request);

    void deleteUser(String id);
}
