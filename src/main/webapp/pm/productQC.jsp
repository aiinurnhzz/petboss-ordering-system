<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>

<%
String staffId = (String) session.getAttribute("staffId");
String staffName = (String) session.getAttribute("staffName");
String role = (String) session.getAttribute("role");

if (staffId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

List<Map<String,String>> qcList =
    (List<Map<String,String>>) request.getAttribute("qcList");

String tab = (String) request.getAttribute("tab");
if (tab == null) tab = "pending";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product QC</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
th { background:#e6f4ea; border:1px solid #009a49 }
td { border:1px solid #009a49; font-size:.85rem; padding:8px; text-align:center }
</style>
</head>

<body class="bg-[#fdf8e9] h-screen flex flex-col">

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

		<!-- ===== SIDEBAR (NO SCROLL, BALANCED VERSION) ===== -->
<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">

    <!-- ===== NAVIGATION ===== -->
    <nav class="flex-1 space-y-5">

        <a href="<%=request.getContextPath()%>/dashboard"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-home w-5 text-center"></i>
            <span>Home</span>
        </a>

        <a href="<%=request.getContextPath()%>/profile"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-user-circle w-5 text-center"></i>
            <span>Profile</span>
        </a>

        <a href="<%=request.getContextPath()%>/product"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-box w-5 text-center"></i>
            <span>Product</span>
        </a>

        <a href="<%=request.getContextPath()%>/supplier"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-truck w-5 text-center"></i>
            <span>Supplier</span>
        </a>

        <a href="<%=request.getContextPath()%>/order"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-file-invoice w-5 text-center"></i>
            <span>Order</span>
        </a>

        <a href="<%=request.getContextPath()%>/receive-product"
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-box-open w-5 text-center"></i>
            <span>Receive Product</span>
        </a>

        <a href="<%=request.getContextPath()%>/product-qc"
           class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-check-circle w-5 text-center"></i>
            <span>Product QC</span>
        </a>

    </nav>

   <!-- ===== LOGO (SAFE FOR SMALL SCREEN) ===== -->
	<div class="flex justify-center mt-auto pb-4">
	    <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
	    	class="w-36 sm:w-40 md:w-44 opacity-100">
	</div>
</aside>
<!-- ================= CONTENT ================= -->
<main class="flex-1 p-8 overflow-y-auto">

<div class="bg-white border-2 border-[#009a49] rounded-2xl p-6 shadow">

<h2 class="text-3xl font-black text-cyan-900 mb-4">PRODUCT QUALITY CHECK</h2>
<hr class="border-green-600 mb-6">

<!-- ===== TABS + SEARCH (MATCH RECEIVE ORDER) ===== -->
<div class="flex justify-between items-center mb-6">

    <!-- ===== TABS ===== -->
    <div class="flex gap-3">
        <a href="?tab=pending"
           class="tab-btn <%= "pending".equals(tab) ? "active" : "" %>">
            Pending QC
        </a>

        <a href="?tab=completed"
           class="tab-btn <%= "completed".equals(tab) ? "active" : "" %>">
            Completed QC
        </a>
    </div>

    <!-- ===== SEARCH ===== -->
    <div class="search-wrapper">
        <input id="searchInput"
               class="search-input"
               placeholder="Search Product QC by Batch Number or Product">
        <i class="fas fa-search search-icon"></i>
    </div>

</div>

<!-- ================= TABLE ================= -->
<table class="w-full">
<thead>
<tr>
<% if ("pending".equals(tab)) { %>
    <th>Product</th>
    <th>Batch Number</th>
    <th>Quantity Received</th>
    <th>Supplier</th>
    <th>Date</th>
    <th>Action</th>
<% } else { %>
    <th>QC ID</th>
    <th>Batch Number</th>
    <th>Product</th>
    <th>Quantity Received</th>
    <th>Action</th>
    <th>Details</th>
<% } %>
</tr>
</thead>



<tbody id="qcTable">

<% if (qcList != null && !qcList.isEmpty()) {
   for (Map<String,String> r : qcList) { %>

<tr>

<% if ("pending".equals(tab)) { %>

    <td><%= r.get("product") %></td>
    <td class="font-mono"><%= r.get("batch") %></td>
    <td><%= r.get("qty") %></td>
    <td><%= r.get("supplier") %></td>
    <td><%= r.get("date") %></td>

    <td>
        <button onclick="openQC(
            '<%=r.get("batch")%>',
            '<%=r.get("product")%>',
            '<%=r.get("supplier")%>',
            '<%=r.get("qty")%>'
        )"
        class="btn-check">
            Check
        </button>
    </td>

<% } else { %>

    <td><%= r.get("qcId") %></td>
    <td class="font-mono"><%= r.get("batch") %></td>
    <td><%= r.get("product") %></td>
    <td><%= r.get("qty") %></td>

    <td>
        <a href="<%=request.getContextPath()%>/product-qc?action=view&qcId=<%=r.get("qcId")%>"
           class="view-icon"
           title="View QC">
            <i class="fas fa-eye"></i>
        </a>
    </td>

    <td>
    <% if ("DAMAGED".equals(r.get("condition"))
           && r.get("returnQty") != null
           && Integer.parseInt(r.get("returnQty")) > 0) { %>

        <a href="<%=request.getContextPath()%>/return-note?qcId=<%=r.get("qcId")%>"
           class="btn-return">
            <i class="fas fa-print"></i> Return Note
        </a>

    <% } else { %>
        <span class="text-gray-400">-</span>
    <% } %>
    </td>

<% } %>

</tr>


<% }} else { %>
<tr>
<td colspan="8" class="py-6 text-center text-gray-500">
No records found
</td>
</tr>
<% } %>

</tbody>
</table>

</div>
</main>
</div>

<!-- ================= QC MODAL ================= -->
<form method="post" action="<%=request.getContextPath()%>/product-qc">
<div id="qcModal"
 class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50">

<div class="bg-white w-[900px] max-h-[90vh]
 rounded-2xl border-2 border-green-600 shadow-2xl overflow-y-auto p-8
 translate-x-6 -translate-y-6">

<!-- ===== PAGE TITLE ===== -->
<div class="text-left mb-8">
    <h2 class="text-3xl font-black text-cyan-900 tracking-wide">
        PRODUCT QUALITY CHECK FORM
    </h2>

    <!-- Green divider line -->
<hr class="mt-4 w-full border-t-2 border-green-600">
</div>


<div class="bg-green-50 border border-green-200 rounded-2xl p-6 mb-8
            grid grid-cols-1 md:grid-cols-2 gap-x-10 gap-y-4 text-sm">

    <p class="flex gap-2">
        <span class="font-bold text-gray-800 w-36 uppercase tracking-wide">Batch</span>
        <span class="text-gray-900">: <span id="mBatch"></span></span>
    </p>

    <p class="flex gap-2">
        <span class="font-bold text-gray-800 w-36 uppercase tracking-wide">Product</span>
        <span class="text-gray-900">: <span id="mProduct"></span></span>
    </p>

    <p class="flex gap-2">
        <span class="font-bold text-gray-800 w-36 uppercase tracking-wide">Supplier</span>
        <span class="text-gray-900">: <span id="mSupplier"></span></span>
    </p>

    <p class="flex gap-2">
        <span class="font-bold text-gray-800 w-36 uppercase tracking-wide">Checked By</span>
        <span class="text-gray-900">: <%= staffName %></span>
    </p>

    <p class="flex gap-2">
        <span class="font-bold text-gray-800 w-36 uppercase tracking-wide">Quantity Received</span>
        <span class="text-gray-900">: <span id="mQty"></span></span>
    </p>

    <p class="flex gap-2">
        <span class="font-bold text-gray-800 w-36 uppercase tracking-wide">Quality Check Date</span>
        <span class="text-gray-900">: <%= new java.sql.Date(System.currentTimeMillis()) %></span>
    </p>

</div>


<!-- REQUIRED BY BACKEND -->
<input type="hidden" name="batchNumber" id="batchInput">

<!-- ✅ SINGLE REMARKS FIELD (FINAL VALUE SENT TO SERVLET) -->
<input type="hidden" name="remarks" id="finalRemarks">
<input type="hidden" id="receivedQtyHidden" name="receivedQty">

<!-- CONDITION -->
<div class="mb-4">
<label class="font-bold">Inspection Result</label>
<div class="flex gap-8 mt-2">
<label>
    <input type="radio" name="condition" value="GOOD"
           onclick="showGood()" required>
    Good
</label>
<label>
    <input type="radio" name="condition" value="DAMAGED"
           onclick="showBad()">
    Damaged / Expired
</label>
</div>
</div>

<!-- GOOD -->
<div id="goodBox" class="hidden border rounded-xl p-4 mb-4 bg-gray-50">
<label class="font-bold">Remarks</label>
<textarea id="goodRemarks"
          class="w-full border rounded p-2"
          placeholder="Enter remarks for good condition"></textarea>
</div>

<!-- BAD -->
<div id="badBox" class="hidden border rounded-xl p-4 mb-4 bg-red-50">

<label class="font-bold">Quantity Damaged</label>
<input name="quantityDamaged" type="number" min="1"
 class="w-full border rounded p-2 mb-3">

<label class="font-bold">Returnable</label>
<div class="flex gap-6 mt-2 mb-3">
<label class="flex items-center gap-2">
  <input type="radio" name="returnable" value="Y"
         onclick="showReturn()">
  Yes
</label>

<label class="flex items-center gap-2">
  <input type="radio" name="returnable" value="N"
         onclick="hideReturn()">
  No
</label>
</div>

<div id="returnBox" class="hidden mb-3">
<label class="font-bold">Quantity to Return</label>
<input name="quantityReturn" type="number" min="1"
 class="w-full border rounded p-2">
</div>

<label class="font-bold">Remarks</label>
<textarea id="badRemarks"
          class="w-full border rounded p-2"
          placeholder="Enter remarks for damaged condition"></textarea>
</div>

<div class="flex justify-end gap-4">

    <!-- Cancel (same behavior, new style) -->
    <button type="button"
            onclick="closeQC()"
            class="w-32 h-11 flex items-center justify-center
                   bg-gray-500 text-white rounded-full
                   transition-all duration-200
                   hover:bg-gray-600 hover:shadow-md hover:-translate-y-0.5">
        Cancel
    </button>

    <!-- Save (same behavior, new style) -->
   <button type="submit"
        id="saveBtn"
        disabled
        onclick="prepareRemarks(); return validateQuantities();"
        class="w-32 h-11 flex items-center justify-center
               bg-green-600 text-white rounded-full
               transition-all duration-200
               hover:bg-green-700 hover:shadow-md hover:-translate-y-0.5
               active:translate-y-0
               disabled:opacity-50 disabled:cursor-not-allowed">
    Save
</button>


</div>
</div>
</div>
</form>


<script>
function openQC(b,p,s,q){
	 batchInput.value=b;
	 mBatch.innerText=b;
	 mProduct.innerText=p;
	 mSupplier.innerText=s;
	 mQty.innerText=q;

	 document.getElementById("receivedQtyHidden").value = q; // ✅ ADD THIS

	 qcModal.classList.remove("hidden");
	}
	
function validateQuantities(){
    const received = parseInt(document.getElementById("receivedQtyHidden").value || 0);
    const damagedInput = document.querySelector('input[name="quantityDamaged"]');
    const returnedInput = document.querySelector('input[name="quantityReturn"]');

    const damaged = damagedInput ? parseInt(damagedInput.value || 0) : 0;
    const returned = returnedInput ? parseInt(returnedInput.value || 0) : 0;

    // Rule 1: Damaged ≤ Received
    if (damaged > received) {
        alert("Quantity Damaged cannot be more than Quantity Received.");
        return false;
    }

    // Rule 2: Returned ≤ Damaged
    if (returned > damaged) {
        alert("Quantity Returned cannot be more than Quantity Damaged.");
        return false;
    }

    return true;
}

function closeQC(){ qcModal.classList.add("hidden"); }
function showGood(){
    goodBox.classList.remove("hidden");
    badBox.classList.add("hidden");
    updateSaveState();
}

function showBad(){
    badBox.classList.remove("hidden");
    goodBox.classList.add("hidden");
    updateSaveState();
}

function showReturn(){
    returnBox.classList.remove("hidden");
    updateSaveState();
}


function hideReturn(){
    returnBox.classList.add("hidden");
    updateSaveState();
}


searchInput.onkeyup=function(){
 let f=this.value.toLowerCase();
 document.querySelectorAll("#qcTable tr").forEach(r=>{
  r.style.display=r.innerText.toLowerCase().includes(f)?"":"none";
 });
};

function prepareRemarks(){
    let r = "";

    if (!goodBox.classList.contains("hidden")) {
        r = document.getElementById("goodRemarks").value;
    }

    if (!badBox.classList.contains("hidden")) {
        r = document.getElementById("badRemarks").value;
    }

    document.getElementById("finalRemarks").value = r;
}

function updateSaveState() {
    const saveBtn = document.getElementById("saveBtn");

    const goodSelected = document.querySelector('input[name="condition"][value="GOOD"]')?.checked;
    const damagedSelected = document.querySelector('input[name="condition"][value="DAMAGED"]')?.checked;

    // Nothing selected → cannot save
    if (!goodSelected && !damagedSelected) {
        saveBtn.disabled = true;
        return;
    }

    // GOOD → save allowed immediately
    if (goodSelected) {
        saveBtn.disabled = false;
        return;
    }

    // DAMAGED selected
    const damagedQty = document.querySelector('input[name="quantityDamaged"]')?.value;
    if (!damagedQty || damagedQty <= 0) {
        saveBtn.disabled = true;
        return;
    }

    const returnableYes = document.querySelector('input[name="returnable"][value="Y"]')?.checked;
    if (returnableYes) {
        const returnedQty = document.querySelector('input[name="quantityReturn"]')?.value;
        if (!returnedQty || returnedQty <= 0) {
            saveBtn.disabled = true;
            return;
        }
    }

    // All conditions satisfied
    saveBtn.disabled = false;
}

document.addEventListener("input", updateSaveState);
document.addEventListener("change", updateSaveState);

</script>

<style>
/* ===== EXISTING STYLES ===== */
.menu-btn{
    display:flex;
    gap:10px;
    align-items:center;
    background:#f2711c;
    color:white;
    padding:10px;
    border-radius:999px;
    font-weight:600
}
.menu-btn.active{background:#009a49}

.tab-btn{
    padding:8px 20px;
    border-radius:999px;
    background:#d1d5db;
    font-weight:bold
}
.active-tab{
    background:#16a34a;
    color:white
}

/* ===== ACTION COLUMN (INLINE, CLEAN) ===== */
.action-group-inline {
    display: flex;
    gap: 8px;
    justify-content: center;
    align-items: center;
}

/* Shared button look */
.action-group-inline a {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 14px;
    font-size: 12px;
    border-radius: 999px;
    font-weight: 600;
    text-decoration: none;
    white-space: nowrap;
}

/* View button */
.btn-view {
    background: #2563eb;
    color: white;
}
.btn-view:hover {
    background: #1e40af;
}

/* ===== Return Note Button (FINAL STYLE) ===== */
.btn-return {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 6px;

    padding: 6px 16px;
    font-size: 12px;
    font-weight: 600;

    background: #f97316;   /* nice orange */
    color: white;

    border: none;
    border-radius: 999px;

    text-decoration: none;
    white-space: nowrap;
    transition: 0.2s ease;
}

.btn-return i {
    font-size: 12px;
    color: white;
}

/* Hover */
.btn-return:hover {
    background: #ea580c;
}


/* Hover effect */
.btn-return:hover {
    background: #fff7ed;
    transform: translateY(-1px);
}

/* Eye icon (View) hover pop effect */
.view-icon {
    font-size: 16px;
    color: #000;
    text-decoration: none;
    display: inline-block;              /* required for transform */
    transition: transform 0.2s ease;    /* smooth pop */
}

.view-icon:hover {
    transform: scale(1.25);             /* pop up effect */
    color: #000;                        /* stay black */
}


/* Check button */
.btn-check {
    background: #16a34a;
    color: white;
    padding: 6px 14px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 600;
    border: none;
    cursor: pointer;
}
.btn-check:hover {
    background: #15803d;
}

/* ===== TAB BUTTON (MATCH RECEIVE ORDER) ===== */
.tab-btn{
    min-width:160px;
    height:44px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:600;
    font-size:0.95rem;
    border-radius:8px;
    border:2px solid #009a49;
    background:#e5e7eb;
    color:#4b5563;
    cursor:pointer;
    transition:all 0.2s ease;
    text-decoration:none;
}

.tab-btn.active{
    background:#0f8f4f;
    color:white;
    cursor:default;
    pointer-events:none;
}

.tab-btn:not(.active):hover{
    background:#cbd5e1;
}

/* ===== SEARCH BAR (MATCH RECEIVE ORDER) ===== */
.search-wrapper{
    position:relative;
    width:600px;
}

.search-input{
    width:100%;
    height:44px;
    border:2px solid #009a49;
    border-radius:6px;
    padding:0 44px 0 16px;
    font-size:0.95rem;
    outline:none;
}

.search-input:focus{
    box-shadow:0 0 0 2px rgba(0,154,73,0.25);
}

.search-icon{
    position:absolute;
    right:14px;
    top:50%;
    transform:translateY(-50%);
    color:#009a49;
}

</style>

</body>
</html>