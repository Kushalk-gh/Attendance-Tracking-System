package servlet;

import dao.StudentDAO;
import dao.AttendanceDAO;
import model.Student;
import model.Attendance;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();
    private AttendanceDAO attendanceDAO = new AttendanceDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        try {
            List<Student> students = studentDAO.getAllStudents();
            List<Attendance> attendanceList = attendanceDAO.getAllAttendance();

            if (students == null) students = new ArrayList<>();
            if (attendanceList == null) attendanceList = new ArrayList<>();

            request.setAttribute("students", students);
            request.setAttribute("attendanceList", attendanceList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("students", new ArrayList<>());
            request.setAttribute("attendanceList", new ArrayList<>());
            request.setAttribute("error", "Error loading data: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        } else if ("clear".equals(action)) {
            // Clear attendance records
            try {
                if (attendanceDAO.clearAllAttendance()) {
                    session.setAttribute("success", "🗑️ All attendance records cleared successfully!");
                } else {
                    session.setAttribute("error", "❌ Failed to clear attendance records!");
                }
            } catch (Exception e) {
                session.setAttribute("error", "❌ Error: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin-dashboard");
            return;
        }

        doGet(request, response);
    }
}
