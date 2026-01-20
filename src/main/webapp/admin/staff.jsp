<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="com.petboss.model.Staff" %>

<%
    List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Staff</title>

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
    border: 1px solid #009a49;
    font-weight: bold;
}

td {
    border: 1px solid #009a49;
    text-align: center;
    font-size: 0.85rem;
    padding: 8px;
}

.search-form {
    display: flex;
    gap: 16px;
    margin-bottom: 24px;
}

.search-box {
    position: relative;
    flex: 1;
}

.search-input {
    width: 100%;
    border: 2px solid #009a49;
    border-radius: 8px;
    padding: 10px 42px 10px 16px;
}

.search-icon {
    position: absolute;
    right: 14px;
    top: 50%;
    transform: translateY(-50%);
    color: #009a49;
}

.filter-box {
    width: 220px;
}

.filter-container {
    display: flex;
    align-items: center;
    border: 2px solid #009a49;
    border-radius: 8px;
    background: white;
    position: relative;
}

.filter-icon {
    padding: 0 14px;
    border-right: 2px solid #009a49;
    color: #009a49;
}

.filter-select {
    width: 100%;
    padding: 10px 40px 10px 14px;
    appearance: none;
    background: transparent;
    cursor: pointer;
}

.filter-arrow {
    position: absolute;
    right: 14px;
    pointer-events: none;
    color: #6b7280;
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
<main class="flex-1 p-8 overflow-y-auto">

<div class="bg-white border-2 border-[#009a49] rounded-2xl p-6 shadow">

    <!-- TITLE ROW -->
	<div class="flex justify-between items-center">
	    <h2 class="text-3xl font-black text-cyan-900">STAFF</h2>
	
	    <a href="<%=request.getContextPath()%>/registerStaff"
	       class="bg-green-600 text-white px-6 py-3 rounded-full font-semibold">
	        + Add Staff
	    </a>
	</div>
	
	<!-- ✅ GARIS PANJANG -->
	<hr class="border-t-2 border-green-600 my-6">
	
    <!-- SEARCH + FILTER -->
    <form class="search-form">

        <!-- SEARCH -->
        <div class="search-box">
            <input
                type="text"
                id="searchInput"
                placeholder="Search staff by name or ID"
                class="search-input">
            <i class="fas fa-search search-icon"></i>
        </div>

        <!-- ROLE FILTER -->
        <div class="filter-box">
            <div class="filter-container">
                <div class="filter-icon">
                    <i class="fas fa-filter"></i>
                </div>

                <select id="roleFilter" class="filter-select">
                    <option value="">All Roles</option>
                    <option>Admin</option>
                    <option>Purchasing Manager</option>
                    <option>Staff</option>
                </select>

                <i class="fas fa-caret-down filter-arrow"></i>
            </div>
        </div>

        <!-- STATUS FILTER -->
        <div class="filter-box">
            <div class="filter-container">
                <div class="filter-icon">
                    <i class="fas fa-filter"></i>
                </div>

                <select id="statusFilter" class="filter-select">
                    <option value="">All Status</option>
                    <option value="Active">Active</option>
                    <option value="Inactive">Inactive</option>
                </select>

                <i class="fas fa-caret-down filter-arrow"></i>
            </div>
        </div>

    </form>

    <!-- TABLE -->
    <div class="overflow-x-hidden">
        <table class="w-full border-collapse staff-table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Staff ID</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody id="staffTable">
            <% if (staffList != null && !staffList.isEmpty()) {
                   for (Staff s : staffList) { %>
                <tr class="staff-row" data-status="<%= s.getStatus() %>">
                    <td><%= s.getFullName() %></td>
                    <td><%= s.getStaffId() %></td>
                    <td class="staff-role"><%= s.getRole() %></td>
                    <td>
                        <div class="flex justify-center gap-4">
                            <a href="<%=request.getContextPath()%>/viewStaff?staffId=<%= s.getStaffId() %>"
                               class="hover:scale-150 transition">
                                <i class="fas fa-eye"></i>
                            </a>
                            <a href="<%=request.getContextPath()%>/updateStaff?staffId=<%= s.getStaffId() %>"
                               class="hover:scale-150 transition">
                                <i class="fas fa-pencil-alt"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            <% } } else { %>
                <tr>
                    <td colspan="4" class="text-center text-gray-500 py-10">
                        No staff found
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

</div>
</main>

</div>

<!-- ===== SCRIPT (UNCHANGED) ===== -->
<script>
const searchInput = document.getElementById("searchInput");
const roleFilter = document.getElementById("roleFilter");
const statusFilter = document.getElementById("statusFilter");
const rows = document.querySelectorAll(".staff-row");

function filterStaff() {
    const search = searchInput.value.toLowerCase();
    const role = roleFilter.value.toLowerCase();
    const status = statusFilter.value.toLowerCase();

    rows.forEach(row => {
        const text = row.innerText.toLowerCase();
        const rowRole = row.querySelector(".staff-role").innerText.toLowerCase();
        const rowStatus = row.dataset.status.toLowerCase();

        row.style.display =
            text.includes(search) &&
            (role === "" || rowRole === role) &&
            (status === "" || rowStatus === status)
                ? ""
                : "none";
    });
}

searchInput.addEventListener("keyup", filterStaff);
roleFilter.addEventListener("change", filterStaff);
statusFilter.addEventListener("change", filterStaff);
</script>

</body>
</html>

