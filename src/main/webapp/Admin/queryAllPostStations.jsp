<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/28
  Time: 18:23
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
                        idForm:{
                            pid:'',
                        },
                        nameForm:{
                            psname:'',
                        },
                        tableData:[],
                        rules:{
                            pid:[
                                { required:true,message:'id不能为空！',trigger:'blur' }
                            ],
                            psname:[
                                { required:true,message:'名称不能为空！',trigger:'blur' }
                            ]
                        }
                    }
                },
                methods:{
                    setCurrent(row) {
                        this.$refs.singleTable.setCurrentRow(row);
                    },
                    handleCurrentChange(val) {
                        this.currentRow = val;
                    },
                    handleDelete(index, row,rows) {
                        let _this = this;
                        this.$confirm('确认删除数据？','提示',{
                            confirmButtonText: '确定',
                            cancelButtonText: '取消',
                            type: 'warning'
                        }).then(()=>{
                            $.ajax({
                                url:'admin/deletePostStationById',
                                type:'post',
                                data:{
                                    pid:row.pid
                                },
                                success:function () {
                                    _this.$message({
                                        type: 'success',
                                        message: '删除成功!'
                                    });
                                    rows.splice(index,1)
                                },
                                error:function () {
                                    _this.$message({
                                        type: 'info',
                                        message: '取消删除'
                                    });
                                }
                            })
                        }).catch(()=>{
                            console.log('error!')
                        })
                    },
                    selectPostStation(formName){
                        this.$refs[formName].validate((valid)=>{
                            if (valid){
                                $.ajax({
                                    url: "admin/queryPostStationById",
                                    type:'get',
                                    dataType: 'json',
                                    data: {
                                        pid:this.idForm.pid
                                    },
                                    success:function (postStations) {
                                        if (postStations.length == 0){
                                            alert("没有查询到数据！")
                                        }
                                        console.log(postStations)
                                        vm.$data.tableData = postStations;
                                    },
                                    error:function () {
                                        alert("查询失败！,请检查参数是否正确")
                                    }
                                })
                            }
                        })
                    },
                    selectPostStation2(formName){
                        this.$refs[formName].validate((valid)=>{
                            if (valid){
                                $.ajax({
                                    url: "admin/queryPostStationByName",
                                    type:'get',
                                    dataType: 'json',
                                    data: {
                                        psname:this.nameForm.psname
                                    },
                                    success:function (postStations) {
                                        if (postStations.length == 0){
                                            alert("没有查询到数据！")
                                        }
                                        console.log(postStations)
                                        vm.$data.tableData = postStations;
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
                            url:'admin/queryAllPostStations',
                            type:'get',
                            dataType:'json',
                            success:function (postStations) {
                                console.log(postStations)
                                vm.$data.tableData = postStations;
                            },
                            error:function () {
                                alert("未查找到数据!")
                            }
                        })
                    },
                }
            })
        }
    </script>
</head>
<body>
    <div id="table">
        <el-form :model="idForm" :lable-position="position" ref="idForm" lable-width="100px" class="demo-ruleForm" :rules="rules">
            <el-form-item>
                <el-button type="primary" @click="selectAll" >查询所有站点</el-button>
            </el-form-item>
            <el-form-item label="站点 id" prop="pid" label-width="80px">
                <el-input v-model="idForm.pid" autocomplete="off" style="width: 300px" clearable></el-input>
                <el-button type="primary" @click="selectPostStation('idForm')">查询</el-button>
            </el-form-item>
        </el-form>
        <el-form :model="nameForm" :lable-position="position" ref="nameForm" lable-width="100px" class="demo-ruleForm" :rules="rules">
            <el-form-item label="站点名称" prop="psname" label-width="80px">
                <el-input v-model="nameForm.psname" autocomplete="off" style="width: 300px" clearable></el-input>
                <el-button type="primary" @click="selectPostStation2('nameForm')">查询</el-button>
            </el-form-item>
        </el-form>
        <el-table
                ref="singleTable"
                :data="tableData"
                highlight-current-row
                @current-change="handleCurrentChange"
                style="width: 1500px">
            <el-table-column
                    property="pid"
                    label="id"
                    width="50">
            </el-table-column>
            <el-table-column
                    property="psname"
                    label="站点名称"
                    width="250">
            </el-table-column>
            <el-table-column
                    property="telephone"
                    label="联系电话"
                    width="250">
            </el-table-column>
            <el-table-column
                    property="psaddress"
                    label="地址"
                    width="250">
            </el-table-column>
            <el-table-column
                    width="250">
            </el-table-column>
            <el-table-column
                    width="250">
            </el-table-column>
            <el-table-column
                    fixed="right"
                    label="操作"
                    width="200">
                <template slot-scope="scope">
                    <el-button
                            size="mini"
                            type="danger"
                            @click="handleDelete(scope.$index, scope.row,tableData)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</body>
</html>
