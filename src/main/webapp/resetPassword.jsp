<%@ page contentType="text/html; charset=UTF-8"%>
<%
    String resetStaffId = (String) session.getAttribute("resetStaffId");
    String success = request.getParameter("success");

    if (resetStaffId == null && success == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reset Password</title>

<link rel="stylesheet"
      href="<%=request.getContextPath()%>/css/register_login.css">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
.password-hint {
    font-size: 13px;
    color: #e0f2f7;
    margin-bottom: 10px;
    line-height: 1.4;
}

.strength {
    height: 8px;
    border-radius: 6px;
    background: #ddd;
    overflow: hidden;
    margin-bottom: 15px;
}

.strength-bar {
    height: 100%;
    width: 0%;
    transition: width 0.3s;
}

.weak { background: #e74c3c; }
.medium { background: #f39c12; }
.strong { background: #2ecc71; }

.toggle {
    position: absolute;
    right: 12px;
    top: 12px;
    cursor: pointer;
    color: #555;
}

.input-group {
    position: relative;
    margin-bottom: 15px;
}

.success-box {
    background: #e0f7e9;
    color: #006b3c;
    padding: 15px;
    border-radius: 12px;
    font-weight: bold;
    text-align: center;
}
</style>
</head>

<body>

<div class="page">

    <div class="logo">
        <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
             alt="PetBoss Logo">
    </div>

    <div class="login-box">

        <h2>RESET PASSWORD</h2>

        <!-- SUCCESS -->
        <% if ("true".equals(success)) { %>
            <div class="success-box">
                Password reset successfully.<br>
                Redirecting to login...
            </div>

            <script>
                setTimeout(() => {
                    window.location.href = "<%=request.getContextPath()%>/login.jsp";
                }, 3000);
            </script>

        <% } else { %>

            <!-- ERROR -->
            <% if ("weak".equals(request.getParameter("error"))) { %>
                <p class="error-msg">
                    Password does not meet requirements.
                </p>
            <% } else if ("nomatch".equals(request.getParameter("error"))) { %>
                <p class="error-msg">
                    Passwords do not match.
                </p>
            <% } %>

            <!-- PASSWORD RULES -->
            <p class="password-hint">
                Must contain at least 8 characters, uppercase, lowercase,
                number and symbol.
            </p>

            <!-- STRENGTH BAR -->
            <div class="strength">
                <div id="strengthBar" class="strength-bar"></div>
            </div>

            <form action="<%=request.getContextPath()%>/reset-password"
                  method="post">

                <div class="input-group">
                    <i class="fa fa-lock"></i>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="New Password"
                           onkeyup="checkStrength()"
                           required>
                    <i class="fa fa-eye toggle"
                       onclick="toggle('password', this)"></i>
                </div>

                <div class="input-group">
                    <i class="fa fa-lock"></i>
                    <input type="password"
                           id="confirm"
                           name="confirmPassword"
                           placeholder="Confirm Password"
                           required>
                    <i class="fa fa-eye toggle"
                       onclick="toggle('confirm', this)"></i>
                </div>

                <button type="submit">
                    Reset Password
                </button>
            </form>

        <% } %>

    </div>

</div>

<script>
function toggle(id, icon) {
    const input = document.getElementById(id);
    if (input.type === "password") {
        input.type = "text";
        icon.classList.replace("fa-eye", "fa-eye-slash");
    } else {
        input.type = "password";
        icon.classList.replace("fa-eye-slash", "fa-eye");
    }
}

function checkStrength() {
    const pwd = document.getElementById("password").value;
    const bar = document.getElementById("strengthBar");

    let score = 0;
    if (pwd.length >= 8) score++;
    if (/[A-Z]/.test(pwd)) score++;
    if (/[a-z]/.test(pwd)) score++;
    if (/[0-9]/.test(pwd)) score++;
    if (/[^A-Za-z0-9]/.test(pwd)) score++;

    if (score <= 2) {
        bar.style.width = "30%";
        bar.className = "strength-bar weak";
    } else if (score <= 4) {
        bar.style.width = "65%";
        bar.className = "strength-bar medium";
    } else {
        bar.style.width = "100%";
        bar.className = "strength-bar strong";
    }
}
</script>

</body>
</html>
