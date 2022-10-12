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
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<script>
    window.onload = function (){
        $.ajax({
            url:'admin/getAdmin',
            type:'get',
            dataType:'json',
            data:{
                id:<%=id%>
            },
            success:function (admin) {
                vm.$data.information.adminname = admin.adminname;
                var role = admin.role;
                if (role == 1){
                    vm.$data.information.role = "管理员";
                }else if (role == 2){
                    vm.$data.information.role = "用户";
                }else if (role == 3){
                    vm.$data.information.role = "驿站";
                }
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
                            adminname:'',
                            role:'',
                        },
                        rules:{}
                    };
                },
                methods: {

                }
            }
        )
    }
</script>
<div id="Area">
    <el-form :model="information" ref="information" :rules="rules" label-width="100px" class="demo-ruleForm">
        <el-form-item label="账号" prop="adminname">
            <el-input v-model="information.adminname" autocomplete="off" style="width: 300px;" clearable :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="身份" prop="role">
            <el-input v-model="information.role" autocomplete="off" style="width: 300px;" clearable :disabled="true"></el-input>
        </el-form-item>
    </el-form>
</div>

</body>
</html>
