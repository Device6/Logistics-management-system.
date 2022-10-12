<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/11
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() +
            request.getContextPath() + "/";
%>
<html>
<head>
    <title>管理员登录界面</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://unpkg.zhimg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="http://at.alicdn.com/t/font_3332846_uhrtjdx0r8r.css">
    <link rel="stylesheet" href="css/loginPageforUser.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.zhimg.com/element-ui/lib/index.js"></script>
    <script src="https://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            const vm = new Vue({
                el:'#loginArea',
                data:{
                    adminname:'',
                    password:'',
                },
                methods: {
                    submitForm(formName){

                    }
                }
            })
            const vm2 = new Vue({
                el:'#actions',
                data:{
                    activeIndex: '1'
                },
                methods: {
                    handleSelect(key, keyPath) {
                        console.log(key, keyPath);
                    }
                }
            })
        }
    </script>
</head>
<body>
<div id="actions">
    <el-menu :default-active="activeIndex" active-text-color="#6497f8" class="el-menu-demo" background-color="#182840" text-color="#f3f8f4" mode="horizontal" @select="handleSelect">
        <el-menu-item index="1"><a href="http://www.baidu.com" style="text-decoration: none;">首页</a></el-menu-item>
        <el-submenu index="2">
            <template slot="title">个人用户</template>
            <el-menu-item index="2-1">选项1</el-menu-item>
            <el-menu-item index="2-2">选项2</el-menu-item>
            <el-menu-item index="2-3">选项3</el-menu-item>
            <el-submenu index="2-4">
                <template slot="title">选项4</template>
                <el-menu-item index="2-4-1">选项1</el-menu-item>
                <el-menu-item index="2-4-2">选项2</el-menu-item>
                <el-menu-item index="2-4-3">选项3</el-menu-item>
            </el-submenu>
        </el-submenu>
        <el-submenu index="3">
            <template slot="title">物流服务商</template>
            <el-menu-item index="3-1">选项1</el-menu-item>
            <el-menu-item index="3-2">选项2</el-menu-item>
            <el-menu-item index="3-3">选项3</el-menu-item>
        </el-submenu>
        <el-submenu index="4">
            <template slot="title">企业用户</template>
            <el-menu-item index="3-1">选项1</el-menu-item>
            <el-menu-item index="3-2">选项2</el-menu-item>
            <el-menu-item index="3-3">选项3</el-menu-item>
        </el-submenu>
        <el-menu-item index="5"><a href="https://www.ele.me" style="text-decoration: none" target="_blank">订单管理</a></el-menu-item>
    </el-menu>
</div>
<div id="center">
    <div id="loginLeft">

    </div>
    <div id="loginArea">
        <div id="loginArea-methods">
            <p style="margin-left: 20px">管理员登录</p>
            <hr>
        </div>
        <form action="admin/adminLogin" method="post">
            <el-input v-model="adminname" prefix-icon="iconfont icon-yonghu" placeholder="请输入账号" name="adminname" type="text" style="margin-bottom: 10px;margin-left: 20px;margin-right: 20px;width: 230px" clearable></el-input>
            <el-input v-model="password" prefix-icon="iconfont icon-mima" placeholder="请输入密码" name="password" type="text" style="margin-bottom: 10px;margin-left: 20px;margin-right: 20px;width: 230px" show-password clearable></el-input>
            <el-button id="loginBtn" native-type="submit" style="margin-left: 20px" round>登录  <i class="iconfont icon-denglu"></i></el-button>
        </form>
        <div id="loginArea-moreActions">
            <span><a href="loginPageForUser.jsp" style="color: #a9aeaa;text-decoration: none">用户登录</a></span>
        </div>
    </div>
    <div id="loginRight">
    </div>
</div>

<div id="bottom">
    <div id="bottom-container">
        <div id="">

        </div>
        <hr>

    </div>
</div>
</body>
</html>
