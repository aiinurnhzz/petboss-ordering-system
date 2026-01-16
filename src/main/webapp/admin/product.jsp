<%@ page import="java.util.List" %>
<%@ page import="com.petboss.model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Products</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
html, body {
    height: 100%;
    margin: 0;
    background-color: #fdf8e9;
}
th {
    background-color: #eafff3;
}
td, th {
    border: 1px solid #009a49;
    padding: 8px;
    text-align: center;
    font-size: 0.85rem;
}
</style>
</head>

<body class="font-sans flex flex-col h-screen">

	<!-- ===== HEADER ===== -->
	<header
		class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
		<h1 class="text-white text-2xl font-bold">Pet Boss Centre Cash
			and Carry</h1>

		<form action="<%=request.getContextPath()%>/logout" method="post">
			<button
				class="bg-[#f2711c] text-white px-4 py-1.5 rounded-xl flex items-center gap-2 font-semibold text-sm">
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
					class="w-full bg-[#009a49] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-box"></i> Product
				</a> 
				
				<a href="<%=request.getContextPath()%>/supplier"
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-truck"></i> Supplier
				</a>

			</nav>
			<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
				class="absolute bottom-6 left-1/2 -translate-x-1/2 w-64 opacity-70">
		</aside>

<!-- ===== MAIN CONTENT ===== -->
<main class="flex-1 p-8 overflow-y-auto">

<div class="bg-white border-2 border-[#009a49] rounded-3xl p-6">

<!-- TITLE -->
<h2 class="text-3xl font-black mb-6">Products</h2>

<!-- SEARCH + FILTER (SERVER-SIDE) -->
<form id="productForm"
      method="get"
      action="<%=request.getContextPath()%>/product"
      class="flex items-center gap-4 mb-6">


    <!-- SEARCH -->
     <div class="relative flex-1">
        <input
            id="productSearch"
            name="keyword"
            type="text"
            value="<%= request.getAttribute("keyword") != null
                    ? request.getAttribute("keyword") : "" %>"
            placeholder="Search Product ID, Name, Brand, Category"
            class="w-full border-2 border-[#009a49]
                   rounded-lg px-4 py-2 outline-none
                   focus:ring-2 focus:ring-green-200 pr-10">

        <i class="fas fa-search absolute right-3 top-2.5
                  text-[#009a49] text-lg pointer-events-none"></i>
    </div>

    <!-- FILTER -->
    <div class="relative w-64">
        <div class="flex items-center border-2 border-[#009a49]
                    rounded-lg overflow-hidden bg-white h-full">

            <div class="px-3 border-r-2 border-[#009a49]">
                <i class="fas fa-filter text-[#009a49]"></i>
            </div>

            <select id="categoryFilter"
			        name="category"
			        class="w-full px-4 py-2 outline-none bg-white appearance-none">
			
			    <option value="">All Category</option>
			
			    <option value="PET_FOOD"
			        <%= "PET_FOOD".equals(request.getAttribute("category")) ? "selected" : "" %>>
			        Pet Food
			    </option>
			
			    <option value="PET_MEDICINE"
			        <%= "PET_MEDICINE".equals(request.getAttribute("category")) ? "selected" : "" %>>
			        Pet Medicine
			    </option>
			
			    <option value="PET_CARE"
			        <%= "PET_CARE".equals(request.getAttribute("category")) ? "selected" : "" %>>
			        Pet Care
			    </option>
			
			    <option value="PET_ACCESSORY"
			        <%= "PET_ACCESSORY".equals(request.getAttribute("category")) ? "selected" : "" %>>
			        Pet Accessory
			    </option>
			</select>
			
            <i class="fas fa-caret-down absolute right-3 top-3
                      pointer-events-none text-gray-500"></i>
        </div>
    </div>
</form>

<!-- TABLE -->
<div class="overflow-x-auto">
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
			<!-- Action -->
        <td>
        
        <div class="relative group flex flex-col items-center">	
            <i class="fas fa-eye text-black hover:scale-150 transition text-lg cursor-pointer"
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
          )">
            </i>
            <span
				class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 hidden group-hover:block bg-black text-white text-[10px]
				py-1 px-2 rounded shadow-lg whitespace-nowrap z-50">View
			</span>
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
                           readonly>
                </div>

                <div>
                    <label class="text-[10px] font-bold text-gray-500 uppercase">
                        Category
                    </label>
                    <input id="viewCategory"
                           class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
                           readonly>
                </div>

                <div>
                    <label class="text-[10px] font-bold text-gray-500 uppercase">
                        Product Brand
                    </label>
                    <input id="viewBrand"
                           class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
                           readonly>
                </div>

                <div>
                    <label class="text-[10px] font-bold text-gray-500 uppercase">
                        SKU / Code / ID
                    </label>
                    <input id="viewId"
                           class="w-full text-xs border border-[#009a49]
                                  rounded px-2 py-1.5 bg-gray-100"
                           readonly>
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
                               readonly>
                    </div>

                    <div>
                        <label class="text-xs font-bold text-gray-600">
                            Minimum Quantity
                        </label>
                        <input id="viewMin"
                               class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
                               readonly>
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
                               readonly>
                    </div>

                    <div>
                        <label class="text-xs font-bold text-gray-600">
                            Selling Price (RM)
                        </label>
                        <input id="viewSell"
                               class="w-full border border-[#009a49]
                                      rounded-lg px-3 py-1.5 bg-gray-100"
                               readonly>
                    </div>
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

<!-- ===== SCRIPT ===== -->
<script>
/* ===== VIEW ===== */
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
}


function closeViewModal(){
    document.getElementById("viewModal").classList.add("hidden");
}
</script>

</body>
</html>
