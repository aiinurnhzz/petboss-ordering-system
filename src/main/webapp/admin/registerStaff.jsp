<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>
<%@ page import="java.util.List"%>
<%@ page import="com.petboss.model.Staff"%>

<%
String staffId = (String) session.getAttribute("staffId");
String role = (String) session.getAttribute("role");

if (staffId == null || role == null || !"ADMIN".equalsIgnoreCase(role)) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Register User</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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

	<!-- ===== HEADER ===== -->
	<header
		class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
		<h1 class="text-white text-2xl font-bold">Pet Boss Centre Cash
			and Carry</h1>

		<form action="<%=request.getContextPath()%>/logout" method="post">
			<button
				class="bg-[#f2711c] text-white px-4 py-1.5 rounded-xl
                       flex items-center gap-2 font-semibold text-sm">
				<i class="fas fa-sign-out-alt"></i> Logout
			</button>
		</form>
	</header>

	<div class="flex flex-1 overflow-hidden">

		<!-- ===== SIDEBAR ===== -->
		<aside class="w-48 bg-[#266b8b] p-6 flex flex-col relative">
			<nav class="w-full space-y-4">

				<a href="<%=request.getContextPath()%>/dashboard"
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-home"></i> Home
				</a> 
				
				<a href="<%=request.getContextPath()%>/profile"
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-user-circle"></i> Profile
				</a> 
				
				<a href="<%=request.getContextPath()%>/staff"
					class="w-full bg-[#009a49] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-users"></i> Staff
				</a> 
				
				<a href="<%=request.getContextPath()%>/product"
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-box"></i> Product
				</a> 
				
				<a href="<%=request.getContextPath()%>/supplier"
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-truck"></i> Supplier
				</a>

			</nav>
			<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
				class="absolute bottom-6 left-1/2 -translate-x-1/2 w-64 opacity-70">
		</aside>

		<!-- ===== MAIN CONTENT ===== -->
		<main class="flex-1 overflow-y-auto p-10 flex justify-center">

			<div>
				<div class="form-header">REGISTER STAFF</div>

				<div class="form-card">

					<form action="<%=request.getContextPath()%>/registerStaff"
						method="post">

						<div class="form-row">
							<label>Staff ID:</label> <input name="staffId"
								placeholder="Enter your Staff ID" required>
						</div>

						<div class="form-row">
							<label>Name:</label> <input name="name"
								placeholder="Enter your full name" required>
						</div>

						<div class="form-row">
							<label>Email:</label> <input type="email" name="email"
								placeholder="Enter your email address">
						</div>

						<div class="form-row">
							<label>Phone No:</label> <input name="phone"
								placeholder="Enter your phone number">
						</div>

						<div class="form-row">
							<label>Address:</label> <input name="address"
								placeholder="Enter your address">
						</div>

						<div class="form-row">
							<label>Role:</label>
							<div class="radio-group">
								<input type="radio" name="role" value="ADMIN" class="role-radio"> <span>Admin</span>
								<input type="radio" name="role" value="PM" class="role-radio"> <span>Purchasing Manager</span>
								<input type="radio" name="role" value="STAFF" class="role-radio"> <span>Staff</span>
							</div>
						</div>

						<div class="form-row" id="pmIdRow" style="display:none;">
						    <label>PM ID:</label>
						    <input name="pmId" placeholder="Enter Purchasing Manager ID">
						</div>

						<div class="button-row">
							<a href="<%=request.getContextPath()%>/staff" class="btn-cancel">Cancel</a>
							<button class="btn-save">Save</button>
						</div>

					</form>
				</div>
			</div>

		</main>
	</div>
	<script>
		const roleRadios = document.querySelectorAll('input[name="role"]');
		const pmIdRow = document.getElementById('pmIdRow');
		
		roleRadios.forEach(radio => {
		    radio.addEventListener('change', () => {
		        pmIdRow.style.display = (radio.value === 'STAFF' && radio.checked)
		            ? 'flex'
		            : 'none';
		    });
		});
		</script>
</body>
</html>
