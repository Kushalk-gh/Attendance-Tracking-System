package servlet;

import dao.StudentDAO;
import model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin-students")
public class AdminStudentServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addStudent(request, response);
            } else if ("delete".equals(action)) {
                deleteStudent(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin-dashboard");
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();  // ✅ declared once at the top

        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String course = request.getParameter("course");

        // Validate input
        if (studentId == null || name == null || email == null || password == null || course == null ||
                studentId.trim().isEmpty() || name.trim().isEmpty() || email.trim().isEmpty() ||
                password.trim().isEmpty() || course.trim().isEmpty()) {

            session.setAttribute("error", "All fields are required.");
            return;
        }

        // Check for duplicate student ID
        if (studentDAO.studentExists(studentId.trim())) {
            session.setAttribute("error", "Student ID already exists.");
            return;
        }

        // Create and insert student
        Student student = new Student();
        student.setStudentId(studentId.trim());
        student.setName(name.trim());
        student.setEmail(email.trim());
        student.setPassword(password.trim());
        student.setCourse(course.trim());

        boolean success = studentDAO.addStudent(student);

        if (success) {
            session.setAttribute("success", "Student added successfully.");
        } else {
            session.setAttribute("error", "Failed to add student. Please try again.");
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();  // ✅ declared once at the top

        String studentId = request.getParameter("studentId");

        if (studentId == null || studentId.trim().isEmpty()) {
            session.setAttribute("error", "Student ID is required.");
            return;
        }

        boolean success = studentDAO.deleteStudent(studentId.trim());

        if (success) {
            session.setAttribute("success", "Student deleted successfully.");
        } else {
            session.setAttribute("error", "Failed to delete student.");
        }
    }
}
