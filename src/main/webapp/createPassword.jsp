<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Password</title>

<link rel="stylesheet"
      href="<%=request.getContextPath()%>/css/register_login.css">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>

<div class="page">

    <div class="logo">
        <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
             alt="PetBoss Logo">
    </div>

    <div class="login-box">

        <h2>CREATE PASSWORD</h2>

        <!-- ERROR MESSAGE -->
        <%
            String error = request.getParameter("error");
            if ("weak".equals(error)) {
        %>
            <p class="error-msg">Password does not meet requirements.</p>
        <% } else if ("nomatch".equals(error)) { %>
            <p class="error-msg">Passwords do not match.</p>
        <% } else if ("invalidstaff".equals(error)) { %>
            <p class="error-msg">Staff ID not found.</p>
        <% } else if ("alreadyset".equals(error)) { %>
            <p class="error-msg">Password already created. Please login.</p>
        <% } %>

        <p class="password-hint">
            Must contain at least 8 characters, uppercase, lowercase,
            number and symbol.
        </p>

        <!-- PASSWORD STRENGTH -->
        <div class="strength">
            <div id="strengthBar" class="strength-bar"></div>
        </div>

        <form action="<%=request.getContextPath()%>/create-password"
              method="post">

            <!-- STAFF ID -->
            <div class="input-group">
                <i class="fa fa-user"></i>
                <input type="text"
                       name="staffId"
                       placeholder="Staff ID"
                       required>
            </div>

            <!-- PASSWORD -->
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

            <!-- CONFIRM -->
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

            <button type="submit">Save Password</button>
        </form>

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
