<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>
<%@ page import="com.petboss.model.Staff"%>

<%
String staffId = (String) session.getAttribute("staffId");
String role = (String) session.getAttribute("role");

if (staffId == null || role == null || !"ADMIN".equalsIgnoreCase(role)) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

Staff staff = (Staff) request.getAttribute("staff");
if (staff == null) {
    response.sendRedirect(request.getContextPath() + "/updateStaff");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Update Staff</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
/* FORM TAB */
body {
	background-color: #f6efe6;
}

.form-header {
	background-color: #1a8a43;
	color: white;
	padding: 10px 28px;
	font-weight: bold;
	font-size: 18px;
	border-radius: 15px 15px 0 0;
	display: inline-block;
}

/* FORM CARD */
.form-card {
	background: white;
	border: 2px solid #1a8a43;
	border-radius: 0 20px 20px 20px;
	padding: 28px 36px;
	width: 800px;
}

/* FORM ROW */
.form-row {
	display: flex;
	align-items: center;
	margin-bottom: 16px;
}

.form-row label {
	width: 140px;
	font-weight: bold;
}

.form-row input {
	flex: 1;
	padding: 10px;
	background-color: #e9f6f3;
	border: none;
	border-radius: 6px;
	font-size: 14px;
}

/* RADIO GROUP */
.radio-group {
	display: flex;
	gap: 24px;
}

.radio-group label {
	white-space: nowrap; /* ✅ keep one line */
}

/* BUTTONS */
.button-row {
	display: flex;
	justify-content: center;
	gap: 24px;
	margin-top: 28px;
}

.btn-cancel {
	background: #777;
	color: white;
	padding: 10px 36px;
	border-radius: 25px;
}

.btn-save {
	background: #1a8a43;
	color: white;
	padding: 10px 36px;
	border-radius: 25px;
	font-weight: bold;
}
</style>
</head>

<body class="font-sans flex flex-col h-screen">

<!-- HEADER -->
<header class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
    <h1 class="text-white text-2xl font-bold">Pet Boss Centre Cash and Carry</h1>

    <form action="<%=request.getContextPath()%>/logout" method="post">
        <button class="bg-[#f2711c] text-white px-4 py-1.5 rounded-xl
                       flex items-center gap-2 font-semibold text-sm">
            <i class="fas fa-sign-out-alt"></i> Logout
        </button>
    </form>
</header>

<div class="flex flex-1 overflow-hidden">

    <!-- SIDEBAR -->
    <aside class="w-48 bg-[#266b8b] p-6 flex flex-col relative">
        <nav class="w-full space-y-4">

            <a href="<%=request.getContextPath()%>/dashboard"
               class="w-full bg-[#f2711c] hover:bg-[#009a49]
                      text-white py-2 px-4 rounded-full
                      flex items-center gap-3 border-2 border-white shadow-md">
                <i class="fas fa-home"></i> Home
            </a>
            
			<a href="<%=request.getContextPath()%>/profile"
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-user-circle"></i> Profile
			</a> 
			
            <a href="<%=request.getContextPath()%>/staff"
               class="w-full bg-[#009a49] text-white py-2 px-4 rounded-full
                      flex items-center gap-3 border-2 border-white shadow-md font-semibold">
                <i class="fas fa-users"></i> Staff
            </a>
            
             <a href="#"
               class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4 rounded-full flex items-center gap-3 border-2 border-white shadow-md">
                <i class="fas fa-box"></i> Product
            </a>

            <a href="<%=request.getContextPath()%>/supplier"
               class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4 rounded-full flex items-center gap-3 border-2 border-white shadow-md">
                <i class="fas fa-truck"></i> Supplier
            </a>
            
        </nav>

        <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
				class="absolute bottom-6 left-1/2 -translate-x-1/2 w-64 opacity-70">
    </aside>

    <!-- ===== MAIN CONTENT ===== -->
    <main class="flex-1 overflow-y-auto p-10 flex justify-center">

    <div>
        <div class="form-header">UPDATE STAFF</div>

        <div class="form-card">

            <form method="post" action="<%=request.getContextPath()%>/updateStaff">

                <div class="form-row">
                    <label>Staff ID:</label>
                    <input type="text" name="staffId"
                           value="<%=staff.getStaffId()%>" readonly>
                </div>

                <div class="form-row">
                    <label>Name:</label>
                    <input type="text" name="name"
                           value="<%=staff.getFullName()%>">
                </div>

                <div class="form-row">
                    <label>Email:</label>
                    <input type="email" name="email"
                           value="<%=staff.getEmail()%>">
                </div>

                <div class="form-row">
                    <label>Phone No:</label>
                    <input type="text" name="phone"
                           value="<%=staff.getPhone()%>">
                </div>

                <div class="form-row">
                    <label>Address:</label>
                    <input type="text" name="address"
                           value="<%=staff.getAddress()%>">
                </div>

                <div class="form-row">
                    <label>Role:</label>
							<div class="radio-group">
								<input type="radio" name="role" value="Admin"
									<%="Admin".equals(staff.getRole()) ? "checked" : ""%>><span>Admin</span>
								 <input type="radio" name="role" value="Purchasing Manager"
									<%="Purchasing Manager".equals(staff.getRole()) ? "checked" : ""%>><span>Purchasing Manager</span>
								 <input type="radio" name="role" value="Staff"
									<%="Staff".equals(staff.getRole()) ? "checked" : ""%>><span>Staff</span>
							</div>
						</div>

                <div class="form-row">
                    <label>PM ID:</label>
                    <input type="text" name="pmId"
                           value="<%=staff.getPmId() == null ? "" : staff.getPmId()%>">
                </div>

                <div class="form-row">
                    <label>Status:</label>
                    <div class="radio-group">
                        <label>
                            <input type="radio" name="status" value="ACTIVE"
                                <%= "ACTIVE".equals(staff.getStatus()) ? "checked" : "" %>>
                            Active
                        </label>
                        <label>
                            <input type="radio" name="status" value="INACTIVE"
                                <%= "INACTIVE".equals(staff.getStatus()) ? "checked" : "" %>>
                            Resign
                        </label>
                    </div>
                </div>

                <div class="button-row">
                    <a href="<%=request.getContextPath()%>/staff" class="btn-cancel">
                        Cancel
                    </a>
                    <button type="submit" class="btn-save">
                        Update
                    </button>
                </div>

            </form>
        </div>
    </div>

</main>
</div>

</body>
</html>
