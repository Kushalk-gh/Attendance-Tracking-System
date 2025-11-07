<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Attendance System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
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
            color: #ff6b6b;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
            position: relative;
            z-index: 1;
            display: none;
        }

        .institute-header h1 {
            font-size: 26px;
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
            color: #ff6b6b;
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
            color: #ff6b6b;
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
            border-color: #ff6b6b;
            background: white;
            box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
        }

        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
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
            box-shadow: 0 10px 20px rgba(255, 107, 107, 0.3);
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

        .back-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e1e5e9;
        }

        .back-link a {
            color: #ff6b6b;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s ease;
        }

        .back-link a:hover {
            color: #ee5a24;
            transform: translateX(-5px);
        }

        .back-link a i {
            margin-right: 8px;
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
                height: 45px;
            }

            .institute-logo-icon {
                font-size: 45px;
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
        <!-- Try to load PNG from same folder -->
        <img src="logo.png" alt="Atria Logo" class="institute-logo" onerror="showFallback()">
        <!-- Fallback icon -->
        <i class="fas fa-university institute-logo-icon"></i>
        <h1>Atria Institute of Technology</h1>
    </div>
</div>

<div class="container">
    <div class="logo">
        <i class="fas fa-user-shield"></i>
        <h1>Admin Portal</h1>
        <p>Attendance Management System</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-triangle"></i>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/admin-login">
        <div class="form-group">
            <i class="fas fa-user-tie"></i>
            <input type="text"
                   name="username"
                   placeholder="Enter Username"
                   value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                   required>
        </div>

        <div class="form-group">
            <i class="fas fa-key"></i>
            <input type="password"
                   name="password"
                   placeholder="Enter Password"
                   required>
        </div>

        <button type="submit" class="btn">
            <i class="fas fa-sign-in-alt" style="margin-right: 8px;"></i>
            Admin Login
        </button>
    </form>

    <div class="back-link">
        <a href="<%= request.getContextPath() %>/index.jsp">
            <i class="fas fa-arrow-left"></i>
            Back to Student Login
        </a>
    </div>
</div>
</body>
</html>
