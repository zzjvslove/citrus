package com.github.yiuman.citrus.support.crud.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.TableInfo;
import com.baomidou.mybatisplus.core.metadata.TableInfoHelper;
import com.baomidou.mybatisplus.core.toolkit.Assert;
import com.baomidou.mybatisplus.core.toolkit.ReflectionKit;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.Collection;
import java.util.Objects;

/**
 * @author yiuman
 * @date 2020/4/11
 */
public interface CrudMapper<T> extends BaseMapper<T> {

    /**
     * 保存实体
     *
     * @param entity 实体对象
     */
    default boolean saveEntity(T entity) {
        if (null != entity) {
            Class<?> cls = entity.getClass();
            TableInfo tableInfo = TableInfoHelper.getTableInfo(cls);
            Assert.notNull(tableInfo, "error: can not execute. because can not find cache of TableInfo for entity!");
            String keyProperty = tableInfo.getKeyProperty();
            Assert.notEmpty(keyProperty, "error: can not execute. because can not find column for id from entity!");
            Object idVal = ReflectionKit.getMethodValue(cls, entity, tableInfo.getKeyProperty());
            if (StringUtils.checkValNull(idVal) || Objects.isNull(selectById((Serializable) idVal))) {
                insert(entity);
            } else {
                updateById(entity);
            }
            return true;
        }
        return false;
    }

    /**
     * 批量保存实体
     *
     * @param entityList ignore
     * @return ignore
     */
    @Transactional(rollbackFor = Exception.class)
    default boolean saveBatch(Collection<T> entityList) {
        try {
            entityList.forEach(this::saveEntity);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }


}