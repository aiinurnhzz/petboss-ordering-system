<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>

<%
Map<String,String> n =
    (Map<String,String>) request.getAttribute("note");

if (n == null) {
    response.sendRedirect(request.getContextPath() + "/product-qc?tab=completed");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Return Note</title>

<style>
/* ===== BASIC ===== */
body {
    font-family: Arial, Helvetica, sans-serif;
    background: white;
    margin: 50px;
    color: #000;
}
@media print {
    button { display:none; }
}

/* ===== TITLE ===== */
.title {
    text-align: center;
    font-size: 28px;
    font-weight: bold;
    letter-spacing: 1px;
    margin-bottom: 35px;
}

/* ===== HEADER ROW ===== */
.header-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 30px;
}

/* ===== COMPANY & SUPPLIER (SAME STYLE) ===== */
.company,
.supplier-block {
    font-size: 13px;
    line-height: 1.6;
}

.company-name,
.supplier-name {
    font-size: 15px;
    font-weight: bold;
    margin-bottom: 6px;
}

/* spacing below company before supplier */
.supplier-block {
    margin-bottom: 30px;
}

/* ===== DOC INFO (RIGHT SIDE) ===== */
.doc-info {
    text-align: right;
    font-size: 13px;
    line-height: 1.6;
}

/* ===== TABLE ===== */
table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
}
th, td {
    border: 1px solid #000;
    padding: 8px;
    text-align: center;
}
th {
    background: #f2f2f2;
    font-weight: bold;
}

/* ===== REMARKS ===== */
.remarks {
    margin-top: 25px;
    font-size: 13px;
}
.remarks-title {
    font-weight: bold;
    margin-bottom: 6px;
}

/* ===== SIGNATURE ===== */
.signature {
    margin-top: 50px;
    font-size: 13px;
}

.sign-left {
    width: 45%;
}

.sign-line {
    margin-top: 35px;
    border-top: 1px solid #000;
    width: 100%;
}

/* ===== PRINT BUTTON ===== */
.print-btn {
    margin-top: 40px;
    padding: 8px 20px;
    font-size: 13px;
    background: #000;
    color: white;
    border: none;
    cursor: pointer;
}
</style>
</head>

<body>

<!-- ===== TITLE ===== -->
<div class="title">RETURN NOTE</div>

<!-- ===== HEADER ===== -->
<div class="header-row">

    <!-- COMPANY (LEFT) -->
    <div class="company">
        <div class="company-name">PET BOSS CENTRE CASH AND CARRY</div>
        JC 2613 & 2614 Jalan PB 4<br>
        77200 Bemban, Jasin, Melaka<br>
        Phone: 011-5553 3480
    </div>

    <!-- DOCUMENT INFO (RIGHT) -->
    <div class="doc-info">
        <b>Return ID:</b> <%= n.get("returnId") %><br>
        <b>Order Date:</b> <%= n.get("orderDate") %><br>
        <b>Order ID:</b> <%= n.get("orderId") %>
    </div>

</div>

<!-- ===== SUPPLIER (FORMAL LETTER STYLE, SAME FONT) ===== -->
<div class="supplier-block">
    <div class="supplier-name"><%= n.get("supplier") %></div>
    <%= n.get("supplierAddress") %><br>
    Phone: <%= n.get("supplierPhone") %>
</div>

<!-- ===== ITEM TABLE ===== -->
<table>
<tr>
    <th style="width:5%">No</th>
    <th style="width:25%">Batch Number</th>
    <th style="width:30%">Product Name</th>
    <th style="width:10%">Qty Received</th>
    <th style="width:10%">Qty Returned</th>
    <th style="width:20%">Reason</th>
</tr>
<tr>
    <td>1</td>
    <td><%= n.get("batch") %></td>
    <td><%= n.get("product") %></td>
    <td><%= n.get("received") %></td>
    <td><%= n.get("returned") %></td>
    <td>Damaged</td>
</tr>
</table>

<!-- ===== REMARKS ===== -->
<div class="remarks">
    <div class="remarks-title">Detailed Remarks / Inspection Report</div>
    <%= n.get("remarks") %>
</div>

<!-- ===== SIGNATURE ===== -->
<div class="signature">

    <!-- LEFT: SIGNATURE + CHECKED BY -->
    <div class="sign-left">
        <b>Signature:</b>
        <div class="sign-line"></div>

        <div style="margin-top:12px;">
            <b>Checked By:</b> <%= n.get("staff") %><br>
            <b>Date:</b> <%= n.get("returnDate") %>
        </div>
    </div>

</div>

<button class="print-btn" onclick="window.print()">Print</button>

</body>
</html>
