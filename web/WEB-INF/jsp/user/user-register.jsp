<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: xanarry
  Date: 17-12-28
  Time: 上午10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/oj.css">

    <script src="/js/jquery-3.2.1.min.js"></script>
    <script src="/js/bootstrap/popper.min.js"></script>
    <script src="/js/bootstrap/bootstrap.min.js"></script>
    <script src="/js/oj.js"></script>

    <script language="JavaScript">
        function checkRegisterInfo() {
            var userName = $("#inputUserName").val();
            var email = $("#inputEmail").val();
            var password = $("#inputPassword").val();
            var confirmPassword = $("#inputConfirmPassword").val();


            var userNameTip = $("#userNameTip");
            var emailTip    = $("#emailTip");
            var passwordTip = $("#passwordTip");
            var confirmPasswordTip = $("#confirmPasswordTip");

            var isOk = 0;

            if (userName.length == 0) {
                userNameTip.html("用户名不能为空");
                userNameTip.show();
                isOk++;
            } else if (userName.toString().indexOf(">") != -1 || userName.toString().indexOf("<") != -1){
                userNameTip.html("用户名含有非法字符");
                userNameTip.show();
            } else {
                userNameTip.hide();
            }

            if (verifyemail(email) == false) {
                emailTip.html("邮箱地址不合法");
                emailTip.show();
                isOk++;
            } else {
                emailTip.hide();
            }

            if (password.length < 6) {
                passwordTip.html("密码长度不能小于6");
                passwordTip.show();
                isOk++;
            } else {
                passwordTip.hide();
            }

            if (password != confirmPassword) {
                confirmPasswordTip.html("两次输入的密码不匹配");
                confirmPasswordTip.show();
                isOk++;
            } else {
                confirmPasswordTip.hide();
            }

            console.log("ok:" + isOk);
            if (isOk == 0)
                $.ajax({
                    type: 'POST',
                    url: "/ajax-check-register-info",
                    data: {
                        inputUserName: userName,
                        inputEmail: email
                    },
                    dataType: "json",
                    success: function (data) {
                        console.log(JSON.stringify(data));
                        var flag = 0;
                        if (data.userNameExist == true) {
                            userNameTip.html("用户名已经存在");
                            userNameTip.show();
                            flag++;
                        } else {
                            userNameTip.hide();
                        }

                        if (data.emailExist == true) {
                            emailTip.html("该邮箱已经注册");
                            emailTip.show();
                            flag++;
                        } else {
                            emailTip.hide();
                        }

                        if (flag == 0) {
                            $("#registerForm").submit();
                        }

                    },

                    error: function (data) {
                        alert("ajax error occured!");
                    }
                });
        }
    </script>
</head>

<body>
<jsp:include page="/WEB-INF/jsp/navbar.jsp"/>
<div class="container custom-container">
    <div class="card-body">
        <div class="text-center">
            <h1>新用户注册</h1>
            <br>
        </div>
        <form action="/register" method="post" id="registerForm">
            <div class="form-group row">
                <label for="inputUserName" class="col-sm-4 col-form-label text-right">用户名 :</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="inputUserName" name="inputUserName" placeholder="用户名">
                </div>
                <label class="col-form-label" id="userNameTip" style="display: none; color: red">用户名label</label>
            </div>

            <div class="form-group row">
                <label for="inputEmail" class="col-sm-4 col-form-label text-right">邮箱 :</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="inputEmail" name="inputEmail" placeholder="邮箱">
                </div>
                <label class="col-form-label" id="emailTip" style="display: none; color: red">邮箱label</label>
            </div>

            <div class="form-group row">
                <label for="inputPassword" class="col-sm-4 col-form-label text-right">密码 :</label>
                <div class="col-sm-5">
                    <input type="password" class="form-control" id="inputPassword" name="inputPassword"
                           placeholder="密码">
                </div>
                <label class="col-form-label" id="passwordTip" style="display: none; color: red">密码label</label>
            </div>

            <div class="form-group row">
                <label for="inputConfirmPassword" class="col-sm-4 col-form-label text-right">确认密码 :</label>
                <div class="col-sm-5">
                    <input type="password" class="form-control" id="inputConfirmPassword" name="inputConfirmPassword"
                           placeholder="确认密码">
                </div>
                <label class="col-form-label" id="confirmPasswordTip"
                       style="display: none; color: red">确定密码label</label>
            </div>

            <div class="form-group row">
                <label for="inputBio" class="col-sm-4 col-form-label text-right">个性签名 :</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="inputBio" name="inputBio" placeholder="50字以内介绍自己">
                </div>
            </div>


            <div class="form-group row">
                <label for="inputPreferLanguage" class="col-sm-4 col-form-label text-right">语言偏好 :</label>
                <div class="col-sm-5">
                    <select class="custom-select col-sm-5" id="inputPreferLanguage" name="inputPreferLanguage">
                        <c:forEach items="${languageList}" var="lang">
                            <c:if test="${lang.language == 'C++' || lang.language == 'c++'}">
                                <option value="${lang.language}" selected>${lang.language}</option>
                            </c:if>
                            <option value="${lang.language}">${lang.language}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </form>
        <div class="form-group row">
            <label class="col-sm-4 col-form-label text-right"> </label>
            <div class="col-sm-5">
                <button onclick="checkRegisterInfo()" class="form-control btn btn-success">注册</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>
