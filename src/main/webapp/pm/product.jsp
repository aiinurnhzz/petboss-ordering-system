<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.petboss.model.Product" %>

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
           class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
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
           class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
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

<!-- ===== MAIN ===== -->
<main class="flex-1 p-8 overflow-y-auto">

<div class="bg-white border-2 border-[#009a49] rounded-2xl p-6 shadow">

    <!-- TITLE ROW -->
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-3xl font-black text-cyan-900">PRODUCT</h2>

        <a href="<%=request.getContextPath()%>/pm/addProduct"
           class="bg-green-600 hover:bg-green-700
                  text-white px-6 py-3 rounded-full font-semibold
                  shadow-md transition">
            + Add Product
        </a>
    </div>

    <!-- DIVIDER -->
    <hr class="border-green-600 mb-6">

<!-- SEARCH + FILTER (SAME STYLE AS ORDER) -->
<!-- SEARCH -->
<form class="search-form">

    <div class="search-box">
        <input type="text" id="searchInput"
               placeholder="Search Supplier by ID, Name or Email"
               class="search-input">
        <i class="fas fa-search search-icon"></i>
   </div>

    <!-- FILTER -->
    <div class="filter-box">
        <div class="filter-container">

            <div class="filter-icon">
                <i class="fas fa-filter"></i>
            </div>

            <select id="categoryFilter" class="filter-select">
                <option value="">All Category</option>
                <option value="PET_FOOD">Pet Food</option>
                <option value="PET_MEDICINE">Pet Medicine</option>
                <option value="PET_CARE">Pet Care</option>
                <option value="PET_ACCESSORY">Pet Accessory</option>
            </select>

            <i class="fas fa-caret-down filter-arrow"></i>
        </div>
    </div>

</form>

<!-- TABLE -->
<div class="overflow-x-hidden">
<table class="w-full border-collapse">
<thead>
<tr>
    <th class="border p-2">Image</th>
    <th class="border p-2">ID</th>
    <th class="border p-2">Name</th>
    <th class="border p-2">Current Quantity</th>
    <th class="border p-2">Category</th>
    <th class="border p-2">Brand</th>
    <th class="border p-2">Selling Price (RM)</th>
    <th class="border p-2">Purchase Price (RM)</th>
    <th class="border p-2">Action</th>
</tr>
</thead>

<tbody>
<% for (Product p : products) { %>
<tr class="product-row">

<td class="border p-2 text-center">
    <% if (p.getImage() != null) { %>
        <img src="<%=request.getContextPath()%>/product-image?file=<%=p.getImage()%>"
             class="h-10 mx-auto">
    <% } else { %> — <% } %>
</td>

<td class="border p-2"><%=p.getProductId()%></td>
<td class="border p-2 text-center"><%=p.getName()%></td>
<td class="border p-2 text-center"><%=p.getQuantity()%></td>
<td class="border p-2"><%=p.getCategory()%></td>
<td class="border p-2"><%=p.getBrand()%></td>
<td class="border p-2 text-center"><%=p.getSellingPrice()%></td>
<td class="border p-2 text-center"><%=p.getPurchasePrice()%></td>

<td class="border p-2 text-center">
    <div class="flex justify-center items-center gap-4">

        <!-- 👁️ VIEW -->
        <div class="relative group flex flex-col items-center">
            <i class="fas fa-eye text-black hover:scale-150 transition text-lg cursor-pointer"
               onclick="openViewModal(
				    '<%=p.getProductId()%>',
				    '<%=p.getName()%>',
				    '<%=p.getCategory()%>',   <!-- MUST be PET_MEDICINE -->
				    '<%=p.getBrand()%>',
				    <%=p.getQuantity()%>,
				    <%=p.getMinQuantity()%>,
				    <%=p.getPurchasePrice()%>,
				    <%=p.getSellingPrice()%>,
				    '<%=p.getImage()%>'
				)"
				></i>
            <span class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2
                         hidden group-hover:block bg-black text-white text-[10px]
                         py-1 px-2 rounded shadow-lg z-50">
                View
            </span>
        </div>

        <!-- ✏️ EDIT -->
        <div class="relative group flex flex-col items-center">
            <i class="fas fa-pencil-alt text-black hover:scale-150 transition text-lg cursor-pointer"
               onclick="openEditModal(
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
            <span class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2
                         hidden group-hover:block bg-black text-white text-[10px]
                         py-1 px-2 rounded shadow-lg z-50">
                Update
            </span>
        </div>

    </div>
</td>

</tr>
<% } %>
</tbody>
</table>
</div>
</div>
</main>
</div>

<!-- ===== VIEW PRODUCT MODAL ===== -->
<div id="viewModal"
     class="fixed inset-0 bg-black bg-opacity-50 z-[110] hidden
            flex items-center justify-center p-4">

<div class="bg-white w-full max-w-3xl rounded-3xl
            border-2 border-[#009a49] shadow-2xl
            overflow-hidden flex flex-col md:flex-row">

    <!-- ===== LEFT : PRODUCT PREVIEW ===== -->
    <div class="w-full md:w-1/3 bg-white p-6 border-r border-gray-200">
        <div class="border-2 border-[#009a49] rounded-xl p-4 h-full flex flex-col">

            <h3 class="text-sm font-bold text-gray-700 mb-4">
                Product Preview
            </h3>

            <div class="w-full aspect-square bg-gray-50 rounded-lg mb-4
                        flex items-center justify-center overflow-hidden
                        border border-gray-100">
                <img id="viewImg"
                     class="max-w-full max-h-full object-contain">
            </div>

            <div class="space-y-3 flex-grow">
                <div>
                    <label class="text-[10px] font-bold text-gray-500 uppercase">
                        Product Name
                    </label>
                    <input id="viewName"
                           class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
                           disabled>
                </div>

                <div>
                    <label class="text-[10px] font-bold text-gray-500 uppercase">
                        Category
                    </label>
                    <input id="viewCategory"
                           class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
                           disabled>
                </div>

                <div>
                    <label class="text-[10px] font-bold text-gray-500 uppercase">
                        Product Brand
                    </label>
                    <input id="viewBrand"
                           class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
                           disabled>
                </div>

                <div>
                    <label class="text-[10px] font-bold text-gray-500 uppercase">
                        SKU / Code / ID
                    </label>
                    <input id="viewId"
                           class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
                           disabled>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== RIGHT : DETAILS ===== -->
    <div class="w-full md:w-2/3 p-8 flex flex-col h-full">

        <div class="flex-grow space-y-8">

            <!-- STOCK -->
            <div>
                <h4 class="text-green-700 font-bold mb-4
                           border-b border-green-200 pb-1">
                    Stock Details
                </h4>

                <div class="grid grid-cols-2 gap-x-12 gap-y-4">
                    <div>
                        <label class="text-xs font-bold text-gray-600">
                            Current Quantity
                        </label>
                        <input id="viewQty"
                               class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
                               disabled>
                    </div>

                    <div>
                        <label class="text-xs font-bold text-gray-600">
                            Minimum Quantity
                        </label>
                        <input id="viewMin"
                               class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
                               disabled>
                    </div>
                </div>
            </div>

            <!-- PRICING -->
            <div>
                <h4 class="text-green-700 font-bold mb-4
                           border-b border-green-200 pb-1">
                    Pricing
                </h4>

                <div class="grid grid-cols-2 gap-x-12 gap-y-4">
                    <div>
                        <label class="text-xs font-bold text-gray-600">
                            Purchase Price (RM)
                        </label>
                        <input id="viewBuy"
                               class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
                               disabled>
                    </div>

                    <div>
                        <label class="text-xs font-bold text-gray-600">
                            Selling Price (RM)
                        </label>
                        <input id="viewSell"
                               class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
                               disabled>
                    </div>
                </div>
            </div>
            
            <!-- CATEGORY DETAILS -->
			<div id="viewCategorySection" class="mt-8 hidden">
			
			    <h4 class="text-green-700 font-bold mb-4
			               border-b border-green-200 pb-1">
			        Category Details
			    </h4>
			
			    <!-- PET MEDICINE -->
			    <div id="view-cat-medicine" class="hidden grid grid-cols-2 gap-x-12 gap-y-4">
			
			        <div>
			            <label class="text-xs font-bold text-gray-600">Dosage</label>
			            <input id="viewMedDosage"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
			                   disabled>
			        </div>
			
			        <div>
			            <label class="text-xs font-bold text-gray-600">Expiry Date</label>
			            <input id="viewMedExpiry"
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
			    <div id="view-cat-food" class="hidden grid grid-cols-2 gap-x-12 gap-y-4">
			        <div>
			            <label class="text-xs font-bold text-gray-600">Weight</label>
			            <input id="viewFoodWeight"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
			                   disabled>
			        </div>
			        <div>
			            <label class="text-xs font-bold text-gray-600">Expiry Date</label>
			            <input id="viewFoodExpiry"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
			                   disabled>
			        </div>
			    </div>
			
			    <!-- PET CARE -->
			    <div id="view-cat-care" class="hidden grid grid-cols-2 gap-x-12 gap-y-4">
			        <div>
			            <label class="text-xs font-bold text-gray-600">Type</label>
			            <input id="viewCareType"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
			                   disabled>
			        </div>
			        <div>
			            <label class="text-xs font-bold text-gray-600">Expiry Date</label>
			            <input id="viewCareExpiry"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5 bg-gray-100"
			                   disabled>
			        </div>
			    </div>
			
			    <!-- PET ACCESSORY -->
			    <div id="view-cat-accessory" class="hidden">
			        <label class="text-xs font-bold text-gray-600">Material</label>
			        <input id="viewAccMaterial"
			               class="w-full border border-[#009a49]
			                      rounded-lg px-3 py-1.5 bg-gray-100"
			               disabled>
			    </div>
			
			</div>
        </div>

        <!-- ===== ACTION ===== -->
        <div class="flex justify-end gap-6 mt-auto pt-10">
            <button type="button"
                    onclick="closeViewModal()"
                    class="bg-red-500 hover:bg-red-600
                           text-white font-bold py-2 px-12
                           rounded-2xl shadow-lg">
                Close
            </button>
        </div>
    </div>

</div>
</div>

		<!-- ===== EDIT PRODUCT MODAL ===== -->
		<div id="editModal"
		     class="fixed inset-0 bg-black bg-opacity-50 z-[110] hidden
		            flex items-center justify-center p-4">
		
		<form action="<%=request.getContextPath()%>/editProduct"
		      method="post"
		      enctype="multipart/form-data"
		      class="bg-white w-full max-w-3xl rounded-3xl
		             border-2 border-[#009a49] shadow-2xl
		             overflow-hidden flex flex-col md:flex-row">
		
		    <!-- 🔑 REQUIRED -->
		    <input type="hidden" name="productId" id="editIDHidden">
			<input type="hidden" name="category" id="editCategoryHidden">
		
		    <!-- LEFT : PRODUCT PREVIEW -->
		    <div class="w-full md:w-1/3 bg-white p-6 border-r border-gray-200">
		        <div class="border-2 border-[#009a49] rounded-xl p-4 h-full flex flex-col">
		            <h3 class="text-sm font-bold text-gray-700 mb-4">
		                Product Preview
		            </h3>
		
		            <div class="w-full aspect-square bg-gray-50 rounded-lg mb-4
		                        flex items-center justify-center overflow-hidden
		                        border border-gray-100">
		                <img id="editImg"
		                     class="max-w-full max-h-full object-contain">
		            </div>
		
		            <!-- 🔥 IMAGE UPLOAD -->
		            <div class="mb-4">
		                <label class="text-xs font-bold text-gray-600">
		                    Change Product Image (optional)
		                </label>
		                <input type="file"
		                       name="productImage"
		                       accept="image/*"
		                       onchange="previewEditImage(this)"
		                       class="w-full border border-[#009a49]
		                              rounded-lg px-3 py-1.5 text-xs">
		            </div>
		
		            <!-- INFO (READ ONLY) -->
		            <div class="space-y-3 flex-grow">
		                <div>
		                    <label class="text-[10px] font-bold text-gray-500 uppercase">
		                        Product Name
		                    </label>
		                    <input id="editName"
		                           class="w-full text-xs border border-[#009a49]
		                                  rounded px-2 py-1.5 bg-gray-100"
		                           disabled>
		                </div>
		
		                <div>
		                    <label class="text-[10px] font-bold text-gray-500 uppercase">
		                        Category
		                    </label>
		                    <input id="editCategory"
		                           class="w-full text-xs border border-[#009a49]
		                                  rounded px-2 py-1.5 bg-gray-100"
		                           disabled>
		                </div>
		
		                <div>
		                    <label class="text-[10px] font-bold text-gray-500 uppercase">
		                        Brand
		                    </label>
		                    <input id="editBrand"
		                           class="w-full text-xs border border-[#009a49]
		                                  rounded px-2 py-1.5 bg-gray-100"
		                           disabled>
		                </div>
		
		                <div>
		                    <label class="text-[10px] font-bold text-gray-500 uppercase">
		                        Product ID
		                    </label>
		                    <input id="editID"
		                           class="w-full text-xs border border-[#009a49]
		                                  rounded px-2 py-1.5 bg-gray-100"
		                           disabled>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <!-- RIGHT : EDIT DETAILS -->
		    <div class="w-full md:w-2/3 p-8 flex flex-col h-full">
		
		        <div class="flex-grow space-y-8">
		
		            <!-- STOCK -->
		            <div>
		                <h4 class="text-green-700 font-bold mb-4 border-b pb-1">
		                    Stock Details
		                </h4>
		
		                <div class="grid grid-cols-2 gap-6">
		                    <input type="number" name="quantity" id="editQty"
		                           placeholder="Quantity"
		                           class="border border-[#009a49] rounded-lg px-3 py-2">
		
		                    <input type="number" name="minQuantity" id="editMin"
		                           placeholder="Min Quantity"
		                           class="border border-[#009a49] rounded-lg px-3 py-2">
		                </div>
		            </div>
		
		            <!-- PRICING -->
		            <div>
		                <h4 class="text-green-700 font-bold mb-4 border-b pb-1">
		                    Pricing
		                </h4>
		
		                <div class="grid grid-cols-2 gap-6">
		                    <input name="purchasePrice" id="editBuy"
		                           placeholder="Purchase Price"
		                           class="border border-[#009a49] rounded-lg px-3 py-2">
		
		                    <input name="sellingPrice" id="editSell"
		                           placeholder="Selling Price"
		                           class="border border-[#009a49] rounded-lg px-3 py-2">
		                </div>
		            </div>
            
            <!-- CATEGORY DETAILS (EDIT) -->
			<div id="editCategorySection" class="mt-8 hidden">
			
			    <h4 class="text-green-700 font-bold mb-4
			               border-b border-green-200 pb-1">
			        Category Details
			    </h4>
			
			    <!-- PET MEDICINE -->
			    <div id="edit-cat-medicine" class="hidden grid grid-cols-2 gap-x-12 gap-y-4">
			
			        <div>
			            <label class="text-xs font-bold text-gray-600">Dosage</label>
			            <input name="dosage" id="editMedDosage"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5">
			        </div>
			
			        <div>
			            <label class="text-xs font-bold text-gray-600">Expiry Date</label>
			            <input type="date" name="expiryDate" id="editMedExpiry"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5">
			        </div>
			
			        <div class="col-span-2">
			            <label class="text-xs font-bold text-gray-600">Prescription</label>
			            <input name="prescription" id="editMedPrescription"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5">
			        </div>
			    </div>
			
			    <!-- PET FOOD -->
			    <div id="edit-cat-food" class="hidden grid grid-cols-2 gap-x-12 gap-y-4">
			        <div>
			            <label class="text-xs font-bold text-gray-600">Weight</label>
			            <input name="weight" id="editFoodWeight"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5">
			        </div>
			        <div>
			            <label class="text-xs font-bold text-gray-600">Expiry Date</label>
			            <input type="date" name="expiryDate" id="editFoodExpiry"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5">
			        </div>
			    </div>
			
			    <!-- PET CARE -->
			    <div id="edit-cat-care" class="hidden grid grid-cols-2 gap-x-12 gap-y-4">
			        <div>
			            <label class="text-xs font-bold text-gray-600">Type</label>
			            <input name="type" id="editCareType"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5">
			        </div>
			        <div>
			            <label class="text-xs font-bold text-gray-600">Expiry Date</label>
			            <input type="date" name="expiryDate" id="editCareExpiry"
			                   class="w-full border border-[#009a49]
			                          rounded-lg px-3 py-1.5">
			        </div>
			    </div>
			
			    <!-- PET ACCESSORY -->
			    <div id="edit-cat-accessory" class="hidden">
			        <label class="text-xs font-bold text-gray-600">Material</label>
			        <input name="material" id="editAccMaterial"
			               class="w-full border border-[#009a49]
			                      rounded-lg px-3 py-1.5">
			    </div>
			
			</div>
        </div>
		
        <div class="flex justify-end gap-6 mt-auto pt-10">
            <button type="button"
                    onclick="closeEditModal()"
                    class="w-32 h-11 flex items-center justify-center 
                    bg-gray-500 text-white rounded-full font-bold">
                Cancel
            </button>

            <button type="submit"
                    class="w-32 h-11 flex items-center justify-center
					bg-green-600 text-white rounded-full font-bold">
                Save
            </button>
        </div>
    </div>
</form>
</div>		

<script>
/* ===== VIEW ===== */
function openViewModal(id, name, cat, brand, qty, min, buy, sell, img) {

    // BASIC INFO
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

    // ✅ AUTO LOAD CATEGORY
    loadCategoryDetails(id, cat);
}


function loadCategoryDetails(productId, category) {

    fetch(
        "<%=request.getContextPath()%>/product-category" +
        "?productId=" + productId +
        "&category=" + category
    )
    .then(res => res.json())
    .then(data => {

        // HIDE ALL
        document.getElementById("viewCategorySection").classList.add("hidden");

        document.querySelectorAll(
            "#view-cat-medicine, #view-cat-food, #view-cat-care, #view-cat-accessory"
        ).forEach(div => div.classList.add("hidden"));

        if (!data || Object.keys(data).length === 0) return;

        document.getElementById("viewCategorySection").classList.remove("hidden");

        // PET MEDICINE
        if (category === "PET_MEDICINE") {
            document.getElementById("viewMedDosage").value = data.dosage || "-";
            document.getElementById("viewMedPrescription").value = data.prescription || "-";
            document.getElementById("viewMedExpiry").value = formatDate(data.expiry_date);
            document.getElementById("view-cat-medicine").classList.remove("hidden");
        }

        // PET FOOD
        if (category === "PET_FOOD") {
            document.getElementById("viewFoodWeight").value = data.weight || "-";
            document.getElementById("viewFoodExpiry").value = formatDate(data.expiry_date);
            document.getElementById("view-cat-food").classList.remove("hidden");
        }

        // PET CARE
        if (category === "PET_CARE") {
            document.getElementById("viewCareType").value = data.type || "-";
            document.getElementById("viewCareExpiry").value = formatDate(data.expiry_date);
            document.getElementById("view-cat-care").classList.remove("hidden");
        }

        // PET ACCESSORY
        if (category === "PET_ACCESSORY") {
            document.getElementById("viewAccMaterial").value = data.material || "-";
            document.getElementById("view-cat-accessory").classList.remove("hidden");
        }
    })
    .catch(err => console.error("CATEGORY LOAD ERROR:", err));
}


function formatDate(dateStr) {
    if (!dateStr) return "-";
    return dateStr.split(" ")[0]; // YYYY-MM-DD
}

function closeViewModal(){
    document.getElementById("viewModal").classList.add("hidden");
}

/* ===== EDIT ===== */
function openEditModal(id, name, cat, brand, qty, min, buy, sell, img) {

    document.getElementById("editID").value = id;
    document.getElementById("editIDHidden").value = id;

    document.getElementById("editCategory").value = cat;
    document.getElementById("editCategoryHidden").value = cat; // 🔥 IMPORTANT

    document.getElementById("editName").value = name;
    document.getElementById("editBrand").value = brand;

    document.getElementById("editQty").value = qty;
    document.getElementById("editMin").value = min;
    document.getElementById("editBuy").value = buy;
    document.getElementById("editSell").value = sell;

    document.getElementById("editImg").src = img
        ? "<%=request.getContextPath()%>/product-image?file=" + img
        : "<%=request.getContextPath()%>/images/default-product.png";

    document.getElementById("editModal").classList.remove("hidden");

    loadCategoryDetailsEdit(id, cat);
}

function loadCategoryDetailsEdit(productId, category) {

    fetch(
        "<%=request.getContextPath()%>/product-category" +
        "?productId=" + productId +
        "&category=" + category
    )
    .then(res => res.json())
    .then(data => {

        // hide all
        document.getElementById("editCategorySection").classList.add("hidden");

        document.querySelectorAll(
            "#edit-cat-medicine, #edit-cat-food, #edit-cat-care, #edit-cat-accessory"
        ).forEach(div => div.classList.add("hidden"));

        if (!data || Object.keys(data).length === 0) return;

        document.getElementById("editCategorySection").classList.remove("hidden");

        // PET MEDICINE
        if (category === "PET_MEDICINE") {
            document.getElementById("editMedDosage").value = data.dosage || "";
            document.getElementById("editMedPrescription").value = data.prescription || "";
            document.getElementById("editMedExpiry").value = toDate(data.expiry_date);
            document.getElementById("edit-cat-medicine").classList.remove("hidden");
        }

        // PET FOOD
        if (category === "PET_FOOD") {
            document.getElementById("editFoodWeight").value = data.weight || "";
            document.getElementById("editFoodExpiry").value = toDate(data.expiry_date);
            document.getElementById("edit-cat-food").classList.remove("hidden");
        }

        // PET CARE
        if (category === "PET_CARE") {
            document.getElementById("editCareType").value = data.type || "";
            document.getElementById("editCareExpiry").value = toDate(data.expiry_date);
            document.getElementById("edit-cat-care").classList.remove("hidden");
        }

        // PET ACCESSORY
        if (category === "PET_ACCESSORY") {
            document.getElementById("editAccMaterial").value = data.material || "";
            document.getElementById("edit-cat-accessory").classList.remove("hidden");
        }
    });
}


function toDate(dateStr) {
    if (!dateStr) return "";
    return dateStr.split(" ")[0]; // YYYY-MM-DD
}

/* ===============================
   SEARCH + FILTER (AJAX)
   =============================== */

const searchInput = document.getElementById("searchInput");
const categoryFilter = document.getElementById("categoryFilter");
const tableBody = document.querySelector("tbody");

let typingTimer;
const contextPath = "<%= request.getContextPath() %>";

function loadProducts() {

    const keyword = searchInput.value || "";
    const category = categoryFilter.value || "";

    fetch(
        contextPath + "/product?ajax=true"
        + "&keyword=" + encodeURIComponent(keyword)
        + "&category=" + encodeURIComponent(category)
    )
    .then(res => res.json())
    .then(data => {

        tableBody.innerHTML = "";

        if (!data || data.length === 0) {
            tableBody.innerHTML =
                "<tr>" +
                    "<td colspan='9' class='text-center text-gray-500 p-4'>" +
                        "No product found" +
                    "</td>" +
                "</tr>";
            return;
        }

        data.forEach(p => {

            /* ===== IMAGE ===== */
            let imgHtml = "-";
            if (p.img) {
                imgHtml =
                    "<img src='" + contextPath +
                    "/product-image?file=" + p.img +
                    "' class='h-10 mx-auto'>";
            }

            /* ===== ROW (MATCH TABLE HEADER ORDER) ===== */
		const row =
		    "<tr class='border border-green-600'>" +
		        "<td class='border p-2 text-center'>" + imgHtml + "</td>" +
		        "<td class='border p-2'>" + p.id + "</td>" +
		        "<td class='border p-2 text-center'>" + p.name + "</td>" +
		        "<td class='border p-2'>" + p.qty + "</td>" +
		        "<td class='border p-2'>" + p.category + "</td>" +
		        "<td class='border p-2'>" + p.brand + "</td>" +
		        "<td class='border p-2'>RM " + Number(p.sell).toFixed(2) + "</td>" +
		        "<td class='border p-2'>RM " + Number(p.buy).toFixed(2) + "</td>" +
		        "<td class='border p-2 text-center'>" +
		            "<div class='flex justify-center items-center gap-4'>" +
		                "<div class='relative group'>" +
		                    "<i class='fas fa-eye text-black hover:scale-150 transition text-lg cursor-pointer' " +
		                    "onclick=\"openViewModal('" +
		                        p.id + "','" +
		                        p.name + "','" +
		                        p.category + "','" +
		                        p.brand + "','" +
		                        p.qty + "','" +
		                        (p.min || 0) + "','" +
		                        p.buy + "','" +
		                        p.sell + "','" +
		                        (p.img || '') +
		                    "')\"></i>" +
		                    "<span class='absolute bottom-full left-1/2 -translate-x-1/2 mb-2 " +
		                          "hidden group-hover:block bg-black text-white text-[10px] " +
		                          "py-1 px-2 rounded shadow-lg whitespace-nowrap z-50'>" +
		                          "View</span>" +
		                "</div>" +
		                "<div class='relative group'>" +
		                    "<i class='fas fa-pencil-alt text-black hover:scale-150 transition text-lg cursor-pointer' " +
		                    "onclick=\"openEditModal('" +
		                        p.id + "','" +
		                        p.name + "','" +
		                        p.category + "','" +
		                        p.brand + "','" +
		                        p.qty + "','" +
		                        (p.min || 0) + "','" +
		                        p.buy + "','" +
		                        p.sell + "','" +
		                        (p.img || '') +
		                    "')\"></i>" +
		                    "<span class='absolute bottom-full left-1/2 -translate-x-1/2 mb-2 " +
		                          "hidden group-hover:block bg-black text-white text-[10px] " +
		                          "py-1 px-2 rounded shadow-lg whitespace-nowrap z-50'>" +
		                          "Update</span>" +
		                "</div>" +
		
		            "</div>" +
		        "</td>" +
	
		    "</tr>";
            tableBody.insertAdjacentHTML("beforeend", row);
        });
    })
    .catch(err => {
        console.error("Failed to load products:", err);
    });
}

function closeEditModal(){
    document.getElementById("editModal").classList.add("hidden");
}

/* ===== LIVE SEARCH ===== */
searchInput.addEventListener("input", () => {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(loadProducts, 400);
});

/* ===== CATEGORY FILTER ===== */
categoryFilter.addEventListener("change", loadProducts);

function previewEditImage(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();

        reader.onload = function (e) {
            document.getElementById("editImg").src = e.target.result;
        };

        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</body>
</html>
