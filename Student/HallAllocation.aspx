<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HallAllocation.aspx.vb" Inherits="Student_HallAllocation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Hall Allocation - Online Exam Hall Allocation System</title>

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

        /* ALLOCATION PANEL */

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

        /* ALLOCATION CARD */

        .allocation-card {
            border: 1px solid #dce4ee;
            background: #f8fafc;
            padding: 25px;
        }

        .exam-title {
            font-size: 20px;
            font-weight: bold;
            color: #172033;
            margin-bottom: 22px;
            padding-bottom: 15px;
            border-bottom: 1px solid #dce4ee;
        }

        .details-row {
            width: 100%;
            overflow: hidden;
        }

        .detail-box {
            width: 42%;
            float: left;
            margin-right: 4%;
            margin-bottom: 15px;
            padding: 15px;
            background: #ffffff;
            border: 1px solid #e1e6ef;
        }

        .detail-label {
            display: block;
            color: #8994a6;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 7px;
        }

        .detail-value {
            color: #26364d;
            font-size: 14px;
            font-weight: bold;
        }

        .seat-box {
            margin-top: 10px;
            padding: 20px;
            background: #ffffff;
            border: 1px solid #dce4ee;
            text-align: center;
        }

        .seat-label {
            display: block;
            color: #8994a6;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .seat-number {
            display: block;
            font-size: 32px;
            font-weight: bold;
            color: #16894f;
        }

        .no-allocation {
            padding: 30px;
            text-align: center;
            border: 1px solid #e1e6ef;
            background: #fafbfd;
            color: #8994a6;
            font-size: 14px;
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

            <a href="HallAllocation.aspx" class="active">
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
                Hall Allocation
            </div>

            <div class="topbar-subtitle">
                View your examination hall and seat information
            </div>

        </div>


        <div class="content">

            <div class="welcome">

                <div class="welcome-title">
                    Your Hall Allocation
                </div>

                <div class="welcome-text">
                    View the examination hall, location and seat assigned to you.
                </div>

            </div>


            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Examination Hall Details
                    </div>

                    <div class="panel-description">
                        Your current active hall allocation
                    </div>

                </div>

                <div class="panel-body">

                    <asp:Panel
                        ID="pnlAllocation"
                        runat="server"
                        Visible="False"
                        CssClass="allocation-card">

                        <div class="exam-title">

                            <asp:Label
                                ID="lblExamName"
                                runat="server">
                            </asp:Label>

                        </div>


                        <div class="details-row">

                            <div class="detail-box">

                                <span class="detail-label">
                                    Subject
                                </span>

                                <asp:Label
                                    ID="lblSubject"
                                    runat="server"
                                    CssClass="detail-value">
                                </asp:Label>

                            </div>


                            <div class="detail-box">

                                <span class="detail-label">
                                    Exam Date
                                </span>

                                <asp:Label
                                    ID="lblExamDate"
                                    runat="server"
                                    CssClass="detail-value">
                                </asp:Label>

                            </div>


                            <div class="detail-box">

                                <span class="detail-label">
                                    Time
                                </span>

                                <asp:Label
                                    ID="lblExamTime"
                                    runat="server"
                                    CssClass="detail-value">
                                </asp:Label>

                            </div>


                            <div class="detail-box">

                                <span class="detail-label">
                                    Hall
                                </span>

                                <asp:Label
                                    ID="lblHallName"
                                    runat="server"
                                    CssClass="detail-value">
                                </asp:Label>

                            </div>


                            <div class="detail-box">

                                <span class="detail-label">
                                    Building
                                </span>

                                <asp:Label
                                    ID="lblBuilding"
                                    runat="server"
                                    CssClass="detail-value">
                                </asp:Label>

                            </div>


                            <div class="detail-box">

                                <span class="detail-label">
                                    Floor
                                </span>

                                <asp:Label
                                    ID="lblFloor"
                                    runat="server"
                                    CssClass="detail-value">
                                </asp:Label>

                            </div>

                        </div>


                        <div class="seat-box">

                            <span class="seat-label">
                                Your Seat Number
                            </span>

                            <asp:Label
                                ID="lblSeatNumber"
                                runat="server"
                                CssClass="seat-number">
                            </asp:Label>

                        </div>

                    </asp:Panel>


                    <asp:Panel
                        ID="pnlNoAllocation"
                        runat="server"
                        CssClass="no-allocation">

                        No hall allocation is currently available for you.

                    </asp:Panel>

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