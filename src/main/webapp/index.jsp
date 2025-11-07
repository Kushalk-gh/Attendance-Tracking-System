<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login - Attendance System</title>
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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }

        .institute-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        .institute-header .header-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 15px;
            color: #2c3e50;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            padding: 25px 40px;
            border-radius: 15px;
            box-shadow:
                    0 10px 30px rgba(0, 0, 0, 0.3),
                    inset 0 1px 0 rgba(255, 255, 255, 0.8);
            border: 3px solid rgba(255, 255, 255, 0.9);
            position: relative;
            overflow: hidden;
        }

        .institute-header .header-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: shimmer 3s infinite;
        }

        .institute-logo {
            height: 80px;
            width: auto;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
            position: relative;
            z-index: 1;
            display: block;
        }

        .institute-logo-icon {
            font-size: 80px;
            color: #667eea;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
            position: relative;
            z-index: 1;
            display: none;
        }

        .institute-header h1 {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            position: relative;
            z-index: 1;
            margin: 0;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            backdrop-filter: blur(10px);
        }

        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo i {
            font-size: 60px;
            color: #667eea;
            margin-bottom: 10px;
        }

        .logo h1 {
            color: #333;
            font-size: 28px;
            font-weight: 600;
        }

        .logo p {
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 18px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 15px 15px 15px 50px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .alert i {
            margin-right: 10px;
            font-size: 16px;
        }

        .alert-danger {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }

        .admin-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e1e5e9;
        }

        .admin-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s ease;
        }

        .admin-link a:hover {
            color: #764ba2;
            transform: translateX(5px);
        }

        .admin-link a i {
            margin-left: 8px;
            font-size: 14px;
        }

        @media (max-width: 480px) {
            .institute-header {
                margin-bottom: 30px;
            }

            .institute-header .header-content {
                padding: 20px 25px;
                gap: 12px;
            }

            .institute-logo {
                height: 60px;
            }

            .institute-logo-icon {
                font-size: 60px;
            }

            .institute-header h1 {
                font-size: 20px;
                letter-spacing: 1px;
            }

            .container {
                margin: 20px;
                padding: 30px 25px;
            }
        }
    </style>
    <script>
        function showFallback() {
            document.querySelector('.institute-logo').style.display = 'none';
            document.querySelector('.institute-logo-icon').style.display = 'block';
        }
    </script>
</head>
<body>
<div class="institute-header">
    <div class="header-content">
        <!-- Try to load PNG from images folder -->
        <img src="images/logo.png" alt="Atria Logo" class="institute-logo" onerror="showFallback()">
        <!-- Fallback icon -->
        <i class="fas fa-university institute-logo-icon"></i>
        <h1>Atria Institute of Technology</h1>
    </div>
</div>

<div class="container">
    <div class="logo">
        <i class="fas fa-graduation-cap"></i>
        <h1>Student Portal</h1>
        <p>Attendance Management System</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-triangle"></i>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form method="post" action="login">
        <div class="form-group">
            <i class="fas fa-user"></i>
            <input type="text"
                   name="studentId"
                   placeholder="Enter Student ID"
                   value="<%= request.getAttribute("studentId") != null ? request.getAttribute("studentId") : "" %>"
                   required>
        </div>

        <div class="form-group">
            <i class="fas fa-lock"></i>
            <input type="password"
                   name="password"
                   placeholder="Enter Password"
                   required>
        </div>

        <button type="submit" class="btn">
            <i class="fas fa-sign-in-alt" style="margin-right: 8px;"></i>
            Login
        </button>
    </form>

    <div class="admin-link">
        <a href="<%= request.getContextPath() %>/admin/login.jsp">
            <i class="fas fa-user-shield"></i>
            Admin Login
            <i class="fas fa-arrow-right"></i>
        </a>
    </div>
</div>
</body>
</html>
