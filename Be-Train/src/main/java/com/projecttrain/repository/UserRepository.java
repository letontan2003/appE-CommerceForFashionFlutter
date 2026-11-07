package com.projecttrain.repository;

import com.projecttrain.entity.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends MongoRepository<User, String> {

    Optional<User> findByEmail(String email);

    Optional<User> findByTenKH(String tenKH);

    Boolean existsByEmail(String email);

    Boolean existsByTenKH(String tenKH);

    Optional<User> findByEmailOrTenKH(String email, String tenKH);
}
