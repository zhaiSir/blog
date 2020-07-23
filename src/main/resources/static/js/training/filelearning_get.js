
var rootPath=$("#contextPath").val();

/**审核*/
$("#form-get").on("click","#ThroughAuditing",function () {
    var id = $("#fileLearningId").val();

    $.ajax({
        type:"post",
        data:"fileLearningId="+id,
        url:rootPath+"/filelearning/doAudit",
        dataType:"json",
        success:function (resultJson) {

            if (resultJson.state == 0){
                layer.alert(resultJson.message);
            }else {
                opener.location.reload();
                window.opener=null;
                window.open('','_self');
                window.close();
            }

        }
    });
});


/**拒绝审核*/
$("#form-get").on("click","#refuseAuditing",function () {

    var id = $("#fileLearningId").val();

    $.ajax({
        type:"post",
        data:"fileLearningId="+id,
        url:rootPath+"/filelearning/refuseAuditing",
        dataType:"json",
        success:function (res) {
                opener.location.reload();
                window.opener=null;
                window.open('','_self');
                window.close();
        }
    });
});

//关闭按钮
function closeForm() {
    //关闭当前页面
    window.opener=null;
    window.open('','_self');
    window.close();
}
