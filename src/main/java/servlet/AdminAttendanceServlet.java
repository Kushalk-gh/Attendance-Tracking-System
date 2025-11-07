package servlet;

import dao.AttendanceDAO;
import model.Attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet("/admin-attendance")
public class AdminAttendanceServlet extends HttpServlet {
    private AttendanceDAO attendanceDAO = new AttendanceDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("mark".equals(action)) {
                markAttendance(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin-dashboard");
    }

    private void markAttendance(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String studentId = request.getParameter("studentId");
        String subject = request.getParameter("subject");
        String status = request.getParameter("status");
        String dateStr = request.getParameter("date");

        if (studentId == null || subject == null || status == null ||
                studentId.trim().isEmpty() || subject.trim().isEmpty() || status.trim().isEmpty()) {

            HttpSession session = request.getSession();
            session.setAttribute("error", "Student ID, Subject, and Status are required");
            return;
        }

        // Use provided date or current date
        LocalDate date;
        if (dateStr != null && !dateStr.trim().isEmpty()) {
            try {
                date = LocalDate.parse(dateStr.trim());
            } catch (Exception e) {
                date = LocalDate.now();
            }
        } else {
            date = LocalDate.now();
        }

        Attendance attendance = new Attendance();
        attendance.setStudentId(studentId.trim());
        attendance.setSubject(subject.trim());
        attendance.setStatus(status.trim());
        attendance.setDate(date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));

        boolean success = attendanceDAO.markAttendance(attendance);

        HttpSession session = request.getSession();
        if (success) {
            session.setAttribute("success", "Attendance marked successfully");
        } else {
            session.setAttribute("error", "Failed to mark attendance");
        }
    }
    private void clearAllAttendance(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            if (attendanceDAO.clearAllAttendance()) {
                request.getSession().setAttribute("success", "🗑️ All attendance records cleared successfully!");
            } else {
                request.getSession().setAttribute("error", "❌ Failed to clear attendance records!");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "❌ Error: " + e.getMessage());
        }
        response.sendRedirect("admin-dashboard");
    }

}
