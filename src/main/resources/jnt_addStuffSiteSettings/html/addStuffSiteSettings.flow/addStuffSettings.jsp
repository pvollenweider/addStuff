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

<c:set var="cmBase" value="${pageContext.request.contextPath}/modules/addstuff/javascript/codemirror"/>

<template:addResources type="javascript" resources="jquery.min.js,admin-bootstrap.js"/>
<template:addResources type="css" resources="admin-bootstrap.css"/>

<link rel="stylesheet" href="${cmBase}/codemirror.min.css"/>
<script src="${cmBase}/codemirror.min.js"></script>
<script src="${cmBase}/mode/xml/xml.min.js"></script>
<script src="${cmBase}/mode/javascript/javascript.min.js"></script>
<script src="${cmBase}/mode/css/css.min.js"></script>
<script src="${cmBase}/mode/htmlmixed/htmlmixed.min.js"></script>

<style>
    .addstuff-section {
        border: 1px solid #ddd;
        border-radius: 4px;
        margin-bottom: 24px;
        overflow: hidden;
    }
    .addstuff-section-header {
        font-family: monospace;
        font-size: 13px;
        font-weight: bold;
        padding: 8px 14px;
        background-color: #e8f0fe;
        border-bottom: 1px solid #c5d4f5;
        color: #2c5282;
    }
    .addstuff-section-header.body {
        background-color: #e6f4ea;
        border-bottom-color: #b7dfc0;
        color: #276534;
    }
    .addstuff-section-body {
        padding: 16px;
        background-color: #f5f5f5;
    }
    .addstuff-field label {
        font-family: monospace;
        font-size: 13px;
        font-weight: bold;
        color: #333;
        margin-bottom: 2px;
        display: block;
    }
    .addstuff-field .help-block {
        font-size: 11px;
        color: #aaa;
        margin: 2px 0 8px 0;
    }
    .CodeMirror {
        height: 140px;
        border-radius: 3px;
        font-size: 12px;
    }
</style>

<div class="page-header">
    <h2><fmt:message key="addstuff.siteSettings.title"/></h2>
</div>
<p class="text-muted"><fmt:message key="addstuff.siteSettings.description"/></p>

<form action="${flowExecutionUrl}" method="post" id="addStuffForm">
    <input type="hidden" name="_eventId" id="addStuffFormAction"/>

    <%-- Hidden textareas used as form fields; CodeMirror syncs to them on submit --%>
    <textarea name="addStuffHeadTop" id="addStuffHeadTop" style="display:none">${fn:escapeXml(siteNode.properties['addStuffHeadTop'])}</textarea>
    <textarea name="addStuffHead"    id="addStuffHead"    style="display:none">${fn:escapeXml(siteNode.properties['addStuffHead'])}</textarea>
    <textarea name="addStuffBodyTop" id="addStuffBodyTop" style="display:none">${fn:escapeXml(siteNode.properties['addStuffBodyTop'])}</textarea>
    <textarea name="addStuffBody"    id="addStuffBody"    style="display:none">${fn:escapeXml(siteNode.properties['addStuffBody'])}</textarea>

    <div class="container-fluid">

        <%-- HEAD section --%>
        <div class="addstuff-section">
            <div class="addstuff-section-header">&lt;head&gt;</div>
            <div class="addstuff-section-body">
                <div class="row-fluid">
                    <div class="span6 addstuff-field">
                        <fmt:message key="jmix_addStuff.addStuffHeadTop" var="labelHeadTop"/>
                        <label><c:out value="${labelHeadTop}"/></label>
                        <p class="help-block"><fmt:message key="addstuff.siteSettings.headTop.help"/></p>
                        <div id="cm-addStuffHeadTop"></div>
                    </div>
                    <div class="span6 addstuff-field">
                        <fmt:message key="jmix_addStuff.addStuffHead" var="labelHead"/>
                        <label><c:out value="${labelHead}"/></label>
                        <p class="help-block"><fmt:message key="addstuff.siteSettings.head.help"/></p>
                        <div id="cm-addStuffHead"></div>
                    </div>
                </div>
            </div>
        </div>

        <%-- BODY section --%>
        <div class="addstuff-section">
            <div class="addstuff-section-header body">&lt;body&gt;</div>
            <div class="addstuff-section-body">
                <div class="row-fluid">
                    <div class="span6 addstuff-field">
                        <fmt:message key="jmix_addStuff.addStuffBodyTop" var="labelBodyTop"/>
                        <label><c:out value="${labelBodyTop}"/></label>
                        <p class="help-block"><fmt:message key="addstuff.siteSettings.bodyTop.help"/></p>
                        <div id="cm-addStuffBodyTop"></div>
                    </div>
                    <div class="span6 addstuff-field">
                        <fmt:message key="jmix_addStuff.addStuffBody" var="labelBody"/>
                        <label><c:out value="${labelBody}"/></label>
                        <p class="help-block"><fmt:message key="addstuff.siteSettings.body.help"/></p>
                        <div id="cm-addStuffBody"></div>
                    </div>
                </div>
            </div>
        </div>

        <%-- Actions --%>
        <div class="row-fluid" style="margin-top: 8px;">
            <div class="span12">
                <button class="btn btn-primary" id="btnSave">
                    <fmt:message key="label.save"/>
                </button>
                <button class="btn" id="btnCancel">
                    <fmt:message key="label.cancel"/>
                </button>
            </div>
        </div>

    </div>
</form>

<script>
(function () {
    var cmOptions = {
        mode: 'htmlmixed',
        theme: 'default',
        lineNumbers: true,
        lineWrapping: true,
        indentWithTabs: false,
        tabSize: 2
    };

    var fields = ['addStuffHeadTop', 'addStuffHead', 'addStuffBodyTop', 'addStuffBody'];
    var editors = {};

    fields.forEach(function (id) {
        var textarea = document.getElementById(id);
        var container = document.getElementById('cm-' + id);
        var editor = CodeMirror(container, $.extend({}, cmOptions, {
            value: textarea.value
        }));
        editors[id] = editor;
    });

    document.getElementById('btnSave').addEventListener('click', function () {
        fields.forEach(function (id) {
            document.getElementById(id).value = editors[id].getValue();
        });
        document.getElementById('addStuffFormAction').value = 'save';
        document.getElementById('addStuffForm').submit();
    });

    document.getElementById('btnCancel').addEventListener('click', function () {
        document.getElementById('addStuffFormAction').value = 'cancel';
        document.getElementById('addStuffForm').submit();
    });
}());
</script>
