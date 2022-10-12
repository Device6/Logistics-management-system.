<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/5/7
  Time: 19:18
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
    <link rel="stylesheet" href="css/indexforadmin.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.zhimg.com/element-ui/lib/index.js"></script>
    <script src="https://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            $.ajax({
                url:'admin/queryAllOrdersPaid',
                type: 'get',
                dataType: 'json',
                success:function (orders) {
                    vm.$data.tableData = orders;
                },
                error:function () {
                    alert("出现错误")
                }
            })
            const vm = new Vue({
                el:'#center',
                data(){
                    return{
                        tableData:[],
                        dialogTableVisible: false,
                        process:false,
                        state:'',
                        options:[],
                        oidForm:{
                            oid:'',
                        },
                        oid:'',
                        rules:{},
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
                        readonly:true
                    }
                },
                methods:{
                    handleClick(row){
                        this.dialogTableVisible = true;
                        this.$data.consignor = row.consignor;
                        this.$data.consignee = row.consignee;
                    },
                    handleProcess(row){
                        this.process = true;
                        this.oid = row.oid;
                        this.state = row.state;
                    },
                    selectAll(){
                        $.ajax({
                            url:'admin/queryAllOrdersPaid',
                            type: 'get',
                            dataType: 'json',
                            success:function (orders) {
                                vm.$data.tableData = orders;
                            },
                            error:function () {
                                alert("出现错误")
                            }
                        })
                    },
                    selectOrder(formName){
                        let _this = this;
                        _this.$refs[formName].validate((valid)=>{
                            if (valid){
                                $.ajax({
                                    url:'admin/queryOrder',
                                    type:'get',
                                    data:{
                                        oid:_this.$data.oidForm.oid
                                    },
                                    success:function (order) {
                                        _this.$data.tableData = order;
                                    }
                                })
                            }
                        })
                    },
                    querySearch(queryString, cb) {
                        var options = this.options;
                        var results = queryString ? options .filter(this.createFilter(queryString)) : options;
                        // 调用 callback 返回建议列表的数据
                        cb(results);
                    },
                    createFilter(queryString) {
                        return (option) => {
                            return (option.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
                        };
                    },
                    handleSelect(item) {
                        console.log(item.value)
                    },
                    loadAll() {
                        return[
                            { "value":"已发货" },
                            { "value":"运输中" },
                            { "value":"已送达" },
                            { "value":"已完成" }
                        ]
                    },
                    confirm(){
                        let _this = this;
                        if (_this.state != "" ){
                            $.ajax({
                                url:"admin/updateOrder",
                                type:'post',
                                data:{
                                    oid:_this.oid,
                                    state:_this.state
                                },
                                success:function () {
                                    _this.$message({
                                        type:'success',
                                        message:'修改订单状态成功!',
                                    })
                                    setTimeout(()=>{
                                        _this.process = false;
                                        $.ajax({
                                            url:'admin/queryAllOrdersPaid',
                                            type: 'get',
                                            dataType: 'json',
                                            success:function (orders) {
                                                vm.$data.tableData = orders;
                                            },
                                            error:function () {
                                                alert("出现错误")
                                            }
                                        })
                                    },2000)
                                },
                                error:function () {
                                    _this.$message({
                                        type:'error',
                                        message:'修改订单状态失败!',
                                    })
                                }
                            })
                        }
                    },
                },
                mounted(){
                    this.options = this.loadAll();
                }
            })
        }
    </script>
</head>
<body>
    <div id="center">
        <el-form :model="oidForm" lable-position="left" ref="oidForm" lable-width="100px" class="demo-ruleForm" :rules="rules">
            <el-form-item>
                <el-button type="primary" @click="selectAll" >所有用户已支付订单</el-button>
            </el-form-item>
            <el-form-item label="订单id" prop="oid" label-width="80px">
                <el-input v-model="oidForm.oid" autocomplete="off" style="width: 300px" clearable></el-input>
                <el-button type="primary" @click="selectOrder('oidForm')">查询</el-button>
            </el-form-item>
        </el-form>
        <el-table :data="tableData" style="width: 100%" height="650">
            <el-table-column prop="oid" label="订单号" width="180"></el-table-column>
            <el-table-column prop="price" label="价格" width="180"></el-table-column>
            <el-table-column prop="paid" label="是否支付" width="180"></el-table-column>
            <el-table-column prop="state" label="订单状态" width="180"></el-table-column>
            <el-table-column prop="createtime" label="创建时间" width="180"></el-table-column>
            <el-table-column width="180"></el-table-column>
            <el-table-column width="180"></el-table-column>
            <el-table-column width="80"></el-table-column>
            <el-table-column fixed="right" label="操作" width="200">
                <template slot-scope="scope">
                    <el-button @click="handleClick(scope.row)" type="text" size="medium">查看</el-button>
                    <el-button @click="handleProcess(scope.row)" type="text" style="color: #76e362" size="medium">处理</el-button>
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

        <el-dialog title="更新订单状态" :visible.sync="process" >
            <el-autocomplete
                    class="inline-input"
                    v-model="state"
                    :fetch-suggestions="querySearch"
                    placeholder="请输入内容"
                    @select="handleSelect"
            ></el-autocomplete>
            <el-button type="primary" @click="confirm">确认</el-button>
        </el-dialog>
    </div>
</body>
</html>
