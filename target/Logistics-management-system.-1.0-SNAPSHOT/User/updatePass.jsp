<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/27
  Time: 17:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() +
            request.getContextPath() + "/";
    Object id =  request.getSession().getAttribute("id");
    Object password = request.getSession().getAttribute("password");
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
            var oldPWD = '<%=password%>'
            const vm = new Vue({
                el: '#formArea',
                data() {
                    var validateOldPwd = (rule,value,callback) =>{
                        if (this.form.oldpass != oldPWD){
                            callback(new Error("密码错误！"))
                        }
                        return callback()
                    }
                    var validateNewPwd = (rule,value,callback) =>{
                        if (this.form.oldpass == value){
                            callback(new Error("新密码不能与旧密码一致！"))
                        }
                        return callback()
                    }
                    var validateNewPwd2 = (rule,value,callback) =>{
                        if (this.form.newpass != value){
                            callback(new Error("两次密码输入不一致!"))
                        }
                        return callback()
                    }
                    return {
                        labelPosition: 'top',
                        form: {
                            oldpass: '',
                            newpass: '',
                            newpass2: ''
                        },
                        rules:{
                            oldpass : [
                                { required: true, message: '旧密码不能为空'},
                                { validator: validateOldPwd,trigger:'blur' }
                            ],
                            newpass: [
                                { required: true, message: '新密码不能为空'},
                                { min: 6 , max: 12 ,message: '密码长度在 6 到 12 个字符' },
                                { validator: validateNewPwd, trigger:'blur' }
                            ],
                            newpass2: [
                                { required: true, message: '确认密码不能为空'},
                                { validator: validateNewPwd2, trigger:'blur'}
                            ]
                        }
                    }
                },
                methods:{
                    submitForm(formName) {
                        this.$refs['passFrom'].validate((valid) => {
                            if (valid){
                                $.ajax({
                                    type:'post',
                                    url:'user/updatePassword',
                                    data:{
                                        password:this.form.newpass,
                                        id:<%=id%>
                                    },
                                    success:function () {
                                        alert("修改密码成功,请重新登录!")
                                        window.sessionStorage.clear();
                                        window.parent.location = "loginPageForUser.jsp"
                                    },
                                    error:function () {
                                        alert("修改失败!")
                                    }
                                })
                            }else {
                                alert('failed!')
                                return false
                            }
                        });
                    },
                    // resetForm(formName) {
                    //     this.$refs[formName].resetFields();
                    // }
                }
            })
        }
    </script>
</head>
<body>
<div id="formArea">
<el-form :label-position="labelPosition" label-width="80px" :model="form" ref="passFrom" :rules="rules">
    <el-form-item label="原密码" prop="oldpass">
        <el-input v-model="form.oldpass" name="oldpass" style="width: 300px" autocomplete="off" clearable></el-input>
    </el-form-item>
    <el-form-item label="新密码" prop="newpass" >
        <el-input v-model="form.newpass" name="newpass" style="width: 300px" clearable></el-input>
    </el-form-item>
    <el-form-item label="确认密码" prop="newpass2">
        <el-input v-model="form.newpass2" name="newpass2" style="width: 300px" clearable></el-input>
    </el-form-item>
    <el-form-item>
        <el-button type="primary" @click="submitForm('passForm')" >确认修改</el-button>
    </el-form-item>
</el-form>
</div>
</body>
</html>
