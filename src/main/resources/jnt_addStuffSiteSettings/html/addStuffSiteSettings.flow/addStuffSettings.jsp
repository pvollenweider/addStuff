<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="flowExecutionUrl" type="java.lang.String"--%>
<%--@elvariable id="siteNode" type="org.jahia.services.content.decorator.JCRSiteNode"--%>

<template:addResources type="javascript" resources="jquery.min.js,admin-bootstrap.js"/>
<template:addResources type="css" resources="admin-bootstrap.css"/>

<div class="page-header">
    <h2><fmt:message key="addstuff.siteSettings.title"/></h2>
</div>
<p><fmt:message key="addstuff.siteSettings.description"/></p>

<form action="${flowExecutionUrl}" method="post">
    <input type="hidden" name="_eventId" id="addStuffFormAction"/>

    <fieldset>
        <div class="container-fluid">

            <div class="row-fluid">
                <div class="span12">
                    <label for="addStuffHeadTop"><fmt:message key="jmix_addStuff.addStuffHeadTop"/></label>
                    <p class="help-block"><fmt:message key="addstuff.siteSettings.headTop.help"/></p>
                    <c:set var="addStuffHeadTop" value="${siteNode.properties['addStuffHeadTop']}"/>
                    <textarea name="addStuffHeadTop" id="addStuffHeadTop" rows="5" class="span12">${fn:escapeXml(addStuffHeadTop)}</textarea>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <label for="addStuffHead"><fmt:message key="jmix_addStuff.addStuffHead"/></label>
                    <p class="help-block"><fmt:message key="addstuff.siteSettings.head.help"/></p>
                    <c:set var="addStuffHead" value="${siteNode.properties['addStuffHead']}"/>
                    <textarea name="addStuffHead" id="addStuffHead" rows="5" class="span12">${fn:escapeXml(addStuffHead)}</textarea>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <label for="addStuffBodyTop"><fmt:message key="jmix_addStuff.addStuffBodyTop"/></label>
                    <p class="help-block"><fmt:message key="addstuff.siteSettings.bodyTop.help"/></p>
                    <c:set var="addStuffBodyTop" value="${siteNode.properties['addStuffBodyTop']}"/>
                    <textarea name="addStuffBodyTop" id="addStuffBodyTop" rows="5" class="span12">${fn:escapeXml(addStuffBodyTop)}</textarea>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <label for="addStuffBody"><fmt:message key="jmix_addStuff.addStuffBody"/></label>
                    <p class="help-block"><fmt:message key="addstuff.siteSettings.body.help"/></p>
                    <c:set var="addStuffBody" value="${siteNode.properties['addStuffBody']}"/>
                    <textarea name="addStuffBody" id="addStuffBody" rows="5" class="span12">${fn:escapeXml(addStuffBody)}</textarea>
                </div>
            </div>

        </div>
    </fieldset>

    <fieldset>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <button class="btn btn-primary" onclick="$('#addStuffFormAction').val('save'); return true;">
                        <fmt:message key="label.save"/>
                    </button>
                    <button class="btn" onclick="$('#addStuffFormAction').val('cancel'); return true;">
                        <fmt:message key="label.cancel"/>
                    </button>
                </div>
            </div>
        </div>
    </fieldset>

</form>
