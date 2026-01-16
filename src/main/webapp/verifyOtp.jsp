<%@ page contentType="text/html; charset=UTF-8"%>
<%
    String otp = (String) session.getAttribute("otp");
    String staffId = (String) session.getAttribute("otpStaffId");

    if (otp == null || staffId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Verify OTP</title>

<link rel="stylesheet"
      href="<%=request.getContextPath()%>/css/register_login.css">

<style>
/* 🔹 Small enhancement without breaking existing CSS */

.otp-box {
    display: flex;
    gap: 12px;
    margin-top: 15px;
}

.otp-box input {
    flex: 1;
}

.info-msg {
    background: #e0f2f7;
    color: #004e64;
    padding: 10px 14px;
    border-radius: 12px;
    font-size: 14px;
    margin-bottom: 15px;
    font-weight: 500;
    text-align: center;
}

.login-box h2 {
    letter-spacing: 1.5px;
}

@media (max-width: 480px) {
    .otp-box {
        flex-direction: column;
    }
}
</style>

</head>

<body>

<div class="page">

    <!-- LOGO (CONSISTENT WITH LOGIN) -->
    <div class="logo">
        <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
             alt="PetBoss Logo">
    </div>

    <div class="login-box">

        <h2>OTP VERIFICATION</h2>

        <!-- OTP Simulation -->
        <p class="info-msg">
            OTP (Simulation Only): <b><%= otp %></b>
        </p>

        <% if ("invalid".equals(request.getParameter("error"))) { %>
            <p class="error-msg">
                Invalid OTP. Please try again.
            </p>
        <% } %>

        <form action="<%=request.getContextPath()%>/verify-otp" method="post">

            <div class="otp-box">
                <input type="text"
                       name="enteredOtp"
                       placeholder="Enter 6-digit OTP"
                       required>

                <button type="submit">
                    Verify OTP
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>
