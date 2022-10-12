<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/5/13
  Time: 13:59
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
            const vm = new Vue({
                el:'#content',
                data(){
                    return{
                        value:null,
                        textarea1:'',
                        textarea2:'',
                        contact:'',
                        infor:{
                            textarea1:'',
                            textarea2:'',
                            contact:''
                        },
                    }
                },
                methods:{
                    postForm(formName){},
                },
            })
        }
    </script>
    <style>
        body{
            margin: 0;
            height: 800px;
        }
        .el-rate__item{
            height: 40px;
            width: 60px;
        }

        .el-rate__icon{
            font-size: 30px;
        }
    </style>
</head>
<body>
    <div id="content" style="margin-left: 500px;background: #eef3ef;height: 800px;width:550px;margin-right: 500px">
        <el-form :model="info" ref="info" >
        <div id="first" style="height: 100px">
            <p>1.基于您对本软件的使用，总体来说您对系统的满意程度如何呢？</p>
            <div id="first_rate" style="margin:30px 30px 30px">
                <el-rate
                        v-model="value"
                        show-text
                >
                </el-rate>
            </div>
        </div>
        <div id="second" style="height: 200px">
            <p>2.您认为本软件有那些需要改善的地方？</p>
            <div id="second_textarea" style="margin:30px 30px 30px ;">
                <el-form-item prop="textarea1">
                    <el-input
                            type="textarea"
                            placeholder="您对系统有任何想法请说出来！"
                            v-model="infor.textarea1"
                            :autosize="{ minRows: 5}"
                            maxlength="150"
                            show-word-limit
                    >
                    </el-input>
                </el-form-item>
            </div>
        </div>
        <div id="third" style="height: 200px">
            <p>3.您对物流服务有什么想说的吗？</p>
            <div id="third_textarea" style="margin:30px 30px 30px ;">
                <el-form-item prop="textarea2">
                    <el-input
                            type="textarea"
                            placeholder="无论是缺陷还是建议都可以！"
                            v-model="infor.textarea2"
                            :autosize="{ minRows: 5}"
                            maxlength="150"
                            show-word-limit
                    >
                    </el-input>
                </el-form-item>
            </div>
        </div>
        <div id="fourth">
            <p>4.您常用的联系方式是？</p>
            <div id="fourth_contact" style="margin:30px 30px 30px ;">
                <el-form-item prop="contact">
                    <el-input v-model="infor.contact" placeholder="请尽量填写，以便我们给您及时回复"></el-input>
                </el-form-item>
            </div>
        </div>
        <div id="fifth" style="margin-left: 120px;margin-top: 80px">
            <el-button type="primary" style="width: 300px" @click="postForm('infor')">提交</el-button>
        </div>
        </el-form>
    </div>
</body>
</html>
