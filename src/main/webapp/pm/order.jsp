<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>
<%@ page import="java.util.List"%>
<%@ page import="com.petboss.model.Order"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
String staffId = (String) session.getAttribute("staffId");

if (staffId == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}

List<Order> orderList = (List<Order>) request.getAttribute("orderList");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

if (orderList != null) {
	orderList.sort((o1, o2) -> {
		if (o1.getOrderDate() == null && o2.getOrderDate() == null)
	return 0;
		if (o1.getOrderDate() == null)
	return 1;
		if (o2.getOrderDate() == null)
	return -1;
		return o2.getOrderDate().compareTo(o1.getOrderDate()); // latest first
	});
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>ORDER</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
html, body {
	height: 100%;
	margin: 0;
	background-color: #fdf8e9;
}

/* ===== TABLE ===== */
th {
	background-color: #e6f4ea;
	border: 1px solid #009a49;
}

td {
	border: 1px solid #009a49;
	text-align: center;
	font-size: 0.85rem;
	padding: 8px;
}

/* ===== SEARCH BAR ===== */
.search-wrapper {
	position: relative;
	width: 600px;
}

.search-input {
	width: 100%;
	height: 40px;
	border: 2px solid #009a49;
	border-radius: 6px;
	padding: 0 40px 0 14px;
	font-size: 0.9rem;
	outline: none;
}

.search-input:focus {
	box-shadow: 0 0 0 2px rgba(0, 154, 73, 0.25);
}

.search-icon {
	position: absolute;
	right: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: #009a49;
}

/* ===== FILTER BOX ===== */
.filter-box {
	height: 40px;
	border: 2px solid #009a49;
	border-radius: 6px;
	padding: 0 14px;
	font-size: 0.9rem;
	background: white;
	cursor: pointer;
}

/* ===== ACTION ICON (EYE) ===== */
.eye-icon {
	display: inline-block;
	font-size: 1rem;
	color: #000;
	transition: transform 0.2s ease;
}

.eye-icon:hover {
	transform: scale(1.3);
}

.create-btn {
	transition: all 0.2s ease;
}

.create-btn:hover {
	background-color: #0f8f4f; /* slightly darker green */
	transform: translateY(-1px);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
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
			<nav class="flex-1 space-y-5">

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
				</a> <a href="<%=request.getContextPath()%>/order"
					class="mx-auto w-[85%] h-11 bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-file-invoice w-5 text-center"></i><span>Order</span>
				</a> <a href="<%=request.getContextPath()%>/receive-product"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box-open w-5 text-center"></i><span>Receive
						Order</span>
				</a> <a href="<%=request.getContextPath()%>/product-qc"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-check-circle w-5 text-center"></i><span>Product
						QC</span>
				</a>

			</nav>

			<div class="flex justify-center mt-auto pb-4">
				<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
					class="w-36 sm:w-40 md:w-44 opacity-100">
			</div>
		</aside>

		<!-- ================= MAIN ================= -->
		<main class="flex-1 p-8 overflow-y-auto">

			<div
				class="bg-white p-6 rounded-2xl border-2 border-[#009a49] shadow">

				<!-- ===== TITLE ===== -->
				<h2 class="text-3xl font-black text-cyan-900 mb-2">ORDER</h2>
				<hr class="border-green-600 mb-4">

				<!-- ===== SEARCH + FILTER ===== -->
				<div class="flex items-center gap-4 mb-6">

					<!-- SEARCH -->
					<div class="search-wrapper">
						<input id="searchInput" class="search-input"
							placeholder="Search Order by ID or Supplier"
							oninput="filterOrders()"> <i
							class="fas fa-search search-icon"></i>
					</div>

					<!-- FILTER -->
					<div class="relative">
						<i
							class="fas fa-filter absolute left-3 top-1/2 -translate-y-1/2 text-green-600"></i>

						<select id="yearFilter" class="filter-box pl-9"
							onchange="filterOrders()">
							<option value="">All Years</option>
							<%
							for (int y = 2022; y <= 2026; y++) {
							%>
							<option value="<%=y%>"><%=y%></option>
							<%
							}
							%>
						</select>
					</div>

					<!-- CREATE ORDER -->
					<a href="<%=request.getContextPath()%>/order?action=create"
						class="ml-auto bg-green-600 text-white px-6 py-3 rounded-full font-semibold create-btn">
						<i class="fas fa-plus mr-2"></i> Add Order
					</a>

				</div>


				<!-- ================= TABLE ================= -->
				<table class="w-full border-collapse" id="orderTable">
					<thead>
						<tr>
							<th>Order ID</th>
							<th>Supplier</th>
							<th>Order By</th>
							<th>Order Date</th>
							<th>Total (RM)</th>
							<th>Action</th>
						</tr>
					</thead>

					<tbody>
						<%
						if (orderList == null || orderList.isEmpty()) {
						%>
						<tr class="no-data">
							<td colspan="6" class="py-6 text-gray-500">No orders found</td>
						</tr>
						<%
						} else {
						for (Order o : orderList) {
						%>

						<tr>
							<td><%=o.getOrderId()%></td>
							<td><%=o.getSupplierName()%></td>
							<td><%=o.getStaffName()%></td>
							<td><%=o.getOrderDate() != null ? sdf.format(o.getOrderDate()) : "-"%></td>
							<td>RM <%=String.format("%.2f", o.getTotal())%></td>
							<td><a
								href="<%=request.getContextPath()%>/order?action=view&id=<%=o.getOrderId()%>">
									<i class="fas fa-eye eye-icon"></i>
							</a></td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
				<!-- ===== PAGINATION (SAME AS PRODUCT) ===== -->
				<div class="flex justify-between items-center mt-6">

					<!-- PAGE NUMBERS -->
					<div id="pagination"
						class="flex items-center gap-2 bg-gray-100 px-4 py-2 rounded-full">
					</div>

					<!-- ROWS PER PAGE -->
					<div class="flex items-center gap-2 text-sm">
						<span class="text-gray-600">Rows:</span> <select
							id="rowsPerPageSelect"
							class="border border-gray-300 rounded-full px-3 py-1 bg-white cursor-pointer">
							<option value="5">5 / page</option>
							<option value="8" selected>8 / page</option>
							<option value="10">10 / page</option>
						</select>
					</div>

				</div>

			</div>
		</main>
	</div>

<script>
/* ===============================
   SEARCH + FILTER (MARK ROWS ONLY)
   =============================== */
function filterOrders() {

    const search = document.getElementById("searchInput").value.toLowerCase();
    const year = document.getElementById("yearFilter").value;
    const rows = document.querySelectorAll("#orderTable tbody tr");

    rows.forEach(row => {
        if (row.classList.contains("no-data")) return;

        const text = row.innerText.toLowerCase();
        const dateCell = row.cells[3]?.innerText || "";
        const rowYear = dateCell.substring(0, 4);

        const matchSearch = text.includes(search);
        const matchYear = year === "" || rowYear === year;

        row.dataset.match = (matchSearch && matchYear) ? "1" : "0";
    });

    currentPage = 1;
    paginateTable();
}

/* ===============================
   PAGINATION (SAME AS PRODUCT)
   =============================== */
let rowsPerPage = 8;
let currentPage = 1;

const rowsPerPageSelect = document.getElementById("rowsPerPageSelect");

rowsPerPageSelect.addEventListener("change", () => {
    rowsPerPage = Number(rowsPerPageSelect.value);
    currentPage = 1;
    paginateTable();
});

function paginateTable() {

    const allRows = Array.from(
        document.querySelectorAll("#orderTable tbody tr")
    ).filter(r => !r.classList.contains("no-data"));

    const rows = allRows.filter(r => r.dataset.match !== "0");

    const pagination = document.getElementById("pagination");
    pagination.innerHTML = "";

    // hide everything first
    allRows.forEach(r => r.style.display = "none");

    if (rows.length === 0) return;

    const totalPages = Math.ceil(rows.length / rowsPerPage);

    rows.forEach((row, index) => {
        if (
            index >= (currentPage - 1) * rowsPerPage &&
            index < currentPage * rowsPerPage
        ) {
            row.style.display = "";
        }
    });

    /* ===== PREV ===== */
    addNav("‹", currentPage === 1, () => {
        currentPage--;
        paginateTable();
    });

    /* ===== PAGE NUMBERS ===== */
    for (let i = 1; i <= totalPages; i++) {
        const btn = document.createElement("button");
        btn.innerText = i;
        btn.className =
            i === currentPage
                ? "px-3 py-1 rounded-full bg-indigo-100 text-indigo-700 font-bold"
                : "px-3 py-1 rounded-full hover:bg-white";

        btn.onclick = () => {
            currentPage = i;
            paginateTable();
        };
        pagination.appendChild(btn);
    }

    /* ===== NEXT ===== */
    addNav("›", currentPage === totalPages, () => {
        currentPage++;
        paginateTable();
    });

    function addNav(label, disabled, action) {
        const btn = document.createElement("button");
        btn.innerHTML = label;
        btn.disabled = disabled;
        btn.className =
            "px-3 py-1 rounded-full " +
            (disabled
                ? "text-gray-400 cursor-not-allowed"
                : "hover:bg-white");
        btn.onclick = action;
        pagination.appendChild(btn);
    }
}

/* ===== INITIAL LOAD ===== */
document.addEventListener("DOMContentLoaded", () => {
    document
        .querySelectorAll("#orderTable tbody tr")
        .forEach(r => r.dataset.match = "1");
    paginateTable();
});
</script>


</body>
</html>
