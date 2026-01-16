<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
	String error = (String) request.getAttribute("error");
	String staffId = (String) request.getAttribute("staffId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/css/register_login.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>

<div class="page">

    <!-- LOGO -->
    <div class="logo">
        <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
             alt="PetBoss Logo">
    </div>

    <!-- BOX -->
    <div class="login-box">

        <h2>FORGOT PASSWORD</h2>

        <%-- 🔴 ERROR MESSAGES --%>
        <% if ("invalid".equals(error)) { %>
            <p class="error-msg">
                Invalid Staff ID.
            </p>
        <% } else if ("notfound".equals(error)) { %>
            <p class="error-msg">
                Staff ID does not exist.
            </p>
        <% } %>

        <%-- 🟢 SUCCESS MESSAGE --%>
        <% if ("success".equals(error)) { %>
            <p class="success-msg">
                Verification successful. Please check your email.
            </p>
        <% } %>

        <form action="<%=request.getContextPath()%>/forgot-password"
              method="post">

            <div class="input-group">
                <i class="fa fa-user"></i>
                <input type="text"
                       name="staffId"
                       placeholder="Staff ID"
                       value="<%= staffId != null ? staffId : "" %>"
                       required>
            </div>

            <button type="submit">CONTINUE</button>
        </form>

        <p class="forgot-link">
            <a href="<%=request.getContextPath()%>/login.jsp">
                Back to login
            </a>
        </p>

    </div>

</div>

</body>
</html>
