<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/5/14
  Time: 9:40
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
    <title>驿站登录</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://unpkg.zhimg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.zhimg.com/element-ui/lib/index.js"></script>
    <script src="https://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            const vm = new Vue({
                el:'#centerdiv',
                data(){
                    return{
                        login:{
                            account:'',
                            password:'',
                        },
                        fullscreenLoading:false,
                        rules:{
                            account:[
                                { required: true,message:'用户名不能为空!',trigger:'blur'},
                            ],
                            password:[
                                { required: true,message:'密码不能为空!',trigger:'blur'},
                                { min:6,max:12,message: '长度在 6 到 12 个字符!',trigger:'blur' }
                            ],
                        },
                    }
                },
                methods:{
                    loginStation(formName){
                        let _this = this;
                        _this.$refs[formName].validate((valid)=>{
                            if (valid){
                                $.ajax({
                                    url:'poststation/login',
                                    type:'post',
                                    data:{
                                        account:_this.login.account,
                                        password:_this.login.password,
                                    },
                                    success:function () {
                                        _this.fullscreenLoading = true,
                                            setTimeout(()=>{3
                                                _this.fullscreenLoading = false,
                                                    _this.$message({
                                                        type:'success',
                                                        message:'登录成功,即将跳转至主页面'
                                                    })
                                                setTimeout(()=>{
                                                    window.location.href = "Poststation/mainPage.jsp"
                                                },2000)
                                            },3000)
                                    }
                                })
                            }
                        })
                    },
                },
            })
        }
    </script>
    <style>
        .text {
            font-size: 14px;
        }

        .item {
            margin-bottom: 18px;
        }

        .clearfix:before,
        .clearfix:after {
            display: table;
            content: "";
        }
        .clearfix:after {
            clear: both
        }

        .box-card {
            width: 480px;
        }
        body{
            background: #edf9e4;
        }
    </style>
</head>
<body>
<div style="height: 100px"></div>
<div id="centerdiv" style="margin-left: 750px;margin-right: 700px">
    <el-card class="box-card">
        <div slot="header" class="clearfix">
            <span>登录</span>
        </div>
        <el-form :model="login" ref="login" label-postion="left" label-width="80px" :rules="rules">
            <el-form-item prop="account" label="站点账号">
                <el-input v-model="login.account" style="width: 300px" auto-complete="on" name="account" clearable></el-input>
            </el-form-item>
            <el-form-item prop="password" label="密码">
                <el-input v-model="login.password" style="width: 300px" auto-complete="on" name="password" clearable show-password></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" style="width: 300px" @click="loginStation('login')" v-loading.fullscreen.lock="fullscreenLoading">登录</el-button>
            </el-form-item>
            <el-form-item>
                <span></span>
            </el-form-item>
        </el-form>
    </el-card>
</div>
</body>
</html>
