<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="google-site-verification" content="7RlxOODrAYO0uvqZOU07Fpu_7tkxMtnJSN53QOLi4jU" />
<title>PetBoss Login</title>

<link rel="stylesheet"
      href="<%=request.getContextPath()%>/css/register_login.css">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>

<div class="page">

    <div class="logo">
        <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png">
    </div>

    <div class="login-box">
        <h2>LOGIN</h2>
        
        <%
		    String error = request.getParameter("error");
		    if ("invalid".equals(error)) {
		%>
		    <p class="error-msg">
		        ❌ Invalid Staff ID or Password
		    </p>
		<%
		    } else if ("inactive".equals(error)) {
		%>
		    <p class="error-msg">
		        ⚠️ Your account is not active. Please contact admin.
		    </p>
		<%
		    }
		%>
        
        <!-- LOGIN FORM -->
		<form action="<%=request.getContextPath()%>/login" method="post">
		
		    <div class="input-group">
		        <i class="fa fa-user"></i>
		        <input type="text"
		               name="staffId"
		               placeholder="Staff ID"
		               required>
		    </div>
		
		    <div class="input-group">
		        <i class="fa fa-lock"></i>
		        <input type="password"
		               id="password"
		               name="password"
		               placeholder="Password"
		               required>
		        <i class="fa fa-eye toggle-password"
		           id="toggleEye"
		           onclick="togglePassword()"></i>
		    </div>
		
		    <div class="remember">
		        <input type="checkbox" name="rememberMe">
		        Remember me
		    </div>
		
		    <!-- INFO -->
		    <p class="info-msg">
		        First time logging in?
		        Please create your password before signing in.
		    </p>
		
		    <a class="create-link"
		       href="<%=request.getContextPath()%>/createPassword.jsp">
		        👉 Create your password
		    </a>
		
		    <p class="forgot-link">
		        <a href="<%=request.getContextPath()%>/forgotPassword.jsp">
		            Forgot password?
		        </a>
		    </p>
		
		    <!-- ✅ LOGIN BUTTON AT BOTTOM -->
		    <button type="submit" class="login-btn">
		        LOGIN
		    </button>	
		</form>
	</div>
</div>
<script>
function togglePassword() {
    const pwd = document.getElementById("password");
    const eye = document.getElementById("toggleEye");

    if (pwd.type === "password") {
        pwd.type = "text";
        eye.classList.replace("fa-eye", "fa-eye-slash");
    } else {
        pwd.type = "password";
        eye.classList.replace("fa-eye-slash", "fa-eye");
    }
}
</script>
</body>
</html>


