<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/28
  Time: 19:10
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
    <title>Title</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://unpkg.zhimg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.zhimg.com/element-ui/lib/index.js"></script>
    <script src="https://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            const vm = new Vue({
                el:'#register',
                data(){
                    return{
                        registerForm:{
                            account:'',
                            password:'',
                            psname:'',
                            telephone:'',
                            psaddress:'',
                        },
                        rules:{
                            account : [
                                { required: true ,message:'账号不可为空！',trigger:'blur'},
                                { max:10 , message: "账号长度最大为 10 位！" ,trigger: 'blur'},
                            ],
                            password : [
                                { required: true ,message:'密码不可为空！',trigger:'blur'},
                                { min: 6 ,max:20 , message: "密码长度为6 到 20 位！" ,trigger: 'blur'},
                            ],
                            psname : [
                                { required: true ,message:'驿站名称不可为空！',trigger:'blur'},
                            ],
                            telephone : [
                                { required: true ,message:'联系电话不可为空！',trigger:'blur'},
                            ],
                            psaddress : [
                                { required: true ,message:'地址不可为空！',trigger:'blur'},
                            ]
                        }
                    }
                },
                methods:{
                    submitForm(formName) {
                        let _this = this;
                        _this.$confirm('确认提交数据？', '提示', {
                            confirmButtonText: '确定',
                            cancelButtonText: '取消',
                            type: 'warning'
                        }).then(() => {
                            _this.$refs[formName].validate((valid) => {
                                if (valid) {
                                    $.ajax({
                                        url:'admin/addPostStation',
                                        data:{
                                            account:this.registerForm.account,
                                            password:this.registerForm.password,
                                            psname:this.registerForm.psname,
                                            telephone:this.registerForm.telephone,
                                            psaddress:this.registerForm.psaddress,
                                        },
                                        type:'post',
                                        success:function () {
                                            _this.$message({
                                                type: 'success',
                                                message: '提交成功!'
                                            });
                                            //清空表单
                                            _this.$refs.registerForm.resetFields()
                                            return true;
                                        },
                                        error:function () {
                                            _this.$message({
                                                type: 'info',
                                                message: '已取消提交'
                                            });
                                            return false;
                                        }
                                    })

                                }
                            });
                        }).catch(() => {
                        });
                    },
                    resetForm(formName) {
                        this.$refs[formName].resetFields();
                    }
                }
            })
        }
    </script>
</head>
<body>
<div id="register">
    <el-form :model="registerForm" status-icon :rules="rules" ref="registerForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="账号" prop="account">
            <el-input v-model="registerForm.account" autocomplete="off" style="width: 400px" clearable></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
            <el-input v-model="registerForm.password" autocomplete="off"style="width: 400px" clearable></el-input>
        </el-form-item>
        <el-form-item label="站点名称" prop="psname">
            <el-input v-model="registerForm.psname"style="width: 400px" clearable></el-input>
        </el-form-item>
        <el-form-item label="联系电话" prop="telephone">
            <el-input v-model="registerForm.telephone" autocomplete="off"style="width: 400px" clearable></el-input>
        </el-form-item>
        <el-form-item label="地址" prop="psaddress">
            <el-input v-model="registerForm.psaddress" autocomplete="off"style="width: 400px" clearable></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="submitForm('registerForm')">提交</el-button>
            <el-button @click="resetForm('registerForm')">重置</el-button>
        </el-form-item>
    </el-form>
</div>
</body>
</html>
