DROP DATABASE IF EXISTS citrus;
CREATE DATABASE IF NOT EXISTS citrus DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ------------用户表----------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`
(
  `user_id`            bigint(20) NOT NULL COMMENT '主键id',
  `login_id`            varchar(45) DEFAULT NULL COMMENT '登录Id',
  `password`           varchar(45) DEFAULT NULL COMMENT '密码',
  `username`           varchar(45) DEFAULT NULL COMMENT '名字',
  `email`              varchar(45) DEFAULT NULL COMMENT '电子邮件',
  `mobile`             varchar(45) DEFAULT NULL COMMENT '手机',
  `uuid`               varchar(45) DEFAULT NULL COMMENT 'UUID',
  `admin`              int(1)      DEFAULT 0 COMMENT '是否管理员',
  `status`             bigint      DEFAULT NULL COMMENT '状态',
  `create_time`        datetime    DEFAULT NULL COMMENT '创建时间',
  `create_by`          bigint(20)  DEFAULT NULL COMMENT '创建人',
  `last_modified_time` datetime    DEFAULT NULL COMMENT '最后的更新时间',
  `last_modified_by`   bigint(20)  DEFAULT NULL COMMENT '最后的更新人',
  `version`            int(11)     DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='用户表';

create index IX_SYS_USER_LOGINID on sys_user (login_id);
create index IX_SYS_USER_USERNAME on sys_user (username);
create index IX_SYS_USER_UUID on sys_user (uuid);
create index IX_SYS_USER_MOBILE on sys_user (mobile);
-- ----------------------------

-- ------------角色表----------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`
(
  `role_id`            bigint(20) NOT NULL COMMENT '主键id',
  `parent_id`          bigint(20)  DEFAULT NULL COMMENT '主键id',
  `type`               int        NOT NULL COMMENT '主键id',
  `role_name`           varchar(45) DEFAULT NULL COMMENT '名字',
  `create_time`        datetime    DEFAULT NULL COMMENT '创建时间',
  `create_by`          bigint(20)  DEFAULT NULL COMMENT '创建人',
  `last_modified_time` datetime    DEFAULT NULL COMMENT '最后的更新时间',
  `last_modified_by`   bigint(20)  DEFAULT NULL COMMENT '最后的更新人',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='角色表';

create index IX_SYS_ROLE_ROLENAME on sys_role (role_name);
-- ----------------------------

-- ------------资源表----------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource`
(
  `resource_id`        varchar(500) NOT NULL COMMENT '主键id',
  `resource_name`       varchar(50)   DEFAULT NULL COMMENT '资源名称名字',
  `parent_id`          varchar(500)  DEFAULT NULL COMMENT '父ID',
  `type`               int          NOT NULL COMMENT '资源类型',
  `path`               varchar(2000) DEFAULT NULL COMMENT '资源路径',
  `operation`          varchar(100)  DEFAULT NULL COMMENT '操作类型',
  `create_time`        datetime      DEFAULT NULL COMMENT '创建时间',
  `create_by`          bigint(20)    DEFAULT NULL COMMENT '创建人',
  `last_modified_time` datetime      DEFAULT NULL COMMENT '最后的更新时间',
  `last_modified_by`   bigint(20)    DEFAULT NULL COMMENT '最后的更新人',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='资源表';

create index IX_SYS_RESOURCE_RESOURCENAME on sys_resource (resource_name);
create index IX_SYS_RESOURCE_PATH on sys_resource (path);
-- ----------------------------

-- ------------组织机构表----------------
DROP TABLE IF EXISTS `sys_organ`;
CREATE TABLE `sys_organ`
(
  `organ_id`           bigint(20) NOT NULL COMMENT '主键id',
  `organ_name`         varchar(50) DEFAULT NULL COMMENT '资源名字',
  `parent_id`          bigint(20) NOT NULL NULL COMMENT '父ID',
  `left_value`         int(7)     NOT NULL COMMENT '左值',
  `right_value`        int(7)     NOT NULL COMMENT '右值',
  `create_time`        datetime    DEFAULT NULL COMMENT '创建时间',
  `create_by`          bigint(20)  DEFAULT NULL COMMENT '创建人',
  `last_modified_time` datetime    DEFAULT NULL COMMENT '最后的更新时间',
  `last_modified_by`   bigint(20)  DEFAULT NULL COMMENT '最后的更新人',
  PRIMARY KEY (`organ_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='组织机构表';

create index IX_SYS_ORGAN_ORGANNAME on sys_organ (organ_name);
create index IX_SYS_ORGAN_LEFTVALUE on sys_organ (left_value);
create index IX_SYS_ORGAN_RIGHTVALUE on sys_organ (right_value);
-- ----------------------------

-- ------------数据范围表----------------
DROP TABLE IF EXISTS `sys_scope`;
CREATE TABLE `sys_scope`
(
  `scope_id`  bigint(20) NOT NULL COMMENT '数据范围ID',
  `scope_name`  varchar (500) NOT NULL COMMENT '范围名称',
  `organ_id` bigint(20) NOT NULL COMMENT '组织ID',
  PRIMARY KEY (`scope_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='数据范围表';

-- ----------------------------

-- ------------数据范围定义表----------------
DROP TABLE IF EXISTS `sys_scope_define`;
CREATE TABLE `sys_scope_define`
(
  `id` bigint(20) NOT NULL COMMENT '数据范围定义对象ID',
  `scope_id`  bigint(20) NOT NULL COMMENT '关联的数据范围ID',
  `organ_id` bigint(20) NOT NULL COMMENT '组织ID',
  `scope_rule` int not null COMMENT '数据范围的规则（0：包含，1：排除）',
  `scope_types` varchar(20)  COMMENT '范围类型（自身、包含子部门、包含父部门）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='数据范围定义表';

-- ----------------------------

-- ------------权限表----------------
DROP TABLE IF EXISTS `sys_authority`;
CREATE TABLE `sys_authority`
(
  `authority_id`           bigint(20) NOT NULL COMMENT '主键id',
  `authority_name`         varchar(50) DEFAULT NULL COMMENT '权限名字',
  `remark`  varchar(2000) DEFAULT NULL COMMENT '权限名字',
  `create_time`        datetime    DEFAULT NULL COMMENT '创建时间',
  `create_by`          bigint(20)  DEFAULT NULL COMMENT '创建人',
  `last_modified_time` datetime    DEFAULT NULL COMMENT '最后的更新时间',
  `last_modified_by`   bigint(20)  DEFAULT NULL COMMENT '最后的更新人',
  PRIMARY KEY (`authority_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='权限表';

create index IX_SYS_AUTHORITY_AUTHORITYNAME on sys_authority (authority_name);
-- ----------------------------


-- ------------权限资源关系表----------------
DROP TABLE IF EXISTS `sys_auth_resource`;
CREATE TABLE `sys_auth_resource`
(
  `authority_id`  bigint(20) NOT NULL COMMENT '权限ID',
   `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `scope_id`  bigint(20)  COMMENT '数据范围ID',
  `object_id` bigint(20)  COMMENT '关联的对象，如果资源类型为"操作"，即关联的对象为该"操作对应的资源ID 例如 菜单与新增、删除等操作，此实体中的resourceId为操作类型的ID，即此objectId为此操作对应的菜单',
  `type` int(2)  COMMENT '资源类型，菜单为0；操作为2',
  PRIMARY KEY (`authority_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='权限资源关系表';

-- ----------------------------


-- ------------用户角色关系表----------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`
(
  `user_id`  bigint(20) NOT NULL COMMENT '用户ID',
  `role_id`  bigint(20) NOT NULL COMMENT '角色ID',
  `organ_id` bigint(20) NOT NULL COMMENT '组织ID',
  PRIMARY KEY (`user_id`, `role_id`, `organ_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='用户角色关系表';

-- ----------------------------

-- ------------角色权限关系表----------------
DROP TABLE IF EXISTS `sys_role_auth`;
CREATE TABLE `sys_role_auth`
(
  `role_id`  bigint(20) NOT NULL COMMENT '角色ID',
  `authority_id` bigint(20) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`, `authority_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='角色权限关系表';

-- ----------------------------






