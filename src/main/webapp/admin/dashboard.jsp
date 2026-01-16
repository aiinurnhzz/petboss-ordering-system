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
<title>Pet Boss Dashboard</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
html, body {
	height: 100%;
	margin: 0;
	overflow: hidden;
	background-color: #fdf8e9;
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
				class="bg-[#f2711c] text-white px-4 py-1.5 rounded-xl flex items-center gap-2 font-semibold text-sm">
				<i class="fas fa-sign-out-alt"></i> Logout
			</button>
		</form>
	</header>

	<div class="flex flex-1 overflow-hidden">

		<!-- ===== SIDEBAR ===== -->
		<aside class="w-48 bg-[#266b8b] p-6 flex flex-col relative">
			<nav class="w-full space-y-4">

				<a href="<%=request.getContextPath()%>/dashboard"
					class="w-full bg-[#009a49] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-home"></i> Home
				</a> 
				
				<a href="<%=request.getContextPath()%>/profile"
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-user-circle"></i> Profile
				</a> 
				
				<a href="<%=request.getContextPath()%>/staff"
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
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

		<!-- ===== CONTENT ===== -->
		<main class="flex-1 p-8 overflow-y-auto">

			<div class="mb-6">
				<h2 class="text-4xl font-black text-cyan-900 uppercase">
					Welcome,
					<%=staffId%>
				</h2>
				<p id="current-date" class="text-gray-700 font-bold mt-1"></p>
			</div>

			<div class="grid grid-cols-4 gap-6 mb-8">

				<div
					class="bg-orange-500 text-white p-6 rounded-lg text-center shadow-md">
					<i class="fas fa-users text-3xl mb-2"></i>
					<h3 class="font-bold text-lg">Total Staff</h3>
					<p class="text-5xl font-bold mt-2">
						<%=request.getAttribute("totalStaff")%>
					</p>
				</div>

				<div
					class="bg-cyan-400 text-white p-6 rounded-lg text-center shadow-md">
					<i class="fas fa-boxes text-3xl mb-2"></i>
					<h3 class="font-bold text-lg">Total Products</h3>
					<p class="text-5xl font-bold mt-2">—</p>
				</div>

				<div
					class="bg-sky-800 text-white p-6 rounded-lg text-center shadow-md">
					<i class="fas fa-truck-loading text-3xl mb-2"></i>
					<h3 class="font-bold text-lg">Suppliers</h3>
					<p class="text-5xl font-bold mt-2">—</p>
				</div>

				<div
					class="bg-red-500 text-white p-6 rounded-lg text-center shadow-md">
					<i class="fas fa-exclamation-triangle text-3xl mb-2"></i>
					<h3 class="font-bold text-lg">Low Stock</h3>
					<p class="text-5xl font-bold mt-2">—</p>
				</div>

			</div>
		</main>
	</div>

	<script>
		const date = new Date().toLocaleDateString('en-GB', {
			day : 'numeric',
			month : 'long',
			year : 'numeric'
		});
		document.getElementById("current-date").innerText = "Today: " + date;
	</script>

</body>
</html>
