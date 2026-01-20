package com.petboss.dao;

import com.petboss.model.Staff;
import com.petboss.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {
	
	// ===============================
	// AUTHENTICATE STAFF (LOGIN)
	// ===============================
	public Staff authenticate(String staffId) throws SQLException {

	    Staff staff = null;

	    String sql = """
	        SELECT STAFF_ID, PASSWORD, FULL_NAME, ROLE, STATUS
	        FROM STAFF
	        WHERE STAFF_ID = ?
	    """;

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, staffId);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            staff = new Staff();
	            staff.setStaffId(rs.getString("STAFF_ID"));
	            staff.setPassword(rs.getString("PASSWORD")); // may be NULL
	            staff.setFullName(rs.getString("FULL_NAME"));
	            staff.setRole(rs.getString("ROLE"));
	            staff.setStatus(rs.getString("STATUS"));
	        }
	    }
	    return staff;
	}

	
	// ===============================
	// UPDATE PASSWORD
	// ===============================
	public void updatePassword(String staffId, String password) throws SQLException {

	    String sql = "UPDATE STAFF SET PASSWORD=? WHERE STAFF_ID=?";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, password);
	        ps.setString(2, staffId);
	        ps.executeUpdate();
	    }
	}
	
	// ===============================
	// INSERT STAFF (TRANSACTION)
	// ===============================
	public void insertStaff(Staff s, Connection con) throws SQLException {

		String sql = """
			    INSERT INTO STAFF
			    (FULL_NAME, PASSWORD, EMAIL, PHONE_NO, ADDRESS,
			     ROLE, PM_ID, STATUS, PHOTO)
			    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
			""";

	    try (PreparedStatement ps = con.prepareStatement(sql)) {

	    	ps.setString(1, s.getFullName());
	    	ps.setString(2, s.getPassword());
	    	ps.setString(3, s.getEmail());
	    	ps.setString(4, s.getPhone());
	    	ps.setString(5, s.getAddress());
	    	ps.setString(6, s.getRole());
	    	ps.setString(7, s.getPmId());
	    	ps.setString(8, s.getStatus());
	    	ps.setString(9, s.getPhoto());

	        ps.executeUpdate();
	    }
	}


    // ===============================
    // GET STAFF BY ID (PROFILE / VIEW)
    // ===============================
    public Staff getStaffById(String staffId) throws SQLException {

        Staff staff = null;
        Connection con = DBConnection.getConnection();

        String sql = """
            SELECT STAFF_ID, FULL_NAME, EMAIL, PHONE_NO, ADDRESS,
                   ROLE, PM_ID, STATUS, PHOTO, JOINED_DATE
            FROM STAFF
            WHERE STAFF_ID = ?
        """;

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, staffId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            staff = new Staff();
            staff.setStaffId(rs.getString("STAFF_ID"));
            staff.setFullName(rs.getString("FULL_NAME"));
            staff.setEmail(rs.getString("EMAIL"));
            staff.setPhone(rs.getString("PHONE_NO"));
            staff.setAddress(rs.getString("ADDRESS"));
            staff.setRole(rs.getString("ROLE"));
            staff.setPmId(rs.getString("PM_ID"));
            staff.setStatus(rs.getString("STATUS"));
            staff.setPhoto(rs.getString("PHOTO"));
            staff.setJoinedDate(rs.getDate("JOINED_DATE"));
        }

        con.close();
        return staff;
    }

    // ===============================
    // INSERT STAFF
    // ===============================
    public void insertStaff(Staff s) {

    	String sql = """
    		    INSERT INTO STAFF
    		    (FULL_NAME, PASSWORD, EMAIL, PHONE_NO, ADDRESS,
    		     ROLE, PM_ID, STATUS, PHOTO)
    		    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    		""";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

        	ps.setString(1, s.getFullName());
        	ps.setString(2, s.getPassword());
        	ps.setString(3, s.getEmail());
        	ps.setString(4, s.getPhone());
        	ps.setString(5, s.getAddress());
        	ps.setString(6, s.getRole());
        	ps.setString(7, s.getPmId());
        	ps.setString(8, "Active");
        	ps.setString(9, s.getPhoto());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }


    // ===============================
    // SELF PROFILE UPDATE (USED BY MODAL)
    // ===============================
    public void updateName(String staffId, String name) throws SQLException {
        String sql = "UPDATE STAFF SET FULL_NAME=? WHERE STAFF_ID=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, staffId);
            ps.executeUpdate();
        }
    }

    public void updatePhone(String staffId, String phone) throws SQLException {
        String sql = "UPDATE STAFF SET PHONE_NO=? WHERE STAFF_ID=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, phone);
            ps.setString(2, staffId);
            ps.executeUpdate();
        }
    }

    public void updateAddress(String staffId, String address) throws SQLException {
        String sql = "UPDATE STAFF SET ADDRESS=? WHERE STAFF_ID=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, address);
            ps.setString(2, staffId);
            ps.executeUpdate();
        }
    }

    public void updatePhoto(String staffId, String photo) throws SQLException {
        String sql = "UPDATE STAFF SET PHOTO=? WHERE STAFF_ID=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, photo);
            ps.setString(2, staffId);
            ps.executeUpdate();
        }
    }

    // ===============================
    // SEARCH + FILTER STAFF (ADMIN)
    // ===============================
    public List<Staff> searchStaff(String keyword, String role) {

        List<Staff> list = new ArrayList<>();
        String sql = "SELECT STAFF_ID, FULL_NAME, ROLE, STATUS FROM STAFF WHERE 1=1";

        if (keyword != null && !keyword.isEmpty()) {
            sql += " AND (LOWER(FULL_NAME) LIKE ? OR LOWER(STAFF_ID) LIKE ?)";
        }

        if (role != null && !role.isEmpty()) {
            sql += " AND ROLE = ?";
        }

        sql += " ORDER BY STAFF_ID";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int index = 1;

            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(index++, "%" + keyword.toLowerCase() + "%");
                ps.setString(index++, "%" + keyword.toLowerCase() + "%");
            }

            if (role != null && !role.isEmpty()) {
                ps.setString(index++, role);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Staff s = new Staff();
                s.setStaffId(rs.getString("STAFF_ID"));
                s.setFullName(rs.getString("FULL_NAME"));
                s.setRole(rs.getString("ROLE"));
                s.setStatus(rs.getString("STATUS"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===============================
    // ACTIVATE / DEACTIVATE STAFF
    // ===============================
    public void activateStaff(String staffId) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE STAFF SET STATUS='Active' WHERE STAFF_ID=?")) {
            ps.setString(1, staffId);
            ps.executeUpdate();
        }
    }

    public void deactivateStaff(String staffId) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE STAFF SET STATUS='Inactive' WHERE STAFF_ID=?")) {
            ps.setString(1, staffId);
            ps.executeUpdate();
        }
    }

    // ===============================
    // UPDATE STAFF (ADMIN)
    // ===============================
    public void updateStaff(Staff staff) throws SQLException {

        Connection con = DBConnection.getConnection();

        String sql = """
            UPDATE STAFF
            SET FULL_NAME=?, EMAIL=?, PHONE_NO=?, ADDRESS=?,
                ROLE=?, PM_ID=?, STATUS=?
            WHERE STAFF_ID=?
        """;

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, staff.getFullName());
        ps.setString(2, staff.getEmail());
        ps.setString(3, staff.getPhone());
        ps.setString(4, staff.getAddress());
        ps.setString(5, staff.getRole());
        ps.setString(6, staff.getPmId());
        ps.setString(7, staff.getStatus());
        ps.setString(8, staff.getStaffId());

        ps.executeUpdate();
        con.close();
    }

    // ===============================
    // TOTAL STAFF
    // ===============================
    public int getTotalStaff() throws SQLException {

        Connection con = DBConnection.getConnection();
        ResultSet rs = con.createStatement()
                          .executeQuery("SELECT COUNT(*) FROM STAFF");

        rs.next();
        int total = rs.getInt(1);
        con.close();
        return total;
    }
    
    public boolean exists(String staffId) throws Exception {
        String sql = "SELECT 1 FROM staff WHERE staff_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, staffId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public boolean passwordExists(String staffId) throws Exception {
        String sql = "SELECT password FROM staff WHERE staff_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, staffId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("password") != null;
            }
            return false;
        }
    }
}

