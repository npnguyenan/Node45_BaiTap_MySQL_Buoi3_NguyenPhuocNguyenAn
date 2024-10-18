-- Bài tập buổi 3 MySQL
-- Node_45 
-- Nguyễn Phước Nguyên Ân

-- Tạo database 
CREATE DATABASE bt_buoi_3
USE bt_buoi_3

-- Tạo table

-- user - key: user_id 
CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

-- restaurant - key: res_id
CREATE TABLE restaurant (
    res_id INT PRIMARY KEY AUTO_INCREMENT,
    res_name VARCHAR(255),
    image VARCHAR(255),
    `desc` VARCHAR(255)
);

-- food_type - key: type_id
CREATE TABLE food_type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(255)
);

-- food - key: food_id, foreign key: type_id từ food_type
CREATE TABLE food (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    food_name VARCHAR(255),
    image VARCHAR(255),
    price FLOAT,
    `desc` VARCHAR(255),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES food_type(type_id)
);

-- sub_food - key: sub_id, foreign key: food_id từ food
CREATE TABLE sub_food (
    sub_id INT PRIMARY KEY AUTO_INCREMENT,
    sub_name VARCHAR(255),
    sub_price FLOAT,
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

-- order - 2 foreign key: food_id từ food và user_id từ user
CREATE TABLE `order` (
    user_id INT,
    food_id INT,
    amount INT,
    code VARCHAR(255),
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

-- rate_res - 2 foreign key: res_id từ restaurant và user_id từ user
CREATE TABLE rate_res (
    user_id INT,
    res_id INT,
    amount INT,
    date_rate DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

-- like_res - 2 foreign key: res_id từ restaurant và user_id từ user
CREATE TABLE like_res (
    user_id INT,
    res_id INT,
    date_like DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

-- Tạo dữ liệu 

-- Bảng user
INSERT INTO user (full_name, email, password)
VALUES
('Nguyen Phuoc Nguyen An', 'np.nguyenan@gmail.com', '123'),
('Ngo Hoang Phuc', 'phucngo@gmail.com', '123'),
('Dang Minh Tuan', 'minhtuan_dang@gmail.com', '123'),
('Le Van Teo', 'teo@gmail.com', '123'),
('Tran Van Ty', 'ty@gmail.com', '123'),
('Nguyen Thi Tun', 'tun@gmail.com', '123');

-- Bảng restaurant
INSERT INTO restaurant (res_name, image, `desc`)
VALUES
('Nha hang 1', 'image1.jpg', 'Nha hang Au'),
('Nha hang 2', 'image2.jpg', 'Nha hang hai san'),
('Nha hang 3', 'image3.jpg', 'Nha hang gia dinh');

-- Bảng food_type 
INSERT INTO food_type (type_name)
VALUES
('Khai vi'),
('Mon chinh'),
('Mon phu'),
('Trang mieng');

-- Bảng food
INSERT INTO food (food_name, image, price, `desc`, type_id)
VALUES
('Beefsteak', 'beefsteak_image.jpg', 400, 'Bo Wagyu', 2),
('Salad', 'salad_image.jpg', 100, 'Rau tuoi organic', 1),
('Cua hoang de', 'cua_hoang_de_image.jpg', 900, 'Cua nhap khau', 2),
('Com chien', 'com_chien_image.jpg', 100, 'Com chien hai san', 3),
('Sua chua', 'sua_chua_image.jpg', 30, 'Sua chua vinamilk', 4);

-- Bảng sub_food
INSERT INTO sub_food (sub_name, sub_price, food_id)
VALUES
('Medium rare', 0, 1),
('Welldone', 0, 1),
('Topping top mo', 10, 2),
('My xao', 50, 3),
('Nhieu hai san', 50, 4),
('Vi dau', 0, 5);

-- Bảng order
INSERT INTO `order` (user_id, food_id, amount, code, arr_sub_id)
VALUES
(1, 1, 1, 'ORD001', '1'),
(2, 2, 2, 'ORD002', ''),
(3, 3, 1, 'ORD003', ''),
(4, 4, 1, 'ORD004', ''),
(5, 2, 1, 'ORD005', ''),
(6, 1, 1, 'ORD006', '2');

-- Bảng rate_res
INSERT INTO rate_res (user_id, res_id, amount, date_rate)
VALUES
(1, 1, 5, '2024-10-10 15:30:00'),
(2, 2, 4, '2024-10-07 11:00:00'),
(1, 2, 5, '2024-10-11 19:00:00'),
(3, 1, 4, '2024-10-08 20:00:00'),
(4, 3, 5, '2024-10-12 20:30:00'),
(5, 1, 4, '2024-10-15 18:45:00'),
(6, 2, 3, '2024-10-14 19:10:00');

-- Bảng like_res
INSERT INTO like_res (user_id, res_id, date_like)
VALUES
(1, 1, '2024-10-07 14:20:00'),
(2, 2, '2024-10-08 15:10:00'),
(1, 3, '2024-10-09 18:25:00'),
(3, 1, '2024-10-10 19:20:00'),
(4, 2, '2024-10-11 21:25:00'),
(5, 3, '2024-10-12 13:00:00'),
(1, 2, '2024-10-13 19:10:00'),
(6, 1, '2024-10-14 14:50:00');

-- Tìm 5 người đã like nhà hàng nhiều nhất
SELECT u.user_id, u.full_name, COUNT(lr.res_id) AS like_count
FROM user u
JOIN like_res lr ON u.user_id = lr.user_id
GROUP BY u.user_id, u.full_name
ORDER BY like_count DESC
LIMIT 5;

-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT r.res_id, r.res_name, COUNT(lr.user_id) AS like_count
FROM restaurant r
JOIN like_res lr ON r.res_id = lr.res_id
GROUP BY r.res_id, r.res_name
ORDER BY like_count DESC
LIMIT 2;

-- Tìm người đã đặt hàng nhiều nhất
SELECT u.user_id, u.full_name, COUNT(o.food_id) AS order_count
FROM user u
JOIN `order` o ON u.user_id = o.user_id
GROUP BY u.user_id, u.full_name
ORDER BY order_count DESC
LIMIT 1;

-- Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng).
SELECT u.user_id, u.full_name
FROM user u
LEFT JOIN `order` o ON u.user_id = o.user_id
LEFT JOIN like_res lr ON u.user_id = lr.user_id
LEFT JOIN rate_res rr ON u.user_id = rr.user_id
WHERE o.user_id IS NULL
AND lr.user_id IS NULL
AND rr.user_id IS NULL;
