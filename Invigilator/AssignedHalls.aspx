<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AssignedHalls.aspx.vb" Inherits="Invigilator_AssignedHalls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Assigned Halls - Invigilator</title>

    <style type="text/css">
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f6fa;
            color: #172033;
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 230px;
            background: #162033;
            color: #ffffff;
        }

        .brand {
            padding: 24px 20px;
            border-bottom: 1px solid #29354a;
        }

        .brand h2 {
            margin: 0;
            font-size: 20px;
        }

        .brand span {
            display: block;
            margin-top: 7px;
            font-size: 12px;
            color: #9eacc3;
        }

        .menu-title {
            padding: 24px 20px 10px;
            font-size: 11px;
            color: #8795ad;
            font-weight: bold;
            text-transform: uppercase;
        }

        .sidebar a {
            display: block;
            padding: 13px 22px;
            color: #ffffff;
            text-decoration: none;
            font-size: 14px;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background: #24324b;
            border-left: 3px solid #3f8cff;
            padding-left: 19px;
        }

        .content {
            margin-left: 230px;
            min-height: 100vh;
        }

        .topbar {
            background: #ffffff;
            padding: 18px 30px;
            border-bottom: 1px solid #dfe4ec;
        }

        .topbar h1 {
            margin: 0;
            font-size: 24px;
        }

        .topbar p {
            margin: 6px 0 0;
            color: #75839a;
            font-size: 13px;
        }

        .main {
            padding: 30px;
        }

        .intro {
            background: #ffffff;
            border: 1px solid #dce2eb;
            padding: 22px;
            margin-bottom: 24px;
        }

        .intro h2 {
            margin: 0;
            font-size: 20px;
        }

        .intro p {
            margin: 7px 0 0;
            color: #75839a;
            font-size: 13px;
        }

        .hall-card {
            background: #ffffff;
            border: 1px solid #dce2eb;
            margin-bottom: 22px;
        }

        .hall-header {
            padding: 20px;
            border-bottom: 1px solid #e3e7ee;
        }

        .hall-header h3 {
            margin: 0;
            font-size: 19px;
        }

        .hall-header p {
            margin: 6px 0 0;
            color: #75839a;
            font-size: 13px;
        }

        .hall-body {
            padding: 20px;
        }

        .info-row {
            margin-bottom: 18px;
        }

        .info-box {
            display: inline-block;
            vertical-align: top;
            width: 30%;
            margin-right: 2.5%;
            padding: 15px;
            background: #f7f9fc;
            border: 1px solid #e1e6ee;
            box-sizing: border-box;
        }

        .info-box.last {
            margin-right: 0;
        }

        .info-label {
            display: block;
            font-size: 10px;
            color: #7b879a;
            text-transform: uppercase;
            font-weight: bold;
            margin-bottom: 7px;
        }

        .info-value {
            font-size: 15px;
            font-weight: bold;
            color: #172033;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            background: #e5f6ec;
            color: #15803d;
            font-size: 11px;
            font-weight: bold;
        }

        .empty {
            background: #ffffff;
            border: 1px solid #dce2eb;
            padding: 35px;
            text-align: center;
            color: #75839a;
        }

        .back-button {
            display: inline-block;
            margin-top: 5px;
            padding: 11px 18px;
            background: #172033;
            color: #ffffff;
            text-decoration: none;
            font-size: 13px;
        }

        .footer {
            text-align: center;
            color: #8a96aa;
            font-size: 11px;
            padding: 20px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="sidebar">

            <div class="brand">
                <h2>Exam Allocation</h2>
                <span>Invigilator Portal</span>
            </div>

            <div class="menu-title">Main</div>

            <a href="InvigilatorDashboard.aspx">Dashboard</a>

            <div class="menu-title">Examination</div>

            <a href="ExamSchedule.aspx">Exam Schedule</a>
            <a href="AssignedHalls.aspx" class="active">Assigned Halls</a>
            <a href="StudentList.aspx">Student List</a>

            <div class="menu-title">Account</div>

            <a href="../Account/ChangePassword.aspx">Change Password</a>
            <a href="../Account/Logout.aspx">Logout</a>

        </div>

        <div class="content">

            <div class="topbar">
                <h1>Assigned Halls</h1>
                <p>View the examination halls assigned to you</p>
            </div>

            <div class="main">

                <div class="intro">
                    <h2>Your Assigned Examination Halls</h2>
                    <p>
                        The following halls have been assigned to you as an invigilator.
                    </p>
                </div>

                <asp:Panel ID="pnlNoHalls" runat="server" CssClass="empty" Visible="false">
                    No examination halls have been assigned to you.
                </asp:Panel>

                <asp:Repeater ID="rptHalls" runat="server">

                    <ItemTemplate>

                        <div class="hall-card">

                            <div class="hall-header">
                                <h3><%# Eval("HallName") %></h3>
                                <p>
                                    <%# Eval("Building") %> -
                                    <%# Eval("Floor") %>
                                </p>
                            </div>

                            <div class="hall-body">

                                <div class="info-row">

                                    <div class="info-box">
                                        <span class="info-label">Exam</span>
                                        <span class="info-value">
                                            <%# Eval("ExamName") %>
                                        </span>
                                    </div>

                                    <div class="info-box">
                                        <span class="info-label">Subject</span>
                                        <span class="info-value">
                                            <%# Eval("SubjectName") %>
                                        </span>
                                    </div>

                                    <div class="info-box last">
                                        <span class="info-label">Exam Date</span>
                                        <span class="info-value">
                                            <%# Eval("ExamDate") %>
                                        </span>
                                    </div>

                                </div>

                                <div class="info-row">

                                    <div class="info-box">
                                        <span class="info-label">Start Time</span>
                                        <span class="info-value">
                                            <%# Eval("StartTime") %>
                                        </span>
                                    </div>

                                    <div class="info-box">
                                        <span class="info-label">End Time</span>
                                        <span class="info-value">
                                            <%# Eval("EndTime") %>
                                        </span>
                                    </div>

                                    <div class="info-box last">
                                        <span class="info-label">Hall Capacity</span>
                                        <span class="info-value">
                                            <%# Eval("Capacity") %>
                                        </span>
                                    </div>

                                </div>

                                <div class="info-row">

                                    <div class="info-box">
                                        <span class="info-label">Students Assigned</span>
                                        <span class="info-value">
                                            <%# Eval("StudentCount") %>
                                        </span>
                                    </div>

                                    <div class="info-box">
                                        <span class="info-label">Building</span>
                                        <span class="info-value">
                                            <%# Eval("Building") %>
                                        </span>
                                    </div>

                                    <div class="info-box last">
                                        <span class="info-label">Assignment Status</span>
                                        <span class="status">
                                            <%# Eval("AssignmentStatus") %>
                                        </span>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <a href="InvigilatorDashboard.aspx" class="back-button">
                    ← Back to Dashboard
                </a>

            </div>

            <div class="footer">
                Online Exam Hall Allocation System | Invigilator Portal
            </div>

        </div>

    </form>
</body>
</html>

