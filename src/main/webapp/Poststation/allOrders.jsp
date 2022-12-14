<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/5/14
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() +
            request.getContextPath() + "/";
    Object pid =  request.getSession().getAttribute("pid");
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
            console.log("<%=pid%>")
            const vm = new Vue({
                el:'#center',
                data(){
                    return{
                        tableData:[],
                        dialogTableVisible: false,
                        process:false,
                        state:'',
                        pid:<%=pid%>,
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
                            url:'poststation/queryAllOrdersPaid',
                            type: 'get',
                            dataType: 'json',
                            data:{
                                pid:vm.$data.pid
                            },
                            success:function (orders) {
                                vm.$data.tableData = orders;
                            },
                            error:function () {
                                alert("????????????")
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
                        // ?????? callback ???????????????????????????
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
                            { "value":"?????????" },
                            { "value":"?????????" },
                            { "value":"?????????" },
                            { "value":"?????????" }
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
                                        message:'????????????????????????!',
                                    })
                                    setTimeout(()=>{
                                        _this.process = false;
                                        $.ajax({
                                            url:'admin/queryAllOrdersPaid',
                                            type: 'get',
                                            dataType: 'json',
                                            data:{
                                                pid:vm.$data.pid
                                            },
                                            success:function (orders) {
                                                vm.$data.tableData = orders;
                                            },
                                            error:function () {
                                                alert("????????????")
                                            }
                                        })
                                    },2000)
                                },
                                error:function () {
                                    _this.$message({
                                        type:'error',
                                        message:'????????????????????????!',
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
            $.ajax({
                url:'poststation/queryAllOrdersPaid',
                type: 'get',
                dataType: 'json',
                data:{
                    pid:vm.$data.pid
                },
                success:function (orders) {
                    vm.$data.tableData = orders;
                },
                error:function () {
                    alert("????????????")
                }
            })
        }
    </script>
</head>
<body>
<div id="center">
    <el-form :model="oidForm" lable-position="left" ref="oidForm" lable-width="100px" class="demo-ruleForm" :rules="rules">
        <el-form-item>
            <el-button type="primary" @click="selectAll" >???????????????????????????</el-button>
        </el-form-item>
        <el-form-item label="??????id" prop="oid" label-width="80px">
            <el-input v-model="oidForm.oid" autocomplete="off" style="width: 300px" clearable></el-input>
            <el-button type="primary" @click="selectOrder('oidForm')">??????</el-button>
        </el-form-item>
    </el-form>
    <el-table :data="tableData" style="width: 100%" height="650">
        <el-table-column prop="oid" label="?????????" width="180"></el-table-column>
        <el-table-column prop="price" label="??????" width="180"></el-table-column>
        <el-table-column prop="paid" label="????????????" width="180"></el-table-column>
        <el-table-column prop="state" label="????????????" width="180"></el-table-column>
        <el-table-column prop="createtime" label="????????????" width="180"></el-table-column>
        <el-table-column width="180"></el-table-column>
        <el-table-column width="180"></el-table-column>
        <el-table-column width="80"></el-table-column>
        <el-table-column fixed="right" label="??????" width="200">
            <template slot-scope="scope">
                <el-button @click="handleClick(scope.row)" type="text" size="medium">??????</el-button>
                <el-button @click="handleProcess(scope.row)" type="text" style="color: #76e362" size="medium">??????</el-button>
            </template>
        </el-table-column>
    </el-table>
    <el-dialog title="??????" :visible.sync="dialogTableVisible">
        <el-descriptions class="margin-top" title="?????????" :column="2" border>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-user"></i>
                    ??????
                </template>
                <el-input v-model="consignor.realname" readonly="readonly" ></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-mobile-phone"></i>
                    ?????????
                </template>
                <el-input v-model="consignor.telephone" readonly="readonly" ></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-office-building"></i>
                    ????????????
                </template>
                <el-input v-model="consignor.address" readonly="readonly" ></el-input>
            </el-descriptions-item>
        </el-descriptions>
        <el-descriptions class="margin-top" title="?????????" :column="2" border>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-user"></i>
                    ??????
                </template>
                <el-input v-model="consignee.name" readonly="readonly" ></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-mobile-phone"></i>
                    ?????????
                </template>
                <el-input v-model="consignee.phone" readonly="readonly" ></el-input>
            </el-descriptions-item>
            <el-descriptions-item>
                <template slot="label">
                    <i class="el-icon-office-building"></i>
                    ????????????
                </template>
                <el-input v-model="consignee.address" readonly="readonly" ></el-input>
            </el-descriptions-item>
        </el-descriptions>
    </el-dialog>

    <el-dialog title="??????????????????" :visible.sync="process" >
        <el-autocomplete
                class="inline-input"
                v-model="state"
                :fetch-suggestions="querySearch"
                placeholder="???????????????"
                @select="handleSelect"
        ></el-autocomplete>
        <el-button type="primary" @click="confirm">??????</el-button>
    </el-dialog>
</div>
</body>
</html>

