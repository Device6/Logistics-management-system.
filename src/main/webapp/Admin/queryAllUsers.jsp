<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/28
  Time: 16:48
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
    <style>
        body{
            margin: 0;
        }
    </style>
    <script type="text/javascript">
        window.onload = function () {
            $.ajax({
                url:'admin/queryAllUsers',
                type:'get',
                dataType:'json',
                success:function (users) {
                    vm.$data.tableData = users;
                }
            })
            const vm = new Vue({
                el: '#table',
                data:{
                  tableData: [],
                  pagesize: 10,
                  currentPage:1,
                  totalCount:0,
                },
                methods:{
                    setCurrent(row) {
                        this.$refs.singleTable.setCurrentRow(row);
                    },
                    handleCurrentChange(val) {
                        this.currentRow = val;
                    },
                }
            })
        }
    </script>
</head>
<body>
    <div id="table">
        <el-table
                ref="singleTable"
                :data="tableData"
                highlight-current-row
                @current-change="handleCurrentChange"
                style="width: 1600px">
            <el-table-column
                    property="id"
                    label="id"
                    width="220">
            </el-table-column>
            <el-table-column
                    property="username"
                    label="账号"
                    width="220">
            </el-table-column>
            <el-table-column
                    property="realname"
                    label="姓名"
                    width="220">
            </el-table-column>
            <el-table-column
                    property="age"
                    label="年龄"
                    width="220">
            </el-table-column>
            <el-table-column
                    property="gender"
                    label="性别"
                    width="220">
            </el-table-column>
            <el-table-column
                    property="telephone"
                    label="联系电话"
                    width="220">
            </el-table-column>
            <el-table-column
                    property="address"
                    label="住址"
                    width="280">
            </el-table-column>
        </el-table>
    </div>
</body>
</html>
