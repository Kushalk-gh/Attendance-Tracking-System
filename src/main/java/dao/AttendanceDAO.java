package dao;

import model.Attendance;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    // Mark or update attendance
    public boolean markAttendance(Attendance attendance) {
        String sql = "INSERT INTO attendance (student_id, date, subject, status) " +
                "VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE status = VALUES(status)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, attendance.getStudentId());

            // Convert string date to java.sql.Date
            Date sqlDate = Date.valueOf(attendance.getDate()); // assuming "yyyy-MM-dd" format
            stmt.setDate(2, sqlDate);

            stmt.setString(3, attendance.getSubject());
            stmt.setString(4, attendance.getStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error while marking attendance: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (IllegalArgumentException e) {
            System.err.println("Invalid date format. Use yyyy-MM-dd: " + attendance.getDate());
            return false;
        }
    }

    // Get attendance by student ID
    public List<Attendance> getAttendanceByStudentId(String studentId) {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ? ORDER BY date DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setId(rs.getInt("id"));
                attendance.setStudentId(rs.getString("student_id"));
                attendance.setDate(rs.getDate("date").toString()); // convert to String
                attendance.setSubject(rs.getString("subject"));
                attendance.setStatus(rs.getString("status"));
                attendanceList.add(attendance);
            }

        } catch (SQLException e) {
            System.err.println("Error while fetching attendance: " + e.getMessage());
            e.printStackTrace();
        }

        return attendanceList;
    }

    // Get all attendance
    public List<Attendance> getAllAttendance() {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance ORDER BY date DESC, student_id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setId(rs.getInt("id"));
                attendance.setStudentId(rs.getString("student_id"));
                attendance.setDate(rs.getDate("date").toString());
                attendance.setSubject(rs.getString("subject"));
                attendance.setStatus(rs.getString("status"));
                attendanceList.add(attendance);
            }

        } catch (SQLException e) {
            System.err.println("Error while fetching all attendance: " + e.getMessage());
            e.printStackTrace();
        }

        return attendanceList;
    }

    // Clear all attendance records
    public boolean clearAllAttendance() {
        String sql = "DELETE FROM attendance";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error while clearing attendance: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
