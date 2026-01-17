<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="true"%>
<%@ page import="com.petboss.model.Staff"%>

<%
String staffId = (String) session.getAttribute("staffId");
String role = (String) session.getAttribute("role");
Staff staff = (Staff) request.getAttribute("staff");

if (staffId == null || role == null || staff == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Profile</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
html, body {
	height: 100%;
	margin: 0;
	overflow: hidden;
	background-color: #fdf8e9;
}

.edit-input {
	border: 2px solid #22c55e; /* green-500 */
	border-radius: 0.75rem;
}

.edit-input:focus {
	outline: none;
	box-shadow: 0 0 0 2px rgba(34, 197, 94, 0.4);
}

/* ===== MODAL ACTION BUTTON GROUP ===== */
.modal-actions {
	display: flex;
	justify-content: center; /* ✅ CENTER */
	gap: 24px;
	margin-top: 24px;
}

/* ===== COMMON BUTTON ===== */
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

/* ===== CANCEL (GREY) ===== */
.btn-cancel {
	background: #6b7280; /* gray-500 */
	color: white;
}

.btn-cancel:hover {
	background: #4b5563; /* gray-600 */
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
					class="mx-auto w-[85%] h-11 bg-[#009a49] hover:bg-[#009a49] text-white
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
				</a> <a href="<%=request.getContextPath()%>/product-qc"
					class="mx-auto w-[85%] h-11 bg-[#f2711c] hover:bg-[#009a49] text-white
        px-4 rounded-full flex items-center gap-3
        border-2 border-white shadow-md text-sm font-semibold">
					<i class="fas fa-box w-5 text-center"></i><span>Product QC</span>
				</a>

			</nav>

			<div class="flex justify-center mt-auto pb-4">
				<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
					class="w-36 sm:w-40 md:w-44 opacity-100">
			</div>
		</aside>
		<!-- ===== MAIN CONTENT ===== -->
		<main
			class="relative flex-1 p-6 md:p-10 overflow-hidden flex justify-center items-center bg-[#fdf8e9]"
			style="background-size: cover; background-position: center;">


			<!-- PROFILE CARD -->
			<div
				class="relative z-10 w-full max-w-6xl bg-white rounded-3xl shadow-xl border-2 border-[#009a49] overflow-hidden">
				<div class="flex justify-between items-start w-full flex-shrink-0">
					<div
						class="bg-[#009a49] text-white py-3 px-16 inline-block rounded-br-3xl text-2xl font-bold tracking-widest">
						PROFILE</div>
				</div>
				<div class="p-10 flex flex-col md:flex-row gap-12">

					<!-- LEFT -->
					<div
						class="w-full md:w-1/3 border-2 border-gray-300 rounded-[20px] p-6 flex flex-col items-center">

						<img
							src="<%=request.getContextPath()%>/uploads/staff/<%=staff.getPhoto()%>?t=<%=System.currentTimeMillis()%>"
							class="w-44 h-44 rounded-full border-[6px] border-cyan-900
            flex items-center justify-center mb-4">




						<form action="<%=request.getContextPath()%>/uploadProfilePhoto"
							method="post" enctype="multipart/form-data"
							class="mb-4 text-center">

							<label
								class="bg-blue-100 hover:bg-blue-200
           text-blue-700 px-5 py-2.5 rounded-full
           text-sm font-bold cursor-pointer
           inline-flex items-center gap-2
           border border-blue-300
           transition">



								<i class="fas fa-image"></i> Change Photo <input type="file"
								name="photo" hidden onchange="this.form.submit()">
							</label>
						</form>
						<div
							class="bg-green-50 border border-green-200 text-green-700
            px-5 py-1.5 rounded-full
            font-bold mb-4">
							<%=staff.getRole()%>
						</div>

						<div class="text-center space-y-2 text-sm font-bold text-gray-600">
							<p>
								Employee ID :
								<%=staff.getStaffId()%></p>
							<p>
								PM ID :
								<%=staff.getPmId() == null ? "-" : staff.getPmId()%></p>
						</div>
					</div>

					<!-- RIGHT -->
					<div class="flex-1 space-y-4 text-gray-800">

						<div class="flex items-center gap-3 mb-2">
							<!-- USER NAME -->
							<h2 class="text-3xl font-black text-cyan-900 uppercase">
								<%=staff.getFullName()%>
							</h2>

							<!-- PENCIL ICON -->
							<button onclick="openUpdateModal()"
								class="flex items-center gap-2
               bg-blue-50 text-blue-600
               px-3 py-1.5 rounded-full
               border border-blue-300
               font-bold text-sm
               hover:bg-blue-100 transition">
								<i class="fas fa-pencil-alt"></i> Edit Profile
							</button>
						</div>

						<div
							class="flex items-center gap-6 text-sm font-bold text-gray-600">
							<p>
								Joined :
								<%=staff.getJoinedDate()%></p>
							<%
							String status = staff.getStatus(); // e.g. ACTIVE / INACTIVE
							boolean isActive = "ACTIVE".equalsIgnoreCase(status);
							%>

							<p
								class="flex items-center gap-2 <%=isActive ? "text-green-600" : "text-red-600"%>">
								<span
									class="w-3 h-3 rounded-full
					        <%=isActive ? "bg-green-500" : "bg-red-500"%>">
								</span>
								<%=status%>
							</p>
						</div>
						<div
							class="bg-green-50 text-green-700 text-center py-2
            font-black tracking-widest rounded-md border
            border-green-200 uppercase">
							Personal Info</div>


						<!-- INFO -->
						<div class="space-y-3">

							<div>
								<label class="text-xs font-bold block mb-1">Full Name</label> <input
									type="text" value="<%=staff.getFullName()%>" readonly
									class="w-full bg-slate-100 border border-slate-300
              rounded-xl px-4 py-2.5 text-slate-700
              cursor-not-allowed
              hover:border-slate-400 transition">


							</div>

							<div class="grid grid-cols-2 gap-4">
								<div>
									<label class="text-xs font-bold block mb-1">Email</label> <input
										type="text" value="<%=staff.getEmail()%>" readonly
										class="w-full bg-slate-100 border border-slate-300
              rounded-xl px-4 py-2.5 text-slate-700
              cursor-not-allowed
              hover:border-slate-400 transition">


								</div>

								<div>
									<label class="text-xs font-bold block mb-1">Phone
										Number</label> <input type="text" value="<%=staff.getPhone()%>"
										readonly
										class="w-full bg-slate-100 border border-slate-300
              rounded-xl px-4 py-2.5 text-slate-700
              cursor-not-allowed
              hover:border-slate-400 transition">


								</div>
							</div>

							<div>
								<label class="text-xs font-bold block mb-1">Address</label>
								<textarea rows="3" readonly
									class="w-full bg-slate-100 border border-slate-300
                 rounded-xl px-4 py-3
                 text-slate-700 resize-none
                 cursor-not-allowed
                 hover:border-slate-400 transition"><%=staff.getAddress()%></textarea>

							</div>

						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
	<!-- ===== UPDATE INFO MODAL ===== -->
	<div id="updateModal"
		class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden
            flex items-center justify-center p-4">

		<div
			class="bg-white w-full max-w-md rounded-3xl
                border-2 border-green-700 shadow-2xl overflow-hidden">

			<!-- TITLE -->
			<div class="text-center py-4">
				<h3
					class="text-2xl font-black text-cyan-900 uppercase tracking-wide">
					Update Information</h3>

			</div>

			<hr class="border-green-600 mb-4">
			<div class="px-8 pb-8 space-y-4">

				<!-- FULL NAME -->
				<div>
					<label class="font-bold text-sm">Full Name</label> <input
						type="text" value="<%=staff.getFullName()%>" readonly
						class="w-full bg-slate-100 border border-slate-300
              rounded-xl px-4 py-2.5
              text-slate-700 cursor-not-allowed
              hover:border-slate-400 transition">
				</div>

				<!-- EMAIL -->
				<div>
					<label class="font-bold text-sm">Email</label> <input type="text"
						value="<%=staff.getEmail()%>" readonly
						class="w-full bg-slate-100 border border-slate-300
              rounded-xl px-4 py-2.5
              text-slate-700 cursor-not-allowed
              hover:border-slate-400 transition">
				</div>

				<hr class="opacity-30">

				<!-- PHONE -->
				<div>
					<label class="font-bold text-sm">New Phone Number</label> <input
						id="updPhone" value="<%=staff.getPhone()%>"
						class="w-full px-3 py-2 edit-input">
				</div>

				<!-- ADDRESS -->
				<div>
					<label class="font-bold text-sm">New Address</label>
					<textarea id="updAddress" rows="3"
						class="w-full px-3 py-2 edit-input"><%=staff.getAddress()%></textarea>
				</div>

				<!-- BUTTONS -->
				<div class="modal-actions">

					<button type="button" onclick="closeUpdateModal()"
						class="modal-btn btn-cancel">Cancel</button>

					<button type="button" onclick="saveProfile()"
						class="modal-btn btn-save">Save</button>

				</div>

			</div>
		</div>
	</div>

	<script>
function openUpdateModal() {
    document.getElementById("updateModal").classList.remove("hidden");
}

function closeUpdateModal() {
    document.getElementById("updateModal").classList.add("hidden");
}

function saveProfile() {
    const phone = document.getElementById("updPhone").value.trim();
    const address = document.getElementById("updAddress").value.trim();

    // 1️⃣ Update phone
    fetch("<%=request.getContextPath()%>/updateProfile", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "field=phone&newValue=" + encodeURIComponent(phone)
    })
    .then(res => res.json())

    // 2️⃣ Update address
    .then(data => {
        if (data.status !== "success") {
            alert(data.message);
            throw new Error("Phone update failed");
        }

        return fetch("<%=request.getContextPath()%>/updateProfile", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: "field=address&newValue=" + encodeURIComponent(address)
        });
    })
    .then(res => res.json())

    // 3️⃣ Final success
    .then(data => {
        if (data.status === "success") {

            // 🔄 Update UI
            document.querySelector("input[value='<%=staff.getPhone()%>']").value = phone;
            document.querySelector("textarea").value = address;

            closeUpdateModal();
            alert("✅ Profile updated successfully");
        } else {
            alert(data.message);
        }
    })
    .catch(err => console.error(err));
}
</script>

</body>
</html>
