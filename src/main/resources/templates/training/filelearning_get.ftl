<#import "../common/simple-layout.ftl" as simpleLayout>
<#import "../common/common-macro.ftl" as commonMacro>
<@simpleLayout.layout pageTitle="文件学习详情" importJs=["js/training/filelearning_get.js"] importCss=["styles/addcommon.css"]>
<section class="main">
<section class="main">
    <div class="container-fluid user-manage">
        <form id="form-get" class="form-horizontal" action="" method="post">
            <input name="fileLearningId" id="fileLearningId" value="${(result.fileLearningId)!}" type="hidden">
            <div class="form-group">
                <label class="control-label col-sm-4" for="">文件标题：</label>
                <div class="col-sm-18">
                    <input type="text" name="fileTitle" class="form-control" value="${(result.fileTitle)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">所属一级专题系列：</label>
                <div class="col-sm-18">
                    <input type="text" name="firstSeries" class="form-control" value="${(result.firstSeries)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">所属二级专题系列：</label>
                <div class="col-sm-18">
                    <input type="text" name="secondSeries" class="form-control" value="${(result.secondSeries)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">所属三级专题系列：</label>
                <div class="col-sm-18">
                    <input type="text" name="thirdSeries" class="form-control" value="${(result.thirdSeries)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">开始时间：</label>
                <div class="col-sm-18">
                    <input type="text" name="beginTime" class="form-control" value="${(result.beginTime)!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">结束时间：</label>
                <div class="col-sm-18">
                    <input type="text" name="endTime" class="form-control" value="${(result.endTime)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">文件内容：</label>
                <div class="col-sm-18">
                    ${(result.fileContent)!}
                </div>
                <#--<div class="col-sm-18">-->
                    <#--<input type="text" name="fileContent" class="form-control" value="${(result.fileContent)!}">-->
                <#--</div>-->
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">状态：</label>
                <div class="col-sm-18">
                    <select name="state" id="state"  class="form-control selectpicker "  value="${result.state!}"  disabled>
                        <option  <#if "${result.state!}"=="0">selected</#if>>未启用</option>
                        <option  <#if "${result.state!}"=="1">selected</#if>>待审核</option>
                        <option  <#if "${result.state!}"=="2">selected</#if>>已审核</option>
                        <option  <#if "${result.state!}"=="3">selected</#if>>已发布</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">是否置顶：</label>
                <div class="col-sm-18">
                    <select name="state" id="state"  class="form-control selectpicker "  value="${result.isTop!}"  disabled>
                        <option  <#if "${result.isTop!}"=="N">selected</#if>>未置顶</option>
                        <option  <#if "${result.isTop!}"=="Y">selected</#if>>已置顶</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">点赞总数：</label>
                <div class="col-sm-18">
                    <input type="text" name="praiseNumber" class="form-control" value="${(result.praiseNumber)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">阅读总数：</label>
                <div class="col-sm-18">
                    <input type="text" name="readNumber" class="form-control" value="${(result.readNumber)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">收藏总数：</label>
                <div class="col-sm-18">
                    <input type="text" name="collectNumber" class="form-control" value="${(result.collectNumber)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">启用时间：</label>
                <div class="col-sm-18">
                    <input type="text" name="startUsingTime" class="form-control" value="${(result.startUsingTime)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">启用人：</label>
                <div class="col-sm-18">
                    <input type="text" name="startUsingUser" class="form-control" value="${(result.startUsingUser)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">停用时间：</label>
                <div class="col-sm-18">
                    <input type="text" name="stopUsingTime" class="form-control" value="${(result.stopUsingTime)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">停用人：</label>
                <div class="col-sm-18">
                    <input type="text" name="stopUsingUser" class="form-control" value="${(result.stopUsingUser)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">审核时间：</label>
                <div class="col-sm-18">
                    <input type="text" name="auditTime" class="form-control" value="${(result.auditTime)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">审核人：</label>
                <div class="col-sm-18">
                    <input type="text" name="auditUser" class="form-control" value="${(result.auditUser)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">发布时间：</label>
                <div class="col-sm-18">
                    <input type="text" name="releaseTime" class="form-control" value="${(result.releaseTime)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">发布人：</label>
                <div class="col-sm-18">
                    <input type="text" name="releaseUser" class="form-control" value="${(result.releaseUser)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">创建者：</label>
                <div class="col-sm-18">
                    <input type="text" name="creator" class="form-control" value="${(result.creator)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">创建时间：</label>
                <div class="col-sm-18">
                    <input type="text" name="createTime" class="form-control" value="${(result.createTime)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">修改人：</label>
                <div class="col-sm-18">
                    <input type="text" name="modifiedBy" class="form-control" value="${(result.modifiedBy)!}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">修改时间：</label>
                <div class="col-sm-18">
                    <input type="text" name="modifyTime" class="form-control" value="${(result.modifyTime)!}" readonly>
                </div>
            </div>

           <#if auditing??>
            <div class="form-group layer-footer">
                <div class="col-sm-offset-10 col-sm-16">
                    <button type="button" class="btn btn-tit btn-primary" id="ThroughAuditing">通过审核</button>
                    <button type="button" class="btn btn-tit btn-default" id="refuseAuditing">拒绝审核</button>
                    <button type="button" class="btn btn-tit btn-default" onclick="closeForm()">取 消</button>
                </div>
            </div>
           <#else >
            <div class="form-group layer-footer">
                <div class="col-sm-offset-11 col-sm-20">
                    <button type="button" class="btn btn-tit btn-default" onclick="closeForm()">取 消</button>
                </div>
            </div>
           </#if>
        </form>
    </div>
    <input id="contextPath" type="hidden" value="${rc.contextPath}"/>
</section>
    <script src="${rc.contextPath}/libs/jquery/v1.12.4/jquery.min.js"></script>
</@simpleLayout.layout>
