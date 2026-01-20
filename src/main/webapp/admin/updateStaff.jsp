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
    padding: 32px 48px;   /* lebih selesa kiri kanan */
    width: 950px;        /* 🔥 LEBAR */
    max-width: 95vw;     /* responsive – tak overflow */
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
    justify-content: flex-end; /* 🔥 hujung kanan */
    gap: 24px;
    margin-top: 28px;
}

.btn-cancel {
    background: #777;
    color: white;
    padding: 10px 36px;
    border-radius: 25px;
    font-weight: bold;
    text-decoration: none;
    transition: all 0.2s ease;
}

.btn-cancel:hover {
    background: #5f5f5f;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    transform: translateY(-1px);
}

.btn-save {
    background: #1a8a43;
    color: white;
    padding: 10px 36px;
    border-radius: 25px;
    font-weight: bold;
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-save:hover {
    background: #147236;
    box-shadow: 0 4px 12px rgba(26,138,67,0.4);
    transform: translateY(-1px);
}


</style>
</head>

<body class="font-sans flex flex-col h-screen">

	<!-- ===== HEADER (SAME AS ADMIN) ===== -->
	<header
		class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
		<h1 class="text-white text-2xl font-bold">Pet Boss Centre Cash
			and Carry</h1>

		<form action="<%=request.getContextPath()%>/logout" method="post">
			<button
				class="text-white font-semibold text-sm">
				<i class="fas fa-sign-out-alt"></i> Logout
			</button>
		</form>
	</header>

<div class="flex flex-1 overflow-hidden">

		<!-- ===== SIDEBAR (DO NOT CHANGE) ===== -->
		<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">
			<nav class="flex-1 space-y-5 mt-6">

				<a href="<%=request.getContextPath()%>/dashboard"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-home w-5 text-center"></i><span>Home</span>
				</a> 
				
				<a href="<%=request.getContextPath()%>/profile"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-user-circle w-5 text-center"></i><span>Profile</span>
				</a> 
				
				<a href="<%=request.getContextPath()%>/staff"
					class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-users w-5 text-center"></i><span>Staff</span>
				</a> 
				
				<a href="<%=request.getContextPath()%>/product"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box w-5 text-center"></i><span>Product</span>
				</a> 
				
				<a href="<%=request.getContextPath()%>/supplier"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-truck w-5 text-center"></i><span>Supplier</span>
				</a>
			</nav>

			<div class="flex justify-center mt-auto pb-4">
				<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
					class="w-36 sm:w-40 md:w-44 opacity-100">
			</div>
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
                            <input type="radio" name="status" value="Active"
                                <%= "ACTIVE".equals(staff.getStatus()) ? "checked" : "" %>>
                            Active
                        </label>
                        <label>
                            <input type="radio" name="status" value="Inactive"
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
