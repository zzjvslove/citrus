package com.github.yiuman.citrus.support.utils;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;

/**
 * Spring相关工具
 *
 * @author yiuman
 * @date 2020/4/4
 */
@Component
public class SpringUtils implements ApplicationContextAware {

    private static ApplicationContext context;

    public SpringUtils() {
    }

    @Override
    public void setApplicationContext(@Nullable ApplicationContext applicationContext) throws BeansException {
        if (context == null) {
            context = applicationContext;
        }
    }

    public static ApplicationContext getContext() {
        return context;
    }

    public static <T> T getBean(Class<T> tClass) {
        return getBean(tClass, false);
    }

    public static <T> T getBean(Class<T> tClass, boolean force) {
        T bean;
        try {
            bean = context.getBean(tClass);
        } catch (NoSuchBeanDefinitionException ex) {
            bean = force ? context.getAutowireCapableBeanFactory().createBean(tClass) : null;
        }
        return bean;
    }

    public static <T> T getBean(Class<T> tClass, String name) {
        return context.getBean(name, tClass);
    }

    public static <T> T getBean(Class<T> tClass, String name, boolean force) {
        T bean;
        try {
            bean = context.getBean(name, tClass);
        } catch (NoSuchBeanDefinitionException ex) {
            bean = force ? context.getAutowireCapableBeanFactory().createBean(tClass) : null;
        }
        return bean;
    }

}
