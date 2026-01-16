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
    box-shadow: 0 0 0 2px rgba(34,197,94,0.4);
}
</style>
</head>

<body class="font-sans flex flex-col h-screen">

<!-- ===== HEADER ===== -->
<header class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
    <h1 class="text-white text-2xl font-bold">
        Pet Boss Centre Cash and Carry
    </h1>

    <form action="<%=request.getContextPath()%>/logout" method="post">
        <button
            class="bg-[#f2711c] text-white px-4 py-1.5 rounded-xl
                   flex items-center gap-2 font-semibold text-sm hover:bg-orange-600">
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
					class="w-full bg-[#009a49] hover:bg-[#009a49] text-white py-2 px-4
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
					class="w-full bg-[#f2711c] hover:bg-[#009a49] text-white py-2 px-4
              rounded-full flex items-center gap-3 border-2 border-white shadow-md">
					<i class="fas fa-truck"></i> Supplier
				</a>

			</nav>
			<img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
				class="absolute bottom-6 left-1/2 -translate-x-1/2 w-64 opacity-70">
		</aside>

<!-- ===== MAIN CONTENT ===== -->
<main class="relative flex-1 p-12 overflow-hidden flex justify-center items-center bg-[#fdf8e9]"
              style="background-size: cover; background-position: center;">


    <!-- PROFILE CARD -->
    <div class="relative z-10 w-full max-w-4xl bg-white rounded-3xl shadow-xl border-2 border-[#009a49] overflow-hidden">
				<div class="flex justify-between items-start w-full flex-shrink-0">
					<div
					class="bg-[#009a49] text-white py-3 px-16 inline-block rounded-br-3xl text-2xl font-bold tracking-widest">
					PROFILE
					</div>
		</div>
        <div class="p-8 flex flex-col md:flex-row gap-10">
		
            <!-- LEFT -->
            <div
					class="w-full md:w-1/3 border-2 border-gray-300 rounded-[20px] p-6 flex flex-col items-center">

					<img src="<%=request.getContextPath()%>/uploads/staff/<%= staff.getPhoto() %>?t=<%= System.currentTimeMillis() %>"
     					class="w-44 h-44 rounded-full border-[6px] border-sky-400
                    flex items-center justify-center mb-4">

					<form action="<%=request.getContextPath()%>/uploadProfilePhoto"
						method="post" enctype="multipart/form-data"
						class="mb-4 text-center">

						<label
							class="bg-orange-500 text-white px-4 py-2 rounded-full text-sm cursor-pointer inline-flex items-center gap-2">
							<i class="fas fa-image"></i> Change Photo <input type="file"
							name="photo" hidden onchange="this.form.submit()">
						</label>
					</form>

                <div class="bg-blue-100 border border-blue-300 text-blue-800 px-12 rounded-lg 
                			font-bold mb-4">
                    <%= staff.getRole() %>
                </div>

                <div class="text-center space-y-2 text-sm font-bold text-gray-600">
                    <p>Employee ID : <%= staff.getStaffId() %></p>
           			<p>PM ID : <%= staff.getPmId() == null ? "-" : staff.getPmId() %></p>
                </div>
            </div>

            <!-- RIGHT -->
            <div class="flex-1 space-y-4 text-gray-800">

                <div class="flex items-center gap-3 mb-2">
				    <!-- USER NAME -->
				    <h2 class="text-3xl font-black uppercase">
				        <%= staff.getFullName() %>
				    </h2>
				
				    <!-- PENCIL ICON -->
				    <button onclick="openUpdateModal()"
				            class="text-blue-500 hover:scale-110 transition-transform">
				        <i class="fas fa-pencil-alt"></i>
				    </button>
				</div>

                <div class="flex items-center gap-6 text-sm font-bold text-gray-600">
                    <p>Joined : <%= staff.getJoinedDate() %></p>
                    <%
					    String status = staff.getStatus(); // e.g. ACTIVE / INACTIVE
					    boolean isActive = "ACTIVE".equalsIgnoreCase(status);
					%>
					
					<p class="flex items-center gap-2 <%= isActive ? "text-green-600" : "text-red-600" %>">
					    <span class="w-3 h-3 rounded-full
					        <%= isActive ? "bg-green-500" : "bg-red-500" %>">
					    </span>
					    <%= status %>
					</p>
                </div>

                <div class="bg-orange-50 text-orange-600 text-center py-1
                            font-black tracking-widest rounded-md border
                            border-orange-100 uppercase">
                    Personal Info
                </div>

                <!-- INFO -->
                <div class="space-y-3">

                    <div>
                        <label class="text-xs font-bold block mb-1">Full Name</label>
                        <input type="text" value="<%= staff.getFullName() %>"
                               readonly
                               class="w-full bg-gray-200 border border-gray-400
                                      rounded-lg px-3 py-2 text-gray-500">
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="text-xs font-bold block mb-1">Email</label>
                            <input type="text" value="<%= staff.getEmail() %>"
                                   readonly
                                   class="w-full bg-gray-200 border border-gray-400
                                          rounded-lg px-3 py-2 text-gray-500">
                        </div>

                        <div>
                            <label class="text-xs font-bold block mb-1">Phone Number</label>
                            <input type="text" value="<%= staff.getPhone() %>"
                                   readonly
                                   class="w-full bg-gray-200 border border-gray-400
                                          rounded-lg px-3 py-2 text-gray-500">
                        </div>
                    </div>

                    <div>
                        <label class="text-xs font-bold block mb-1">Address</label>
                        <textarea rows="3" readonly
                                  class="w-full bg-gray-200 border border-gray-400
                                         rounded-lg px-3 py-2 text-gray-500"><%= staff.getAddress() %></textarea>
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

    <div class="bg-white w-full max-w-md rounded-3xl
                border-2 border-green-700 shadow-2xl overflow-hidden">

        <!-- TITLE -->
        <div class="text-center py-4">
            <h3 class="text-2xl font-bold uppercase tracking-wide">
                Update Information
            </h3>
        </div>

        <div class="px-8 pb-8 space-y-4">

    <!-- FULL NAME -->
    <div>
        <label class="font-bold text-sm">Full Name</label>
        <input type="text"
               value="<%= staff.getFullName() %>"
               readonly
               class="w-full bg-gray-200 border rounded-lg
                      px-3 py-2 text-gray-500 cursor-not-allowed">
    </div>

    <!-- EMAIL -->
    <div>
        <label class="font-bold text-sm">Email</label>
        <input type="text"
               value="<%= staff.getEmail() %>"
               readonly
               class="w-full bg-gray-200 border rounded-lg
                      px-3 py-2 text-gray-500 cursor-not-allowed">
    </div>

    <hr class="opacity-30">

    <!-- PHONE -->
    <div>
        <label class="font-bold text-sm">New Phone Number</label>
        <input id="updPhone"
               value="<%= staff.getPhone() %>"
               class="w-full px-3 py-2 edit-input">
    </div>

    <!-- ADDRESS -->
    <div>
        <label class="font-bold text-sm">New Address</label>
        <textarea id="updAddress"
                  rows="3"
                  class="w-full px-3 py-2 edit-input"><%= staff.getAddress() %></textarea>
    </div>

    <!-- BUTTONS -->
    <div class="flex gap-4 pt-4">
        <button onclick="closeUpdateModal()"
                type="button"
                class="flex-1 bg-gray-500 text-white
                       py-2 rounded-xl font-bold">
            Cancel
        </button>

        <button onclick="saveProfile()"
                type="button"
                class="flex-1 bg-green-600 text-white
                       py-2 rounded-xl font-bold">
            Save
        </button>
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
            document.querySelector("input[value='<%= staff.getPhone() %>']").value = phone;
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
