package com.github.yiuman.citrus.system.mapper;

import com.github.yiuman.citrus.support.crud.mapper.CrudMapper;
import com.github.yiuman.citrus.system.entity.UserRole;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户角色DAO
 *
 * @author yiuman
 * @date 2020/4/7
 */
@Mapper
public interface UserRoleMapper extends CrudMapper<UserRole> {

}