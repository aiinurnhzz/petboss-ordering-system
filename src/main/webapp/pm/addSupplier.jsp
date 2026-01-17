<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>

<%
String staffId = (String) session.getAttribute("staffId");
String role = (String) session.getAttribute("role");

if (staffId == null || role == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Supplier</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
html, body {
	height: 100%;
	margin: 0;
	overflow: hidden;
	background-color: #fdf8e9;
}

th {
	background-color: #e6f4ea;
	color: #000;
	font-weight: bold;
	border: 1px solid #009a49 !important;
}

td {
	border: 1px solid #009a49 !important;
	text-align: center;
	font-size: 0.85rem;
	padding: 8px;
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
			<button class="text-white font-semibold text-sm">
				<i class="fas fa-sign-out-alt"></i> Logout
			</button>
		</form>
	</header>

	<div class="flex flex-1 overflow-hidden">

		<!-- ===== SIDEBAR (NO SCROLL, BALANCED VERSION) ===== -->
		<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">

			<!-- ===== NAVIGATION ===== -->
			<nav class="flex-1 space-y-5">

				<a href="<%=request.getContextPath()%>/dashboard"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-home w-5 text-center"></i> <span>Home</span>
				</a> <a href="<%=request.getContextPath()%>/profile"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-user-circle w-5 text-center"></i> <span>Profile</span>
				</a> <a href="<%=request.getContextPath()%>/product"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box w-5 text-center"></i> <span>Product</span>
				</a> <a href="<%=request.getContextPath()%>/supplier"
					class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-truck w-5 text-center"></i> <span>Supplier</span>
				</a> <a href="<%=request.getContextPath()%>/order"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-file-invoice w-5 text-center"></i> <span>Order</span>
				</a> <a href="<%=request.getContextPath()%>/receive-product"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box-open w-5 text-center"></i> <span>Receive
						Order</span>
				</a> <a href="<%=request.getContextPath()%>/product-qc"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-check-circle w-5 text-center"></i> <span>Product
						QC</span>
				</a>

			</nav>

			<!-- ===== LOGO (SAFE FOR SMALL SCREEN) ===== -->
			<div class="flex justify-center mt-auto pb-4">
				<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
					class="w-36 sm:w-40 md:w-44 opacity-100">
			</div>

		</aside>

		<!-- ===== MAIN CONTENT ===== -->
		<main class="flex-1 p-10 overflow-y-auto">


			<!-- FORM CARD -->
			<div class="bg-white border-2 border-[#009a49] rounded-3xl p-8">

				<!-- ===== TITLE (MATCH ADD PRODUCT STYLE) ===== -->
				<div class="flex items-center gap-4 mb-4">

					<!-- BACK BUTTON -->
					<a href="<%=request.getContextPath()%>/supplier"
						class="text-green-700 text-2xl hover:text-green-900"> <i
						class="fas fa-arrow-left"></i>
					</a>

					<!-- TITLE -->
					<h2 class="text-3xl font-black text-cyan-900">ADD NEW SUPPLIER
					</h2>
				</div>

				<!-- GREEN DIVIDER -->
				<hr class="border-green-600 mb-6">

				<form action="<%=request.getContextPath()%>/pm/addSupplier"
					method="post">

					<!-- COMPANY INFO -->
					<h3 class="text-green-700 font-bold mb-4">COMPANY INFORMATION</h3>

					<div class="grid grid-cols-2 gap-6 mb-6">
						<div>
							<label class="font-semibold text-sm">Supplier Name</label> <input
								name="supplierName" required
								class="w-full border border-gray-500 rounded-lg px-3 py-2">
						</div>

						<div>
							<label class="text-sm font-semibold text-gray-700">
								Supplier ID </label>

							<div class="relative mt-1 group">
								<!-- INPUT -->
								<input type="text" value="AUTO GENERATED" readonly
									class="w-full border border-gray-400 rounded-lg
                      px-3 py-2 text-sm bg-gray-200 pr-12
                      cursor-not-allowed">
								<!-- TOOLTIP -->
								<div
									class="absolute right-0 -top-9
                   hidden group-hover:block
                   bg-black text-white text-xs
                   px-3 py-1 rounded shadow-lg
                   whitespace-nowrap z-50">
									Auto Generated</div>
							</div>
						</div>

					</div>

					<!-- CONTACT INFO -->
					<h3 class="text-green-700 font-bold mb-4">CONTACT INFORMATION</h3>

					<div class="grid grid-cols-2 gap-6 mb-6">
						<div>
							<label class="font-semibold text-sm">Email</label> <input
								name="email" type="email" required
								class="w-full border border-gray-500 rounded-lg px-3 py-2">
						</div>

						<div>
							<label class="font-semibold text-sm">Phone Number</label> <input
								name="phone" required
								class="w-full border border-gray-500 rounded-lg px-3 py-2">
						</div>
					</div>

					<!-- ADDRESS -->
					<h3 class="text-green-700 font-bold mb-4">BUSINESS ADDRESS</h3>

					<div class="mb-8">
						<label class="font-semibold text-sm">Address</label>
						<textarea name="address" required
							class="w-full border border-gray-500 rounded-lg px-3 py-3 h-28"></textarea>
					</div>

					<!-- ACTION BUTTONS -->
					<div class="flex justify-end gap-4">

						<!-- CANCEL -->
						<a href="<%=request.getContextPath()%>/supplier"
							class="w-32 h-11 flex items-center justify-center
              bg-gray-500 text-white rounded-full font-bold
              transition-all duration-200
              hover:bg-gray-600 hover:scale-105
              active:scale-95 cursor-pointer">
							Cancel </a>

						<!-- SAVE -->
						<button type="submit"
							class="w-32 h-11 bg-green-600 text-white rounded-full font-bold
              transition-all duration-200
              hover:bg-green-700 hover:scale-105
              active:scale-95 cursor-pointer">
							Save</button>

					</div>


				</form>
			</div>

		</main>
	</div>

</body>
</html>
