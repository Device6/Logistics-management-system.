<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/5/1
  Time: 13:42
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
    <script type="text/javascript">
        window.onload = function () {
            //加载订单数据
            $.ajax({
                url:'user/queryAllOrders',
                type:'get',
                data:{
                    id:<%=id%>
                },
                dataType:'json',
                success:function (orders) {
                    vm.$data.tableData = orders;
                },
                error:function () {
                    alert("查询订单失败")
                }
            })
            const vm = new Vue({
                el:'#order',
                data(){
                    return{
                        tableData:[],
                        dialogTableVisible: false,
                        ispay:false,
                        oid:'',
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
                methods: {
                    handleClick(row) {
                        this.dialogTableVisible = true;
                        this.$data.consignor = row.consignor;
                        this.$data.consignee = row.consignee;
                    },
                    payForOrder(row){
                        let _this = this
                        if (row.paid == "已支付"){
                            _this.$message({
                                type:'warning',
                                message:'您已支付请勿重复!'
                            })
                        }else{
                            _this.ispay = true;
                            _this.oid = row.oid
                        }
                    },
                    pay(){
                        let _this = this
                        _this.$confirm('确认支付？','提示',{
                            confirmButtonText:'确认支付',
                            cancelButtonText:'取消'
                        }).then(()=>{
                            _this.$message({
                                type:'warning',
                                message: '确定支付？'
                            })
                            setTimeout(()=>{
                                $.ajax({
                                    url:'user/payForOrder',
                                    type:'post',
                                    data:{
                                        oid:_this.oid
                                    },
                                    success:function () {
                                        _this.$message({
                                            type:'success',
                                            message: '支付成功!'
                                        })
                                        setTimeout(()=>{
                                            _this.ispay = false;
                                            $.ajax({
                                                url:'user/queryAllOrders',
                                                type:'get',
                                                data:{
                                                    id:<%=id%>
                                                },
                                                dataType:'json',
                                                success:function (orders) {
                                                    vm.$data.tableData = orders;
                                                },
                                                error:function () {
                                                    alert("查询订单失败")
                                                }
                                            },2000)
                                        })
                                    }
                                })
                            },2000)
                        })
                    }
                },
            })
        }
    </script>
</head>
<body>
    <div id="order">
    <el-table :data="tableData" style="width: 100%">
        <el-table-column prop="oid" label="订单号" width="180"></el-table-column>
        <el-table-column prop="price" label="价格" width="180"></el-table-column>
        <el-table-column prop="paid" label="是否支付" width="180"></el-table-column>
        <el-table-column prop="state" label="订单状态" width="180"></el-table-column>
        <el-table-column prop="createtime" label="创建时间" width="180"></el-table-column>
        <el-table-column width="180"></el-table-column>
        <el-table-column width="180"></el-table-column>
        <el-table-column width="100"></el-table-column>
        <el-table-column fixed="right" label="操作" width="180">
            <template slot-scope="scope">
                <el-button @click="handleClick(scope.row)" type="text" size="medium">查看</el-button>
                <el-button @click="payForOrder(scope.row)" type="text" size="medium" style="color: #65f98a">去支付</el-button>
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
        <el-dialog title="支付页面" :visible.sync="ispay">
            <el-button type="success" @click="pay">支付！</el-button>
        </el-dialog>
    </div>
</body>
</html>
