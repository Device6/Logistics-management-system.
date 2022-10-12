<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/5/14
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() +
            request.getContextPath() + "/";
    Object pid =  request.getSession().getAttribute("pid");
    Object station = request.getSession().getAttribute("station");
%>
<html>
<head>
    <title>站点主页</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://unpkg.zhimg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="css/indexForUser.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.zhimg.com/element-ui/lib/index.js"></script>
    <script src="https://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
    <script src="js/mainPage.js"></script>
    <%--挂载vm--%>
    <script type="text/javascript">
        window.onload = function () {
            Vue.config.productionTip=false;
            const vm = new Vue({
                el: '#container',
                data() {
                    return {
                        isCollapse:false,
                        poststation:'',
                        station:'<%=station%>',
                    }
                },
                methods: {
                    // 展开
                    handleOpen(key, keyPath) {
                    },
                    // 关闭
                    handleClose(key, keyPath) {
                    },
                    handleSelect(select){
                        let _this = this;
                        var src;
                        var frame = document.getElementById("frame");
                        if (select == '1-1-1'){
                            src = "Poststation/allOrders.jsp";
                            frame.src = src;
                        }else if (select == "2"){
                            src = "Poststation/backInfo.jsp";
                            frame.src = src;
                        }else if (select == "1-1-2"){
                            src = "Poststation/allOrders2.jsp";
                            frame.src = src;
                        }else if (select == "1-1-3"){
                            src = "Poststation/allOrders3.jsp";
                            frame.src = src;
                        }else if (select == "3"){
                            window.sessionStorage.clear();
                            window.location.href = "Poststation/loginForStation.jsp"
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
            height: 1035px;
        }


    </style>
</head>
<body>
<!--导航栏-->



<!--内容展示区域-->
<div id="container">
    <el-container style="height: 920px; border: 1px solid #eee">
        <el-aside width="200px" style="background: #fcfff6" >
            <el-radio-group v-model="isCollapse" style="margin-bottom: 20px;">
                <el-radio-button :label="false">展开</el-radio-button>
                <el-radio-button :label="true">收起</el-radio-button>
            </el-radio-group>
            <el-menu :default-openeds="['1']" class="el-menu-vertical-demo" style="background: #fcfff6" @open="handleOpen" @close="handleClose" @select="handleSelect" :collapse="isCollapse">
                <el-submenu index="1">
                    <template slot="title">
                        <i class="el-icon-notebook-2"></i>
                        <span slot="title">管理订单</span>
                    </template>
                    <el-submenu index="1-1">
                        <template slot="title">订单</template>
                        <el-menu-item index="1-1-1">所有订单</el-menu-item>
                        <el-menu-item index="1-1-2">未处理订单</el-menu-item>
                        <el-menu-item index="1-1-3">已处理订单</el-menu-item>
                    </el-submenu>
                </el-submenu>
                <el-menu-item index="2">反馈信息</el-menu-item>
                <el-menu-item index="3">退出系统</el-menu-item>
            </el-menu>
        </el-aside>

        <el-container>
            <el-header style="text-align: right; font-size: 12px;background: #182840">
                <el-menu class="el-menu-demo" style="border: 0" mode="horizontal" text-color="#ffffff" background-color="#182840" active-text-color="#ffffff" >
                    <el-menu-item index="1">
                        <template slot="title">
                            <i class="el-icon-user"></i>{{ station }}
                        </template>
                    </el-menu-item>
                </el-menu>
            </el-header>
            <el-main>
                <iframe id="frame" width="1600px" height="1200px" frameborder="0" scrolling="no" src="Poststation/blank.jsp"></iframe>
            </el-main>
        </el-container>

    </el-container>
</div>
</body>
</html>
