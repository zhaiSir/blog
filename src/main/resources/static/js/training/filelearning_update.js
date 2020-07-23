
var rootPath=$("#contextPath").val();

$(function () {

    //实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    editor = UE.getEditor('fileContent', {
        elementPathEnabled: false,
        toolbars: [[
            'fullscreen', 'source', '|', 'undo', 'redo', '|',
            'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', '|',
            'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|',
            'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
            'customstyle', 'paragraph','fontsize', '|',  //,'fontfamily'
            'link', 'unlink', '|', 'touppercase', 'tolowercase', '|', 'indent', '|',
            'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
            'horizontal', 'date', 'time', 'spechars', '|',
            'simpleupload', 'insertimage','attachment', '|',
            'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
            'print', 'preview', 'searchreplace'
        ]],
        initialFrameWidth:null,
        initialFrameHeight: 550,
        wordCount:false,
        initialStyle:'body{font-family:仿宋}',
        retainOnlyLabelPasted: true
    });

    editor.ready(function () {
        editor.execCommand('fontfamily','仿宋');
    })

    $('#form-update').bootstrapValidator({
        container:"tooltip",
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            fileTitle: {
                validators: {
                    notEmpty: {
                        message: '文件标题不能为空'
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
            fileContent: {
                validators: {
                    notEmpty: {
                        message: '文件内容不能为空'
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
            url:rootPath+"/filelearning/update",
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
            data:"fatherSeries="+firstSeries+"&type=2&category=filelearning",
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
            data: "fatherSeries=" + secondSeries+"&type=3&category=filelearning",
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










