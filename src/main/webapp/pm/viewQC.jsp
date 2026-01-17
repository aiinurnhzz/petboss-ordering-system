<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.Map" %>

<%
String staffId = (String) session.getAttribute("staffId");
String staffName = (String) session.getAttribute("staffName");

if (staffId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

Map<String,String> qc =
    (Map<String,String>) request.getAttribute("qc");

if (qc == null) {
    response.sendRedirect(request.getContextPath() + "/product-qc?tab=completed");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View QC</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body class="bg-[#fdf8e9] h-screen flex flex-col">

<!-- ===== HEADER ===== -->
<header class="w-full bg-[#266b8b] flex justify-between items-center px-6 py-3">
    <h1 class="text-white text-2xl font-bold">
        Pet Boss Centre Cash and Carry
    </h1>

    <form action="<%=request.getContextPath()%>/logout" method="post">
        <button class="text-white font-semibold text-sm">
            <i class="fas fa-sign-out-alt"></i> Logout
        </button>
    </form>
</header>

<div class="flex flex-1 overflow-hidden">

<!-- ===== SIDEBAR ===== -->
<aside class="w-60 bg-[#266b8b] px-5 py-4 flex flex-col h-full">

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
            <span>Receive Order</span>
        </a>

        <!-- ACTIVE -->
        <a href="<%=request.getContextPath()%>/product-qc"
           class="mx-auto w-[85%] h-11 bg-[#009a49] text-white
                  px-4 rounded-full flex items-center gap-3
                  border-2 border-white shadow-md text-sm font-semibold">
            <i class="fas fa-check-circle w-5 text-center"></i>
            <span>Product QC</span>
        </a>

    </nav>

	<div class="flex justify-center mt-auto pb-4">
	    <img src="<%=request.getContextPath()%>/images/logo_PetBoss.png"
	    	class="w-36 sm:w-40 md:w-44 opacity-100">
	</div>
</aside>

<!-- ===== MAIN CONTENT ===== -->
<main class="flex-1 p-8 overflow-y-auto">

<!-- ===== BACK ICON (ICON ONLY, NOT PRINTED) ===== -->
<div class="mb-4 print:hidden">
    <a href="<%=request.getContextPath()%>/product-qc?tab=completed"
       class="inline-flex items-center text-green-700 hover:text-green-900
              text-2xl">
        <i class="fas fa-arrow-left"></i>
    </a>
</div>

    <div class="bg-white border-2 border-[#009a49]
                rounded-2xl shadow-lg p-8
                max-w-4xl mx-auto print-area">
                
<h2 class="text-3xl font-black text-cyan-900 text-center">
    PRODUCT QUALITY CHECK DETAILS
</h2>

<hr class="border-t-2 border-green-600 my-4">


    <table class="w-full text-sm border-collapse">
        <tbody>
            <tr class="border-b"><td class="font-bold py-2 w-1/3">QC ID</td><td><%=qc.get("qcId")%></td></tr>
            <tr class="border-b"><td class="font-bold py-2">Batch Number</td><td class="font-mono"><%=qc.get("batch")%></td></tr>
            <tr class="border-b"><td class="font-bold py-2">Product</td><td><%=qc.get("product")%></td></tr>
            <tr class="border-b"><td class="font-bold py-2">Order ID</td><td><%=qc.get("order")%></td></tr>
            <tr class="border-b"><td class="font-bold py-2">Supplier</td><td><%=qc.get("supplier")%></td></tr>
            <tr class="border-b"><td class="font-bold py-2">Quantity Received</td><td><%=qc.get("receivedQty")%></td></tr>
            <tr class="border-b">
    <td class="font-bold py-2">Quantity Good</td>
    <td class="font-semibold text-green-700">
        <%= Integer.parseInt(qc.get("receivedQty"))
           - Integer.parseInt(qc.get("damaged")) %>
    </td>
</tr>
            <tr class="border-b"><td class="font-bold py-2">Quantity Damaged</td>
                <td class="text-red-600 font-semibold"><%=qc.get("damaged")%></td></tr>
            <tr class="border-b"><td class="font-bold py-2">Quantity Returned</td><td><%=qc.get("returned")%></td></tr>
            <tr class="border-b">
    <td class="font-bold py-2">Quantity Cannot Be Returned</td>
    <td class="font-semibold text-orange-600">
        <%= Integer.parseInt(qc.get("damaged"))
           - Integer.parseInt(qc.get("returned")) %>
    </td>
</tr>
            
            <tr class="border-b"><td class="font-bold py-2">Condition</td>
                <td>
                    <span class="px-3 py-1 rounded-full text-xs font-bold
                    <%= "GOOD".equalsIgnoreCase(qc.get("condition"))
                        ? "bg-green-200 text-green-800"
                        : "bg-red-200 text-red-800" %>">
                        <%=qc.get("condition")%>
                    </span>
                </td>
            </tr>
            <tr class="border-b"><td class="font-bold py-2">Remarks</td><td><%=qc.get("remarks")%></td></tr>
            <tr class="border-b"><td class="font-bold py-2">QC Date</td><td><%=qc.get("date")%></td></tr>
            <tr><td class="font-bold py-2">Checked By</td><td><%=qc.get("staff")%></td></tr>
        </tbody>
    </table>

    <% if ("DAMAGED".equalsIgnoreCase(qc.get("condition"))) { %>
    <div class="mt-6 bg-red-50 border border-red-400 text-red-700 p-3 rounded text-sm text-center">
        ⚠ This batch contains damaged items. Please proceed with return or disposal.
    </div>
    <% } %>

</div>
<!-- ===== PRINT BUTTON (NOT PRINTED) ===== -->
<div class="fixed bottom-6 right-6 print:hidden">
    <button onclick="window.print()"
            class="bg-green-600 hover:bg-green-700 text-white
                   w-14 h-14 rounded-full shadow-lg
                   flex items-center justify-center">
        <i class="fas fa-print text-xl"></i>
    </button>
</div>

</main>
</div>
<style>
/* ===== PRINT SETTINGS ===== */
@media print {

    /* Hide header & sidebar */
    header,
    aside {
        display: none !important;
    }

    /* Remove background color */
    body {
        background: white !important;
    }

    /* Expand main content to full width */
    main {
        padding: 0 !important;
        margin: 0 !important;
    }

    /* Remove card border & shadow for clean print */
    .print-area {
        border: none !important;
        box-shadow: none !important;
        max-width: 100% !important;
    }
}
</style>

</body>
</html>
