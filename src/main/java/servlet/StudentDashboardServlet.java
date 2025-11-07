package servlet;

import dao.AttendanceDAO;
import model.Attendance;
import model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.WeekFields;
import java.util.List;
import java.util.ArrayList;
import java.util.Locale;

@WebServlet("/student-dashboard")
public class StudentDashboardServlet extends HttpServlet {
    private AttendanceDAO attendanceDAO = new AttendanceDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        try {
            List<Attendance> attendanceList = attendanceDAO.getAttendanceByStudentId(student.getStudentId());
            if (attendanceList == null) {
                attendanceList = new ArrayList<>();
            }

            // Calculate attendance statistics
            int totalClasses = attendanceList.size();
            int presentCount = 0;
            int absentCount = 0;

            // Count present and absent
            for (Attendance attendance : attendanceList) {
                if ("Present".equalsIgnoreCase(attendance.getStatus())) {
                    presentCount++;
                } else if ("Absent".equalsIgnoreCase(attendance.getStatus())) {
                    absentCount++;
                }
            }

            // Calculate attendance percentage
            double attendancePercentage = 0.0;
            if (totalClasses > 0) {
                attendancePercentage = (double) presentCount / totalClasses * 100;
            }

            // Calculate weekly and monthly attendance
            double weeklyAttendance = calculateWeeklyAttendance(attendanceList);
            double monthlyAttendance = calculateMonthlyAttendance(attendanceList);

            // Set all attributes for JSP
            request.setAttribute("attendanceList", attendanceList);
            request.setAttribute("totalClasses", totalClasses);
            request.setAttribute("presentCount", presentCount);
            request.setAttribute("absentCount", absentCount);
            request.setAttribute("attendancePercentage", Math.round(attendancePercentage));
            request.setAttribute("weeklyAttendance", Math.round(weeklyAttendance));
            request.setAttribute("monthlyAttendance", Math.round(monthlyAttendance));

            // Debug logging
            System.out.println("=== Attendance Debug ===");
            System.out.println("Student ID: " + student.getStudentId());
            System.out.println("Total Classes: " + totalClasses);
            System.out.println("Present: " + presentCount);
            System.out.println("Absent: " + absentCount);
            System.out.println("Percentage: " + Math.round(attendancePercentage) + "%");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("attendanceList", new ArrayList<>());
            request.setAttribute("error", "Error loading attendance data");
            // Set default values when error occurs
            request.setAttribute("totalClasses", 0);
            request.setAttribute("presentCount", 0);
            request.setAttribute("absentCount", 0);
            request.setAttribute("attendancePercentage", 0);
            request.setAttribute("weeklyAttendance", 0);
            request.setAttribute("monthlyAttendance", 0);
        }

        request.getRequestDispatcher("student/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            session.invalidate();
            response.sendRedirect("index.jsp");
            return;
        }

        doGet(request, response);
    }

    private double calculateWeeklyAttendance(List<Attendance> attendanceList) {
        LocalDate now = LocalDate.now();
        LocalDate sevenDaysAgo = now.minusDays(7);

        int recentTotal = 0;
        int recentPresent = 0;

        for (Attendance attendance : attendanceList) {
            try {
                LocalDate attendanceDate = parseDate(attendance.getDate());
                if (attendanceDate != null && attendanceDate.isAfter(sevenDaysAgo)) {
                    recentTotal++;
                    if ("Present".equalsIgnoreCase(attendance.getStatus())) {
                        recentPresent++;
                    }
                }
            } catch (Exception e) {
                System.out.println("Error parsing date: " + attendance.getDate());
            }
        }

        System.out.println("Last 7 days - Total: " + recentTotal + ", Present: " + recentPresent);
        return recentTotal > 0 ? (double) recentPresent / recentTotal * 100 : 0.0;
    }

    private double calculateMonthlyAttendance(List<Attendance> attendanceList) {
        LocalDate now = LocalDate.now();
        LocalDate thirtyDaysAgo = now.minusDays(30);

        int recentTotal = 0;
        int recentPresent = 0;

        for (Attendance attendance : attendanceList) {
            try {
                LocalDate attendanceDate = parseDate(attendance.getDate());
                if (attendanceDate != null && attendanceDate.isAfter(thirtyDaysAgo)) {
                    recentTotal++;
                    if ("Present".equalsIgnoreCase(attendance.getStatus())) {
                        recentPresent++;
                    }
                }
            } catch (Exception e) {
                System.out.println("Error parsing date: " + attendance.getDate());
            }
        }

        System.out.println("Last 30 days - Total: " + recentTotal + ", Present: " + recentPresent);
        return recentTotal > 0 ? (double) recentPresent / recentTotal * 100 : 0.0;
    }


    private LocalDate parseDate(String dateString) {
        if (dateString == null || dateString.trim().isEmpty()) {
            return null;
        }

        // Try different date formats
        DateTimeFormatter[] formatters = {
                DateTimeFormatter.ofPattern("yyyy-MM-dd"),
                DateTimeFormatter.ofPattern("dd/MM/yyyy"),
                DateTimeFormatter.ofPattern("MM/dd/yyyy"),
                DateTimeFormatter.ofPattern("dd-MM-yyyy"),
                DateTimeFormatter.ofPattern("yyyy/MM/dd")
        };

        for (DateTimeFormatter formatter : formatters) {
            try {
                return LocalDate.parse(dateString.trim(), formatter);
            } catch (Exception e) {
                // Try next format
            }
        }

        System.out.println("Could not parse date: " + dateString);
        return null;
    }
}
