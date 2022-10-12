<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/12
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() +
            request.getContextPath() + "/";
    Object id = request.getSession().getAttribute("id");
%>
<html>
<head>
    <title>发布订单</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://unpkg.zhimg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.zhimg.com/element-ui/lib/index.js"></script>
    <script src="https://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
    <style>
        .clearfix:before,
        .clearfix:after {
            display: table;
            content: "";
        }

        .clearfix:after {
            clear: both
        }

        .box-card {
            width: 100%;
            height: 220px;
        }

        .el-dialog {
            height: 560px;
        }

        .el-dropdown-link {
            cursor: pointer;
            color: #409EFF;
        }

        .el-icon-arrow-down {
            font-size: 12px;
        }


    </style>
    <script type="text/javascript">
        window.onload = function () {
            //显示发件人
            $.ajax({
                url:'user/getUser',
                type:'get',
                data:{
                    id:<%=id%>
                },
                dataType:'json',
                success:function (user) {
                    vm.$data.consignor = user;
                },
                error:function () {
                    vm.$message({
                        type:'error',
                        message:'查询发件人失败'
                    })
                }
            })
            //显示驿站数据
            $.ajax({
                url:'user/queryAllStations',
                type:'get',
                dataType:'json',
                success:function (stations) {
                    vm.$data.stations = stations;
                },
                error:function () {
                    vm.$message({
                        type:'error',
                        message:'查询驿站出现错误'
                    })
                }
            })
            //显示企业数据
            $.ajax({
                url:'user/queryAllEnterprises',
                type:'get',
                dataType:'json',
                success:function (enterprises) {
                    vm.$data.enterprises = enterprises;
                },
                error:function () {
                    vm.$message.error("查询物流企业失败！请重试")
                }
            })
            const vm = new Vue({
                el: '#formTable',
                data() {
                    return {
                        labelPosition: 'left',
                        outerVisible: false,
                        innerVisible: false,
                        modifyConsignee: false,
                        consignees: [],
                        updateForm: {
                            id: '',
                            name: '',
                            phone: '',
                            address: ''
                        },
                        order: {
                            price: '',
                            uid: <%=id%>,
                            cid: '',
                            pid: '',
                            enterprise:''
                        },
                        consignor: {
                            id: '',
                            username: '',
                            realname: '',
                            age: '',
                            gender: '',
                            telephone: '',
                            address: ''
                        },
                        consignee: {
                            id: '',
                            name: '',
                            address: '',
                            phone: ''
                        },
                        newConsignee: {
                            name: '',
                            phone: '',
                            address: ''
                        },
                        itemTable: [
                            {
                                type: '',
                                number: '',
                                weight: '',
                                volume: '',
                                price: '',
                            }
                        ],
                        pagination:{
                            size:5,
                            total:25,
                            count:5
                        },
                        value: '',
                        options: [{
                            value: '1',
                            label: '食品'
                        }, {
                            value: '2',
                            label: '电子产品'
                        }, {
                            value: '3',
                            label: '建材'
                        }, {
                            value: '4',
                            label: '木材'
                        }, {
                            value: '5',
                            label: '家畜'
                        }, {
                            value: '6',
                            label: '日用品'
                        }, {
                            value: '7',
                            label: '危险品'
                        },
                        ],
                        stations:[],
                        enterprises:[],
                        currentStation:null,
                        currentEnterprise:null,
                        style: {
                            height: 60,
                        },
                        fullscreenLoading:false,
                        //校验联系人
                        ruleforConsignee: {
                            name: [
                                {required: true, message: '名字不可为空', trigger: 'blur'},
                            ],
                            phone: [
                                {required: true, message: '联系电话不可为空', trigger: 'blur'},
                            ],
                            address: [
                                {required: true, message: '地址不可为空', trigger: 'blur'},
                            ]
                        },
                        rules:{},
                    }
                },
                methods: {
                    //提交表单
                    postOrder(formName) {
                        let _this = this;
                        _this.$refs[formName].validate((valid)=>{
                            if (valid){
                                _this.$confirm('确认下单吗？','提示',{
                                    confirmButtonText:'下单！',
                                    cancelButtonText:'取消',
                                    type:'info'
                                }).then(()=>{
                                    $.ajax({
                                        url:'user/postOrder',
                                        type:'post',
                                        data:{
                                            price:_this.$data.order.price,
                                            uid:_this.$data.order.uid,
                                            cid:_this.$data.order.cid,
                                            pid:_this.$data.order.pid,
                                            enterprise:_this.$data.order.enterprise
                                        },
                                        success:function () {
                                            _this.fullscreenLoading = true;
                                            setTimeout(() => {
                                                _this.fullscreenLoading = false;
                                                _this.$message({
                                                    type:'success',
                                                    message:'下单成功',
                                                    offset:300,
                                                })
                                                //延迟加载页面
                                                setTimeout(()=>{
                                                    var frame = parent.document.getElementById("frame")
                                                    frame.src = "User/showOrders.jsp"
                                                },2000)
                                            }, 2000);
                                        },
                                        error:function () {
                                            _this.$message({
                                                type:'error',
                                                message:'提交失败！'
                                            })
                                        }
                                    })
                                }).catch(()=>{
                                    _this.$message({
                                        type:'info',
                                        message:'已取消提交'
                                    })
                                })
                            }
                        })
                    },
                    //打开对话框
                    handleClick() {
                        this.outerVisible = true;
                        let _this = this;
                        $.ajax({
                            url: 'user/queryAllConsignees',
                            type: 'get',
                            dataType: 'json',
                            data: {
                                id:<%=id%>
                            },
                            success: function (consignees) {
                                _this.$data.consignees = consignees;
                            },
                            error: function () {
                                _this.$message({
                                    message: '很抱歉！查询出现错误，请联系客服解决问题',
                                    type: 'warning'
                                });
                            }
                        })
                    },
                    //修改联系人信息
                    handleModify(row) {
                        let _this = this;
                        _this.$data.modifyConsignee = true;
                        _this.$data.updateForm.id = row.id;
                        _this.$data.updateForm.name = row.name;
                        _this.$data.updateForm.phone = row.phone;
                        _this.$data.updateForm.address = row.address;
                    },
                    handleUpdate(formName) {
                        let _this = this;
                        _this.$refs[formName].validate((valid) => {
                            if (valid) {
                                $.ajax({
                                    url: 'user/updateConsignee',
                                    type: 'post',
                                    data: {
                                        id: _this.$data.updateForm.id,
                                        name: _this.$data.updateForm.name,
                                        phone: _this.$data.updateForm.phone,
                                        address: _this.$data.updateForm.address,
                                    },
                                    success: function () {
                                        _this.$message({
                                            type: 'success',
                                            message: '修改成功!'
                                        })
                                        _this.$data.modifyConsignee = false;
                                        $.ajax({
                                            url: 'user/queryAllConsignees',
                                            type: 'get',
                                            dataType: 'json',
                                            data: {
                                                id:<%=id%>
                                            },
                                            success: function (consignees) {
                                                _this.$data.consignees = consignees;
                                            },
                                            error: function () {
                                                _this.$message({
                                                    message: '很抱歉！查询出现错误，请联系客服解决问题',
                                                    type: 'warning'
                                                });
                                            }
                                        })
                                    },
                                    error: function () {
                                        _this.$message({
                                            type: 'error',
                                            message: '很抱歉，系统出现了些小问题，修改失败！'
                                        })
                                    }
                                })
                            }
                        })
                    },
                    //添加联系人
                    addConsignee(formName) {
                        let _this = this;
                        _this.$refs[formName].validate((valid) => {
                            if (valid) {
                                _this.$confirm('确认添加？', '提示', {
                                    confirmButtonText: '添加',
                                    cancelButtonText: '取消',
                                    type: 'info'
                                }).then(() => {
                                    $.ajax({
                                        url: 'user/addConsignee',
                                        type: 'post',
                                        data: {
                                            uid:<%=id%>,
                                            name: _this.$data.newConsignee.name,
                                            phone: _this.$data.newConsignee.phone,
                                            address: _this.$data.newConsignee.address
                                        },
                                        success: function () {
                                            _this.$message({
                                                type: 'success',
                                                message: '添加成功!'
                                            })
                                            //关闭窗口
                                            _this.innerVisible = false;
                                            //刷新表格数据
                                            $.ajax({
                                                url: 'user/queryAllConsignees',
                                                type: 'get',
                                                dataType: 'json',
                                                data: {
                                                    id:<%=id%>
                                                },
                                                success: function (consignees) {
                                                    _this.$data.consignees = consignees;
                                                },
                                                error: function () {
                                                    _this.$message({
                                                        message: '很抱歉！查询出现错误，请联系客服解决问题',
                                                        type: 'warning'
                                                    });
                                                }
                                            })
                                        },
                                        error: function () {
                                            _this.$message({
                                                type: 'error',
                                                message: '添加失败!'
                                            })
                                        }
                                    })
                                }).catch(() => {
                                    _this.$message({
                                        type: 'info',
                                        message: '取消提交'
                                    })
                                })
                            }
                        })
                    },
                    //清除表单数据
                    clearForm(formName) {
                        this.$refs[formName].resetFields();
                    },
                    //删除联系人
                    handleDelete(index, rows) {
                        let _this = this;
                        _this.$confirm('确定删除联系人？', '提示', {
                            confirmButtonText: '确定',
                            cancelButtonText: '取消',
                            type: 'warning'
                        }).then(() => {
                            //发起删除请求
                            $.ajax({
                                url: 'user/deleteConsignee',
                                type: 'post',
                                data: {
                                    id: rows[index].id,
                                },
                                success: function () {
                                    rows.splice(index, 1);
                                    _this.$message({
                                        type: 'success',
                                        message: '删除成功！'
                                    })
                                },
                                error: function () {
                                    _this.$message({
                                        type: 'error',
                                        message: '因未知原因删除失败！,请联系管理员'
                                    })
                                }
                            })
                        }).catch(() => {
                            _this.$message({
                                type: 'info',
                                message: '已取消'
                            })
                        })
                    },
                    //计算价格/km
                    calculate(row) {
                        var type = this.value;
                        var num = parseInt(row.number);
                        var weight = parseFloat(row.weight);
                        var volume = parseFloat(row.volume);
                        var price = 0;
                        if (weight >0){
                            price = num * weight * 0.25
                            row.price = price + ""
                            this.$data.order.price = price * 10;
                        }else if (isNaN(weight) && volume > 0){
                            price = num * volume * 1.5
                            row.price = price + ""
                            this.$data.order.price = price * 10;
                        }
                    },
                    //选择收件人
                    handleCurrentConsignee(val){
                        this.$data.consignee = val;
                        this.$data.order.cid = val.id;
                        //关闭对话框
                        this.outerVisible = false;
                    },
                    //选中驿站
                    handleCurrentStation(val){
                        this.currentStation = val;
                        this.$data.order.pid = val.pid
                    },
                    //选择物流公司
                    handleCurrentEnterprise(val){
                        this.currentEnterprise = val;
                        this.$data.order.enterprise = val.name;
                    }
                }
            })
        }
    </script>

</head>
<body>
<div id="formTable">
    <el-form :model="order" ref="order" :rules="rules" :label-position="labelPosition" label-width="80px">
        <el-card class="box-card" style="width: 780px;float: left;margin: 0">
            <div slot="header" class="clearfix">
                <span>寄件人信息</span>
            </div>
            <el-form-item label="寄件人" prop="realname">
                <el-input v-model="consignor.realname" placeholder="请输入发件人" style="width: 200px;"></el-input>
                <label class="el-form-item_label" style="color: #606266;width: 80px">&nbsp联系电话&nbsp</label>
                <el-input v-model="consignor.telephone" placeholder="请输入联系电话" style="width: 200px;"></el-input>
            </el-form-item>
            <el-form-item label="寄出地址">
                <el-input v-model="consignor.address" style="width: 472px;"></el-input>
            </el-form-item>
        </el-card>
        <div style="margin: 0;width: 20px;float: left;height: 220px"></div>
        <el-card class="box-card" style="width: 780px;float: left">
            <div slot="header" class="clearfix">
                <span>收件人信息</span>
            </div>
            <el-form-item label="收件人" prop="name">
                <el-input v-model="consignee.name" placeholder="请输入收件人" style="width: 200px;"></el-input>
                <label class="el-form-item_label" style="color: #606266;width: 80px">&nbsp联系电话&nbsp</label>
                <el-input v-model="consignee.phone" placeholder="请输入联系电话" style="width: 200px;"></el-input>
            </el-form-item>
            <el-form-item label="寄送地址" prop="address">
                <el-input v-model="consignee.address" style="width: 472px;"></el-input>
                <el-button type="primary" @click="handleClick">选择常用联系人</el-button>
                <!--常用联系人-->
                <el-dialog title="常用联系人" :visible.sync="outerVisible" center>
                    <el-table
                            :data="consignees"
                            stripe
                            style="width: 100%;height: 334px"
                            highlight-current-row
                            @row-click="handleCurrentConsignee">
                        <el-table-column
                                prop="name"
                                label="姓名"
                                width="180">
                        </el-table-column>
                        <el-table-column
                                prop="phone"
                                label="联系电话"
                                width="180">
                        </el-table-column>
                        <el-table-column
                                prop="address"
                                label="地址">
                        </el-table-column>
                        <el-table-column
                                fixed="right"
                                label="操作"
                                width="150">
                            <template slot-scope="scope">
                                <el-button @click.stop="handleModify(scope.row)" type="primary" size="small">修改</el-button>
                                <!--修改联系人窗口-->
                                <el-dialog width="30%"
                                           title="修改联系人"
                                           :visible.sync="modifyConsignee"
                                           append-to-body
                                           center
                                           @close="clearForm('updateForm')">
                                    <el-form :model="updateForm" ref="updateForm" :rules="ruleforConsignee"
                                             label-position="top" label-width="80px">
                                        <el-form-item label="联系人姓名" prop="name">
                                            <el-input v-model="updateForm.name" style="width: 400px"></el-input>
                                        </el-form-item>
                                        <el-form-item label="联系电话" prop="phone">
                                            <el-input v-model="updateForm.phone" style="width: 400px"></el-input>
                                        </el-form-item>
                                        <el-form-item label="地址" prop="address">
                                            <el-input v-model="updateForm.address" style="width: 400px"></el-input>
                                        </el-form-item>
                                    </el-form>
                                    <div slot="footer" class="dialog-footer">
                                        <el-button type="primary" @click="handleUpdate('updateForm')">修改</el-button>
                                    </div>
                                </el-dialog>
                                <el-button @click.stop="handleDelete(scope.$index,consignees)" type="danger" size="small">
                                    删除
                                </el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                    <div style="height: 25px"></div>
                    <!--分页-->
                    <el-pagination
                            background
                            layout="prev, pager, next"
                            :page-size="pagination.size"
                            :total="pagination.total"
                            :pager-count="pagination.count"
                            style="margin-left: 220px">
                    </el-pagination>
                    <!--新增联系人-->
                    <el-dialog
                            width="30%"
                            title="新增常用联系人"
                            :visible.sync="innerVisible"
                            append-to-body
                            center
                            @close="clearForm('newConsignee')">
                        <el-form :model="newConsignee" ref="newConsignee" :rules="ruleforConsignee" label-position="top"
                                 label-width="80px">
                            <el-form-item label="联系人姓名" prop="name">
                                <el-input v-model="newConsignee.name" style="width: 400px"></el-input>
                            </el-form-item>
                            <el-form-item label="联系电话" prop="phone">
                                <el-input v-model="newConsignee.phone" style="width: 400px"></el-input>
                            </el-form-item>
                            <el-form-item label="地址" prop="address">
                                <el-input v-model="newConsignee.address" style="width: 400px"></el-input>
                            </el-form-item>
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button type="primary" @click="addConsignee('newConsignee')">添加</el-button>
                        </div>
                    </el-dialog>
                    <!--底部-->
                    <div slot="footer" class="dialog-footer">
                        <el-button type="primary" @click="innerVisible = true">新增联系人</el-button>
                        <el-button @click="outerVisible = false">取 消</el-button>
                    </div>
                </el-dialog>
            </el-form-item>
        </el-card>
        <div style="height: 20px;width: 100%;float: left"></div>
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span>货物信息(重量与体积可之选其一)</span>
            </div>
            <!--货物信息表-->
            <el-table :data="itemTable" border style="width: 100%" height="115px">
                <el-table-column prop="type" label="货物类型" width="250">
                    <template slot-scope="scope">
                        <el-select v-model="value" clearable placeholder="请选择">
                            <el-option
                                    v-for="item in options"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                            </el-option>
                        </el-select>
                    </template>
                </el-table-column>
                <el-table-column prop="number" label="总件数" width="250">
                    <template slot-scope="scope">
                    <el-input v-model="scope.row.number" type="number" style="width: 180px" clearable></el-input>&nbsp;件
                    </template>
                </el-table-column>
                <el-table-column prop="weight" label="预估重量" width="250">
                    <template slot-scope="scope">
                    <el-input v-model="scope.row.weight" type="number" style="width: 180px" clearable></el-input>&nbsp;千克
                    </template>
                </el-table-column>
                <el-table-column prop="volume" label="预估体积" width="250">
                    <template slot-scope="scope">
                    <el-input v-model="scope.row.volume" type="number" style="width: 180px" clearable></el-input>&nbsp;立方
                    </template>
                </el-table-column>
                <el-table-column prop="price" label="价格/KM" width="250">
                    <template slot-scope="scope">
                    <el-input v-model="scope.row.price" type="number" style="width: 180px" disabled></el-input>&nbsp;￥
                    </template>
                </el-table-column>
                <el-table-column label="操作" width="250" fixed="right">
                    <template slot-scope="scope">
                        <el-button @click="calculate(scope.row)" type="primary" size="small">计算</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
        <div style="height: 20px"></div>
        <el-card class="box-card" style="height: 300px">
            <div slot="header" class="clearfix">
                <span>寄送驿站</span>
            </div>
            <el-table :data="stations" ref="station" highlight-current-row @current-change="handleCurrentStation" border style="width: 100%" height="215">
                <el-table-column label="驿站" prop="psname" width="450">

                </el-table-column>
                <el-table-column label="联系电话" prop="telephone" width="450">

                </el-table-column>
                <el-table-column label="地址" prop="psaddress" width="450">

                </el-table-column>
                <el-table-column label="操作" width="192">
                    <template slot-scope="scope">
                        <el-button type="primary" size="small">选择</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
        <div style="height: 20px"></div>
        <el-card class="box-card" style="height: 300px">
            <div slot="header" class="clearfix" >
                <span>选择物流公司</span>
            </div>
            <el-table :data="enterprises" ref="enterprise" highlight-current-row @current-change="handleCurrentEnterprise" border style="width: 100%" height="215">
                <el-table-column label="承接商" prop="name" width="450">

                </el-table-column>
                <el-table-column label="联系电话" prop="phone" width="450">

                </el-table-column>
                <el-table-column label="网址" prop="address" width="450">

                </el-table-column>
                <el-table-column label="操作" width="192">
                    <template slot-scope="scope">
                        <el-button type="primary" size="small">选择</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
        <div style="height: 20px"></div>
        <el-button type="primary" @click="postOrder('order')"  v-loading.fullscreen.lock="fullscreenLoading" style="margin-left: 730px">立即发布</el-button>
        <hr color="skyblue">
    </el-form>
</div>
</body>
</html>
