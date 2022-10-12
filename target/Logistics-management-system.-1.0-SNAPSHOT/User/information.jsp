<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/27
  Time: 18:17
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
    <title>Title</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://unpkg.zhimg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.zhimg.com/element-ui/lib/index.js"></script>
    <script src="https://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
</head>
<body>
<script>
    window.onload = function (){
        $.ajax({
            url:'user/getUser',
            type:'get',
            dataType:'json',
            data:{
                id:<%=id%>
            },
            success:function (user) {
                vm.$data.information.username = user.username;
                var role = user.role;
                if (role == 1){
                    vm.$data.information.role = "管理员";
                }else if (role == 2){
                    vm.$data.information.role = "用户";
                }else if (role == 3){
                    vm.$data.information.role = "驿站";
                };
                vm.$data.information.realname = user.realname;
                vm.$data.information.age = user.age;
                vm.$data.information.gender = user.gender;
                vm.$data.information.creditnumber = user.creditnumber;
                vm.$data.information.telephone = user.telephone;
                vm.$data.information.address = user.address;
            },
            error:function () {
                alert("获取信息失败")
            }
        })
        var vm = new Vue ({
                el:'#Area',
                data() {
                    return {
                        information:{
                            username:'',
                            role:'',
                            realname:'',
                            age:'',
                            gender:'',
                            creditnumber:'',
                            telephone:'',
                            address:''
                        },
                        genders:[{
                            value:'男'
                        },{
                            value: '女'
                        }],
                        rules:{}
                    };
                },
                methods: {
                    handleAlert(formName){
                        let _this = this;
                        _this.$refs[formName].validate((valid)=>{
                            if (valid){
                                $.ajax({
                                    url:'user/updateInformation',
                                    type: 'post',
                                    data:{
                                        id:<%=id%>,
                                        realname:_this.information.realname,
                                        age:_this.information.age,
                                        gender:_this.information.gender,
                                        telephone:_this.information.telephone,
                                        address:_this.information.address,
                                    },
                                    success:function () {
                                        _this.$message({
                                            type:'success',
                                            message:'修改成功'
                                        })
                                    },
                                    error:function () {
                                        _this.$message({
                                            type:'erro',
                                            message:'修改失败'
                                        })
                                    }
                                })
                            }
                        })
                    },
                    queryGender(genders,cb){
                        genders = this.genders
                        cb(genders);
                    },
                    handleSelect(item){
                        this.information.gender = item.value;
                    }
                }
            }
        )
    }
</script>
<div id="Area" >
    <el-form :model="information" ref="information" :rules="rules" label-width="700px" class="demo-ruleForm">
        <el-form-item label="账号" prop="username">
            <el-input v-model="information.username" autocomplete="off" style="width: 300px;" clearable :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="身份" prop="role">
            <el-input v-model="information.role" autocomplete="off" style="width: 300px;" clearable :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="realname">
            <el-input v-model="information.realname" autocomplete="off" style="width: 300px;" clearable></el-input>
        </el-form-item>
        <el-form-item label="年龄" prop="age">
            <el-input v-model="information.age" autocomplete="off" style="width: 300px;" clearable></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="gender">
<%--            <el-input v-model="information.gender" autocomplete="off" style="width: 300px;" clearable></el-input>--%>
                <el-autocomplete
                    class="inline-input"
                    v-model="information.gender"
                    :fetch-suggestions="queryGender"
                    @select="handleSelect"
                    style="width: 300px"
                ></el-autocomplete>
        </el-form-item>
        <el-form-item label="联系电话" prop="telephone">
            <el-input v-model="information.telephone" autocomplete="off" style="width: 300px;" clearable></el-input>
        </el-form-item>
        <el-form-item label="地址" prop="address">
            <el-input v-model="information.address" autocomplete="off" style="width: 300px;" clearable></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="handleAlert('information')">修改</el-button>
        </el-form-item>
    </el-form>
</div>

</body>
</html>
