<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/10
  Time: 16:37
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
    <title>注册</title>
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
                   var confirmUsername = (rule,value,callback)=>{
                       var msg = "";
                       $.ajax({
                                url:'user/findUserByUsername',
                                type:'get',
                                dataType:'text',
                                data:{
                                    username:value,
                                },
                                success:function (result) {
                                    msg = result;
                                    if (msg == "no"){
                                        callback(new Error("用户名重复，请重新输入"))
                                    }else{
                                        callback()
                                    }

                                }
                            })
                       };
                   return{
                       register:{
                           username:'',
                           password:'',
                       },
                       fullscreenLoading:false,
                       rules:{
                           username:[
                               { required: true,message:'用户名不能为空!',trigger:'blur'},
                               { min:6,max:10,message: '长度在 6 到 10 个字符!',trigger:'blur' },
                               { validator: confirmUsername , trigger: 'blur' }
                           ],
                           password:[
                               { required: true,message:'密码不能为空!',trigger:'blur'},
                               { min:6,max:12,message: '长度在 6 到 12 个字符!',trigger:'blur' }
                           ],
                       },
                   }
               },
               methods:{
                   UserRegister(formName){
                       let _this = this;
                       _this.$refs[formName].validate((valid)=>{
                           if (valid){
                               $.ajax({
                                   url:'user/userRegister',
                                   type:'post',
                                   data:{
                                       username:_this.register.username,
                                       password:_this.register.password,
                                   },
                                   success:function () {
                                       _this.fullscreenLoading = true,
                                        setTimeout(()=>{3
                                            _this.fullscreenLoading = false,
                                            _this.$message({
                                                type:'success',
                                                message:'注册成功,即将跳转至登陆页面'
                                            })
                                            setTimeout(()=>{
                                                window.location = "loginPageForUser.jsp"
                                            },3000)
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
                <span>用户注册</span>
            </div>
            <el-form :model="register" ref="register" label-postion="left" label-width="80px" :rules="rules">
                <el-form-item prop="username" label="用户名">
                    <el-input v-model="register.username" style="width: 300px" clearable></el-input>
                </el-form-item>
                <el-form-item prop="password" label="密码">
                    <el-input v-model="register.password" style="width: 300px" clearable></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" style="width: 300px" @click="UserRegister('register')" v-loading.fullscreen.lock="fullscreenLoading">注册</el-button>
                </el-form-item>
            </el-form>
        </el-card>
    </div>
</body>
</html>
