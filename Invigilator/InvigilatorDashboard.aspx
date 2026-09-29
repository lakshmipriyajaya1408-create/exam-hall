<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InvigilatorDashboard.aspx.vb" Inherits="Invigilator_InvigilatorDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <title>Invigilator Dashboard - Online Exam Hall Allocation System</title>

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

        .welcome {
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

        /* STATISTICS */

        .stats {
            width: 100%;
            overflow: hidden;
            margin-bottom: 25px;
        }

        .stat-box {
            width: 29%;
            min-height: 100px;
            background: #ffffff;
            border: 1px solid #e1e6ef;
            float: left;
            margin-right: 2%;
            padding: 20px;
        }

        .stat-label {
            color: #7b8799;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .stat-number {
            margin-top: 12px;
            font-size: 28px;
            font-weight: bold;
            color: #172033;
        }

        .stat-description {
            margin-top: 5px;
            font-size: 11px;
            color: #8994a6;
        }

        /* PANEL */

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

        /* INFORMATION */

        .info-row {
            width: 100%;
            overflow: hidden;
        }

        .info-box {
            width: 42%;
            float: left;
            margin-right: 4%;
            margin-bottom: 15px;
            padding: 15px;
            background: #f8fafc;
            border: 1px solid #e1e6ef;
        }

        .info-label {
            display: block;
            color: #8994a6;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 7px;
        }

        .info-value {
            color: #26364d;
            font-size: 14px;
            font-weight: bold;
        }

        /* DUTY TABLE */

        .duty-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        .duty-table th {
            background: #172033;
            color: #ffffff;
            padding: 13px 12px;
            text-align: left;
            font-size: 12px;
        }

        .duty-table td {
            padding: 13px 12px;
            border-bottom: 1px solid #e5e9ef;
            color: #344054;
        }

        .duty-table tr:hover td {
            background: #f8fafc;
        }

        .empty-message {
            padding: 30px;
            text-align: center;
            color: #8994a6;
            font-size: 13px;
        }

        /* FOOTER */

        .footer {
            text-align: center;
            padding: 20px;
            color: #9ba7bd;
            font-size: 11px;
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
                Invigilator Portal
            </div>

        </div>


        <div class="menu">

            <div class="menu-title">
                Main
            </div>

            <a href="InvigilatorDashboard.aspx" class="active">
                Dashboard
            </a>


            <div class="menu-title">
                Examination
            </div>

            <a href="ExamSchedule.aspx">
                Exam Schedule
            </a>

            <a href="AssignedHalls.aspx">
                Assigned Halls
            </a>

            <a href="StudentList.aspx">
                Student List
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
                Invigilator Dashboard
            </div>

            <div class="topbar-subtitle">
                View your examination duties and assigned halls
            </div>

        </div>


        <div class="content">

            <!-- WELCOME -->

            <div class="welcome">

                <div class="welcome-title">

                    Welcome,
                    <asp:Label ID="lblInvigilatorName" runat="server">
                    </asp:Label>

                </div>

                <div class="welcome-text">
                    View your assigned examinations, halls and student information from this dashboard.
                </div>

            </div>


            <!-- STATISTICS -->

            <div class="stats">

                <div class="stat-box">

                    <div class="stat-label">
                        Assigned Exams
                    </div>

                    <div class="stat-number">
                        <asp:Label ID="lblAssignedExams" runat="server">
                        0
                        </asp:Label>
                    </div>

                    <div class="stat-description">
                        Examination duties
                    </div>

                </div>


                <div class="stat-box">

                    <div class="stat-label">
                        Assigned Halls
                    </div>

                    <div class="stat-number">
                        <asp:Label ID="lblAssignedHalls" runat="server">
                        0
                        </asp:Label>
                    </div>

                    <div class="stat-description">
                        Examination halls
                    </div>

                </div>


                <div class="stat-box">

                    <div class="stat-label">
                        Students
                    </div>

                    <div class="stat-number">
                        <asp:Label ID="lblStudentCount" runat="server">
                        0
                        </asp:Label>
                    </div>

                    <div class="stat-description">
                        Students in assigned halls
                    </div>

                </div>

            </div>


            <!-- INVIGILATOR INFORMATION -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Invigilator Information
                    </div>

                    <div class="panel-description">
                        Your registered account information
                    </div>

                </div>


                <div class="panel-body">

                    <div class="info-row">

                        <div class="info-box">

                            <span class="info-label">
                                Name
                            </span>

                            <asp:Label
                                ID="lblName"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                        <div class="info-box">

                            <span class="info-label">
                                Email
                            </span>

                            <asp:Label
                                ID="lblEmail"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                        <div class="info-box">

                            <span class="info-label">
                                Department
                            </span>

                            <asp:Label
                                ID="lblDepartment"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>


                        <div class="info-box">

                            <span class="info-label">
                                Availability
                            </span>

                            <asp:Label
                                ID="lblAvailability"
                                runat="server"
                                CssClass="info-value">
                            </asp:Label>

                        </div>

                    </div>

                </div>

            </div>


            <!-- UPCOMING DUTIES -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Upcoming Examination Duties
                    </div>

                    <div class="panel-description">
                        Your assigned examination halls and student counts
                    </div>

                </div>


                <div class="panel-body">

                    <asp:GridView
                        ID="gvDuties"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="duty-table"
                        GridLines="None"
                        EmptyDataText="No examination duties have been assigned to you.">

                        <Columns>

                            <asp:BoundField
                                DataField="ExamName"
                                HeaderText="Exam Name" />

                            <asp:BoundField
                                DataField="Subject"
                                HeaderText="Subject" />

                            <asp:BoundField
                                DataField="ExamDate"
                                HeaderText="Exam Date"
                                DataFormatString="{0:dd-MM-yyyy}" />

                            <asp:BoundField
                                DataField="StartTime"
                                HeaderText="Start Time" />

                            <asp:BoundField
                                DataField="EndTime"
                                HeaderText="End Time" />

                            <asp:BoundField
                                DataField="HallName"
                                HeaderText="Hall" />

                            <asp:BoundField
                                DataField="StudentCount"
                                HeaderText="Students" />

                            <asp:BoundField
                                DataField="AssignmentStatus"
                                HeaderText="Status" />

                        </Columns>

                    </asp:GridView>

                </div>

            </div>

        </div>


        <div class="footer">
            Online Exam Hall Allocation System | Invigilator Portal
        </div>

    </div>

</div>

</form>

</body>
</html>
