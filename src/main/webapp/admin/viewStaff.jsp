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
        response.sendRedirect(request.getContextPath() + "/staff");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Staff</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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

	<!-- ===== HEADER (DO NOT CHANGE) ===== -->
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

		<!-- ===== SIDEBAR (DO NOT CHANGE) ===== -->
		<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">
			<nav class="flex-1 space-y-5 mt-6">

				<a href="<%=request.getContextPath()%>/dashboard"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-home w-5 text-center"></i><span>Home</span>
				</a> <a href="<%=request.getContextPath()%>/profile"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-user-circle w-5 text-center"></i><span>Profile</span>
				</a> <a href="<%=request.getContextPath()%>/staff"
					class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-users w-5 text-center"></i><span>Staff</span>
				</a> <a href="<%=request.getContextPath()%>/product"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box w-5 text-center"></i><span>Product</span>
				</a> <a href="<%=request.getContextPath()%>/supplier"
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

<!-- ================= MAIN ================= -->
<main class="relative flex-1 p-12 overflow-hidden flex justify-center items-center bg-[#fdf8e9]"
              style="background-size: cover; background-position: center;">

<!-- TITLE + CANCEL -->
<div class="relative z-10 w-full max-w-4xl bg-white rounded-3xl shadow-xl border-2 border-[#009a49] overflow-hidden">
				<div class="flex justify-between items-start w-full flex-shrink-0">
					<div
						class="bg-[#009a49] text-white py-3 px-16 inline-block rounded-br-3xl text-2xl font-bold tracking-widest">
						VIEW STAFF</div>

					<div class="pt-3 pr-8">
				    <a href="<%=request.getContextPath()%>/staff"
				       class="inline-block bg-[#737373] hover:bg-[#737373]
				              text-white px-8 py-2 rounded-full font-bold text-lg
				              shadow-lg border-2 border-white
				              transition-transform active:scale-95">
				        Cancel
				    </a>
					</div>
				</div>
				
				<div class="p-8 flex flex-col md:flex-row gap-10">
        <div class="w-full md:w-1/3 border-2 border-gray-400 rounded-[20px] p-6 flex flex-col items-center">
        
        <div class="w-44 h-44 rounded-full border-[6px] border-sky-400
                    flex items-center justify-center mb-4">
            <img
                src="<%=request.getContextPath()%>/uploads/staff/<%= staff.getPhoto() == null ? "default.png" : staff.getPhoto() %>?t=<%=System.currentTimeMillis()%>"
                class="w-40 h-40 rounded-full">
        </div>

        <!-- Role -->
        <span class="bg-blue-100 border border-blue-300 text-blue-800 px-4 rounded-lg
                     font-bold mb-4">
            <%= staff.getRole() %>
        </span>

        <!-- IDs -->
        <div class="text-sm space-y-2 text-center font-bold">
            <p>Employee ID : <%= staff.getStaffId() %></p>
            <p>PM ID : <%= staff.getPmId() == null ? "-" : staff.getPmId() %></p>
        </div>
    </div>

    <!-- ===== RIGHT INFO ===== -->
    <div class="flex-1 space-y-4">
    <div class="flex-1 items-center justify-between mb-2">

        <!-- NAME -->
        <h2 class="text-3xl font-black uppercase mb-2">
            <%= staff.getFullName() %>
        </h2>
	</div>
        <!-- JOINED + STATUS -->
         <div class="flex items-center gap-6 text-sm font-bold text-gray-600">
                    <p>Joined : <%= staff.getJoinedDate() %></p>
                    <%
					    String status = staff.getStatus(); // e.g. ACTIVE / INACTIVE
					    boolean isActive = "ACTIVE".equalsIgnoreCase(status);
					%>
					
					<p class="flex items-center gap-2 <%= isActive ? "text-green-600" : "text-red-600" %>">
					    <span class="w-3 h-3 rounded-full
					        <%= isActive ? "bg-green-500" : "bg-red-500" %>">
					    </span>
					    <%= status %>
					</p>
                </div>
		
        <!-- PERSONAL INFO BAR -->
        <div class="bg-[#fdf3e7] text-[#e67e22] text-center py-2 font-bold tracking-widest 
        rounded-xl border border-orange-100 uppercase">
            PERSONAL INFO
        </div>

        <!-- INFO FIELDS -->
        <div class="space-y-4">

            <div>
                <label class="text-sm font-semibold">Full Name</label>
                <div class="w-full bg-white border-2 border-gray-400 rounded-xl px-4 py-2 text-black font-bold">
                    <%= staff.getFullName() %>
                </div>
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="text-sm font-semibold">Email</label>
                    <div class="w-full bg-white border-2 border-gray-400 rounded-xl px-4 py-2 text-black font-bold">
                        <%= staff.getEmail() %>
                    </div>
                </div>

                <div>
                    <label class="text-sm font-semibold">Phone Number</label>
                    <div class="w-full bg-white border-2 border-gray-400 rounded-xl px-4 py-2 text-black font-bold">
                        <%= staff.getPhone() %>
                    </div>
                </div>
            </div>

            <div>
                <label class="text-sm font-semibold">Address</label>
                <div class="w-full bg-white border-2 border-gray-400 rounded-xl px-4 py-2 text-black font-bold">
                    <%= staff.getAddress() %>
                </div>
            </div>

        </div>
    </div>
</div>
</div>
</main>
</div>

</body>
</html>
