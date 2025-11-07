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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        if (studentId == null || password == null || studentId.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both Student ID and password");
            request.setAttribute("studentId", studentId);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        Student student = studentDAO.validateStudent(studentId.trim(), password.trim());

        if (student != null) {
            HttpSession session = request.getSession();
            session.setAttribute("student", student);
            response.sendRedirect("student-dashboard");
        } else {
            request.setAttribute("error", "Invalid Student ID or password");
            request.setAttribute("studentId", studentId);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
