<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Unauthorized</title>
</head>
<body>
    <h2>Access Denied</h2>
    <p>You do not have permission to access this page.</p>
    <a href="<%=request.getContextPath()%>/login.jsp">Back to Login</a>
</body>
</html>
