<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.petboss.model.Supplier"%>

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

/* ===== VIEW-ONLY FIELD (🚫 cursor) ===== */
.view-only {
	cursor: not-allowed !important;
}

.view-only:hover {
	box-shadow: inset 0 0 0 1px #9ca3af;
}

/* ===== MODAL ACTION BUTTON GROUP ===== */
.modal-actions {
    display: flex;
    justify-content: flex-end;
    gap: 16px;
    margin-top: 32px; /* space from last field */
}

/* ===== COMMON BUTTON SIZE ===== */
.modal-btn {
    width: 140px;
    height: 44px;
    border-radius: 999px;
    font-weight: 700;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
}

/* ===== CANCEL / CLOSE ===== */
.btn-cancel {
    background: #ef4444;
    color: white;
}

.btn-cancel:hover {
    background: #dc2626;
    transform: scale(1.08);
    box-shadow: 0 6px 14px rgba(0,0,0,0.2);
}

/* ===== SAVE ===== */
.btn-save {
    background: #16a34a;
    color: white;
}

.btn-save:hover {
    background: #15803d;
    transform: scale(1.08);
    box-shadow: 0 6px 14px rgba(0,0,0,0.25);
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

		<!-- MAIN -->
		<main class="flex-1 p-8 overflow-y-auto">

			<div
				class="bg-white border-2 border-[#009a49] rounded-2xl p-6 shadow">

				<!-- TITLE ROW -->
				<div class="flex justify-between items-center mb-4">
					<h2 class="text-3xl font-black text-cyan-900">SUPPLIER</h2>

					<a href="<%=request.getContextPath()%>/pm/addSupplier"
						class="ml-auto bg-green-600 text-white px-6 py-3 rounded-full font-semibold create-btn">
						<i class="fas fa-plus mr-2"></i> Add Supplier
					</a>

				</div>

				<!-- DIVIDER -->
				<hr class="border-green-600 mb-6">

				<!-- SEARCH -->
				<div class="search-form">

					<div class="search-box">
						<input type="text" id="searchInput"
							placeholder="Search Supplier by ID, Name or Email"
							class="search-input"> <i
							class="fas fa-search search-icon"></i>
					</div>
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
								<th class="border p-2">Action</th>
							</tr>
						</thead>

						<tbody>
							<%
							if (suppliers != null && !suppliers.isEmpty()) {
								for (Supplier s : suppliers) {
							%>
							<tr>
								<td><%=s.getSupplierId()%></td>
								<td><%=s.getName()%></td>
								<td><%=s.getEmail()%></td>
								<td><%=s.getPhone()%></td>
								<td>
									<div class="inline-flex gap-4 justify-center">

										<!-- 👁️ VIEW -->
										<div class="relative group flex flex-col items-center">
											<i
												class="fas fa-eye text-black hover:scale-150 transition text-lg cursor-pointer"
												data-id="<%=s.getSupplierId()%>"
												data-name="<%=s.getName()%>" data-email="<%=s.getEmail()%>"
												data-phone="<%=s.getPhone()%>"
												data-address="<%=s.getAddress()%>"
												onclick="openViewSupplierModal(this)"></i> <span
												class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 hidden group-hover:block
                bg-black text-white text-[10px] py-1 px-2 rounded shadow-lg whitespace-nowrap z-50">
												View </span>
										</div>

										<!-- ✏️ EDIT (still allowed for PM) -->
										<div class="relative group flex flex-col items-center">
											<i
												class="fas fa-pencil-alt text-black hover:scale-150 transition text-lg cursor-pointer"
												data-id="<%=s.getSupplierId()%>"
												data-name="<%=s.getName()%>" data-email="<%=s.getEmail()%>"
												data-phone="<%=s.getPhone()%>"
												data-address="<%=s.getAddress()%>"
												onclick="openEditSupplierModal(this)"></i> <span
												class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 hidden group-hover:block
                bg-black text-white text-[10px] py-1 px-2 rounded shadow-lg whitespace-nowrap z-50">
												Update </span>
										</div>

									</div>
								</td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="6" class="text-center py-6 text-gray-500">No
									suppliers found</td>
							</tr>
							<%
							}
							%>
						</tbody>

					</table>
<div class="flex justify-between items-center mt-6">

    <div id="pagination"
         class="flex items-center gap-2 bg-gray-100 px-4 py-2 rounded-full">
    </div>

    <div class="flex items-center gap-2 text-sm">
        <span class="text-gray-600">Rows:</span>
        <select id="rowsPerPageSelect"
                class="border border-gray-300 rounded-full px-3 py-1">
            <option value="5">5 / page</option>
            <option value="8" selected>8 / page</option>
            <option value="10">10 / page</option>
        </select>
    </div>

</div>



				</div>
			</div>
		</main>
	</div>

	<!-- ===== VIEW SUPPLIER MODAL ===== -->
	<div id="viewSupplierModal"
		class="fixed inset-0 bg-black bg-opacity-50 hidden
            flex items-center justify-center z-50">

		<div
			class="bg-white rounded-2xl border-2 border-[#009a49]
            w-[800px] p-8">

			<h3 class="text-green-700 font-bold mb-2">COMPANY INFORMATION</h3>

			<div class="grid grid-cols-2 gap-6 mb-6">
				<div>
					<label class="text-sm font-semibold text-gray-700">
						Supplier Name </label> <input id="viewSupplierName"
						class="w-full border border-gray-300 rounded-md
              p-2 bg-gray-50 view-only"
						readonly>

				</div>

				<div>
					<label class="text-sm font-semibold text-gray-700">
						Supplier ID </label> <input id="viewSupplierId"
						class="w-full border border-gray-300 rounded-md
              p-2 bg-gray-200 view-only"
						readonly>

				</div>
			</div>


			<h3 class="text-green-700 font-bold mb-2">CONTACT INFORMATION</h3>

			<div class="grid grid-cols-2 gap-6 mb-6">
				<div>
					<label class="text-sm font-semibold text-gray-700"> Email </label>
					<input id="viewSupplierEmail"
						class="w-full border border-gray-300 rounded-md
              p-2 bg-gray-50 view-only"
						readonly>

				</div>

				<div>
					<label class="text-sm font-semibold text-gray-700"> Phone
						Number </label> <input id="viewSupplierPhone"
						class="w-full border border-gray-300 rounded-md
              p-2 bg-gray-50 view-only"
						readonly>

				</div>
			</div>


			<h3 class="text-green-700 font-bold mb-2">BUSINESS ADDRESS</h3>

			<label class="text-sm font-semibold text-gray-700"> Address </label>
			<textarea id="viewSupplierAddress"
				class="w-full border border-gray-300 rounded-md
                 p-3 h-24 bg-gray-50 view-only"
				readonly></textarea>

<div class="modal-actions">
    <button onclick="closeViewSupplierModal()"
            class="modal-btn btn-cancel">
        Close
    </button>
</div>

	</div>
	</div>

	<!-- ===== EDIT SUPPLIER MODAL ===== -->
	<div id="editSupplierModal"
		class="fixed inset-0 bg-black bg-opacity-50 hidden
            flex items-center justify-center z-50">

		<form action="<%=request.getContextPath()%>/updateSupplier"
			method="post"
			class="bg-white rounded-2xl border-2 border-[#009a49]
             w-[800px] p-8">

			<!-- ===== COMPANY INFORMATION ===== -->
			<h3 class="text-green-700 font-bold mb-2">COMPANY INFORMATION</h3>

			<div class="grid grid-cols-2 gap-6 mb-6">
				<div>
					<label class="text-sm font-semibold text-gray-700">
						Supplier Name </label> <input name="supplierName" id="editSupplierName"
						class="w-full border border-gray-300 rounded-md
                          p-2 bg-white">
				</div>

				<div>
					<label class="text-sm font-semibold text-gray-700">
						Supplier ID </label> <input name="supplierId" id="editSupplierId"
						class="w-full border border-gray-300 rounded-md
                          p-2 bg-gray-200 cursor-not-allowed"
						readonly>
				</div>
			</div>

			<!-- ===== CONTACT INFORMATION ===== -->
			<h3 class="text-green-700 font-bold mb-2">CONTACT INFORMATION</h3>

			<div class="grid grid-cols-2 gap-6 mb-6">
				<div>
					<label class="text-sm font-semibold text-gray-700"> Email </label>
					<input name="email" id="editSupplierEmail"
						class="w-full border border-gray-300 rounded-md
                          p-2 bg-white">
				</div>

				<div>
					<label class="text-sm font-semibold text-gray-700"> Phone
						Number </label> <input name="phone" id="editSupplierPhone"
						class="w-full border border-gray-300 rounded-md
                          p-2 bg-white">
				</div>
			</div>

			<!-- ===== BUSINESS ADDRESS ===== -->
			<h3 class="text-green-700 font-bold mb-2">BUSINESS ADDRESS</h3>

			<label class="text-sm font-semibold text-gray-700"> Address </label>
			<textarea name="address" id="editSupplierAddress"
				class="w-full border border-gray-300 rounded-md
                     p-3 h-24 bg-white"></textarea>

			<!-- ===== ACTION BUTTONS ===== -->
<div class="modal-actions">
    <button type="button"
            onclick="closeEditSupplierModal()"
            class="modal-btn btn-cancel">
        Cancel
    </button>

    <button type="submit"
            class="modal-btn btn-save">
        Save
    </button>
</div>

	</form>
	</div>

<script>
/* =====================================================
   GLOBAL VARIABLES (SAME AS PRODUCT)
   ===================================================== */
let rowsPerPage = 8;
let currentPage = 1;

const supplierSearch = document.getElementById("searchInput");
const tableBody = document.querySelector("tbody");
const pagination = document.getElementById("pagination");
const rowsPerPageSelect = document.getElementById("rowsPerPageSelect");
const contextPath = "<%=request.getContextPath()%>";

let typingTimer;

/* =====================================================
   ROWS PER PAGE CHANGE (CLONE PRODUCT)
   ===================================================== */
rowsPerPageSelect.addEventListener("change", () => {
    rowsPerPage = Number(rowsPerPageSelect.value);
    currentPage = 1;
    paginateTable();
});

/* =====================================================
   PAGINATION FUNCTION (CLONE PRODUCT)
   ===================================================== */
function paginateTable() {

    const rows = document.querySelectorAll("tbody tr");
    pagination.innerHTML = "";

    if (rows.length === 0) return;

    const totalPages = Math.ceil(rows.length / rowsPerPage);

    // hide all rows
    rows.forEach(row => row.style.display = "none");

    // show current page rows
    rows.forEach((row, index) => {
        if (
            index >= (currentPage - 1) * rowsPerPage &&
            index < currentPage * rowsPerPage
        ) {
            row.style.display = "";
        }
    });

    /* ===== PREVIOUS BUTTON ===== */
    const prevBtn = document.createElement("button");
    prevBtn.innerHTML = "&#8249;";
    prevBtn.disabled = currentPage === 1;
    prevBtn.className =
        "px-3 py-1 rounded-full " +
        (prevBtn.disabled
            ? "text-gray-400 cursor-not-allowed"
            : "hover:bg-white");

    prevBtn.onclick = () => {
        currentPage--;
        paginateTable();
    };
    pagination.appendChild(prevBtn);

    /* ===== PAGE NUMBERS ===== */
    const maxVisible = 5;
    let start = Math.max(1, currentPage - 2);
    let end = Math.min(totalPages, start + maxVisible - 1);

    if (start > 1) {
        addPageButton(1);
        addEllipsis();
    }

    for (let i = start; i <= end; i++) {
        addPageButton(i);
    }

    if (end < totalPages) {
        addEllipsis();
        addPageButton(totalPages);
    }

    /* ===== NEXT BUTTON ===== */
    const nextBtn = document.createElement("button");
    nextBtn.innerHTML = "&#8250;";
    nextBtn.disabled = currentPage === totalPages;
    nextBtn.className =
        "px-3 py-1 rounded-full " +
        (nextBtn.disabled
            ? "text-gray-400 cursor-not-allowed"
            : "hover:bg-white");

    nextBtn.onclick = () => {
        currentPage++;
        paginateTable();
    };
    pagination.appendChild(nextBtn);

    /* ===== HELPERS ===== */
    function addPageButton(page) {
        const btn = document.createElement("button");
        btn.innerText = page;
        btn.className =
            page === currentPage
                ? "px-3 py-1 rounded-full bg-indigo-100 text-indigo-700 font-bold"
                : "px-3 py-1 rounded-full hover:bg-white";

        btn.onclick = () => {
            currentPage = page;
            paginateTable();
        };
        pagination.appendChild(btn);
    }

    function addEllipsis() {
        const span = document.createElement("span");
        span.innerText = "...";
        span.className = "px-2 text-gray-400";
        pagination.appendChild(span);
    }
}

/* =====================================================
   AJAX LOAD SUPPLIERS + PAGINATION SYNC
   ===================================================== */
function loadSuppliers() {

    fetch(
        contextPath +
        "/supplier?ajax=true&keyword=" +
        encodeURIComponent(supplierSearch.value || "")
    )
    .then(res => res.json())
    .then(data => {

        tableBody.innerHTML = "";

        if (!data || data.length === 0) {
            tableBody.innerHTML =
                "<tr>" +
                "<td colspan='5' class='py-6 text-center text-gray-500'>No suppliers found</td>" +
                "</tr>";
            paginateTable();
            return;
        }

        data.forEach(s => {
            tableBody.insertAdjacentHTML("beforeend",
                "<tr>" +
                    "<td>" + s.id + "</td>" +
                    "<td>" + s.name + "</td>" +
                    "<td>" + s.email + "</td>" +
                    "<td>" + s.phone + "</td>" +
                    "<td>" +
                        "<div class='inline-flex gap-4 justify-center'>" +

                        "<i class='fas fa-eye text-black hover:scale-150 transition cursor-pointer' " +
                        "data-id='" + s.id + "' data-name='" + s.name + "' " +
                        "data-email='" + s.email + "' data-phone='" + s.phone + "' " +
                        "data-address='" + s.address + "' onclick='openViewSupplierModal(this)'></i>" +

                        "<i class='fas fa-pencil-alt text-black hover:scale-150 transition cursor-pointer' " +
                        "data-id='" + s.id + "' data-name='" + s.name + "' " +
                        "data-email='" + s.email + "' data-phone='" + s.phone + "' " +
                        "data-address='" + s.address + "' onclick='openEditSupplierModal(this)'></i>" +

                        "</div>" +
                    "</td>" +
                "</tr>"
            );
        });

        currentPage = 1;
        paginateTable();
    });
}

/* =====================================================
   LIVE SEARCH (DEBOUNCE)
   ===================================================== */
supplierSearch.addEventListener("input", () => {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(loadSuppliers, 400);
});

/* =====================================================
   INITIAL LOAD
   ===================================================== */
document.addEventListener("DOMContentLoaded", paginateTable);

/* =========================
   VIEW SUPPLIER MODAL
   ========================= */
function openViewSupplierModal(el) {
    document.getElementById("viewSupplierId").value = el.dataset.id;
    document.getElementById("viewSupplierName").value = el.dataset.name;
    document.getElementById("viewSupplierEmail").value = el.dataset.email;
    document.getElementById("viewSupplierPhone").value = el.dataset.phone;
    document.getElementById("viewSupplierAddress").value = el.dataset.address;

    document.getElementById("viewSupplierModal").classList.remove("hidden");
}

function closeViewSupplierModal() {
    document.getElementById("viewSupplierModal").classList.add("hidden");
}

/* =========================
   EDIT SUPPLIER MODAL
   ========================= */
function openEditSupplierModal(el) {
    document.getElementById("editSupplierId").value = el.dataset.id;
    document.getElementById("editSupplierName").value = el.dataset.name;
    document.getElementById("editSupplierEmail").value = el.dataset.email;
    document.getElementById("editSupplierPhone").value = el.dataset.phone;
    document.getElementById("editSupplierAddress").value = el.dataset.address;

    document.getElementById("editSupplierModal").classList.remove("hidden");
}

function closeEditSupplierModal() {
    document.getElementById("editSupplierModal").classList.add("hidden");
}
</script>


</body>
</html>
