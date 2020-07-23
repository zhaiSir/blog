<#import "../common/simple-layout.ftl" as simpleLayout>
<#import "../common/common-macro.ftl" as commonMacro>
<@simpleLayout.layout pageTitle="新增必修课" importJs=["js/training/requiredcourse_add.js","libs/jquery/jquery.form.js"]
importCss=["styles/addcommon.css"]>
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
        <form id="form-add" class="form-horizontal" <#--action="${rc.contextPath}/requiredcourse/add" method="post"-->>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="">课件标题：<span class="spanMandatory">*</span></label>
                    <div class="col-sm-18">
                        <input type="text" name="courseTitle" class="form-control" value="${(result.courseTitle)!}">
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
                    <label class="control-label col-sm-4" for="">链接地址：<span class="spanMandatory">*</span></label>
                    <div class="col-sm-18">
                        <input type="text" name="linkAdress" class="form-control" value="${(result.linkAdress)!}">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="">开始时间：<span class="spanMandatory">*</span></label>
                    <div class="col-sm-18">
                        <input type="text" id="beginTime" name="beginTime" class="form-control datePicker">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="">结束时间：<span class="spanMandatory">*</span></label>
                    <div class="col-sm-18">
                        <input type="text" id="endTime" name="endTime" class="form-control datePicker">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="">描述：</label>
                    <div class="col-sm-18">
                        <input type="text" name="description" class="form-control" value="${(result.description)!}">
                    </div>
                </div>

            <div class="form-group layer-footer">
                <div class="col-sm-offset-10 col-sm-16">
                    <#--<button type="submit" class="btn btn-primary"">确 定</button>-->
                    <button id="sureButt" type="submit" class="btn btn-tit btn-primary" onclick="submitForm()">确 定</button>
                    <button type="button" class="btn btn-tit btn-default" onclick="closeForm()" >取 消</button>
                </div>
            </div>
        </form>
    </div>
    <input id="contextPath" type="hidden" value="${rc.contextPath}"/>
</section>
</@simpleLayout.layout>
