<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/5/7
  Time: 19:51
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
                el:'#table',
                data(){
                    return{
                        position:'left',
                        dialogTableVisible: false,
                        nameForm:{
                            enterprise: ''
                        },
                        consignor:{
                            id:'',
                            username:'',
                            realname:'',
                            age:'',
                            gender:'',
                            telephone:'',
                            address:''
                        },
                        consignee:{
                            id:'',
                            name:'',
                            address:'',
                            phone:''
                        },
                        tableData:[],
                        rules:{
                            pid:[
                                { required:true,message:'id不能为空！',trigger:'blur' }
                            ]
                        },
                        readonly:true,
                    }
                },
                methods:{
                    setCurrent(row) {
                        this.$refs.singleTable.setCurrentRow(row);
                    },
                    handleCurrentChange(val) {
                        this.currentRow = val;
                    },
                    selectOrders(formName){
                        this.$refs[formName].validate((valid)=>{
                            if (valid){
                                $.ajax({
                                    url: "admin/queryOrdersByEnter",
                                    type:'get',
                                    dataType: 'json',
                                    data: {
                                        enterprise:this.$data.nameForm.enterprise
                                    },
                                    success:function (orders) {
                                        if (orders.length == 0){
                                            alert("没有查询到数据！")
                                        }
                                        vm.$data.tableData = orders;
                                    },
                                    error:function () {
                                        alert("查询失败！,请检查参数是否正确")
                                    }
                                })
                            }
                        })
                    },
                    selectAll(){
                        $.ajax({
                            url:'admin/queryAllOrdersPaid',
                            type:'get',
                            dataType:'json',
                            success:function (orders) {
                                vm.$data.tableData = orders;
                            },
                            error:function () {
                                alert("未查找到数据!")
                            }
                        })
                    },
                    handleClick(row){
                        this.dialogTableVisible = true;
                        this.$data.consignor = row.consignor;
                        this.$data.consignee = row.consignee;
                    },
                }
            })
        }
    </script>
</head>
<body>
<div id="table">
    <el-form :model="nameForm" :lable-position="position" ref="nameForm" lable-width="100px" class="demo-ruleForm" :rules="rules">
        <el-form-item>
            <el-button type="primary" @click="selectAll" >查询所有站点订单</el-button>
        </el-form-item>
        <el-form-item label="企业名称" prop="enterprise" label-width="80px">
            <el-input v-model="nameForm.enterprise" autocomplete="off" style="width: 300px" clearable></el-input>
            <el-button type="primary" @click="selectOrders('nameForm')">查询</el-button>
        </el-form-item>
    </el-form>
    <el-table :data="tableData" ref="singleTable" highlight-current-row style="width: 100%">
        <el-table-column prop="oid" label="订单号" width="180"></el-table-column>
        <el-table-column prop="price" label="价格" width="180"></el-table-column>
        <el-table-column prop="paid" label="是否支付" width="180"></el-table-column>
        <el-table-column prop="state" label="订单状态" width="180"></el-table-column>
        <el-table-column prop="createtime" label="创建时间" width="180"></el-table-column>
        <el-table-column width="180"></el-table-column>
        <el-table-column width="180"></el-table-column>
        <el-table-column width="180"></el-table-column>
        <el-table-column fixed="right" label="操作" width="100">
            <template slot-scope="scope">
                <el-button @click="handleClick(scope.row)" type="text" size="medium">查看</el-button>
            </template>
        </el-table-column>
    </el-table>
    <el-dialog title="订单" :visible.sync="dialogTableVisible">
        <el-descriptions class="margin-top" title="寄件人" :column="2" border>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-user"></i>
                    姓名
                </template>
                <el-input v-model="consignor.realname" readonly="readonly" ></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-mobile-phone"></i>
                    手机号
                </template>
                <el-input v-model="consignor.telephone" readonly="readonly" ></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-office-building"></i>
                    寄出地址
                </template>
                <el-input v-model="consignor.address" readonly="readonly" ></el-input>
            </el-descriptions-item>
        </el-descriptions>
        <el-descriptions class="margin-top" title="收件人" :column="2" border>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-user"></i>
                    姓名
                </template>
                <el-input v-model="consignee.name" readonly="readonly" ></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-mobile-phone"></i>
                    手机号
                </template>
                <el-input v-model="consignee.phone" readonly="readonly" ></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-office-building"></i>
                    寄送地址
                </template>
                <el-input v-model="consignee.address" readonly="readonly" ></el-input>
            </el-descriptions-item>
        </el-descriptions>
    </el-dialog>
</div>
</body>
</html>