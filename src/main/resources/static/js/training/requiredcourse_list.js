var rootPath=$("#contextPath").val();

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


function revertState(res) {
    if (res == 0){
        return "未启用";
    }else if(res == 1){
        return "待审核";
    }else if(res == 2){
        return "已审核";
    }else if(res == 3){
        return "已发布";
    }
}

function istop(res) {
    var sss="置顶";
    if (res == "Y"){
        sss="取消置顶";
    }
    var top = '<a href="#" class="update-top">'+sss+'</a>&nbsp;&nbsp;';
    return top;
}

/**点击置顶*/
$("#requiredCourseForm").on("click",".update-top",function () {
    var me = $(this);
    //获取id
    var id = me.closest("tr").data("uniqueid");
    //改变是否是置顶的
    $.ajaxSetup({cache:false});
    $.ajax({
        url:rootPath+"/requiredcourse/updateTop",
        type:"get",
        dataType:"json",
        data:"requiredCourseId="+id,
        success:function (edc) {
            if(edc.state == -1){
                layer.alert(edc.message);
            }else{
                window.open(rootPath+"/requiredcourse/list","_self");
            }
        }
    });
});

/**发布*/
$("#requiredCourseForm").on("click","#release",function () {

    var me = $(this);
    var id = me.closest("tr").data("uniqueid");

    if (confirm("是否发布")){
        $.ajaxSetup({cache:false});
        $.ajax({
            type:"post",
            data:"requiredCourseId="+id,
            url:rootPath+"/requiredcourse/release",
            dataType:"json",
            success:function (resultJson) {
                if (resultJson.state == 0){
                    layer.alert(resultJson.message);
                }else {
                    location.reload(true);
                }

            }
        });
    }
});

/**审核*/
$("#requiredCourseForm").on("click","#audit",function () {
    var me = $(this);
    var id = me.closest("tr").data("uniqueid");

        $.ajax({
            type:"post",
            data:"requiredCourseId="+id,
            url:rootPath+"/requiredcourse/ableAudit",
            dataType:"json",
            success:function (res) {

                if (res == 1){
                    window.open(rootPath+"/requiredcourse/get?requiredCourseId="+id+"&getIs=audit");
                }else {
                    layer.alert("不满足审核条件！");
                }

            }
        });

});

/** 停用按钮 */
$(".bt-box").on("click","#data-disable",function (e) {
    e.preventDefault();
    e.stopPropagation();
    var me=$(this);
    var selectIds = WELKIN.bt.getSelectionIds(this);
    if (selectIds.length == 0){
        layer.alert("至少选择一条数据");
    }else if (selectIds.length > 1){
        layer.alert("请选择一条数据");
    }else if (selectIds.length == 1){

        if (confirm("是否停用")){

            $.ajax({
                type:"post",
                data:"requiredCourseId="+selectIds,
                url:rootPath+"/requiredcourse/disenable",
                dataType:"json",
                success:function (resultJson) {
                    if (resultJson.state == 0){
                        layer.alert(resultJson.message);
                    }else {
                        location.reload(true);
                    }

                }
            });
        }
    }
});

/** 启用按钮 */
$(".bt-box").on("click","#data-enable",function (e) {
    e.preventDefault();
    e.stopPropagation();
    var me=$(this);
    var selectIds = WELKIN.bt.getSelectionIds(this);
    if (selectIds.length == 0){
        layer.alert("至少选择一条数据");
    }else if (selectIds.length > 1){
        layer.alert("请选择一条数据");
    }else if (selectIds.length == 1){
        if (confirm("是否启用")){
            $.ajax({
                type:"post",
                data:"requiredCourseId="+selectIds,
                url:rootPath+"/requiredcourse/enable",
                dataType:"json",
                success:function (resultJson) {
                    if (resultJson.state == 0){
                        layer.alert(resultJson.message);
                    }else {
                        location.reload(true);
                    }

                }
            });
        }
    }
});

/**跳转修改页面*/
$("#requiredCourseForm").on("click",".update-dialog",function () {
    var me = $(this);
    var href = rootPath + "/requiredcourse/update";
    var btTable = $("#"+WELKIN.getComponentTableId(this));
    var uniqueId = btTable.bootstrapTable('getOptions').uniqueId;
    var id = me.closest("tr").data("uniqueid");
    var paramStr = uniqueId+"="+id;
    $.ajax({
        type:"post",
        data:"requiredCourseId="+id,
        url:rootPath+"/requiredcourse/isupdate",
        dataType:"json",
        success:function (resultJson) {
            if (resultJson.state == 0){
                layer.alert(resultJson.message);
            }else {
                window.open(href+"?"+paramStr);
            }

        }
    });

});

//点击进入详情页面
$("#requiredCourseForm").on("click",".get-dialog",function () {
    var me = $(this);
    var href = rootPath + "/requiredcourse/get";
    var btTable = $("#"+WELKIN.getComponentTableId(this));
    var uniqueId = btTable.bootstrapTable('getOptions').uniqueId;
    var id = me.closest("tr").data("uniqueid");
    var paramStr = uniqueId+"="+id;
    window.open(href+"?"+paramStr);
    // WELKIN.openDialog(title, href, paramStr, {}, me);
});

//点击新增按钮弹出新的页面
function addNewOnclick() {
    window.open(rootPath+"/requiredcourse/add");
}

//点击名单查看按钮弹出新的页面
$("#requiredCourseForm").on("click",".get-whitelist",function () {
    var me = $(this);
    var id = me.closest("tr").data("uniqueid");
    window.open(rootPath + "/viewwhitelist/list?relationId="+id+"&category=requiredcourse");
});


//机构选择
$("#requiredCourseForm").on("click",".get-org",function () {
    var me = $(this);
    var relationId = me.closest("tr").data("uniqueid");
    $("#relationId").val(relationId);
    // if (firstInit) {
        selectOrgTree = $.fn.zTree.init($('#selectOrgTree'), orgTreeOption);
    // } else {
    //     selectOrgTree.reAsyncChildNodes(null, "refresh");
    // }
    layer.open({
        type: 1,
        title: '机构选择',
        area: ['400px','550px'],
        content: $('#selectOrg'), btn : [ '确定', '关闭' ],
        yes: function (index) {
            var organizationIds ="";
            var datas = selectOrgTree.getCheckedNodes();
            for (var i = 0; i < datas.length; i++) {
                    if (datas[i].organizationId) {
                        organizationIds+=datas[i].organizationId+",";
                    }
            }
            // alert(organizationIds);
            showLoadMask();
            $.ajax({
                url : rootPath + "/viewwhitelist/selectOrg/add.json",
                data : {
                    relationId : relationId,
                    organizationIds:organizationIds,
                    category:"requiredcourse",
                },
                type : "post",
                async : false,
                traditional : true,
                success : function (data) {
                    if (data.success) {
                        hideLoadMask();
                        layer.msg('更新成功！', {
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        });
                        layer.close(index);
                    } else {
                        hideLoadMask();
                        layer.msg(data.message);
                    }
                }
            });
        },
        btn2: function (index) {
            $('#selectOrg').attr('style','display: none')
            layer.close(index);
        }
    })
});

/*机构树的初始化和设置*/
// var firstInit = true;
var selectOrgTree;
var orgTreeOption = {
    async: {
        enable: true,
        // url: rootPath + "/usercontroller/getorgnode.json",       //老OA机构组织
        //url: rootPath + "/organization/orgtree.json",          //hoop带权限所有可用机构组织
        url: rootPath + "/orgunit/orgtree.json",               //hoop不带权限所有可用机构组织，去掉网点支行
        dataFilter: function (treeId, parentNode, responseData) {
            //将返回的数据进行组装，添加所需要的属性
            return initTreeData(responseData.result);
        }
    },
    view: {
        dblClickExpand: true,
        selectedMulti: true,
        expandSpeed: "fast"
    }, check: {
        chkboxType: {"Y": "", "N": ""},
        chkStyle: "checkbox",
        enable: true
    }, data: {
        key: {
            name: "orgName", //设置树节点的name，节点参数name必须和它匹配
            children: "children"
        }, simpleData: {
            enable: true, //开启树的层级结构
            idKey: "organizationId",
            pIdKey: "parentId"
        }
    }, listeners: {
        "click": function (event, treeId, treeNode) {
        }
    }, callback: {
        onClick: function (event, treeId, treeNode) {
        },
        onRightClick: function (event, treeId, treeNode) {
        },
        onAsyncSuccess: function () {
            //异步请求完成后 是否展开所有
            selectOrgTree.expandAll(true);
            // if (firstInit) {
            //     firstInit = false;
            // }
            initTreeCheck();
        }
    }
}

//初始化树数据
initTreeData = function (datas) {
    if (datas && datas.length > 0) {
        for (var i = 0; i < datas.length; i++) {
            processData(datas[i]);
        }
    }
    return datas;
};

function processData(data) {
    if (!data.childrenVo) {
        data.childrenVo = [];
    }
    var children = data.childrenVo;
    initTreeData(children);
}

/*权限树勾选初始化*/
initTreeCheck = function (url, ztree) {
    var relationId= $("#relationId").val();
    var none = false;
    var _tree = ztree;
    if (!url) {
        url = rootPath + "/viewwhitelist/selectOrg/get.json";
    }
    if (!ztree) {
        _tree = selectOrgTree;
    }
    _tree.checkAllNodes(false);

    //获取当前点击大讲堂已选机构
    $.ajax({
        url: url,
        data: {
            relationId: relationId
        },
        type: "post",
        async: false,
        success: function (data) {
            var result = data.result;
            if (data.success) {
                if (result) {
                    //result  为  String
                    if (data.result.length < 1) {
                        none = true;
                    }
                    var result = result.split(",");
                    for (var j = 0; j < result.length; j++) {
                        var id = result[j];
                        var nodes = _tree.getNodesByParam("organizationId", id);

                        //通过id找到对应的节点
                        for (var i = 0; i < nodes.length; i++) {
                            if (!nodes[i].checked) {
                                _tree.checkNode(nodes[i], true);
                                //选中父的操作
                                // var parent = nodes[i].getParentNode();
                                // if (parent && !parent.checked) {
                                //     _tree.checkNode(parent, true);
                                // }
                            }
                        }
                        // _tree.checkNode(_tree.getNodeByParam("root", true), true);
                    }
                }
            }
        },
        error: function (data) {
        }
    });
    return none;
};

//全选
function checkAll(){
    // layer.confirm( '确认全选？', {
    //     icon: 3,
    //     btn:['确定','取消']
    // }, function (index) {
        selectOrgTree.checkAllNodes(true);
    //     layer.close(index);
    // });
}

//全不选
function checkNone(){
    // layer.confirm( '确认全不选？', {
    //     icon: 3,
    //     btn:['确定','取消']
    // }, function (index) {
        selectOrgTree.checkAllNodes(false);
    //     layer.close(index);
    // });
}
