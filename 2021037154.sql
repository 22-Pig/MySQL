/*
 Navicat MySQL Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : 2021037154

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 03/11/2021 11:24:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fenshu_info
-- ----------------------------
DROP TABLE IF EXISTS `fenshu_info`;
CREATE TABLE `fenshu_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `student_id` int NOT NULL COMMENT '学号',
  `c_name` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名',
  `fenshu` float NULL DEFAULT NULL COMMENT '分数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fenshu_info
-- ----------------------------
INSERT INTO `fenshu_info` VALUES (1, 2015663456, '计算机组成', 95);
INSERT INTO `fenshu_info` VALUES (2, 2015663456, '数据库', 90);
INSERT INTO `fenshu_info` VALUES (3, 2010013345, '软件工程', 55);
INSERT INTO `fenshu_info` VALUES (4, 2010013345, '数据库', 86);
INSERT INTO `fenshu_info` VALUES (5, 2012345790, '英语', 81);
INSERT INTO `fenshu_info` VALUES (6, 2012030842, '英语', 72);
INSERT INTO `fenshu_info` VALUES (7, 2012030842, '编译原理', 68);
INSERT INTO `fenshu_info` VALUES (8, 2015690623, '英语', 52);
INSERT INTO `fenshu_info` VALUES (9, 2021037154, '数据库', 96);

-- ----------------------------
-- Table structure for student_info
-- ----------------------------
DROP TABLE IF EXISTS `student_info`;
CREATE TABLE `student_info`  (
  `student_no` int NOT NULL COMMENT '学号',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `depart` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '院系',
  `addr` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭地址',
  PRIMARY KEY (`student_no`) USING BTREE,
  UNIQUE INDEX `student_no`(`student_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_info
-- ----------------------------
INSERT INTO `student_info` VALUES (2010013345, '王五', '女', 19, '软件工程系', '浙江象山枇杷村');
INSERT INTO `student_info` VALUES (2012030842, '西门人', '男', 22, '英语系', '浙江宁海大一村');
INSERT INTO `student_info` VALUES (2012345790, '阿尔法', '女', 24, '信息工程系', '浙江慈溪杨梅村');
INSERT INTO `student_info` VALUES (2014672901, '刘夫', '男', 26, '信息工程系', '浙江三门里外村');
INSERT INTO `student_info` VALUES (2015663456, '李四', '男', 20, '计算机系', '浙江舟山海港村');
INSERT INTO `student_info` VALUES (2015690623, '马云三', '男', 21, '英语系', '浙江三门青蟹村');
INSERT INTO `student_info` VALUES (2021037154, '沈轶东', '男', 21, '计算机系', NULL);

SET FOREIGN_KEY_CHECKS = 1;
