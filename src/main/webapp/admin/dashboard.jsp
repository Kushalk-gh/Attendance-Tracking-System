<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page import="model.Attendance" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Attendance System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
            font-size: 16px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 15px;
        }

        /* Header Styles */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            color: #333;
            padding: 25px 30px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header-content h1 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 15px;
            color: #667eea;
        }

        .header-content p {
            font-size: 16px;
            color: #666;
        }

        .logout-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 16px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        /* Alert Styles */
        .alert {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
            font-size: 16px;
            backdrop-filter: blur(10px);
        }

        .alert-success {
            background: rgba(212, 237, 218, 0.9);
            color: #155724;
            border-left: 4px solid #28a745;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);
        }

        .alert-danger {
            background: rgba(248, 215, 218, 0.9);
            color: #721c24;
            border-left: 4px solid #dc3545;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.2);
        }

        /* Card Styles */
        .section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .section h2 {
            color: #667eea;
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(102, 126, 234, 0.1);
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
            font-size: 16px;
        }

        input, select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.2s ease;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(5px);
        }

        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        /* Button Styles */
        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 500;
            font-size: 16px;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            padding: 8px 16px;
            font-size: 14px;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .btn-danger:hover {
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
        }

        /* Layout */
        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 25px;
        }

        /* Table Styles */
        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 12px;
            text-align: left;
            font-weight: 600;
            font-size: 16px;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
            font-size: 16px;
        }

        tr:hover {
            background: rgba(102, 126, 234, 0.05);
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-left: 4px solid #667eea;
        }

        .stat-card i {
            font-size: 32px;
            margin-bottom: 15px;
            color: #667eea;
        }

        .stat-card h3 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .stat-card p {
            font-size: 14px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
        }

        /* Status badges */
        .status-present {
            background: rgba(212, 237, 218, 0.9);
            color: #155724;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: 600;
        }

        .status-absent {
            background: rgba(248, 215, 218, 0.9);
            color: #721c24;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: 600;
        }

        .course-badge {
            background: rgba(102, 126, 234, 0.1);
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 14px;
            color: #667eea;
            font-weight: 500;
        }

        /* Empty states */
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 15px;
            opacity: 0.3;
            color: #667eea;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .header {
                padding: 20px;
                text-align: center;
            }

            .header-content h1 {
                font-size: 24px;
            }

            .row {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .section {
                padding: 20px;
            }

            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Header -->
    <div class="header">
        <div class="header-content">
            <h1>
                <i class="fas fa-tachometer-alt"></i>
                Admin Dashboard
            </h1>
            <p>Welcome back, <%= session.getAttribute("adminUsername") != null ? session.getAttribute("adminUsername") : "Admin" %>!</p>
        </div>
        <form method="post" style="display: inline;">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Logout
            </button>
        </form>
    </div>

    <!-- Success/Error Messages -->
        <% if (session.getAttribute("success") != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <%= session.getAttribute("success") %>
        <% session.removeAttribute("success"); %>
    </div>
        <% } %>

        <% if (session.getAttribute("error") != null) { %>
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-triangle"></i>
        <%= session.getAttribute("error") %>
        <% session.removeAttribute("error"); %>
    </div>
        <% } %>

    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <i class="fas fa-users"></i>
            <h3><%
                List<Student> students = (List<Student>) request.getAttribute("students");
                out.print(students != null ? students.size() : 0);
            %></h3>
            <p>Total Students</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-clipboard-check"></i>
            <h3><%
                List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");
                out.print(attendanceList != null ? attendanceList.size() : 0);
            %></h3>
            <p>Attendance Records</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-calendar-day"></i>
            <h3><%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd")) %></h3>
            <p><%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("MMM yyyy")) %></p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="row">
        <!-- Add Student Section -->
        <div class="section">
            <h2>
                <i class="fas fa-user-plus"></i>
                Add New Student
            </h2>
            <form action="admin-students" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label for="studentId">Student ID</label>
                    <input type="text" id="studentId" name="studentId" placeholder="Enter student ID" required>
                </div>
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter full name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="Enter email address" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>
                </div>
                <div class="form-group">
                    <label for="course">Course</label>
                    <input type="text" id="course" name="course" placeholder="Enter course name" required>
                </div>
                <button type="submit" class="btn">
                    <i class="fas fa-plus"></i>
                    Add Student
                </button>
            </form>
        </div>

        <!-- Mark Attendance Section -->
        <div class="section">
            <h2>
                <i class="fas fa-clipboard-check"></i>
                Mark Attendance
            </h2>
            <form action="admin-attendance" method="post">
                <input type="hidden" name="action" value="mark">
                <div class="form-group">
                    <label for="attendanceStudentId">Student ID</label>
                    <input type="text" id="attendanceStudentId" name="studentId" placeholder="Enter student ID" required>
                </div>
                <div class="form-group">
                    <label for="subject">Subject</label>
                    <input type="text" id="subject" name="subject" placeholder="Enter subject name" required>
                </div>
                <div class="form-group">
                    <label for="status">Attendance Status</label>
                    <select id="status" name="status" required>
                        <option value="">Select Status</option>
                        <option value="Present">✅ Present</option>
                        <option value="Absent">❌ Absent</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="date">Date</label>
                    <input type="date" id="date" name="date" value="<%= java.time.LocalDate.now() %>">
                </div>
                <button type="submit" class="btn">
                    <i class="fas fa-save"></i>
                    Mark Attendance
                </button>
            </form>
        </div>
    </div>

    <!-- Students List -->
    <div class="section">
        <h2>
            <i class="fas fa-users"></i>
            All Students
        </h2>
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Course</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Student> studentsList = (List<Student>) request.getAttribute("students");
                    if (studentsList != null && !studentsList.isEmpty()) {
                        for (Student student : studentsList) {
                %>
                <tr>
                    <td><strong><%= student.getStudentId() %></strong></td>
                    <td><%= student.getName() %></td>
                    <td><%= student.getEmail() %></td>
                    <td><span class="course-badge"><%= student.getCourse() %></span></td>
                    <td>
                        <form method="post" action="admin-students" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="studentId" value="<%= student.getStudentId() %>">
                            <button type="submit" class="btn-danger" onclick="return confirm('Are you sure you want to delete this student?')">
                                <i class="fas fa-trash"></i>
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="5" class="empty-state">
                        <i class="fas fa-users"></i>
                        <br>
                        <strong>No students found</strong>
                        <br>
                        <small>Add your first student using the form above</small>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Attendance Records -->
    <div class="section">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 15px;">
            <h2 style="margin-bottom: 0;">
                <i class="fas fa-history"></i>
                Recent Attendance Records
            </h2>
            <form method="post" action="admin-dashboard" style="display: inline;">
                <input type="hidden" name="action" value="clear">
                <button type="submit" class="btn-danger"
                        onclick="return confirm('⚠️ WARNING: This will permanently delete ALL attendance records!\n\nThis action cannot be undone. Are you absolutely sure?')"
                        style="background: linear-gradient(135deg, #ff4757 0%, #ff3742 100%); padding: 10px 16px; font-size: 14px; box-shadow: 0 4px 15px rgba(255, 71, 87, 0.3);">
                    <i class="fas fa-trash-alt"></i>
                    Clear All Records
                </button>
            </form>
        </div>
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Subject</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Attendance> recentAttendance = (List<Attendance>) request.getAttribute("attendanceList");
                    if (recentAttendance != null && !recentAttendance.isEmpty()) {
                        for (Attendance attendance : recentAttendance) {
                %>
                <tr>
                    <td><strong><%= attendance.getStudentId() %></strong></td>
                    <td><%= attendance.getSubject() %></td>
                    <td><%= attendance.getDate() %></td>
                    <td>
                        <% if ("Present".equals(attendance.getStatus())) { %>
                        <span class="status-present">✅ Present</span>
                        <% } else { %>
                        <span class="status-absent">❌ Absent</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="4" class="empty-state">
                        <i class="fas fa-clipboard-list"></i>
                        <br>
                        <strong>No attendance records found</strong>
                        <br>
                        <small>Start marking attendance using the form above</small>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>



    <script>
    // Simple form validation feedback
    document.querySelectorAll('input[required]').forEach(input => {
        input.addEventListener('invalid', function() {
            this.style.borderColor = '#ff6b6b';
        });

        input.addEventListener('input', function() {
            if (this.validity.valid) {
                this.style.borderColor = '#28a745';
            } else {
                this.style.borderColor = 'rgba(102, 126, 234, 0.2)';
            }
        });
    });

    // Auto-hide alerts after 4 seconds
    document.querySelectorAll('.alert').forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-10px)';
            setTimeout(() => {
                alert.style.display = 'none';
            }, 300);
        }, 4000);
    });

    // Simple loading state for forms
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('button[type="submit"]');
            if (submitBtn && !submitBtn.classList.contains('btn-danger')) {
                const originalText = submitBtn.innerHTML;
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';

                // Re-enable after 2 seconds (fallback)
                setTimeout(() => {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalText;
                }, 2000);
            }
        });
    });
</script>
</body>
</html>
