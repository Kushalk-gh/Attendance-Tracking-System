<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Attendance System</title>
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
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 15px;
        }

        /* Compact Header */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header-left h1 {
            color: #4a5568;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .student-info {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            font-size: 0.9rem;
            color: #4a5568;
        }

        .student-info span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .logout-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* Main Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        /* Compact Summary Cards */
        .summary-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .summary-section h2 {
            color: #4a5568;
            font-size: 1.3rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .summary-cards {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .summary-card {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .summary-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .summary-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .summary-card.present::before {
            background: linear-gradient(135deg, #48bb78, #38a169);
        }

        .summary-card.absent::before {
            background: linear-gradient(135deg, #f56565, #e53e3e);
        }

        .summary-card.percentage::before {
            background: linear-gradient(135deg, #ed8936, #dd6b20);
        }

        .summary-card h3 {
            color: #4a5568;
            font-size: 0.9rem;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .summary-number {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2d3748;
            margin: 0;
        }

        .summary-card.present .summary-number {
            color: #38a169;
        }

        .summary-card.absent .summary-number {
            color: #e53e3e;
        }

        .summary-card.percentage .summary-number {
            color: #dd6b20;
        }

        /* Status Panel */
        .status-panel {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .status-panel h2 {
            color: #4a5568;
            font-size: 1.3rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .status-alert {
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 15px;
        }

        .status-alert.success {
            background: linear-gradient(135deg, #c6f6d5, #9ae6b4);
            color: #22543d;
        }

        .status-alert.warning {
            background: linear-gradient(135deg, #feebc8, #fbd38d);
            color: #744210;
        }

        .status-alert.danger {
            background: linear-gradient(135deg, #fed7d7, #feb2b2);
            color: #742a2a;
        }

        .status-alert i {
            font-size: 1.5rem;
            margin-bottom: 8px;
            display: block;
        }

        .quick-stats {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .stat-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 12px;
            background: #f8fafc;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .stat-label {
            font-weight: 500;
            color: #4a5568;
        }

        .stat-value {
            font-weight: 700;
        }

        .text-success { color: #38a169; }
        .text-warning { color: #dd6b20; }
        .text-danger { color: #e53e3e; }
        .text-info { color: #3182ce; }

        /* Compact Attendance Table */
        .attendance-records {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            grid-column: 1 / -1;
        }

        .attendance-records h2 {
            color: #4a5568;
            font-size: 1.3rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .table-container {
            max-height: 400px;
            overflow-y: auto;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
        }

        thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        th {
            padding: 15px;
            text-align: left;
            color: white;
            font-weight: 600;
            font-size: 0.95rem;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 0.9rem;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .status-present {
            background: linear-gradient(135deg, #48bb78, #38a169);
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: 600;
            text-align: center;
            display: inline-block;
            min-width: 70px;
            font-size: 0.8rem;
        }

        .status-absent {
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: 600;
            text-align: center;
            display: inline-block;
            min-width: 70px;
            font-size: 0.8rem;
        }

        .no-records {
            text-align: center;
            color: #718096;
            font-style: italic;
            padding: 30px !important;
            font-size: 1rem;
        }

        /* Recent Activity Compact */
        .recent-activity {
            margin-top: 15px;
        }

        .recent-activity h3 {
            color: #4a5568;
            font-size: 1rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px;
            background: #f8fafc;
            border-radius: 8px;
            font-size: 0.85rem;
        }

        .activity-icon {
            width: 25px;
            height: 25px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 0.7rem;
        }

        .activity-icon.present {
            background: linear-gradient(135deg, #48bb78, #38a169);
        }

        .activity-icon.absent {
            background: linear-gradient(135deg, #f56565, #e53e3e);
        }

        .activity-details {
            flex: 1;
        }

        .activity-subject {
            font-weight: 600;
            color: #4a5568;
            margin: 0;
        }

        .activity-date {
            font-size: 0.75rem;
            color: #718096;
            margin: 0;
        }

        /* Icons */
        .icon {
            margin-right: 5px;
            font-size: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .summary-cards {
                grid-template-columns: repeat(4, 1fr);
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .header-content {
                flex-direction: column;
                align-items: flex-start;
            }

            .student-info {
                flex-direction: column;
                gap: 8px;
            }

            .summary-cards {
                grid-template-columns: repeat(2, 1fr);
                gap: 10px;
            }

            .summary-card {
                padding: 12px;
            }

            .summary-number {
                font-size: 1.5rem;
            }

            th, td {
                padding: 8px 10px;
                font-size: 0.8rem;
            }

            .table-container {
                max-height: 300px;
            }
        }

        @media (max-width: 480px) {
            .summary-cards {
                grid-template-columns: 1fr 1fr;
            }

            .header-left h1 {
                font-size: 1.5rem;
            }

            th, td {
                padding: 6px 8px;
                font-size: 0.75rem;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Scroll Animation */
        .fade-in {
            animation: fadeIn 0.6s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Compact Header -->
    <div class="header fade-in">
        <div class="header-content">
            <div class="header-left">
                <h1><i class="fas fa-graduation-cap icon"></i>Student Dashboard</h1>
                <% Student student = (Student) session.getAttribute("student"); %>
                <% if (student != null) { %>
                <div class="student-info">
                    <span><i class="fas fa-user icon"></i><strong><%= student.getName() %></strong></span>
                    <span><i class="fas fa-id-card icon"></i>ID: <%= student.getStudentId() %></span>
                    <span><i class="fas fa-book icon"></i>Course: <%= student.getCourse() %></span>
                </div>
                <% } else { %>
                <div class="student-info">
                    <span style="color: #e53e3e;"><i class="fas fa-exclamation-triangle icon"></i>Student information not available</span>
                </div>
                <% } %>
            </div>
            <div class="header-right">
                <form action="student-dashboard" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Main Dashboard Grid -->
    <div class="dashboard-grid fade-in">
        <!-- Left Column: Attendance Summary -->
        <div class="summary-section">
            <h2><i class="fas fa-chart-pie icon"></i>Attendance Overview</h2>
            <div class="summary-cards">
                <div class="summary-card">
                    <h3><i class="fas fa-calendar-alt icon"></i>Total Classes</h3>
                    <p class="summary-number">
                        <c:choose>
                            <c:when test="${not empty totalClasses}">${totalClasses}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="summary-card present">
                    <h3><i class="fas fa-check-circle icon"></i>Present</h3>
                    <p class="summary-number">
                        <c:choose>
                            <c:when test="${not empty presentCount}">${presentCount}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="summary-card absent">
                    <h3><i class="fas fa-times-circle icon"></i>Absent</h3>
                    <p class="summary-number">
                        <c:choose>
                            <c:when test="${not empty absentCount}">${absentCount}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="summary-card percentage">
                    <h3><i class="fas fa-percentage icon"></i>Attendance Rate</h3>
                    <p class="summary-number">
                        <c:choose>
                            <c:when test="${not empty attendancePercentage}">${attendancePercentage}%</c:when>
                            <c:otherwise>0%</c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
        </div>

        <!-- Right Column: Status & Quick Stats -->
        <div class="status-panel">
            <h2><i class="fas fa-exclamation-triangle icon"></i>Status Alert</h2>
            <c:set var="currentPercentage" value="${not empty attendancePercentage ? attendancePercentage : 0}" />
            <c:choose>
                <c:when test="${currentPercentage >= 75}">
                    <div class="status-alert success">
                        <i class="fas fa-check-circle"></i>
                        <p>Great! Your attendance is above the required threshold.</p>
                    </div>
                </c:when>
                <c:when test="${currentPercentage >= 65}">
                    <div class="status-alert warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        <p>Warning! Your attendance is below 75%. Please attend more classes.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="status-alert danger">
                        <i class="fas fa-times-circle"></i>
                        <p>Critical! Your attendance is critically low. Immediate action required.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="quick-stats">
                <div class="stat-row">
                    <span class="stat-label">Overall Attendance</span>
                    <span class="stat-value">
                            <c:set var="overallPercentage" value="${not empty attendancePercentage ? attendancePercentage : 0}" />
                            <c:choose>
                                <c:when test="${overallPercentage >= 80}">
                                    <span class="text-success">${overallPercentage}%</span>
                                </c:when>
                                <c:when test="${overallPercentage >= 60}">
                                    <span class="text-warning">${overallPercentage}%</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-danger">${overallPercentage}%</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">Classes Attended</span>
                    <span class="stat-value text-success">
                            ${not empty presentCount ? presentCount : 0} / ${not empty totalClasses ? totalClasses : 0}
                        </span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">Classes Missed</span>
                    <span class="stat-value">
                            <c:set var="missedCount" value="${not empty absentCount ? absentCount : 0}" />
                            <c:choose>
                                <c:when test="${missedCount == 0}">
                                    <span class="text-success">${missedCount}</span>
                                </c:when>
                                <c:when test="${missedCount <= 2}">
                                    <span class="text-warning">${missedCount}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-danger">${missedCount}</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">Required Minimum</span>
                    <span class="stat-value text-info">75%</span>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="recent-activity">
                <h3><i class="fas fa-clock icon"></i>Recent Activity</h3>
                <div class="activity-list">
                    <c:forEach var="attendance" items="${attendanceList}" begin="0" end="2">
                        <div class="activity-item">
                            <div class="activity-icon ${attendance.status.toLowerCase()}">
                                <c:choose>
                                    <c:when test="${attendance.status.toLowerCase() == 'present'}">
                                        <i class="fas fa-check"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-times"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="activity-details">
                                <p class="activity-subject">${attendance.subject}</p>
                                <p class="activity-date">${attendance.date}</p>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty attendanceList}">
                        <p style="text-align: center; color: #718096; font-style: italic; padding: 15px;">No recent activity</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Attendance Records Table -->
    <div class="attendance-records fade-in">
        <h2><i class="fas fa-list-alt icon"></i>Attendance History</h2>
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th><i class="fas fa-calendar icon"></i>Date</th>
                    <th><i class="fas fa-book-open icon"></i>Subject</th>
                    <th><i class="fas fa-info-circle icon"></i>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="attendance" items="${attendanceList}">
                    <tr>
                        <td>${attendance.date}</td>
                        <td>${attendance.subject}</td>
                        <td>
                                    <span class="status-${attendance.status.toLowerCase()}">
                                        <c:choose>
                                            <c:when test="${attendance.status.toLowerCase() == 'present'}">
                                                <i class="fas fa-check"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-times"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        ${attendance.status}
                                    </span>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty attendanceList}">
                    <tr>
                        <td colspan="3" class="no-records">
                            <i class="fas fa-inbox icon"></i>
                            No attendance records found
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    // Add smooth scrolling and animations
    document.addEventListener('DOMContentLoaded', function() {
        // Add fade-in animation to elements
        const elements = document.querySelectorAll('.fade-in');
        elements.forEach((element, index) => {
            element.style.animationDelay = ${index * 0.1}s;
        });

        // Add click animation to cards
        const cards = document.querySelectorAll('.summary-card, .status-panel');
        cards.forEach(card => {
            card.addEventListener('click', function() {
                this.style.transform = 'scale(0.98)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);
            });
        });

        // Debug: Log attendance values to console
        console.log('Attendance Data:', {
            totalClasses: '${totalClasses}',
            presentCount: '${presentCount}',
            absentCount: '${absentCount}',
            attendancePercentage: '${attendancePercentage}',
            attendanceListSize: '${attendanceList.size()}'
        });
    });

    // Logout confirmation
    document.querySelector('.logout-btn').addEventListener('click', function(e) {
        if (!confirm('Are you sure you want to logout?')) {
            e.preventDefault();
        }
    });

    // Add smooth scroll for table
    const tableContainer = document.querySelector('.table-container');
    if (tableContainer) {
        tableContainer.addEventListener('scroll', function() {
            const scrollTop = this.scrollTop;
            const thead = this.querySelector('thead');
            if (thead) {
                thead.style.transform = translateY(${scrollTop}px);
            }
        });
    }
</script>
</body>
</html>