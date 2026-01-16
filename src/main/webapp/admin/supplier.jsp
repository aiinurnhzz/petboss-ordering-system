<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.petboss.model.Supplier" %>

<%
    List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Pet Boss - Suppliers</title>

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
					class="w-full bg-[#009a49] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-truck"></i> Supplier
				</a>

			</nav>
			<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
				class="absolute bottom-6 left-1/2 -translate-x-1/2 w-64 opacity-70">
		</aside>

<!-- MAIN -->
<main class="flex-1 p-8 overflow-y-auto">
<div class="bg-white p-8 rounded-3xl border-2 border-green-600">

<!-- TITLE -->
<div class="flex justify-between items-center mb-6">
    <h2 class="text-3xl font-black">Suppliers</h2>
</div>

<!-- SEARCH -->
<div class="relative mb-6">
    <input id="supplierSearch" type="text" placeholder="Search"
           class="w-full border-2 border-[#009a49] rounded-lg px-4 py-2 pr-10">
    <i class="fas fa-search absolute right-3 top-2.5 text-[#009a49]"></i>
</div>

<!-- TABLE -->
<div class="overflow-x-auto">
<table class="w-full border-collapse">

<thead>
<tr>
    <th class="border p-2">Supplier ID</th>
    <th class="border p-2">Supplier Name</th>
    <th class="border p-2">Email</th>
    <th class="border p-2">Phone</th>
    <th class="border p-2">Address</th>
    <th class="border p-2">Action</th>
</tr>
</thead>

<tbody>
<%
    if (suppliers != null && !suppliers.isEmpty()) {
        for (Supplier s : suppliers) {
%>
<tr>
    <td><%= s.getSupplierId() %></td>
	<td><%= s.getName() %></td>
    <td><%= s.getEmail() %></td>
    <td><%= s.getPhone() %></td>
    <td><%= s.getAddress() %></td>
	<td>
        <div class="relative group flex flex-col items-center">
            <i class="fas fa-eye text-black hover:scale-150 transition text-lg cursor-pointer"
               data-id="<%= s.getSupplierId() %>"
               data-name="<%= s.getName() %>"
               data-email="<%= s.getEmail() %>"
               data-phone="<%= s.getPhone() %>"
               data-address="<%= s.getAddress() %>"
               onclick="openViewSupplierModal(this)"></i>
            <span
				class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 hidden group-hover:block bg-black text-white text-[10px]
				 py-1 px-2 rounded shadow-lg whitespace-nowrap z-50">View
			</span>
		</div>
</tr>
<%
        }
    } else {
%>
<tr>
    <td colspan="6" class="text-center py-6 text-gray-500">
        No suppliers found
    </td>
</tr>
<%
    }
%>
</tbody>

</table>
</div>
</div>
</main>
</div>

<!-- ===== VIEW SUPPLIER MODAL ===== -->
<div id="viewSupplierModal"
     class="fixed inset-0 bg-black bg-opacity-50 hidden
            flex items-center justify-center z-50">

<div class="bg-white rounded-2xl border-2 border-[#009a49]
            w-[800px] p-8">

    <h3 class="text-green-700 font-bold mb-4">
        COMPANY INFORMATION
    </h3>

    <div class="grid grid-cols-2 gap-6 mb-6">
        <div>
            <label>Supplier Name</label>
            <input id="viewSupplierName" class="w-full border p-2" readonly>
        </div>

        <div>
            <label>Supplier ID</label>
            <input id="viewSupplierId" class="w-full border p-2 bg-gray-200" readonly>
        </div>
    </div>

    <h3 class="text-green-700 font-bold mb-2">
        CONTACT INFORMATION
    </h3>

    <div class="grid grid-cols-2 gap-6 mb-6">
        <div>
            <label>Email</label>
            <input id="viewSupplierEmail" class="w-full border p-2" readonly>
        </div>

        <div>
            <label>Phone Number</label>
            <input id="viewSupplierPhone" class="w-full border p-2" readonly>
        </div>
    </div>

    <h3 class="text-green-700 font-bold mb-2">
        BUSINESS ADDRESS
    </h3>

    <textarea id="viewSupplierAddress"
              class="w-full border p-3 h-24"
              readonly></textarea>

    <div class="flex justify-end mt-6">
        <button onclick="closeViewSupplierModal()"
                class="bg-red-500 text-white px-8 py-2 rounded-full">
            Close
        </button>
    </div>
</div>
</div>

<script>
function openViewSupplierModal(el) {
    document.getElementById('viewSupplierId').value = el.dataset.id;
    document.getElementById('viewSupplierName').value = el.dataset.name;
    document.getElementById('viewSupplierEmail').value = el.dataset.email;
    document.getElementById('viewSupplierPhone').value = el.dataset.phone;
    document.getElementById('viewSupplierAddress').value = el.dataset.address;

    document.getElementById('viewSupplierModal').classList.remove('hidden');
}

function closeViewSupplierModal() {
    document.getElementById('viewSupplierModal').classList.add('hidden');
}
</script>

</body>
</html>
