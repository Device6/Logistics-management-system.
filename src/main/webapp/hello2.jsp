<%--
  Created by IntelliJ IDEA.
  User: SHW
  Date: 2022/4/13
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- cdn引入ElementUI样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!--cdn引入ElementUI组件必须先引入Vue-->
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <!-- cdn引入ElementUI组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
</head>
<body>
<div id="app">
    <i class="el-icon-edit"></i>
    <i class="el-icon-share"></i>
    <i class="el-icon-delete"></i>
    <el-button type="primary" icon="el-icon-search">搜索</el-button>
</div>

<script type="text/javascript">
    // 配置对象 options
    const vm = new Vue({
        // 配置选项(option)
        // element: 指定用vue来管理页面中的哪个标签区域
        el: '#app',
        data: {
            isCollapse: true
        },
        methods: {

        }
    });
</script>
</body>
</html>
