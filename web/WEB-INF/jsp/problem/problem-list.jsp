<%--
  Created by IntelliJ IDEA.
  User: xanarry
  Date: 17-12-27
  Time: 下午10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
<head>
    <title>题目列表</title>
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/font-awesome.css">
    <link rel="stylesheet" href="/css/oj.css">

    <script src="/js/jquery-3.2.1.min.js"></script>
    <script src="/js/bootstrap/popper.min.js"></script>
    <script src="/js/bootstrap/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp"/>
<div class="container custom-container">
    <h4>${tableTitle}</h4>
    <div class="card">
        <table class="table table-striped text-center" style="margin-bottom: 0rem;">
            <thead>
            <tr>
                <c:if test="${not empty cookie.get('userID')}">
                    <th>状态</th>
                </c:if>
                <th>题号</th>
                <th>题目名称</th>
                <th>通过(人)/提交(次)</th>
                <th>日期</th>
                <c:if test="${not empty cookie.get('userType') and cookie.get('userType').value > 0}">
                    <th>操作</th>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${problemList}" var="problem">
                <tr>
                    <c:if test="${not empty cookie.get('userID')}">
                        <c:choose>
                            <c:when test="${problem.result == 'Accepted'}">
                                <td><span class="badge badge-success"><i class="fa fa-check"></i></span></td>
                            </c:when>
                            <c:otherwise>
                                <td><span class="badge badge-secondary"></span></td>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <td><a href="problem?problemID=${problem.problemID}">${1000 + problem.problemID}</a></td>
                    <td><a href="problem?problemID=${problem.problemID}">${problem.title}</td>
                    <td>${problem.accepted}/${problem.submitted}</td>
                    <jsp:useBean id="createTime" class="java.util.Date"/>
                    <c:set target="${createTime}" property="time" value="${problem.createTime}"/>
                    <td><fmt:formatDate pattern="yyyy/MM/dd" value="${createTime}"/></td>
                    <c:if test="${not empty cookie.get('userType') and cookie.get('userType').value > 0}">
                        <td>
                            <a href="/record-list?problemID=${problem.problemID}"><span
                                    class="badge badge-light">记录</span></a>
                            <a href="/test-point-list?problemID=${problem.problemID}"><span
                                    class="badge badge-secondary">数据</span></a>
                            <a href="/problem-edit?problemID=${problem.problemID}"><span
                                    class="badge badge-primary">编辑</span></a>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <br>
    <c:if test="${not empty pageInfo}">
        <jsp:include page="/WEB-INF/jsp/pagination.jsp"/>
    </c:if>
    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>
