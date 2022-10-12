<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/11
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() +
            request.getContextPath() + "/";
    Object id =  request.getSession().getAttribute("id");
%>
<html>
<head>
    <title>管理员主页</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://unpkg.zhimg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="css/indexforadmin.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.zhimg.com/element-ui/lib/index.js"></script>
    <script src="https://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
    <script src="js/mainPage.js"></script>
    <%--挂载vm--%>
    <script type="text/javascript">
        window.onload = function () {

            $.ajax({
                url:'admin/getAdminName',
                type:'get',
                dataType:'text',
                success:function (result) {
                }
            })
            const vm = new Vue({
                el: '#container',
                data() {
                    return{
                        isCollapse:true
                    }
                },
                methods: {
                    // 展开
                    handleOpen(key, keyPath) {
                    },
                    // 关闭
                    handleClose(key, keyPath) {
                    },
                    handleSelect(select) {
                        if (select == 1){
                            var src = "Admin/information.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }else if(select == 2){
                            var src = "Admin/updatePass.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }else if(select == 3){
                            this.$confirm('确认退出？','提示',{
                                confirmButtonText:'确认',
                                cancelButtonText:'取消'
                                }
                            ).then(()=>{
                                window.parent.sessionStorage.clear();
                                window.parent.location = "loginPageForAdmin.jsp"
                            })
                        }
                    },
                    handleSelect2(select){
                        if (select == '1-1-1'){
                            var src = "Admin/queryAllUsers.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }else if(select == '1-2-1'){
                            var src = "Admin/queryAllPostStations.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }else if(select == '1-2-2') {
                            var src = "Admin/registerNewPostStation.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }else if(select == '2-1-1') {
                            var src = "Admin/allOrders.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }else if(select == '2-2-1') {
                            var src = "Admin/showStationOrders.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }else if(select == '2-3-1') {
                            var src = "Admin/showEnterOrders.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }else if(select == '1-3-1') {
                            var src = "Admin/queryAllEnterprises.jsp";
                            var frame = document.getElementById("frame");
                            frame.src = src;
                        }
                    }
                }
            })
        }
    </script>
    <style>
        .el-header {
            background-color: #B3C0D1;
            color: #333;
            line-height: 60px;
        }

        .el-aside {
            color: #333;
        }

        .el-menu-vertical-demo:not(.el-menu--collapse) {
            width: 200px;
            min-height: 498px;
        }

        .el-menu--collapse {
            height: 735px;
        }
    </style>
</head>
<body>
<!--导航栏-->



<!--内容展示区域-->
<div id="container">
    <el-container style="height: 800px; border: 1px solid #eee">
        <el-aside width="200px" style="background: #fcfff6" >
            <el-radio-group v-model="isCollapse" style="margin-bottom: 20px;">
                <el-radio-button :label="false">展开</el-radio-button>
                <el-radio-button :label="true">收起</el-radio-button>
            </el-radio-group>
            <el-menu :default-openeds="['1']" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose" @select="handleSelect2" :collapse="isCollapse">
                <el-submenu index="1">
                    <template slot="title">
                        <i class="el-icon-user"></i>
                        <span slot="title">管理账户</span>
                    </template>
                    <el-submenu index="1-1">
                        <template slot="title">
                            <i class="el-icon-user-solid"></i>
                            <span slot="title">用户账户</span>
                        </template>
                        <el-menu-item index="1-1-1">查询所有用户</el-menu-item>
                    </el-submenu>
                    <el-submenu index="1-2">
                        <template slot="title">
                            <i class="el-icon-s-goods"></i>
                            <span slot="title">驿站账户</span>
                        </template>
                        <el-menu-item index="1-2-1">查询所有站点</el-menu-item>
                        <el-menu-item index="1-2-2">新增站点申请</el-menu-item>
                    </el-submenu>
                    <el-submenu index="1-3">
                        <template slot="title">
                            <i class="el-icon-s-cooperation"></i>
                            <span slot="title">运输公司账户</span>
                        </template>
                        <el-menu-item index="1-3-1">查询所有运输公司站点</el-menu-item>
                    </el-submenu>
                </el-submenu>
                <el-submenu index="2">
                    <template slot="title">
                        <i class="el-icon-notebook-2"></i>
                        <span slot="title">管理订单</span>
                    </template>
                    <el-submenu index="2-1">
                        <template slot="title">用户订单</template>
                        <el-menu-item index="2-1-1">所有订单</el-menu-item>
                    </el-submenu>
                    <el-submenu index="2-2">
                        <template slot="title">驿站订单</template>
                        <el-menu-item index="2-2-1">查询</el-menu-item>
                    </el-submenu>
                    <el-submenu index="2-3">
                        <template slot="title">运输公司订单</template>
                        <el-menu-item index="2-3-1">查询</el-menu-item>
                    </el-submenu>
                </el-submenu>
                <el-submenu index="3">
                    <template slot="title">
                        <i class="el-icon-message"></i>
                        <span slot="title">反馈信息</span>
                    </template>
                    <el-submenu index="3-1">
                        <template slot="title">用户反馈</template>
                        <el-menu-item index="3-1-1">反馈</el-menu-item>
                    </el-submenu>
                </el-submenu>
            </el-menu>
        </el-aside>

        <el-container>
            <el-header style="text-align: left; font-size: 12px;background: #182840">
                <el-menu class="el-menu-demo" style="border: 0" mode="horizontal" @select="handleSelect" text-color="#ffffff" background-color="#182840" active-text-color="#ffffff" >
                    <el-menu-item index="1">个人信息</el-menu-item>
                    <el-menu-item index="2">修改密码</el-menu-item>
                    <el-menu-item index="3">退出系统</el-menu-item>
                </el-menu>
            </el-header>


            <el-main>
                <iframe id="frame" width="1600px" height="650px" frameborder="0" scrolling="no" src="Admin/information.jsp">

                </iframe>
            </el-main>

        </el-container>

    </el-container>
</div>
</body>
</html>
