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
body {
	background-color: #f6efe6;
}

/* FORM HEADER */
.form-header {
	background-color: #1a8a43;
	color: white;
	padding: 12px 36px;
	font-weight: bold;
	font-size: 20px;
	border-radius: 18px 18px 0 0;
	display: inline-block;
}

/* FORM CARD */
.form-card {
	background: white;
	border: 2px solid #1a8a43;
	border-radius: 0 24px 24px 24px;
	padding: 36px 48px; /* ⬅ more breathing space */
	width: 920px; /* ⬅ bigger form */
}

/* FORM ROW */
.form-row {
	display: flex;
	align-items: center;
	margin-bottom: 18px;
}

.form-row label {
	width: 110px; /* ⬅ closer to input */
	font-weight: bold;
}

/* INPUTS */
.form-row input {
	flex: 1;
	padding: 12px 14px;
	background-color: #eef7f5;
	border: 2px solid transparent;
	border-radius: 10px;
	font-size: 14px;
}

.form-row input:focus {
	outline: none;
	box-shadow: 0 0 0 2px rgba(26, 138, 67, 0.4);
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
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
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
	box-shadow: 0 4px 12px rgba(26, 138, 67, 0.4);
	transform: translateY(-1px);
}

.required {
	color: #dc2626; /* Tailwind red-600 */
}

/* === FORCE FORM TO USE GRID FOR ROLE ROW === */
.form-row.role-row {
	display: grid;
	grid-template-columns: 110px 1fr; /* SAME as label width */
	align-items: start; /* 🔑 absolute fix */
}

/* ROLE ROW GRID */
.form-row.role-row {
	display: grid;
	grid-template-columns: 110px auto;
	align-items: center;
}

/* RADIO GROUP – CLEAN & CALM */
.radio-group {
	display: flex;
	align-items: center;
	gap: 32px; /* 🔥 sweet spot (tak rapat, tak jauh) */
}

/* RADIO ITEM */
.radio-item {
	display: inline-flex;
	align-items: center;
	gap: 8px; /* radio rapat dgn text */
	white-space: nowrap;
	font-weight: normal; /* 🔥 BUANG bold clash */
	color: #111827; /* dark neutral (tak terlalu hitam) */
}

/* REMOVE DEFAULT RADIO SPACING */
.radio-item input[type="radio"] {
	margin: 0;
	padding: 0;
}

/* OPTIONAL: hover feel (soft) */
.radio-item:hover {
	cursor: pointer;
	color: #1a8a43;
}

/* Extra space before Staff radio (PM ↔ Staff) */
.radio-item.staff-gap {
	margin-left: 32px; /* 🔥 adjust sini: 24px / 32px / 40px */
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
				<div class="form-header">REGISTER STAFF</div>

				<div class="form-card">

					<form action="<%=request.getContextPath()%>/registerStaff" method="post">

				    <!-- STAFF ID (DISPLAY ONLY) -->
				    <div class="form-row">
				        <label>Staff ID</label>
				        <input
				            type="text"
				            value="Auto generated by system"
				            readonly
				            class="bg-gray-200 text-gray-500 cursor-not-allowed">
				    </div>
				
				    <div class="form-row">
				        <label>Name <span class="required">*</span></label>
				        <input name="name" placeholder="Enter full name" required>
				    </div>
				
				    <div class="form-row">
				        <label>Email</label>
				        <input type="email" name="email"
				               placeholder="example@petboss.com">
				    </div>
				
				    <div class="form-row">
				        <label>Phone No</label>
				        <input name="phone" placeholder="01X-XXXXXXX">
				    </div>
				
				    <div class="form-row">
				        <label>Address</label>
				        <input name="address" placeholder="Enter full address">
				    </div>
				
				    <div class="form-row">
				        <label>Role <span class="required">*</span></label>
				        <div class="radio-group">
				            <label class="radio-item">
				                <input type="radio" name="role" value="Admin">
				                <span>Admin</span>
				            </label>
				            <label class="radio-item">
				                <input type="radio" name="role" value="Purchasing Manager">
				                <span>Purchasing Manager</span>
				            </label>
				            <label class="radio-item staff-gap">
				                <input type="radio" name="role" value="Staff">
				                <span>Staff</span>
				            </label>
				        </div>
				    </div>
				
				    <div class="form-row" id="pmIdRow" style="display:none;">
					    <label>PM ID</label>
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
document.addEventListener("DOMContentLoaded", function () {

    const roleRadios = document.querySelectorAll('input[name="role"]');
    const pmIdRow = document.getElementById('pmIdRow');

    roleRadios.forEach(radio => {
        radio.addEventListener('change', function () {

            if (this.value === "Staff") {
                pmIdRow.style.display = "flex";
            } else {
                pmIdRow.style.display = "none";
            }

        });
    });

});
</script>

</body>
</html>
