<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.petboss.model.Product"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Products</title>

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

input:disabled {
	cursor: not-allowed;
	background-color: #f3f4f6; /* light gray */
	color: #374151;
	border-color: #009a49;
}

/* ===== MODAL ACTION BUTTON GROUP ===== */
.modal-actions {
	display: flex;
	justify-content: flex-end;
	gap: 16px;
	margin-top: 32px;
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
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.2);
}

/* ===== SAVE ===== */
.btn-save {
	background: #16a34a;
	color: white;
}

.btn-save:hover {
	background: #15803d;
	transform: scale(1.08);
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.25);
}

/* ===== MODAL SECTION TITLE (UNIFIED) ===== */
.modal-section-title {
	font-size: 0.95rem; /* same size everywhere */
	font-weight: 700;
	color: #15803d; /* green-700 */
	margin-bottom: 1rem;
	padding-bottom: 0.25rem;
	border-bottom: 1px solid #bbf7d0; /* soft green divider */
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
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-users w-5 text-center"></i><span>Staff</span>
				</a> <a href="<%=request.getContextPath()%>/product"
					class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
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

		<!-- ===== MAIN ===== -->
		<main class="flex-1 p-8 overflow-y-auto">

			<div
				class="bg-white border-2 border-[#009a49] rounded-2xl p-6 shadow">

				<!-- TITLE ROW -->
				<div class="flex justify-between items-center mb-4">
					<h2 class="text-3xl font-black text-cyan-900">PRODUCT</h2>

					<a href="<%=request.getContextPath()%>/pm/addProduct"
						class="bg-green-600 hover:bg-green-700
                  text-white px-6 py-3 rounded-full font-semibold
                  shadow-md transition">
						+ Add Product </a>
				</div>

				<!-- DIVIDER -->
				<hr class="border-green-600 mb-6">

				<!-- SEARCH + FILTER (SAME STYLE AS ORDER) -->
				<!-- SEARCH -->
				<form method="get"
			      action="<%=request.getContextPath()%>/product"
			      class="search-form">
			
			    <!-- SEARCH -->
			    <div class="search-box">
			        <input type="text"
			               name="keyword"
			               value="<%=request.getParameter("keyword") != null ? request.getParameter("keyword") : ""%>"
			               placeholder="Search product by ID or Name"
			               class="search-input">
			        <i class="fas fa-search search-icon"></i>
			    </div>
			
			    <!-- FILTER -->
			    <div class="filter-box">
			        <div class="filter-container">
			
			            <div class="filter-icon">
			                <i class="fas fa-filter"></i>
			            </div>
			
			            <select name="category" class="filter-select">
						    <option value="">All Category</option>
						    <option value="PET_FOOD"
						        <%= "PET_FOOD".equals(request.getParameter("category")) ? "selected" : "" %>>
						        Pet Food
						    </option>
						    <option value="PET_MEDICINE"
						        <%= "PET_MEDICINE".equals(request.getParameter("category")) ? "selected" : "" %>>
						        Pet Medicine
						    </option>
						    <option value="PET_CARE"
						        <%= "PET_CARE".equals(request.getParameter("category")) ? "selected" : "" %>>
						        Pet Care
						    </option>
						    <option value="PET_ACCESSORY"
						        <%= "PET_ACCESSORY".equals(request.getParameter("category")) ? "selected" : "" %>>
						        Pet Accessory
						    </option>
						</select>

			
			            <i class="fas fa-caret-down filter-arrow"></i>
			        </div>
			    </div>
			
			    <!-- BUTTON -->
			    <button
			        class="bg-green-600 hover:bg-green-700
			               text-white px-6 rounded-full font-semibold shadow">
			        Search
			    </button>
			
			</form>

				<!-- TABLE -->
				<div class="overflow-x-hidden">
					<table class="w-full border-collapse">
						<thead>
							<tr>
								<th class="border p-2">Image</th>
								<th class="border p-2">Product ID</th>
								<th class="border p-2">Name</th>
								<th class="border p-2">Quantity</th>
								<th class="border p-2">Category</th>
								<th class="border p-2">Selling Price (RM)</th>
								<th class="border p-2">Action</th>
							</tr>
						</thead>

						<tbody>
							<%
							if (products != null && !products.isEmpty()) {
								for (Product p : products) {
							%>

							<tr class="product-row">

								<!-- IMAGE -->
								<td class="border p-2 text-center">
									<%
									if (p.getImage() != null) {
									%> <img
									src="<%=request.getContextPath()%>/product-image?file=<%=p.getImage()%>"
									class="h-10 mx-auto"> <%
 } else {
 %> — <%
 }
 %>
								</td>

								<td class="border p-2"><%=p.getProductId()%></td>
								<td class="border p-2 text-center"><%=p.getName()%></td>

								<td class="border p-2 text-center font-semibold"><%=p.getQuantity()%>
								</td>

								<td class="border p-2"><%=p.getCategory()%></td>

								<td class="border p-2 text-center">RM <%=String.format("%.2f", p.getSellingPrice())%>
								</td>

								<!-- ACTION -->
								<td class="border p-2 text-center">
									<div class="flex justify-center items-center gap-4">

										<!-- VIEW -->
										<div class="relative group">
											<i
												class="fas fa-eye text-black text-lg hover:scale-150 transition cursor-pointer"
												onclick="openViewModal(
                       '<%=p.getProductId()%>',
                       '<%=p.getName()%>',
                       '<%=p.getCategory()%>',
                       '<%=p.getBrand()%>',
                       <%=p.getQuantity()%>,
                       <%=p.getMinQuantity()%>,
                       <%=p.getPurchasePrice()%>,
                       <%=p.getSellingPrice()%>,
                       '<%=p.getImage()%>'
                   )"></i>

											<span
												class="absolute bottom-full mb-2 hidden group-hover:block
                             bg-black text-white text-[10px] px-2 py-1 rounded">
												View </span>
										</div>

	<!-- ===== VIEW PRODUCT MODAL ===== -->
	<div id="viewModal"
		class="fixed inset-0 bg-black bg-opacity-50 z-[110] hidden
            flex items-center justify-center p-4">

		<div
			class="bg-white w-full max-w-5xl rounded-3xl
           border-2 border-[#009a49] shadow-2xl
           overflow-hidden flex flex-col md:flex-row">


			<!-- ===== LEFT : PRODUCT PREVIEW ===== -->
			<div class="w-full md:w-1/3 bg-white p-6 border-r border-gray-200">
				<div
					class="border-2 border-[#009a49] rounded-xl p-4 h-full flex flex-col">

					<h3
						class="text-lg font-bold text-green-700 mb-4 border-b border-green-200 pb-1">PRODUCT
						PREVIEW</h3>

					<div
						class="w-full aspect-square bg-white rounded-lg mb-4
                        flex items-center justify-center overflow-hidden
                        border border-gray-100">
						<img id="viewImg" class="max-w-full max-h-full object-contain">
					</div>

					<div class="space-y-3 flex-grow">
						<div>
							<label class="text-[10px] font-bold text-gray-500 uppercase">
								Product Name </label> <input id="viewName"
								class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
								disabled>
						</div>

						<div>
							<label class="text-[10px] font-bold text-gray-500 uppercase">
								Category </label> <input id="viewCategory"
								class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
								disabled>
						</div>

						<div>
							<label class="text-[10px] font-bold text-gray-500 uppercase">
								Product Brand </label> <input id="viewBrand"
								class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
								disabled>
						</div>

						<div>
							<label class="text-[10px] font-bold text-gray-500 uppercase">
								SKU / Code / ID </label> <input id="viewId"
								class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
								disabled>
						</div>
					</div>
				</div>
			</div>

			<!-- ===== RIGHT : DETAILS ===== -->
			<div class="w-full md:w-2/3 p-8 flex flex-col h-full bg-gray-50">

				<div class="flex-grow space-y-8">

					<!-- STOCK -->
					<div
						class="bg-white rounded-2xl p-6 shadow-sm border border-green-100">
						<h4
							class="text-lg font-bold text-green-700 mb-4 border-b border-green-200 pb-1">
							STOCK DETAILS</h4>


						<div class="grid grid-cols-2 gap-6">

							<div>
								<label class="text-xs font-bold text-gray-600"> Current
									Quantity </label> <input id="viewQty"
									class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>

							<div>
								<label class="text-xs font-bold text-gray-600"> Minimum
									Quantity </label> <input id="viewMin"
									class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>
						</div>
					</div>

					<!-- PRICING -->
					<div
						class="bg-white rounded-2xl p-6 shadow-sm border border-green-100">
						<h4
							class="text-lg font-bold text-green-700 mb-4 border-b border-green-200 pb-1">
							PRICING</h4>



						<div class="grid grid-cols-2 gap-x-12 gap-y-4">
							<div>
								<label class="text-xs font-bold text-gray-600"> Purchase
									Price (RM) </label> <input id="viewBuy"
									class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>

							<div>
								<label class="text-xs font-bold text-gray-600"> Selling
									Price (RM) </label> <input id="viewSell"
									class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>
						</div>
					</div>

					<!-- CATEGORY DETAILS -->
					<div id="viewCategorySection"
						class="mt-10 hidden bg-white rounded-2xl p-6
            border border-dashed border-green-300">

						<h4
							class="text-green-700 font-bold mb-4
			               border-b border-green-200 pb-1">
							CATEGORY DETAILS</h4>

						<!-- PET MEDICINE -->
						<div id="view-cat-medicine"
							class="hidden grid grid-cols-2 gap-x-12 gap-y-4">

							<div>
								<label class="text-xs font-bold text-gray-600">Dosage</label> <input
									id="viewMedDosage"
									class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>

							<div>
								<label class="text-xs font-bold text-gray-600">Expiry
									Date</label> <input id="viewMedExpiry"
									class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>

							<div class="col-span-2">
								<label class="text-xs font-bold text-gray-600">Prescription</label>
								<input id="viewMedPrescription"
									class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>
						</div>

						<!-- PET FOOD -->
						<div id="view-cat-food"
							class="hidden grid grid-cols-2 gap-x-12 gap-y-4">
							<div>
								<label class="text-xs font-bold text-gray-600">Weight</label> <input
									id="viewFoodWeight"
									class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>
							<div>
								<label class="text-xs font-bold text-gray-600">Expiry
									Date</label> <input id="viewFoodExpiry"
									class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>
						</div>

						<!-- PET CARE -->
						<div id="view-cat-care"
							class="hidden grid grid-cols-2 gap-x-12 gap-y-4">
							<div>
								<label class="text-xs font-bold text-gray-600">Type</label> <input
									id="viewCareType"
									class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>
							<div>
								<label class="text-xs font-bold text-gray-600">Expiry
									Date</label> <input id="viewCareExpiry"
									class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
									disabled>
							</div>
						</div>

						<!-- PET ACCESSORY -->
						<div id="view-cat-accessory" class="hidden">
							<label class="text-xs font-bold text-gray-600">Material</label> <input
								id="viewAccMaterial"
								class="w-full border border-[#009a49]
			                      rounded-lg px-3 py-1.5 bg-gray-100"
								disabled>
						</div>

					</div>
				</div>

				<!-- ===== ACTION ===== -->
				<div class="modal-actions">
					<button type="button" onclick="closeViewModal()"
						class="modal-btn btn-cancel">Close</button>
				</div>

			</div>

		</div>
	</div>
	<script>
/* ===== VIEW ===== */
/* ===============================
   VIEW MODAL
   =============================== */
function openViewModal(id, name, cat, brand, qty, min, buy, sell, img) {

    document.getElementById("viewId").value = id;
    document.getElementById("viewName").value = name;
    document.getElementById("viewCategory").value = cat;
    document.getElementById("viewBrand").value = brand;
    document.getElementById("viewQty").value = qty;
    document.getElementById("viewMin").value = min;
    document.getElementById("viewBuy").value = buy;
    document.getElementById("viewSell").value = sell;

    document.getElementById("viewImg").src = img
        ? "<%=request.getContextPath()%>/product-image?file=" + img
        : "<%=request.getContextPath()%>/images/default-product.png";

    document.getElementById("viewModal").classList.remove("hidden");

    loadCategoryDetails(id, cat);
}

function closeViewModal() {
    document.getElementById("viewModal").classList.add("hidden");
}

function loadCategoryDetails(productId, category) {

    fetch("<%=request.getContextPath()%>/product-category?productId=" + productId + "&category=" + category)
    .then(res => res.json())
    .then(data => {

        document.getElementById("viewCategorySection").classList.add("hidden");
        document.querySelectorAll(
            "#view-cat-medicine, #view-cat-food, #view-cat-care, #view-cat-accessory"
        ).forEach(div => div.classList.add("hidden"));

        if (!data || Object.keys(data).length === 0) return;

        document.getElementById("viewCategorySection").classList.remove("hidden");

        if (category === "PET_MEDICINE") {
            document.getElementById("viewMedDosage").value = data.dosage || "-";
            document.getElementById("viewMedPrescription").value = data.prescription || "-";
            document.getElementById("viewMedExpiry").value = formatDate(data.expiry_date);
            document.getElementById("view-cat-medicine").classList.remove("hidden");
        }

        if (category === "PET_FOOD") {
            document.getElementById("viewFoodWeight").value = data.weight || "-";
            document.getElementById("viewFoodExpiry").value = formatDate(data.expiry_date);
            document.getElementById("view-cat-food").classList.remove("hidden");
        }

        if (category === "PET_CARE") {
            document.getElementById("viewCareType").value = data.type || "-";
            document.getElementById("viewCareExpiry").value = formatDate(data.expiry_date);
            document.getElementById("view-cat-care").classList.remove("hidden");
        }

        if (category === "PET_ACCESSORY") {
            document.getElementById("viewAccMaterial").value = data.material || "-";
            document.getElementById("view-cat-accessory").classList.remove("hidden");
        }
    });
}

function formatDate(dateStr) {
    return dateStr ? dateStr.split(" ")[0] : "-";
}

/* ===============================
ADVANCED PAGINATION (LIKE DESIGN)
=============================== */

let rowsPerPage = 10;
let currentPage = 1;

const rowsPerPageSelect = document.getElementById("rowsPerPageSelect");

rowsPerPageSelect.addEventListener("change", () => {
rowsPerPage = Number(rowsPerPageSelect.value);
currentPage = 1;
paginateTable();
});

function paginateTable() {

const rows = document.querySelectorAll("tbody tr");
const pagination = document.getElementById("pagination");
pagination.innerHTML = "";

if (rows.length === 0) return;

const totalPages = Math.ceil(rows.length / rowsPerPage);

// hide all rows
rows.forEach(r => r.style.display = "none");

// show current page rows
rows.forEach((row, index) => {
  if (
      index >= (currentPage - 1) * rowsPerPage &&
      index < currentPage * rowsPerPage
  ) {
      row.style.display = "";
  }
});

/* ===== PREV BUTTON ===== */
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

/* ===== INITIAL LOAD ===== */
document.addEventListener("DOMContentLoaded", paginateTable);

</script>
</body>
</html>

