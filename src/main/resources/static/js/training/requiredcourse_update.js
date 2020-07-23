
var rootPath=$("#contextPath").val();

$(function () {
    $('#form-update').bootstrapValidator({
        container:"tooltip",
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            courseTitle: {
                validators: {
                    notEmpty: {
                        message: '视频标题不能为空'
                    }
                }
            },
            firstSeries: {
                validators: {
                    notEmpty: {
                        message: '所属一级专题系列不能为空'
                    }
                }
            },
            secondSeries: {
                validators: {
                    notEmpty: {
                        message: '所属二级专题系列不能为空'
                    }
                }
            },
            thirdSeries: {
                validators: {
                    notEmpty: {
                        message: '所属三级专题系列不能为空'
                    }
                }
            },
            linkAdress: {
                validators: {
                    notEmpty: {
                        message: '链接地址不能为空'
                    }
                }
            },
            beginTime: {
                validators: {
                    notEmpty: {
                        message: '开始时间不能为空'
                    }
                }
            },
            endTime: {
                validators: {
                    notEmpty: {
                        message: '结束时间不能为空'
                    }
                }
            }
        }
    });
})

$('#endTime').on('changeDate', function (e) {
    var beginTime = $("#beginTime").val();
    if (!beginTime) {
        return;
    }
    var endTime = $(this).val();
    if ((endTime) < (beginTime)) {
        $(this).val('');
        //errmsg("结束日期不能小于开始日期!", 4000);
        layer.msg("结束时间不能小于开始时间!",{time:2000});
    }
});

$('#beginTime').on('changeDate', function (e) {
    var endTime = $("#endTime").val();
    if (endTime=="") {
        return;
    }
    var beginTime = $(this).val();
    if ((endTime) < (beginTime)) {
        $(this).val('');
        layer.msg("开始时间不能大于结束时间!",{time:2000});
    }
});

//点击取消关闭当前页面
function closeForm() {
    window.opener=null;
    window.open('','_self');
    window.close();
}

$('.datePicker').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii:ss',
    todayHighlight: true,
    autoclose: true,
    todayBtn: true,
});

//ajax提交表单
function submitForm() {
    $('#form-update').data('bootstrapValidator').validate();
    if($('#form-update').data('bootstrapValidator').isValid()){
        $("#form-update").ajaxSubmit({
            type:"post",
            url:rootPath+"/requiredcourse/update",
            success:function (res) {
                if (res==1){
                    opener.location.reload();
                    window.opener=null;
                    window.open('','_self');
                    window.close();
                }else {
                    layer.alert('修改失败！');
                }
            }
        });
    }else{
        return ;
    }
}

/**当选择所属一级专题之后返回二级菜单*/
$("#firstSeries").change(function () {
    var firstSeries = $("#firstSeries").val();
    $("#secondSeries").empty();
    $("#thirdSeries").empty();
    if(firstSeries!=null&&firstSeries!=""){
        $.ajax({
            url: rootPath + "/specialseries/getChild",
            type: "get",
            data:"fatherSeries="+firstSeries+"&type=2&category=requiredcourse",
            dataType: "json",
            success: function (res) {
                var map = res.data;
                var option='<option value=""></option>';
                // var option = '';
                for (var key in map) {
                    option += '<option value="' + key + '">' + map[key] + '</option>';
                }
                $("#secondSeries").html(option);
            }
        });
    }
});

/**当选择所属二级专题之后返回三级菜单*/
$("#secondSeries").change(function () {
    var secondSeries = $("#secondSeries").val();
    $("#thirdSeries").empty();
    if(secondSeries!=null&&secondSeries!="") {
        $.ajax({
            url: rootPath + "/specialseries/getChild",
            type: "get",
            data: "fatherSeries=" + secondSeries+"&type=3&category=requiredcourse",
            dataType: "json",
            success: function (res) {
                var map = res.data;
                var option = '<option value=""></option>';
                // var option = '';
                for (var key in map) {
                    option += '<option value="' + key + '">' + map[key] + '</option>';
                }
                $("#thirdSeries").html(option);
            }
        });
    }
});










