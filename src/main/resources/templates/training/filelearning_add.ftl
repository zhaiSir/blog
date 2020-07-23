<#import "../common/simple-layout.ftl" as simpleLayout>
<#import "../common/common-macro.ftl" as commonMacro>
<@simpleLayout.layout pageTitle="新增文件学习" importJs=["js/training/filelearning_add.js","libs/jquery/jquery.form.js",
"js/text/ueditor/ueditor.config.js","js/text/ueditor/ueditor.all.min.js","js/text/ueditor/ueditor.parse.js",
"js/text/ueditor/lang/zh-cn/zh-cn.js","src/js/global-configuration.js"]
importCss=["js/text/ueditor/themes/default/css/ueditor.css","styles/addcommon.css"]>
<style type="text/css">
    .spanMandatory{
        color: #ff0000;
        font-size: 18px;
    }
    .spanCue{
        color: #ff0000;
        font-size: 10px;
    }
</style>
<section class="main">
    <div class="container-fluid user-manage">
        <form id="form-add" class="form-horizontal" action="${rc.contextPath}/filelearning/add" method="post">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="">文件标题：<span class="spanMandatory">*</span></label>
                    <div class="col-sm-18">
                        <input type="text" name="fileTitle" class="form-control" value="${(result.fileTitle)!}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="">所属一级专题系列：<span class="spanMandatory mustdo">*</span></label>
                    <div class="col-sm-3">
                        <select name="firstSeries" id="firstSeries" class="form-control">
                            <option  value=""></option>
                             <#if firstSeriesList??>
                                 <#list firstSeriesList as fsl>
                                        <option  value="${fsl[0]!}">${fsl[1]!}</option>
                                 </#list>
                             </#if>
                        </select>
                    </div>
                    <label class="control-label col-sm-4" for="">所属二级专题系列：<span class="spanMandatory mustdo">*</span></label>
                    <div class="col-sm-3">
                        <select name="secondSeries" id="secondSeries" class="form-control">
                        </select>
                    </div>
                    <label class="control-label col-sm-4" for="">所属三级专题系列：<span class="spanMandatory mustdo">*</span></label>
                    <div class="col-sm-3">
                        <select name="thirdSeries" id="thirdSeries" class="form-control">
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="">开始时间：<span class="spanMandatory">*</span></label>
                    <div class="col-sm-18">
                        <input type="text" id="beginTime" name="beginTime" class="form-control datePicker" value="${(result.beginTime)!}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="">结束时间：<span class="spanMandatory">*</span></label>
                    <div class="col-sm-18">
                        <input type="text" id="endTime" name="endTime" class="form-control datePicker" value="${(result.endTime)!}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="">文件内容：<span class="spanMandatory">*</span></label>
                    <div class="col-sm-18">
                        <script id="fileContent"  name="fileContent" type="text/plain">
                        </script>
                    </div>
                </div>

            <div class="form-group layer-footer">
                <div class="col-sm-offset-10 col-sm-16">
                    <button id="sureButt" type="submit" class="btn btn-tit btn-primary" onclick="submitForm()">确 定</button>
                    <button type="button" class="btn btn-tit btn-default" onclick="closeForm()" >取 消</button>
                </div>
            </div>
        </form>
    </div>
    <input id="contextPath" type="hidden" value="${rc.contextPath}"/>
</section>
</@simpleLayout.layout>
