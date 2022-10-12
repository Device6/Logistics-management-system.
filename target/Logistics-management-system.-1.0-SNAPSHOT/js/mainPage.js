$(function () {
    // 获取管理员名
    $.ajax({
        url:"admin/getAdminName",
        type:"get",
        dataType:"text",
        success:function (result) {
            $('#welcome').append(result);
        },
        error:function () {
            alert("获取数据失败!");
        }
    })

})

function updatePass() {
    var src = "http://localhost:8080/Logistics_management_system/Admin/updatePass.jsp"
    var frame = document.getElementById("frame");
    frame.src = src;
}