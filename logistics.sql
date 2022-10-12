/*
 Navicat Premium Data Transfer

 Source Server         : shw
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : logistics

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 12/10/2022 14:08:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `role` int(0) NOT NULL DEFAULT 1 COMMENT '角色码',
  `adminname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 1, 'root', '1234567');
INSERT INTO `admin` VALUES (3, 1, 'roo2', '123456');

-- ----------------------------
-- Table structure for consignee
-- ----------------------------
DROP TABLE IF EXISTS `consignee`;
CREATE TABLE `consignee`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `uid` int(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `用户`(`uid`) USING BTREE,
  INDEX `address`(`address`) USING BTREE,
  CONSTRAINT `用户` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consignee
-- ----------------------------
INSERT INTO `consignee` VALUES (1, 1, '鞠强', '广东省深圳市宝安区航城街道', '12345678910');
INSERT INTO `consignee` VALUES (2, 1, '敖夏凯', '江西', '12345678911');
INSERT INTO `consignee` VALUES (3, 6, '罗坤', '江西九江', '12345678922');
INSERT INTO `consignee` VALUES (7, 1, '万灵冬', '九江共青城市', '12345678911');
INSERT INTO `consignee` VALUES (15, 1, '张三', '江西九江共青城市', '18279229007');

-- ----------------------------
-- Table structure for driver
-- ----------------------------
DROP TABLE IF EXISTS `driver`;
CREATE TABLE `driver`  (
  `id` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `enterprise` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `realname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `enterprise`(`enterprise`) USING BTREE,
  CONSTRAINT `driver_ibfk_1` FOREIGN KEY (`enterprise`) REFERENCES `enterprise` (`name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of driver
-- ----------------------------
INSERT INTO `driver` VALUES ('ZT20220421', '123456', '中通快递', '鞠强', '12345678911');

-- ----------------------------
-- Table structure for enterprise
-- ----------------------------
DROP TABLE IF EXISTS `enterprise`;
CREATE TABLE `enterprise`  (
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '4',
  `role` int(0) NOT NULL DEFAULT 4,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of enterprise
-- ----------------------------
INSERT INTO `enterprise` VALUES ('中通快递', 4, '95311', 'www.zto.com');
INSERT INTO `enterprise` VALUES ('申通快递', 4, '95543', 'www.sto.cn');
INSERT INTO `enterprise` VALUES ('韵达快递', 4, '95546', 'www.yundaex.com');

-- ----------------------------
-- Table structure for order_test
-- ----------------------------
DROP TABLE IF EXISTS `order_test`;
CREATE TABLE `order_test`  (
  `oid` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double NOT NULL,
  `paid` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未支付',
  `createtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `state` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '等待处理',
  `uid` int(0) NOT NULL,
  `cid` int(0) NOT NULL,
  `pid` int(0) NOT NULL,
  `enterprise` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`oid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `order_test_ibfk_2`(`cid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `order_test_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_test_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `consignee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_test_ibfk_3` FOREIGN KEY (`pid`) REFERENCES `poststation` (`pid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_test
-- ----------------------------
INSERT INTO `order_test` VALUES ('2022041914515635', 14.2, '已支付', '2022-04-19 14:53:05', '已发货', 1, 1, 1, '中通快递');
INSERT INTO `order_test` VALUES ('2022041920021516', 36.06, '未支付', '2022-04-19 20:02:52', '运输中', 3, 1, 1, '中通快递');
INSERT INTO `order_test` VALUES ('2022041920452251', 999.99, '已支付', '2022-04-19 20:45:22', '已完成', 1, 1, 1, '申通快递');
INSERT INTO `order_test` VALUES ('2022042520021256', 14, '未支付', '2022-04-25 20:04:18', '等待处理', 6, 3, 2, '中通快递');
INSERT INTO `order_test` VALUES ('2022050320195673', 60, '已支付', '2022-05-03 20:19:56', '已发货', 1, 7, 2, '中通快递');
INSERT INTO `order_test` VALUES ('2022050320262199', 65, '未支付', '2022-05-03 20:26:21', '等待处理', 1, 1, 20, '中通快递');
INSERT INTO `order_test` VALUES ('202205032029153', 160, '已支付', '2022-05-03 20:29:15', '等待处理', 1, 7, 2, '中通快递');
INSERT INTO `order_test` VALUES ('2022050320295669', 30, '已支付', '2022-05-03 20:29:56', '等待处理', 1, 2, 2, '中通快递');
INSERT INTO `order_test` VALUES ('2022050320304263', 57.5, '未支付', '2022-05-03 20:30:42', '等待处理', 1, 2, 2, '中通快递');
INSERT INTO `order_test` VALUES ('2022050320464970', 922.5, '未支付', '2022-05-03 20:46:49', '等待处理', 1, 1, 2, '中通快递');
INSERT INTO `order_test` VALUES ('2022050416204298', 390, '未支付', '2022-05-04 16:20:42', '等待处理', 1, 2, 1, '中通快递');
INSERT INTO `order_test` VALUES ('2022050721101980', 2.5, '未支付', '2022-05-07 21:10:19', '等待处理', 1, 2, 2, '中通快递');
INSERT INTO `order_test` VALUES ('2022051409125420', 2.5, '未支付', '2022-05-14 09:12:54', '等待处理', 1, 2, 2, '申通快递');
INSERT INTO `order_test` VALUES ('2022051411245270', 12.5, '未支付', '2022-05-14 11:24:52', '等待处理', 1, 15, 2, '申通快递');
INSERT INTO `order_test` VALUES ('2022051411253899', 90, '已支付', '2022-05-14 11:25:38', '已发货', 1, 15, 1, '中通快递');
INSERT INTO `order_test` VALUES ('2022051416581337', 12.5, '已支付', '2022-05-14 16:58:13', '等待处理', 1, 2, 1, '中通快递');

-- ----------------------------
-- Table structure for pe_relation
-- ----------------------------
DROP TABLE IF EXISTS `pe_relation`;
CREATE TABLE `pe_relation`  (
  `ename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `ename`(`ename`) USING BTREE,
  INDEX `pname`(`pname`) USING BTREE,
  CONSTRAINT `pe_relation_ibfk_2` FOREIGN KEY (`ename`) REFERENCES `enterprise` (`name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pe_relation_ibfk_3` FOREIGN KEY (`pname`) REFERENCES `poststation` (`psname`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pe_relation
-- ----------------------------
INSERT INTO `pe_relation` VALUES ('中通快递', '菜鸟驿站');
INSERT INTO `pe_relation` VALUES ('申通快递', '菜鸟驿站');
INSERT INTO `pe_relation` VALUES ('中通快递', '邻里驿站');

-- ----------------------------
-- Table structure for poststation
-- ----------------------------
DROP TABLE IF EXISTS `poststation`;
CREATE TABLE `poststation`  (
  `pid` int(0) NOT NULL AUTO_INCREMENT,
  `role` int(0) NOT NULL DEFAULT 3,
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `psname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telephone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `psaddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`pid`) USING BTREE,
  INDEX `postName`(`psname`) USING BTREE COMMENT '驿站名'
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of poststation
-- ----------------------------
INSERT INTO `poststation` VALUES (1, 3, 'CaiNiao001', '123456', '菜鸟驿站', '400-3654-1234', '广东宝安');
INSERT INTO `poststation` VALUES (2, 3, 'linli001', '123456', '邻里驿站', '400-4567-9874', '江西南昌');
INSERT INTO `poststation` VALUES (20, 3, 'WuHe001', '123456', '舞鹤驿站', '400-8815-7895', '江苏宿迁');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `role` int(0) UNSIGNED NOT NULL DEFAULT 2 COMMENT '角色码',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `realname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(0) NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creditnumber` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `nameindex`(`realname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 2, 'shw123', '123456', '孙浩文', 22, '男', '320825200006140015', '15189077570', '江苏宿迁');
INSERT INTO `user` VALUES (3, 2, 'jq1234', '123456', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (4, 2, 'axk123', '123456', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (5, 2, 'zs1234', '123456', '张三', 15, '男', NULL, NULL, NULL);
INSERT INTO `user` VALUES (6, 2, 'zlw1234', '123456', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (9, 2, 'li1234', '123456', '李四', 20, '男', NULL, NULL, NULL);
INSERT INTO `user` VALUES (10, 2, 'wangwu123', '123456', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (13, 2, 'root01', '123456', NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
