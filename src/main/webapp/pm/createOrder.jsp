<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="com.petboss.model.Supplier" %>

<%
    String staffId = (String) session.getAttribute("staffId");
    List<Supplier> supplierList =
        (List<Supplier>) request.getAttribute("supplierList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Order</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
html, body {
    height: 100%;
    margin: 0;
    background-color: #fdf8e9;
}
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
</style>
</head>

<body class="font-sans flex flex-col h-screen">

<!-- ===== HEADER (DO NOT CHANGE) ===== -->
<header class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
    <h1 class="text-white text-2xl font-bold">Pet Boss Centre Cash and Carry</h1>

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
        </a>

        <a href="<%=request.getContextPath()%>/profile"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-user-circle w-5 text-center"></i><span>Profile</span>
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

        <a href="<%=request.getContextPath()%>/order"
           class="mx-auto w-[85%] h-11 bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-file-invoice w-5 text-center"></i><span>Order</span>
        </a>

        <a href="<%=request.getContextPath()%>/receive-product"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-box-open w-5 text-center"></i><span>Receive Product</span>
        </a>

        <a href="<%=request.getContextPath()%>/product-qc"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-check-circle w-5 text-center"></i><span>Product QC</span>
        </a>
    </nav>

	<div class="flex justify-center mt-auto pb-4">
	    <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
	    	class="w-36 sm:w-40 md:w-44 opacity-100">
	</div>
</aside>

<!-- ================= MAIN ================= -->
<main class="flex-1 overflow-auto p-6">

<form action="<%=request.getContextPath()%>/pm/createOrder"
      method="post"
      onsubmit="return validateForm();">


<!-- ===== CONTENT CARD ===== -->
<div class="bg-white p-8 rounded-2xl border-2 border-green-600 max-w-7xl mx-auto">

<!-- ===== TITLE INSIDE SAME WHITE BOX ===== -->
<div class="flex items-center gap-4 mb-4">
    <a href="<%=request.getContextPath()%>/order"
       class="text-green-700 text-2xl hover:text-green-900">
        <i class="fas fa-arrow-left"></i>
    </a>
    <h2 class="text-3xl font-black text-cyan-900">ADD ORDER</h2>
</div>

<!-- ===== GREEN DIVIDER ===== -->
<hr class="border-green-600 mb-6">

<!-- ================= ORDER HEADER ================= -->
<div class="grid grid-cols-3 gap-6 mb-8">

    <!-- ORDER DETAILS (BIGGER) -->
    <div class="col-span-2 border-2 border-green-600 rounded-xl p-6">
        <h3 class="font-black text-lg mb-3 text-left text-green-700">
    ORDER DETAILS
</h3>

        <div class="grid grid-cols-3 gap-6">
            <div>
                <label class="font-semibold">Supplier</label>
                <select name="supplierId" id="supplierSelect" required
                        class="w-full border p-2 rounded">
                    <option value="">Select Supplier</option>
                    <% if (supplierList != null) {
                       for (Supplier s : supplierList) { %>
                    <option value="<%=s.getSupplierId()%>"><%=s.getName()%></option>
                    <% }} %>
                </select>
            </div>

            <div>
                <label class="font-semibold">Order By</label>
              <input type="text" value="<%=staffId%>" readonly
     				  title="This field is auto-filled and cannot be edited"
      				 class="w-full border p-2 bg-gray-100 cursor-not-allowed">
            </div>

            <div>
                <label class="font-semibold">Order Date</label>
                <input type="date" name="orderDate" id="orderDate" required
                       max="<%= java.time.LocalDate.now() %>"
                       class="w-full border p-2">
            </div>
        </div>
    </div>

    <!-- ORDER SUMMARY (JUST NICE) -->
    <div class="border-2 border-green-600 rounded-xl p-6">
        <h3 class="font-black text-lg mb-3 text-left text-green-700">
    ORDER SUMMARY
</h3>

        <div class="space-y-2 text-sm">
            <div class="flex justify-between"><span>Items</span><span id="sumItems">0</span></div>
            <div class="flex justify-between"><span>Subtotal</span><span id="sumSubtotal">0.00</span></div>
            <div class="flex justify-between"><span>Tax (6%)</span><span id="sumTax">0.00</span></div>
            <hr>
            <div class="flex justify-between font-bold text-green-700">
                <span>Grand Total</span><span id="sumGrand">0.00</span>
            </div>
        </div>
    </div>

</div>

<!-- ================= PRODUCT SECTION (UNCHANGED) ================= -->
<div class="border-2 border-green-600 rounded-xl p-6">

<p id="addProductHint" class="text-sm text-gray-500 mb-2">
Please select supplier and order date first
</p>

<button type="button"
        id="addProductBtn"
        onclick="openModal()"
        disabled
        class="bg-gray-300 text-gray-600 px-6 py-2 rounded-full
               mb-6 cursor-not-allowed
               transition-all duration-200">
    + Add Product
</button>


<table class="w-full mb-6">
<thead>
<tr>
<th>Product ID</th>
<th>Product</th>
<th>Quantity</th>
<th>Unit Price</th>
<th>Total</th>
<th>Action</th>
</tr>
</thead>

<tbody id="orderBody">
<tr>
<td colspan="6" class="italic text-gray-500">No product added</td>
</tr>
</tbody>
</table>

<div class="flex justify-end gap-6 mt-6">

<a href="<%=request.getContextPath()%>/order"
   class="w-32 h-11 flex items-center justify-center
          bg-gray-500 text-white rounded-full
          transition-all duration-200
          hover:bg-gray-600 hover:shadow-md hover:-translate-y-0.5">
    Cancel
</a>

<button type="submit"
        class="w-32 h-11 flex items-center justify-center
               bg-green-600 text-white rounded-full
               transition-all duration-200
               hover:bg-green-700 hover:shadow-md hover:-translate-y-0.5
               active:translate-y-0">
    Save
</button>

<input type="hidden" name="productId[]" id="productIds">
<input type="hidden" name="quantity[]" id="quantities">
<input type="hidden" name="unitPrice[]" id="unitPrices">
<input type="hidden" name="total[]" id="totals">

</div>
</form>
</main>
</div>


<!-- ================= MODAL ================= -->
<div id="addProductModal"
     class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center hidden z-50">

<div class="bg-white p-6 w-[400px] rounded-xl border-2 border-green-600">
<h3 class="text-xl font-bold mb-4">Add Product</h3>

<label class="text-sm font-semibold">Product</label>
<select id="productSelect" onchange="onProductChange()"
        class="w-full border p-2 mb-3">
<option value="">Select product</option>
</select>

<label class="text-sm font-semibold">Product ID</label>
<input id="productId" readonly class="w-full border p-2 mb-3 bg-gray-100">

<label class="text-sm font-semibold">Quantity</label>
<input id="quantity" type="number" value="1" min="1"
       oninput="calculateTotal()"
       class="w-full border p-2 mb-3">

<label class="text-sm font-semibold">Unit Price</label>
<input id="unitPrice" readonly class="w-full border p-2 mb-3 bg-gray-100">

<label class="text-sm font-semibold">Total</label>
<input id="total" readonly class="w-full border p-2 bg-gray-100">

<div class="flex justify-end gap-3 mt-4">
<button type="button" onclick="closeModal()"
        class="bg-gray-400 text-white px-4 py-2 rounded">Cancel</button>
<button type="button" onclick="saveItem()"
        class="bg-green-600 text-white px-4 py-2 rounded">Save</button>
</div>
</div>
</div>

<!-- ================= SCRIPT ================= -->
<script>
let orderItems = [];

// ===== ELEMENT REFERENCES =====
const supplierSelect = document.getElementById("supplierSelect");
const orderDateInput = document.getElementById("orderDate");
const addProductBtn = document.getElementById("addProductBtn");
const addProductHint = document.getElementById("addProductHint");

// ===== EVENT LISTENERS =====
supplierSelect.addEventListener("change", checkHeaderInfo);
orderDateInput.addEventListener("change", checkHeaderInfo);

// ===== ENABLE / DISABLE ADD PRODUCT =====
function checkHeaderInfo(){
    if(supplierSelect.value && orderDateInput.value){
        addProductBtn.disabled = false;
        addProductBtn.classList.remove("bg-gray-300","text-gray-600","cursor-not-allowed");
        addProductBtn.classList.add("bg-green-600","text-white");
        addProductHint.classList.add("hidden");
    } else {
        addProductBtn.disabled = true;
        addProductBtn.classList.remove("bg-green-600","text-white");
        addProductBtn.classList.add("bg-gray-300","text-gray-600","cursor-not-allowed");
        addProductHint.classList.remove("hidden");
    }
}

// ===== LOCK / UNLOCK HEADER FIELDS (READONLY, NOT DISABLED) =====
function lockHeaderFields(){
    supplierSelect.setAttribute("readonly", true);
    orderDateInput.setAttribute("readonly", true);

    supplierSelect.classList.add("bg-gray-100","cursor-not-allowed");
    orderDateInput.classList.add("bg-gray-100","cursor-not-allowed");
}

function unlockHeaderFields(){
    supplierSelect.removeAttribute("readonly");
    orderDateInput.removeAttribute("readonly");

    supplierSelect.classList.remove("bg-gray-100","cursor-not-allowed");
    orderDateInput.classList.remove("bg-gray-100","cursor-not-allowed");
}

// ===== FORM VALIDATION =====
function validateForm(){
    if(orderItems.length === 0){
        alert("Please add at least one product");
        return false;
    }
    return true;
}

// ===== MODAL HANDLING =====
function openModal(){
    if(addProductBtn.disabled){
        alert("Please select supplier and order date first.");
        return;
    }

    document.getElementById("addProductModal").classList.remove("hidden");

    fetch("<%=request.getContextPath()%>/api/products")
        .then(r => r.json())
        .then(data => {
            const s = document.getElementById("productSelect");
            s.innerHTML = "<option value=''>Select product</option>";
            data.forEach(p => {
                const o = document.createElement("option");
                o.value = p.id;
                o.textContent = p.name;
                o.dataset.price = p.price;
                s.appendChild(o);
            });
        });
}

function closeModal(){
    document.getElementById("addProductModal").classList.add("hidden");
}

// ===== PRODUCT SELECTION =====
function onProductChange(){
    const s = document.getElementById("productSelect");
    const o = s.options[s.selectedIndex];

    document.getElementById("productId").value = o.value || "";
    document.getElementById("unitPrice").value = o.dataset.price || "";
    calculateTotal();
}

function calculateTotal(){
    const q = Number(document.getElementById("quantity").value || 0);
    const p = Number(document.getElementById("unitPrice").value || 0);
    document.getElementById("total").value = (q * p).toFixed(2);
}

// ===== SAVE PRODUCT =====
function saveItem(){
    const s = document.getElementById("productSelect");
    const o = s.options[s.selectedIndex];
    if(!o.value){
        alert("Select product");
        return;
    }

    const pid = o.value;
    const qty = Number(document.getElementById("quantity").value);
    const price = Number(document.getElementById("unitPrice").value);

    const exist = orderItems.find(i => i.productId === pid);
    if(exist){
        exist.quantity += qty;
        exist.total = exist.quantity * price;
    } else {
        orderItems.push({
            productId: pid,
            productName: o.text,
            quantity: qty,
            unitPrice: price,
            total: qty * price
        });
    }

    renderTable();
    updateHidden();
    updateSummary();
    closeModal();

    // LOCK supplier & date after first product
    lockHeaderFields();
}

// ===== RENDER TABLE =====
function renderTable(){
    const body = document.getElementById("orderBody");
    body.innerHTML = "";

    if(orderItems.length === 0){
        body.innerHTML =
            "<tr><td colspan='6' class='italic text-gray-500'>No product added</td></tr>";
        return;
    }

    orderItems.forEach((i, idx) => {
        body.innerHTML +=
            "<tr>" +
            "<td>" + i.productId + "</td>" +
            "<td>" + i.productName + "</td>" +
            "<td>" + i.quantity + "</td>" +
            "<td>" + i.unitPrice.toFixed(2) + "</td>" +
            "<td>" + i.total.toFixed(2) + "</td>" +
            "<td><i class='fas fa-trash cursor-pointer' onclick='removeItem(" + idx + ")'></i></td>" +
            "</tr>";
    });
}

// ===== REMOVE PRODUCT =====
function removeItem(index){
    orderItems.splice(index, 1);
    renderTable();
    updateHidden();
    updateSummary();

    // UNLOCK if no products left
    if(orderItems.length === 0){
        unlockHeaderFields();
        checkHeaderInfo();
    }
}

// ===== UPDATE HIDDEN INPUTS =====
function updateHidden(){
    productIds.value = orderItems.map(i => i.productId).join(",");
    quantities.value = orderItems.map(i => i.quantity).join(",");
    unitPrices.value = orderItems.map(i => i.unitPrice).join(",");
    totals.value = orderItems.map(i => i.total).join(",");
}

// ===== UPDATE SUMMARY =====
function updateSummary(){
    let subtotal = 0;
    orderItems.forEach(i => subtotal += i.total);

    const tax = subtotal * 0.06;

    document.getElementById("sumItems").innerText = orderItems.length;
    document.getElementById("sumSubtotal").innerText = subtotal.toFixed(2);
    document.getElementById("sumTax").innerText = tax.toFixed(2);
    document.getElementById("sumGrand").innerText = (subtotal + tax).toFixed(2);
}
</script>

</body>
</html>