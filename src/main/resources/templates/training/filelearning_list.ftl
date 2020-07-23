<#import "../common/global-layout.ftl" as global>
<#import "../common/common-macro.ftl" as common>
<@global.layout pageTitle="文件学习"  breadcrumb="<li>培训管理</li><li>文件学习</li>"
importJs=["js/training/filelearning_list.js"] importCss =["styles/receive.css","styles/tableCommon.css"]>
<section class="main">
    <div class="container-fluid bt-box">
        <form id="fileLearningForm" class="form-horizontal" action=""
              method="post" name="query-form">

            <div class="wlk-top">
                <div class="row form-qs">
                    <div class="pull-right"   style="white-space: nowrap">
                        <label class="text-right" for="">文件标题：</label>
                        <input name="fileTitle" class="sm" type="text" Style="width: 120px"
                               value="${fileLearningQo.fileTitle!}" placeholder="请输入">
                        <label class="text-right" for="">状态：</label>
                        <select name="state" id="state" value="${fileLearningQo.state!}" class="sm" Style="width: 120px">
                            <option  value=""></option>
                            <option  value="0">未启用</option>
                            <option  value="1">待审核</option>
                            <option  value="2">已审核</option>
                            <option  value="3">已发布</option>
                        </select>
                        <label class="text-right" for="">所属一级专题系列：</label>
                        <select name="firstSeries" id="firstSeries" value="${fileLearningQo.firstSeries!}" class="sm" Style="width: 120px">
                            <option  value=""></option>
                                         <#if firstSeriesList??>
                                             <#list firstSeriesList as fsl>
                                                    <option  value="${fsl[0]!}">${fsl[1]!}</option>
                                             </#list>
                                         </#if>
                        </select>
                        <label class="text-right" for="">所属二级专题系列：</label>
                        <select name="secondSeries" id="secondSeries" value="${fileLearningQo.secondSeries!}" class="sm" Style="width: 120px">
                        </select>
                        <label class="text-right" for="">所属三级专题系列：</label>
                        <select name="thirdSeries" id="thirdSeries" value="${fileLearningQo.thirdSeries!}" class="sm" Style="width: 120px">
                        </select>
                        <button id="data-query" class="btn btn-sm btn-submit bt-query">查询</button>
                        <button type="reset" id="data-reset" class="btn btn-sm btn-reset">重置</button>
                    </div>

                </div>
            </div>

            <div class="wlk-bottom">
                <!--数据操作-->
                <div class="query-operation hide">
                    <button type="button" href="${rc.contextPath}/filelearning/add" onclick="addNewOnclick()"
                            class="btn btn-xs btn-add">新增
                    </button>

                    <button type="button" href="${rc.contextPath}/filelearning/delete.json"
                            class="btn btn-xs btn-add btn-confirm" msg="确认删除？">删除
                    </button>
                    <button type="button" id="data-enable" class="btn btn-xs btn-add">启用</button>
                    <button type="button" id="data-disable" class="btn btn-xs btn-add">停用</button>
                </div>

                <!--查询结果-->
                <div class="query-result">
                    <table id="fileLearningTable" class="bt-table" unique-id="fileLearningId"
                           url="${rc.contextPath}/filelearning/list.json">
                        <thead>
                        <tr class="hide">
                            <th field="checkbox" width="5%" checkbox="true"><input type="checkbox"></th>
                            <th field="fileTitle">文件标题</th>
                            <th field="firstSeries">所属一级专题系列</th>
                            <th field="secondSeries">所属二级专题系列</th>
                            <th field="thirdSeries">所属三级专题系列</th>
                            <th field="beginTime">开始时间</th>
                            <th field="endTime">结束时间</th>
                            <th field="state"  formatter="revertState">状态</th>
                            <th field="isTop"  formatter="istop">置顶</th>
                            <th field="praiseNumber">点赞总数</th>
                            <th field="readNumber">阅读总数</th>
                            <th field="collectNumber">收藏总数</th>
                            <th field="state" class="min-width150" width="15%" formatter="operation">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </form>
    </div>

<#--<!--选择机构弹出框&ndash;&gt;background-color: rgb(46, 141, 237);-->
<#--color: rgb(255, 255, 255);-->
<#--border-color: rgb(72, 152, 213);-->
    <div id="selectOrg" style="display:none;/*height:550px; none;*/">
        <button type="button" id="checkAllTrue" onclick="checkAll()" class="btn btn-sm" style="width:62px;height:25px;background-color: rgb(46, 141, 237);color: rgb(255, 255, 255);margin-top: 3px">全选</button>
        <button type="button" id="checkAllFalse" onclick="checkNone()" class="btn btn-sm" style="width:62px;height:25px;background-color: rgb(46, 141, 237);color: rgb(255, 255, 255);margin-left: 15px">全不选</button>
        <div class="authority" style="margin-top: 3px">
            <input type="text" name="orgName" class="hide">
            <div class="col-sm-18">
                <div class="wid_con_text clearfix">
                    <div class="tree_content clearfix" style="width:390px;height:400px; overflow:auto;">
                        <ul id="selectOrgTree" class="ztree first_tree clearfix">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
<#--点击选择机构时赋值-->
    <input id="relationId" type="hidden"/>
    <input id="contextPath" type="hidden" value="${rc.contextPath}"/>
</section>
<script>
    function operation(value,row,index) {
        var modifyUpdate;
        var advertisingAuditUpdate;
        var releaseUpdate;
        var delUpdate;

        //状态确定样式
        if ("1" == value){
            releaseUpdate='stopA';
            modifyUpdate='stopA';
            delUpdate='stopA';
        }else if ("2" == value){
            advertisingAuditUpdate='stopA';
            modifyUpdate='stopA';
            delUpdate='stopA';
        }else if ("3" == value) {
            advertisingAuditUpdate = 'stopA';
            modifyUpdate = 'stopA';
            releaseUpdate = 'stopA';
            delUpdate = 'stopA';
        }else if ("0" == value){
            advertisingAuditUpdate = 'stopA';
            releaseUpdate = 'stopA';
        }

        var detail = '<a href="#" class="get-dialog" dialog-title="详情">详情</a>&nbsp;&nbsp;';
        var modify = modifyUpdate == 'stopA'?'<span style="pointer-events: none">修改</span>&nbsp;&nbsp;':'<a href="#" class="update-dialog" dialog-title="修改">修改</a>&nbsp;&nbsp;';
        var advertisingAudit = advertisingAuditUpdate == 'stopA'?'<span style="pointer-events: none">审核</span>&nbsp;&nbsp;':'<a href="#" id="audit"  dialog-title="审核">审核</a>&nbsp;&nbsp;';
        var release =releaseUpdate == 'stopA'? '<span style="pointer-events: none">发布</span>&nbsp;&nbsp;':'<a href="#" id="release" dialog-title="发布">发布</a>&nbsp;&nbsp;';
        var del =delUpdate == 'stopA'? '<span style="pointer-events: none">删除</span>&nbsp;&nbsp;':'<a href="' + rootPath + '/filelearning/delete.json" class="a-confirm" msg="确认删除？">删除</a>&nbsp;&nbsp;';
        var orgSelect = '<a href="javascript:void(0);" class="get-org" >机构选择</a>&nbsp;&nbsp;';
        var readerList = '<a href="#"  class="get-whitelist">名单查看</a>&nbsp;&nbsp;';

        return detail + modify+orgSelect+readerList+advertisingAudit+release+ del;
    }
</script>
</@global.layout>
