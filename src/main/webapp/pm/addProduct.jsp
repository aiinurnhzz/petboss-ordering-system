<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>

<%
String staffId = (String) session.getAttribute("staffId");
String role = (String) session.getAttribute("role");

if (staffId == null || role == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add New Product</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
html, body {
	height: 100%;
	margin: 0;
	background-color: #fdf8e9;
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
					class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box w-5 text-center"></i> <span>Product</span>
				</a> <a href="<%=request.getContextPath()%>/supplier"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
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
						Product</span>
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

		<!-- ===== MAIN CONTENT ===== -->
		<main class="flex-1 p-8 overflow-y-auto">

			<!-- ===== MAIN WHITE BOX ===== -->
			<div class="border-2 border-green-600 rounded-lg p-6 bg-white">

				<form action="<%=request.getContextPath()%>/pm/addProduct"
					method="post" enctype="multipart/form-data"
					class="flex flex-col h-full">

					<!-- ===== TITLE INSIDE SAME WHITE BOX ===== -->
					<div class="flex items-center gap-4 mb-4">

						<!-- BACK BUTTON -->
						<a href="<%=request.getContextPath()%>/product"
							class="text-green-700 text-2xl hover:text-green-900"> <i
							class="fas fa-arrow-left"></i>
						</a>

						<!-- TITLE -->
						<h2 class="text-3xl font-black text-cyan-900">ADD NEW PRODUCT
						</h2>
					</div>

					<!-- GREEN DIVIDER -->
					<hr class="border-green-600 mb-6">

					<!-- ===== FORM CONTENT ===== -->
					<div class="grid grid-cols-2 gap-6">

						<!-- ===== LEFT PANEL ===== -->
						<div class="border border-green-600 rounded-lg p-4 bg-green-50">

							<label class="block font-semibold mb-1">Category</label> <select
								name="category" id="category"
								class="w-full border rounded px-3 py-2 mb-3"
								onchange="showForm()" required>

								<option value="">Select category</option>
								<option value="PET_FOOD">Pet Food</option>
								<option value="PET_MEDICINE">Pet Medicine</option>
								<option value="PET_CARE">Pet Care</option>
								<option value="PET_ACCESSORY">Pet Accessory</option>

							</select> <label class="block font-semibold mb-1">Product Preview</label>
							<label for="productImage"
								class="border border-dashed border-green-600 h-40
							              flex flex-col items-center justify-center
							              text-gray-400 mb-3 cursor-pointer
							              hover:bg-green-100 rounded-lg relative">

								<div id="uploadPlaceholder" class="flex flex-col items-center">
									<i class="fas fa-image text-3xl mb-2"></i> <span>+ Add
										Image</span>
								</div> <img id="preview"
								class="hidden absolute inset-0
							                w-full h-full object-contain p-3 rounded-lg" />
							</label> <input type="file" name="productImage" id="productImage"
								accept="image/*" class="hidden" onchange="previewImage(event)">

							<label class="block font-semibold mb-1">Product Name</label> <input
								type="text" name="productName"
								class="w-full border rounded px-3 py-2 mb-2" required> <label
								class="block font-semibold mb-1">Product Brand</label> <input
								type="text" name="productBrand"
								class="w-full border rounded px-3 py-2 mb-2"> <label
								class="block font-semibold mb-1"> SKU / Code / ID </label>

							<div class="relative mt-1 group">

								<!-- INPUT -->
								<input type="text" value="AUTO GENERATED" readonly
									class="w-full border border-gray-400 rounded-lg
							                  px-3 py-2 text-sm bg-gray-200 pr-12
							                  cursor-not-allowed">
								<!-- TOOLTIP -->
								<div
									class="absolute right-0 -top-9
							               hidden group-hover:block
							               bg-black text-white text-xs
							               px-3 py-1 rounded shadow-lg
							               whitespace-nowrap z-50">
									Auto Generated</div>
							</div>
						</div>
						<!-- ===== RIGHT PANEL ===== -->
						<div>
							<h3 class="text-green-700 font-bold mb-2">Stock Details</h3>
							<div class="grid grid-cols-2 gap-4 mb-6">
								<div>
									<label class="text-sm font-semibold text-gray-700">
										Current Quantity </label> <input type="number" name="quantity"
										class="w-full border rounded px-3 py-2"
										placeholder="Enter quantity" required>
								</div>

								<div>
									<label class="text-sm font-semibold text-gray-700">
										Minimum Quantity </label> <input type="number" name="minQuantity"
										class="w-full border rounded px-3 py-2"
										placeholder="Enter minimum quantity" required>
								</div>
							</div>


							<h3 class="text-green-700 font-bold mb-2">Pricing</h3>
							<div class="grid grid-cols-2 gap-4 mb-6">
								<div>
									<label class="text-sm font-semibold text-gray-700">
										Purchase Price (RM) </label> <input type="number" step="0.01"
										name="purchasePrice" class="w-full border rounded px-3 py-2"
										placeholder="Enter purchase price" required>
								</div>

								<div>
									<label class="text-sm font-semibold text-gray-700">
										Selling Price (RM) </label> <input type="number" step="0.01"
										name="sellingPrice" class="w-full border rounded px-3 py-2"
										placeholder="Enter selling price" required>
								</div>
							</div>


							<!-- ===== CATEGORY-SPECIFIC FIELDS ===== -->

							<!-- PET FOOD -->
							<div id="food" class="hidden min-h-[230px]">
								<label class="text-sm font-semibold text-gray-700">Weight</label>
								<input type="text" name="weight"
									class="border rounded px-3 py-2 w-full mb-3"
									placeholder="e.g. 15 kg"> <label
									class="text-sm font-semibold text-gray-700">Expiry Date</label>
								<input type="date" name="expiryDate_food"
									class="border rounded px-3 py-2 w-full mb-3">
							</div>

							<!-- PET MEDICINE -->
							<div id="medicine" class="hidden min-h-[230px]">
								<label class="text-sm font-semibold text-gray-700">Dosage</label>
								<input type="text" name="dosage"
									class="border rounded px-3 py-2 w-full mb-2"
									placeholder="e.g. 1 tablet per 20–40kg"> <label
									class="text-sm font-semibold text-gray-700">Prescription</label>
								<input type="text" name="prescription"
									class="border rounded px-3 py-2 w-full mb-2"
									placeholder="Yes / No"> <label
									class="text-sm font-semibold text-gray-700">Expiry Date</label>
								<input type="date" name="expiryDate_medicine"
									class="border rounded px-3 py-2 w-full mb-3">
							</div>

							<!-- PET CARE -->
							<div id="care" class="hidden min-h-[230px]">
								<label class="text-sm font-semibold text-gray-700">Type</label>
								<select name="type_care"
									class="border rounded px-3 py-2 w-full mb-2">
									<option value="">Select Type</option>
									<option value="Lotion">Lotion</option>
									<option value="Balm">Balm</option>
									<option value="Spray">Spray</option>
								</select> <label class="text-sm font-semibold text-gray-700">Expiry
									Date</label> <input type="date" name="expiryDate_care"
									class="border rounded px-3 py-2 w-full mb-3">
							</div>

							<!-- PET ACCESSORY -->
							<div id="accessory" class="hidden min-h-[230px]">
								<label class="text-sm font-semibold text-gray-700">Type</label>
								<select name="type_accessory"
									class="border rounded px-3 py-2 w-full mb-2">
									<option value="">Select Type</option>
									<option value="Toy">Toy</option>
									<option value="Bowl">Bowl</option>
									<option value="Collar">Collar</option>
									<option value="Cage">Cage</option>
								</select> <label class="text-sm font-semibold text-gray-700">Material</label>
								<input type="text" name="material"
									class="border rounded px-3 py-2 w-full mb-3"
									placeholder="e.g. Plastic, Rubber, Steel">
							</div>

							<!-- ===== BUTTONS (FIXED AT BOTTOM) ===== -->
							<div class="flex justify-end gap-4 mt-auto pt-6">

								<!-- CANCEL -->
								<a href="<%=request.getContextPath()%>/product"
									class="w-32 h-11 flex items-center justify-center
              bg-gray-500 text-white rounded-full font-bold
              transition-all duration-200
              hover:bg-gray-600 hover:shadow-md hover:-translate-y-0.5
              active:translate-y-0">
									Cancel </a>

								<!-- SAVE -->
								<button type="submit"
									class="w-32 h-11 bg-green-600 text-white
                   rounded-full font-bold
                   transition-all duration-200
                   hover:bg-green-700 hover:shadow-md hover:-translate-y-0.5
                   active:translate-y-0">
									Save</button>

							</div>

						</div>
					</div>
				</form>
			</div>
		</main>
	</div>
	<script>
		function showForm() {
		    document.getElementById("food").style.display = "none";
		    document.getElementById("medicine").style.display = "none";
		    document.getElementById("care").style.display = "none";
		    document.getElementById("accessory").style.display = "none";
		
		    const c = document.getElementById("category").value;
		
		    if (c === "PET_FOOD")
		        document.getElementById("food").style.display = "block";
		
		    if (c === "PET_MEDICINE")
		        document.getElementById("medicine").style.display = "block";
		
		    if (c === "PET_CARE")
		        document.getElementById("care").style.display = "block";
		
		    if (c === "PET_ACCESSORY")
		        document.getElementById("accessory").style.display = "block";
		}
		
		function previewImage(event) {
		    const file = event.target.files[0];
		    const preview = document.getElementById("preview");
		    const placeholder = document.getElementById("uploadPlaceholder");

		    if (!file) return;

		    // Optional: validate file type
		    if (!file.type.startsWith("image/")) {
		        alert("Please select an image file");
		        event.target.value = "";
		        return;
		    }

		    const reader = new FileReader();

		    reader.onload = function () {
		        preview.src = reader.result;
		        preview.classList.remove("hidden");
		        placeholder.classList.add("hidden");
		    };

		    reader.readAsDataURL(file);
		}
		
		document.getElementById("category").addEventListener("change", () => {
		    document.getElementById("preview").classList.add("hidden");
		    document.getElementById("uploadPlaceholder").classList.remove("hidden");
		});

	</script>

</body>
</html>
