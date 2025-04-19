/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80035 (8.0.35)
 Source Host           : localhost:3306
 Source Schema         : rbac

 Target Server Type    : MySQL
 Target Server Version : 80035 (8.0.35)
 File Encoding         : 65001

 Date: 13/04/2025 11:21:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `category_id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '电子产品');
INSERT INTO `categories` VALUES (2, '家居用品');
INSERT INTO `categories` VALUES (3, '电子产品');
INSERT INTO `categories` VALUES (4, '家居用品');
INSERT INTO `categories` VALUES (5, '图书音像');
INSERT INTO `categories` VALUES (6, '服装配饰');
INSERT INTO `categories` VALUES (7, '食品饮料');
INSERT INTO `categories` VALUES (8, '运动户外');
INSERT INTO `categories` VALUES (9, '美妆个护');
INSERT INTO `categories` VALUES (10, '母婴用品');
INSERT INTO `categories` VALUES (11, '数码配件');
INSERT INTO `categories` VALUES (12, '家装饰品');
INSERT INTO `categories` VALUES (13, '汽车用品');
INSERT INTO `categories` VALUES (14, '办公设备');
INSERT INTO `categories` VALUES (15, '宠物用品');
INSERT INTO `categories` VALUES (16, '园艺工具');
INSERT INTO `categories` VALUES (17, '乐器');
INSERT INTO `categories` VALUES (18, '玩具');
INSERT INTO `categories` VALUES (19, '旅行装备');
INSERT INTO `categories` VALUES (20, '健康护理');
INSERT INTO `categories` VALUES (21, '珠宝首饰');
INSERT INTO `categories` VALUES (22, '钟表');
INSERT INTO `categories` VALUES (23, '鞋类');
INSERT INTO `categories` VALUES (24, '箱包');
INSERT INTO `categories` VALUES (25, '电脑周边');
INSERT INTO `categories` VALUES (26, '手机配件');
INSERT INTO `categories` VALUES (27, '家用电器');
INSERT INTO `categories` VALUES (28, '厨房用品');
INSERT INTO `categories` VALUES (29, '卫浴用品');
INSERT INTO `categories` VALUES (30, '灯具');
INSERT INTO `categories` VALUES (31, '装饰画');
INSERT INTO `categories` VALUES (32, '床上用品');

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `detail_id` int NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id` int NOT NULL COMMENT '订单ID（外键）',
  `product_id` int NOT NULL COMMENT '商品ID（外键）',
  `quantity` int NOT NULL COMMENT '购买数量',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '成交单价',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `fk_order`(`order_id` ASC) USING BTREE,
  INDEX `fk_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单商品明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `user_id` int NOT NULL COMMENT '用户ID（外键）',
  `order_date` date NOT NULL COMMENT '订单日期',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `fk_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `permission_id` int NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `permission_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限代码（如：order:create）',
  `permission_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称（如：创建订单）',
  PRIMARY KEY (`permission_id`) USING BTREE,
  UNIQUE INDEX `permission_code_UNIQUE`(`permission_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'order:create', '创建订单');
INSERT INTO `permissions` VALUES (2, 'order:view', '查看订单');
INSERT INTO `permissions` VALUES (3, 'product:edit', '编辑商品');
INSERT INTO `permissions` VALUES (4, 'product:delete', '删除商品');
INSERT INTO `permissions` VALUES (5, 'user:manage', '管理用户');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `product_id` int NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `price` decimal(10, 2) NOT NULL COMMENT '单价',
  `category_id` int NOT NULL COMMENT '分类ID（外键）',
  `stock` int NOT NULL COMMENT '库存量',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品描述',
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `fk_category`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'iPhone 15', 6999.00, 1, 100, '最新款苹果手机');
INSERT INTO `products` VALUES (2, '实木餐桌', 2999.00, 2, 50, '北欧风格实木餐桌');
INSERT INTO `products` VALUES (3, 'Java编程思想', 89.00, 3, 200, '经典编程教材');
INSERT INTO `products` VALUES (4, '男士衬衫', 199.00, 4, 300, '纯棉修身男士衬衫');
INSERT INTO `products` VALUES (5, '矿泉水', 2.00, 5, 1000, '550ml瓶装矿泉水');
INSERT INTO `products` VALUES (6, '跑步机', 4999.00, 6, 30, '家用静音跑步机');
INSERT INTO `products` VALUES (7, '保湿面膜', 99.00, 7, 200, '深层补水保湿面膜');
INSERT INTO `products` VALUES (8, '婴儿推车', 899.00, 8, 80, '可折叠便携婴儿推车');
INSERT INTO `products` VALUES (9, '无线鼠标', 129.00, 9, 150, '2.4G无线静音鼠标');
INSERT INTO `products` VALUES (10, '装饰花瓶', 159.00, 10, 120, '现代简约陶瓷花瓶');
INSERT INTO `products` VALUES (11, '汽车座垫', 399.00, 11, 90, '冰丝透气汽车座垫');
INSERT INTO `products` VALUES (12, '激光打印机', 1299.00, 12, 40, '黑白激光打印机');
INSERT INTO `products` VALUES (13, '狗粮', 89.00, 13, 500, '10kg装全价犬粮');
INSERT INTO `products` VALUES (14, '园艺剪刀', 59.00, 14, 200, '不锈钢园艺修剪剪刀');
INSERT INTO `products` VALUES (15, '电子琴', 999.00, 15, 60, '61键电子琴');
INSERT INTO `products` VALUES (16, '积木套装', 199.00, 16, 150, '儿童益智积木玩具');
INSERT INTO `products` VALUES (17, '旅行箱', 599.00, 17, 100, '20寸万向轮旅行箱');
INSERT INTO `products` VALUES (18, '血压计', 299.00, 18, 120, '智能上臂式血压计');
INSERT INTO `products` VALUES (19, '银项链', 899.00, 19, 50, '纯银时尚项链');
INSERT INTO `products` VALUES (20, '石英表', 499.00, 20, 70, '男士商务石英手表');
INSERT INTO `products` VALUES (21, '运动鞋', 399.00, 21, 200, '透气网面运动跑鞋');
INSERT INTO `products` VALUES (22, '双肩包', 299.00, 22, 180, '防水帆布双肩背包');
INSERT INTO `products` VALUES (23, '机械键盘', 499.00, 23, 100, 'RGB背光机械键盘');
INSERT INTO `products` VALUES (24, '手机壳', 49.00, 24, 300, '防摔磨砂手机壳');
INSERT INTO `products` VALUES (25, '电饭煲', 399.00, 25, 150, '智能预约电饭煲');
INSERT INTO `products` VALUES (26, '炒锅', 199.00, 26, 200, '不粘涂层炒锅');
INSERT INTO `products` VALUES (27, '花洒', 159.00, 27, 100, '增压节水淋浴花洒');
INSERT INTO `products` VALUES (28, 'LED台灯', 129.00, 28, 180, '护眼充电式台灯');
INSERT INTO `products` VALUES (29, '装饰画', 299.00, 29, 90, '现代抽象装饰画');
INSERT INTO `products` VALUES (30, '四件套', 399.00, 30, 120, '纯棉床上四件套');

-- ----------------------------
-- Table structure for role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE `role_permissions`  (
  `role_id` int NOT NULL COMMENT '角色ID（外键）',
  `permission_id` int NOT NULL COMMENT '权限ID（外键）',
  PRIMARY KEY (`role_id`, `permission_id`) USING BTREE,
  INDEX `fk_role_permissions_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `fk_role_permissions_perm` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色与权限关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `role_id` int NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称（如：管理员、普通用户）',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE INDEX `role_name_UNIQUE`(`role_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'admin', '系统管理员');
INSERT INTO `roles` VALUES (2, 'customer', '普通用户');
INSERT INTO `roles` VALUES (3, 'editor', '内容编辑');
INSERT INTO `roles` VALUES (4, 'manager', '部门经理');
INSERT INTO `roles` VALUES (5, 'guest', '访客');

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles`  (
  `user_id` int NOT NULL COMMENT '用户ID（外键）',
  `role_id` int NOT NULL COMMENT '角色ID（外键）',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `fk_user_roles_role`(`role_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_roles
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名（唯一）',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '加密密码',
  `age` int NOT NULL COMMENT '年龄',
  `gender` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '性别',
  `register_date` date NOT NULL COMMENT '注册日期',
  `status` tinyint NULL DEFAULT 1 COMMENT '账户状态（0-禁用，1-启用）',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username_UNIQUE`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户基础信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (31, 'user1', 'a722c63db8ec8625af6cf71cb8c2d939', 25, '男', '2023-01-01', 1);
INSERT INTO `users` VALUES (32, 'user2', 'c1572d05424d0ecb2a65ec6a82aeacbf', 28, '女', '2023-01-05', 1);
INSERT INTO `users` VALUES (33, 'user3', '3afc79b597f88a72528e864cf81856d2', 32, '男', '2023-02-10', 1);
INSERT INTO `users` VALUES (34, 'user4', 'fc2921d9057ac44e549efaf0048b2512', 22, '女', '2023-03-15', 1);
INSERT INTO `users` VALUES (35, 'user5', 'd35f6fa9a79434bcd17f8049714ebfcb', 35, '男', '2023-04-20', 1);
INSERT INTO `users` VALUES (36, 'user6', 'e9568c9ea43ab05188410a7cf85f9f5e', 29, '女', '2023-05-25', 1);
INSERT INTO `users` VALUES (37, 'user70', '8c96c3884a827355aed2c0f744594a52', 31, '男', '2023-06-30', 1);
INSERT INTO `users` VALUES (38, 'user8', 'ccd3cd18225730c5edfc69f964b9d7b3', 27, '女', '2023-07-05', 1);
INSERT INTO `users` VALUES (39, 'user9', 'c28cce9cbd2daf76f10eb54478bb0454', 24, '男', '2023-08-10', 1);
INSERT INTO `users` VALUES (40, 'user10', 'a3224611fd03510682690769d0195d66', 26, '女', '2023-09-15', 1);
INSERT INTO `users` VALUES (41, 'user11', '0102812fbd5f73aa18aa0bae2cd8f79f', 33, '男', '2023-10-20', 1);
INSERT INTO `users` VALUES (42, 'user12', '0bd0fe6372c64e09c4ae81e056a9dbda', 30, '女', '2023-11-25', 1);
INSERT INTO `users` VALUES (43, 'user13', 'c868bff94e54b8eddbdbce22159c0299', 28, '男', '2023-12-30', 1);
INSERT INTO `users` VALUES (44, 'user14', 'd1f38b569c772ebb8fa464e1a90c5a00', 29, '女', '2024-01-05', 1);
INSERT INTO `users` VALUES (45, 'user15', 'b279786ec5a7ed00dbe4d3fe1516c121', 31, '男', '2024-02-10', 1);
INSERT INTO `users` VALUES (46, 'user16', '66c99bf933f5e6bf3bf2052d66577ca8', 27, '女', '2024-03-15', 1);
INSERT INTO `users` VALUES (47, 'user7', '6c2a5c9ead1d7d6ba86c8764d5cad395', 24, '男', '2024-04-20', 1);
INSERT INTO `users` VALUES (48, 'user18', '64152ab7368fc7ca6b3ef6b71e330b86', 26, '女', '2024-05-25', 1);
INSERT INTO `users` VALUES (49, 'user19', '1f61b744f2c9e8f49ae4c4965f39963f', 34, '男', '2024-06-30', 1);
INSERT INTO `users` VALUES (50, 'user20', '90bfa11df19a9b9d429ccfa6997104df', 29, '女', '2024-07-05', 1);
INSERT INTO `users` VALUES (51, 'user21', '5cddd1f7857fd4ab8095f676fcf88835', 32, '男', '2024-08-10', 1);
INSERT INTO `users` VALUES (52, 'user22', 'b9974191c2e2806abb0ed0fe229ca0f6', 28, '女', '2024-09-15', 1);
INSERT INTO `users` VALUES (53, 'user23', 'b9b09ad3b376b828898d171e1cc2e05b', 25, '男', '2024-10-20', 1);
INSERT INTO `users` VALUES (54, 'user24', '87de23031d30a01efbb97ab885de862b', 30, '女', '2024-11-25', 1);
INSERT INTO `users` VALUES (55, 'user25', '41e4652a622b10077ff4c22717dc57fd', 33, '男', '2024-12-30', 1);
INSERT INTO `users` VALUES (56, 'user26', 'ea8852d0353318fdf7c0fa2769fe2c35', 29, '女', '2025-01-05', 1);
INSERT INTO `users` VALUES (57, 'user27', '713fdc6c473ce5e66a6276686a3c745f', 31, '男', '2025-02-10', 1);
INSERT INTO `users` VALUES (58, 'user28', '421b66e92350b35dc2e8c67948b1eb74', 27, '女', '2025-03-15', 1);
INSERT INTO `users` VALUES (59, 'user29', '6cf1cd514774dd611a9a07ff764f3324', 24, '男', '2025-04-20', 1);
INSERT INTO `users` VALUES (60, 'user30', '60d589174ca2b89351a41d90a8c9c2cf', 26, '女', '2025-05-25', 1);

-- ----------------------------
-- Procedure structure for process_users_data
-- ----------------------------
DROP PROCEDURE IF EXISTS `process_users_data`;
delimiter ;;
CREATE PROCEDURE `process_users_data`()
BEGIN
    -- 变量声明（必须位于BEGIN后）
    DECLARE v_user_id INT;
    DECLARE v_username VARCHAR(50);
    DECLARE v_status TINYINT;
    DECLARE exit_loop BOOLEAN DEFAULT FALSE;

    -- 游标声明（变量声明后）
    DECLARE users_cursor CURSOR FOR 
        SELECT user_id, username, status FROM users;

    -- 处理程序声明（游标声明后）
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
        SET exit_loop = TRUE;

    -- 打开游标
    OPEN users_cursor;

    read_loop: LOOP
        FETCH users_cursor INTO v_user_id, v_username, v_status;
        IF exit_loop THEN
            LEAVE read_loop;
        END IF;

        -- 示例操作：输出结果
        SELECT 
            v_user_id AS '用户ID',
            v_username AS '用户名',
            CASE v_status 
                WHEN 1 THEN '启用' 
                ELSE '禁用' 
            END AS '状态';
    END LOOP;

    -- 关闭游标
    CLOSE users_cursor;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
