<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ExamHistory.aspx.vb" Inherits="Student_ExamHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Exam History - Online Exam Hall Allocation System</title>

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

        /* HISTORY TABLE */

        .history-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        .history-table th {
            background: #172033;
            color: #ffffff;
            padding: 13px 12px;
            text-align: left;
            font-size: 12px;
        }

        .history-table td {
            padding: 13px 12px;
            border-bottom: 1px solid #e5e9ef;
            color: #344054;
        }

        .history-table tr:hover td {
            background: #f8fafc;
        }

        .empty-message {
            padding: 30px;
            text-align: center;
            color: #8994a6;
            font-size: 13px;
        }

        .back-link {
            display: inline-block;
            margin-top: 5px;
            padding: 10px 16px;
            background: #172033;
            color: #ffffff;
            text-decoration: none;
            font-size: 12px;
        }

        .back-link:hover {
            background: #222d43;
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

            <a href="StudentDashboard.aspx">
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

            <a href="ExamHistory.aspx" class="active">
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
                Exam History
            </div>

            <div class="topbar-subtitle">
                View your previous examination records
            </div>

        </div>


        <div class="content">

            <div class="welcome">

                <div class="welcome-title">
                    Examination History
                </div>

                <div class="welcome-text">
                    View your examination records and hall allocation history.
                </div>

            </div>


            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Your Examination Records
                    </div>

                    <div class="panel-description">
                        Previous and completed examination records
                    </div>

                </div>


                <div class="panel-body">

                    <asp:GridView
                        ID="gvExamHistory"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="history-table"
                        GridLines="None"
                        EmptyDataText="No examination history is currently available.">

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
                                DataField="SeatNumber"
                                HeaderText="Seat Number" />

                            <asp:BoundField
                                DataField="AllocationStatus"
                                HeaderText="Status" />

                        </Columns>

                    </asp:GridView>

                </div>

            </div>


            <a href="StudentDashboard.aspx" class="back-link">
                ← Back to Dashboard
            </a>

        </div>

    </div>

</div>

</form>

</body>
</html>