<%@ Page Language="VB" AutoEventWireup="false" CodeFile="StudentDashboard.aspx.vb" Inherits="Student_StudentDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Student Dashboard - Online Exam Hall Allocation System</title>

    <style type="text/css">

        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #263238;
        }

        .page-wrapper {
            width: 100%;
            min-height: 1000px;
        }

        /* SIDEBAR */

        .sidebar {
            width: 230px;
            min-height: 1000px;
            background: #172033;
            float: left;
            color: #ffffff;
        }

        .brand {
            padding: 25px 20px;
            border-bottom: 1px solid #29344a;
        }

        .brand-title {
            font-size: 20px;
            font-weight: bold;
            color: #ffffff;
        }

        .brand-subtitle {
            font-size: 11px;
            color: #9ba7bd;
            margin-top: 5px;
        }

        .menu {
            padding-top: 15px;
        }

        .menu-title {
            padding: 10px 20px;
            color: #7f8ca5;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .menu a {
            display: block;
            padding: 13px 20px;
            color: #cbd3e1;
            text-decoration: none;
            font-size: 13px;
            border-left: 3px solid transparent;
        }

        .menu a:hover {
            background: #222d43;
            color: #ffffff;
            border-left: 3px solid #4f8cff;
        }

        .menu .active {
            background: #222d43;
            color: #ffffff;
            border-left: 3px solid #4f8cff;
        }

        /* MAIN */

        .main-content {
            margin-left: 230px;
            min-height: 1000px;
            background: #f4f7fb;
        }

        .topbar {
            height: 70px;
            background: #ffffff;
            border-bottom: 1px solid #e2e7ef;
            padding-left: 30px;
            padding-right: 30px;
        }

        .topbar-title {
            padding-top: 17px;
            font-size: 22px;
            font-weight: bold;
            color: #172033;
        }

        .topbar-subtitle {
            font-size: 12px;
            color: #7b8799;
            margin-top: 4px;
        }

        .content {
            padding: 30px;
        }

        /* WELCOME */

        .welcome-panel {
            background: #ffffff;
            border: 1px solid #e1e6ef;
            padding: 22px;
            margin-bottom: 25px;
        }

        .welcome-title {
            font-size: 20px;
            font-weight: bold;
            color: #172033;
        }

        .welcome-text {
            margin-top: 8px;
            color: #7b8799;
            font-size: 13px;
        }

        /* STATS */

        .stats-row {
            width: 100%;
            overflow: hidden;
            margin-bottom: 25px;
        }

        .stat-card {
            width: 28%;
            min-height: 90px;
            background: #ffffff;
            border: 1px solid #e1e6ef;
            float: left;
            margin-right: 2.5%;
            padding: 18px;
        }

        .stat-card.last {
            margin-right: 0;
        }

        .stat-label {
            color: #7b8799;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .stat-value {
            display: block;
            font-size: 28px;
            font-weight: bold;
            color: #172033;
            margin-top: 12px;
        }

        .stat-description {
            font-size: 11px;
            color: #9aa4b3;
            margin-top: 5px;
        }

        /* PANELS */

        .panel {
            background: #ffffff;
            border: 1px solid #e1e6ef;
            margin-bottom: 25px;
        }

        .panel-header {
            padding: 18px 20px;
            border-bottom: 1px solid #e8ecf2;
        }

        .panel-title {
            font-size: 17px;
            font-weight: bold;
            color: #172033;
        }

        .panel-description {
            padding-top: 5px;
            font-size: 12px;
            color: #8792a4;
        }

        .panel-body {
            padding: 20px;
        }

        /* STUDENT INFORMATION */

        .info-row {
            width: 100%;
            overflow: hidden;
        }

        .info-item {
            width: 43%;
            float: left;
            padding: 12px 15px;
            margin-right: 3%;
            margin-bottom: 10px;
            border: 1px solid #e7ebf1;
            background: #fafbfd;
        }

        .info-label {
            display: block;
            color: #8994a6;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 6px;
        }

        .info-value {
            color: #26364d;
            font-size: 14px;
            font-weight: bold;
        }

        /* ALLOCATION */

        .allocation-box {
            border: 1px solid #dce4ee;
            background: #f8fafc;
            padding: 20px;
        }

        .allocation-title {
            font-size: 15px;
            font-weight: bold;
            color: #172033;
            margin-bottom: 15px;
        }

        .allocation-row {
            width: 100%;
            overflow: hidden;
        }

        .allocation-item {
            width: 27%;
            float: left;
            margin-right: 4%;
            margin-bottom: 12px;
        }

        .allocation-label {
            display: block;
            color: #8994a6;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .allocation-value {
            color: #26364d;
            font-size: 13px;
            font-weight: bold;
        }

        .seat-value {
            color: #16894f;
            font-size: 20px;
            font-weight: bold;
        }

        .no-allocation {
            color: #8994a6;
            font-size: 13px;
        }

        /* QUICK LINKS */

        .quick-links {
            width: 100%;
            overflow: hidden;
        }

        .quick-link {
            width: 26%;
            min-height: 70px;
            float: left;
            margin-right: 3%;
            padding: 18px;
            background: #f8fafc;
            border: 1px solid #e1e6ef;
            text-decoration: none;
        }

        .quick-link:hover {
            background: #eef4ff;
            border-color: #b9cdf4;
        }

        .quick-link-title {
            display: block;
            color: #172033;
            font-size: 14px;
            font-weight: bold;
        }

        .quick-link-text {
            display: block;
            color: #8994a6;
            font-size: 11px;
            margin-top: 6px;
        }

        .footer-note {
            text-align: center;
            color: #9aa4b3;
            font-size: 11px;
            padding: 20px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="page-wrapper">

    <!-- SIDEBAR -->

    <div class="sidebar">

        <div class="brand">

            <div class="brand-title">
                Exam Allocation
            </div>

            <div class="brand-subtitle">
                Student Portal
            </div>

        </div>


        <div class="menu">

            <div class="menu-title">
                Main
            </div>

            <a href="StudentDashboard.aspx" class="active">
                Dashboard
            </a>


            <div class="menu-title">
                Examination
            </div>

            <a href="ExamSchedule.aspx">
                Exam Schedule
            </a>

            <a href="HallAllocation.aspx">
                Hall Allocation
            </a>

            <a href="ExamHistory.aspx">
                Exam History
            </a>


            <div class="menu-title">
                Account
            </div>

            <a href="../Account/ChangePassword.aspx">
                Change Password
            </a>

            <a href="../Account/Logout.aspx">
                Logout
            </a>

        </div>

    </div>


    <!-- MAIN CONTENT -->

    <div class="main-content">


        <div class="topbar">

            <div class="topbar-title">
                Student Dashboard
            </div>

            <div class="topbar-subtitle">
                Examination schedule and hall allocation information
            </div>

        </div>


        <div class="content">


            <!-- WELCOME -->

            <div class="welcome-panel">

                <div class="welcome-title">

                    Welcome,
                    <asp:Label
                        ID="lblStudentName"
                        runat="server"
                        Text="Student">
                    </asp:Label>

                </div>

                <div class="welcome-text">
                    View your examination schedule, hall allocation and examination history from this dashboard.
                </div>

            </div>


            <!-- STATISTICS -->

            <div class="stats-row">

                <div class="stat-card">

                    <div class="stat-label">
                        Upcoming Exams
                    </div>

                    <asp:Label
                        ID="lblUpcomingExams"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                    <div class="stat-description">
                        Scheduled examinations
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-label">
                        Allocations
                    </div>

                    <asp:Label
                        ID="lblAllocationCount"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                    <div class="stat-description">
                        Your hall allocations
                    </div>

                </div>


                <div class="stat-card last">

                    <div class="stat-label">
                        Department
                    </div>

                    <asp:Label
                        ID="lblDepartment"
                        runat="server"
                        CssClass="stat-value"
                        Text="-">
                    </asp:Label>

                    <div class="stat-description">
                        Academic department
                    </div>

                </div>

            </div>


            <!-- STUDENT INFORMATION -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Student Information
                    </div>

                    <div class="panel-description">
                        Your registered academic information
                    </div>

                </div>


                <div class="panel-body">

                    <div class="info-row">


                        <div class="info-item">

                            <span class="info-label">
                                Name
                            </span>

                            <asp:Label
                                ID="lblName"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Register Number
                            </span>

                            <asp:Label
                                ID="lblRegisterNumber"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Department
                            </span>

                            <asp:Label
                                ID="lblStudentDepartment"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Year
                            </span>

                            <asp:Label
                                ID="lblYear"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Section
                            </span>

                            <asp:Label
                                ID="lblSection"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Status
                            </span>

                            <asp:Label
                                ID="lblStatus"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                    </div>

                </div>

            </div>


            <!-- LATEST ALLOCATION -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Latest Hall Allocation
                    </div>

                    <div class="panel-description">
                        Your most recent examination hall and seat information
                    </div>

                </div>


                <div class="panel-body">

                    <asp:Panel
                        ID="pnlAllocation"
                        runat="server"
                        CssClass="allocation-box"
                        Visible="False">


                        <div class="allocation-title">

                            <asp:Label
                                ID="lblAllocationExam"
                                runat="server">
                            </asp:Label>

                        </div>


                        <div class="allocation-row">


                            <div class="allocation-item">

                                <span class="allocation-label">
                                    Subject
                                </span>

                                <asp:Label
                                    ID="lblAllocationSubject"
                                    runat="server"
                                    CssClass="allocation-value">
                                </asp:Label>

                            </div>


                            <div class="allocation-item">

                                <span class="allocation-label">
                                    Exam Date
                                </span>

                                <asp:Label
                                    ID="lblAllocationDate"
                                    runat="server"
                                    CssClass="allocation-value">
                                </asp:Label>

                            </div>


                            <div class="allocation-item">

                                <span class="allocation-label">
                                    Time
                                </span>

                                <asp:Label
                                    ID="lblAllocationTime"
                                    runat="server"
                                    CssClass="allocation-value">
                                </asp:Label>

                            </div>


                            <div class="allocation-item">

                                <span class="allocation-label">
                                    Hall
                                </span>

                                <asp:Label
                                    ID="lblHallName"
                                    runat="server"
                                    CssClass="allocation-value">
                                </asp:Label>

                            </div>


                            <div class="allocation-item">

                                <span class="allocation-label">
                                    Building
                                </span>

                                <asp:Label
                                    ID="lblBuilding"
                                    runat="server"
                                    CssClass="allocation-value">
                                </asp:Label>

                            </div>


                            <div class="allocation-item">

                                <span class="allocation-label">
                                    Floor
                                </span>

                                <asp:Label
                                    ID="lblFloor"
                                    runat="server"
                                    CssClass="allocation-value">
                                </asp:Label>

                            </div>


                            <div class="allocation-item">

                                <span class="allocation-label">
                                    Seat Number
                                </span>

                                <asp:Label
                                    ID="lblSeatNumber"
                                    runat="server"
                                    CssClass="seat-value">
                                </asp:Label>

                            </div>


                        </div>

                    </asp:Panel>


                    <asp:Label
                        ID="lblNoAllocation"
                        runat="server"
                        CssClass="no-allocation"
                        Text="No hall allocation is currently available for you.">
                    </asp:Label>

                </div>

            </div>


            <!-- QUICK LINKS -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Quick Access
                    </div>

                    <div class="panel-description">
                        Quickly access your examination information
                    </div>

                </div>


                <div class="panel-body">

                    <div class="quick-links">


                        <a href="ExamSchedule.aspx"
                           class="quick-link">

                            <span class="quick-link-title">
                                Exam Schedule
                            </span>

                            <span class="quick-link-text">
                                View upcoming examination dates and times
                            </span>

                        </a>


                        <a href="HallAllocation.aspx"
                           class="quick-link">

                            <span class="quick-link-title">
                                Hall Allocation
                            </span>

                            <span class="quick-link-text">
                                View your examination hall and seat number
                            </span>

                        </a>


                        <a href="ExamHistory.aspx"
                           class="quick-link">

                            <span class="quick-link-title">
                                Exam History
                            </span>

                            <span class="quick-link-text">
                                View your previous examination records
                            </span>

                        </a>


                    </div>

                </div>

            </div>


            <div class="footer-note">
                Online Exam Hall Allocation System &nbsp;|&nbsp; Student Portal
            </div>


        </div>

    </div>

</div>

</form>

</body>

</html>
