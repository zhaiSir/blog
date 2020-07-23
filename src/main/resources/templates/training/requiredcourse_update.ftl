<#import "../common/simple-layout.ftl" as simpleLayout>
<#import "../common/common-macro.ftl" as commonMacro>
<@simpleLayout.layout pageTitle="必修课修改"   importJs=["js/training/requiredcourse_update.js","libs/jquery/jquery.form.js","src/js/global-configuration.js"]
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
        <form id="form-update" class="form-horizontal" action="${rc.contextPath}/requiredcourse/update" method="post">
            <input name="requiredCourseId" value="${(result.requiredCourseId)!}" type="hidden">
            <div class="form-group">
                <label class="control-label col-sm-4" for="">视频标题：<span class="spanMandatory mustdo">*</span></label>
                <div class="col-sm-18">
                    <input type="text" name="courseTitle" class="form-control" value="${(result.courseTitle)!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">所属一级专题系列：<span class="spanMandatory mustdo">*</span></label>
                <div class="col-sm-3">
                    <select name="firstSeries" id="firstSeries" class="form-control">
                        <option  value="" ></option>
                        <#if firstSeriesList??>
                            <#list firstSeriesList as fsl>
                                <option  value="${fsl[0]!}" <#if ("${(result.firstSeries)!}" == "${fsl[0]!}")>selected</#if>>${fsl[1]!}</option>
                            </#list>
                        </#if>
                    </select>
                    </select>
                </div>
                <label class="control-label col-sm-4" for="">所属二级专题系列：<span class="spanMandatory mustdo">*</span></label>
                <div class="col-sm-3">
                    <select name="secondSeries" id="secondSeries" class="form-control">
                        <option  value="" ></option>
                        <#if secondSeriesList??>
                            <#list secondSeriesList as ssl>
                                <option  value="${ssl['SERIESID']!}" <#if "${result.secondSeries!}" == "${ssl['SERIESID']!}">selected</#if>>
                                    ${ssl["NAME"]!}
                                </option>
                            </#list>
                        </#if>
                    </select>
                </div>
                <label class="control-label col-sm-4" for="">所属三级专题系列：<span class="spanMandatory mustdo">*</span></label>
                <div class="col-sm-3">
                    <select name="thirdSeries" id="thirdSeries" class="form-control">
                        <option  value="" ></option>
                        <#if thirdSeriesList??>
                            <#list thirdSeriesList as tsl>
                                <option  value="${tsl['SERIESID']!}" <#if "${result.thirdSeries!}" == "${tsl['SERIESID']!}">selected</#if>>
                                    ${tsl["NAME"]!}
                                </option>
                            </#list>
                        </#if>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">链接地址：<span class="spanMandatory mustdo">*</span></label>
                <div class="col-sm-18">
                    <input type="text" name="linkAdress" class="form-control" value="${(result.linkAdress)!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">开始时间：<span class="spanMandatory mustdo">*</span></label>
                <div class="col-sm-18">
                    <input type="text" id="beginTime" name="beginTime" class="form-control datePicker" value="${(result.beginTime)!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">结束时间：<span class="spanMandatory mustdo">*</span></label>
                <div class="col-sm-18">
                    <input type="text" id="endTime" name="endTime" class="form-control datePicker" value="${(result.endTime)!}">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="">描述：</label>
                <div class="col-sm-18">
                    <input type="text" name="description" class="form-control" value="${(result.description)!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">点赞总数：</label>
                <div class="col-sm-18">
                    <input type="text" name="praiseNumber" class="form-control" value="${(result.praiseNumber)!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">阅读总数：</label>
                <div class="col-sm-18">
                    <input type="text" name="readNumber" class="form-control" value="${(result.readNumber)!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="">收藏总数：</label>
                <div class="col-sm-18">
                    <input type="text" name="collectNumber" class="form-control" value="${(result.collectNumber)!}">
                </div>
            </div>

            <div class="form-group layer-footer">
                <div class="col-sm-offset-11 col-sm-16">
                    <button type="button" class="btn btn-tit btn-primary" onclick="submitForm()">确 定</button>
                    <button type="button" class="btn btn-tit btn-default" onclick="closeForm()" >取 消</button>
                </div>
            </div>
        </form>
    </div>
    <input id="contextPath" type="hidden" value="${rc.contextPath}"/>
</section>
</@simpleLayout.layout>
