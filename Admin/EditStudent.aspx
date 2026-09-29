<%@ Page Language="VB"
    AutoEventWireup="false"
    CodeFile="EditStudent.aspx.vb"
    Inherits="Admin_EditStudent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Edit Student - Online Exam Hall Allocation System</title>

    <style type="text/css">

        * {
            box-sizing: border-box;
        }

        html, body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #172033;
        }

        body {
            min-height: 100%;
        }

        .dashboard {
            width: 100%;
            min-height: 100vh;
        }

        /* ================= SIDEBAR ================= */

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 250px;
            background: #19365f;
            color: #ffffff;
            overflow-y: auto;
        }

        .sidebar-brand {
            height: 88px;
            padding: 18px 20px;
            border-bottom: 1px solid #2b4a74;
            display: table;
            width: 100%;
        }

        .sidebar-logo {
            display: table-cell;
            vertical-align: middle;
            width: 48px;
            height: 48px;
            background: #2875c7;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            border-radius: 4px;
        }

        .brand-title {
            font-size: 16px;
            font-weight: bold;
            margin-left: 12px;
            margin-top: 2px;
        }

        .brand-subtitle {
            font-size: 11px;
            color: #c8d6ea;
            margin-left: 12px;
            margin-top: 5px;
        }

        .sidebar-nav {
            padding: 18px 0;
        }

        .nav-item {
            display: block;
            height: 46px;
            line-height: 46px;
            padding: 0 24px;
            color: #e5edf8;
            text-decoration: none;
            font-size: 14px;
        }

        .nav-item:hover {
            background: #24476f;
            color: #ffffff;
        }

        .nav-item.active {
            background: #2c75c5;
            color: #ffffff;
            font-weight: bold;
        }

        .nav-icon {
            display: inline-block;
            width: 30px;
            font-size: 15px;
        }

        /* ================= MAIN ================= */

        .dashboard-main {
            margin-left: 250px;
            min-height: 100vh;
        }

        .topbar {
            height: 78px;
            background: #ffffff;
            border-bottom: 1px solid #e1e6ed;
            padding: 0 32px;
            position: relative;
        }

        .topbar-title {
            line-height: 78px;
            font-size: 19px;
            font-weight: bold;
            color: #172f54;
        }

        .topbar-right {
            position: absolute;
            right: 32px;
            top: 17px;
        }

        .user-profile {
            display: table;
        }

        .user-avatar {
            display: table-cell;
            vertical-align: middle;
            width: 42px;
            height: 42px;
            background: #eaf2fc;
            color: #1f5fa9;
            border-radius: 50%;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
        }

        .user-name {
            display: table-cell;
            vertical-align: middle;
            padding-left: 12px;
            font-size: 13px;
            font-weight: bold;
            color: #19365f;
        }

        /* ================= CONTENT ================= */

        .dashboard-content {
            padding: 30px 32px 50px 32px;
        }

        .welcome-section {
            margin-bottom: 24px;
        }

        .welcome-title {
            margin: 0;
            font-size: 28px;
            font-weight: bold;
            color: #16365f;
        }

        .welcome-subtitle {
            margin-top: 7px;
            color: #7a8aa3;
            font-size: 14px;
        }

        /* ================= PANEL ================= */

        .dashboard-panel {
            background: #ffffff;
            border: 1px solid #e0e6ee;
            border-radius: 7px;
            margin-bottom: 25px;
        }

        .panel-header {
            padding: 22px 24px;
            border-bottom: 1px solid #e5eaf0;
        }

        .panel-title {
            font-size: 18px;
            font-weight: bold;
            color: #172f54;
        }

        .panel-subtitle {
            margin-top: 6px;
            font-size: 13px;
            color: #7d8da5;
        }

        .panel-body {
            padding: 28px 24px 30px 24px;
        }

        /* ================= FORM ================= */

        .form-card {
            border: 1px solid #e0e6ee;
            background: #fbfcfe;
            border-radius: 7px;
            padding: 28px;
        }

        .form-grid {
            width: 100%;
            overflow: hidden;
        }

        .form-group {
            width: 48%;
            float: left;
            margin-right: 4%;
            margin-bottom: 22px;
        }

        .form-group:nth-child(even) {
            margin-right: 0;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: bold;
            color: #34445b;
        }

        .form-input {
            display: block;
            width: 100%;
            min-height: 42px;
            padding: 10px 12px;
            border: 1px solid #ccd5e2;
            background: #ffffff;
            color: #26364d;
            font-size: 14px;
            font-family: Arial, Helvetica, sans-serif;
            border-radius: 4px;
        }

        .form-input:focus {
            border-color: #2c75c5;
            outline: none;
        }

        textarea.form-input {
            min-height: 100px;
            resize: vertical;
        }

        /* ================= MESSAGE ================= */

        .alert {
            display: block;
            margin-bottom: 20px;
            padding: 12px 14px;
            border-radius: 4px;
            font-size: 13px;
        }

        .alert:empty {
            display: none;
        }

        .alert-error {
            background: #fff0f0;
            border: 1px solid #efb8b8;
            color: #b32626;
        }

        /* ================= BUTTONS ================= */

        .form-actions {
            clear: both;
            margin-top: 10px;
            padding-top: 22px;
            border-top: 1px solid #e2e7ee;
        }

        .btn {
            display: inline-block;
            min-width: 135px;
            padding: 11px 18px;
            border: 0;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-primary {
            background: #286bb3;
            color: #ffffff;
        }

        .btn-primary:hover {
            background: #1f5998;
        }

        .btn-secondary {
            margin-left: 8px;
            background: #e8edf4;
            color: #25364d;
        }

        .btn-secondary:hover {
            background: #dce3ed;
        }

        /* ================= FOOTER ================= */

        .footer {
            text-align: center;
            color: #8997aa;
            font-size: 12px;
            padding: 10px 0 30px 0;
        }

        /* ================= RESPONSIVE ================= */

        @media screen and (max-width: 900px) {

            .sidebar {
                width: 210px;
            }

            .dashboard-main {
                margin-left: 210px;
            }

            .form-group {
                width: 100%;
                margin-right: 0;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="dashboard">

    <!-- ================= SIDEBAR ================= -->

    <aside class="sidebar">

        <div class="sidebar-brand">

            <div class="sidebar-logo">
                OE
            </div>

            <div>
                <div class="brand-title">
                    Online Exam
                </div>

                <div class="brand-subtitle">
                    Hall Allocation
                </div>
            </div>

        </div>


        <nav class="sidebar-nav">

            <a href="AdminDashboard.aspx"
               class="nav-item">

                <span class="nav-icon">&#127968;</span>
                Dashboard

            </a>


            <a href="ManageStudents.aspx"
               class="nav-item active">

                <span class="nav-icon">&#128101;</span>
                Students

            </a>


            <a href="ManageExams.aspx"
               class="nav-item">

                <span class="nav-icon">&#128221;</span>
                Exams

            </a>


            <a href="ManageHalls.aspx"
               class="nav-item">

                <span class="nav-icon">&#127970;</span>
                Halls

            </a>


            <a href="ManageInvigilators.aspx"
               class="nav-item">

                <span class="nav-icon">&#128100;</span>
                Invigilators

            </a>


            <a href="ManageSchedule.aspx"
               class="nav-item">

                <span class="nav-icon">&#128197;</span>
                Schedule

            </a>


            <a href="AllocateHalls.aspx"
               class="nav-item">

                <span class="nav-icon">&#128203;</span>
                Allocations

            </a>


            <a href="AssignInvigilators.aspx"
               class="nav-item">

                <span class="nav-icon">&#128274;</span>
                Invigilators Assignment

            </a>


            <a href="ViewAllocations.aspx"
               class="nav-item">

                <span class="nav-icon">&#128065;</span>
                View Allocations

            </a>


            <a href="Reports.aspx"
               class="nav-item">

                <span class="nav-icon">&#128202;</span>
                Reports

            </a>


            <a href="../Account/Logout.aspx"
               class="nav-item">

                <span class="nav-icon">&#128682;</span>
                Logout

            </a>

        </nav>

    </aside>


    <!-- ================= MAIN ================= -->

    <main class="dashboard-main">


        <!-- TOP BAR -->

        <header class="topbar">

            <div class="topbar-title">
                Edit Student
            </div>


            <div class="topbar-right">

                <div class="user-profile">

                    <div class="user-avatar">
                        A
                    </div>

                    <div class="user-name">
                        System Administrator
                    </div>

                </div>

            </div>

        </header>


        <!-- CONTENT -->

        <section class="dashboard-content">


            <!-- PAGE TITLE -->

            <div class="welcome-section">

                <h1 class="welcome-title">
                    Edit Student
                </h1>

                <div class="welcome-subtitle">
                    Update student account and academic information.
                </div>

            </div>


            <!-- STUDENT PANEL -->

            <div class="dashboard-panel">


                <div class="panel-header">

                    <div class="panel-title">
                        Student Information
                    </div>

                    <div class="panel-subtitle">
                        Modify the student's details below.
                    </div>

                </div>


                <div class="panel-body">


                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        Text=""
                        CssClass="alert">
                    </asp:Label>


                    <div class="form-card">


                        <div class="form-grid">


                            <!-- FULL NAME -->

                            <div class="form-group">

                                <asp:Label
                                    ID="lblName"
                                    runat="server"
                                    Text="Full Name"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:TextBox
                                    ID="txtName"
                                    runat="server"
                                    CssClass="form-input">
                                </asp:TextBox>

                            </div>


                            <!-- REGISTER NUMBER -->

                            <div class="form-group">

                                <asp:Label
                                    ID="lblRegisterNumber"
                                    runat="server"
                                    Text="Register Number"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:TextBox
                                    ID="txtRegisterNumber"
                                    runat="server"
                                    CssClass="form-input">
                                </asp:TextBox>

                            </div>


                            <!-- EMAIL -->

                            <div class="form-group">

                                <asp:Label
                                    ID="lblEmail"
                                    runat="server"
                                    Text="Email Address"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:TextBox
                                    ID="txtEmail"
                                    runat="server"
                                    CssClass="form-input">
                                </asp:TextBox>

                            </div>


                            <!-- PHONE -->

                            <div class="form-group">

                                <asp:Label
                                    ID="lblPhone"
                                    runat="server"
                                    Text="Phone Number"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:TextBox
                                    ID="txtPhone"
                                    runat="server"
                                    CssClass="form-input">
                                </asp:TextBox>

                            </div>


                            <!-- DEPARTMENT -->

                            <div class="form-group">

                                <asp:Label
                                    ID="lblDepartment"
                                    runat="server"
                                    Text="Department"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:DropDownList
                                    ID="ddlDepartment"
                                    runat="server"
                                    CssClass="form-input">

                                    <asp:ListItem
                                        Text="Select Department"
                                        Value="">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Computer Science &amp; Engineering"
                                        Value="CSE">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Information Technology"
                                        Value="IT">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Electronics &amp; Communication"
                                        Value="ECE">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Electrical &amp; Electronics"
                                        Value="EEE">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Mechanical Engineering"
                                        Value="MECH">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Civil Engineering"
                                        Value="CIVIL">
                                    </asp:ListItem>

                                </asp:DropDownList>

                            </div>


                            <!-- YEAR -->

                            <div class="form-group">

                                <asp:Label
                                    ID="lblYear"
                                    runat="server"
                                    Text="Year"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:DropDownList
                                    ID="ddlYear"
                                    runat="server"
                                    CssClass="form-input">

                                    <asp:ListItem
                                        Text="Select Year"
                                        Value="">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="I Year"
                                        Value="1">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="II Year"
                                        Value="2">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="III Year"
                                        Value="3">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="IV Year"
                                        Value="4">
                                    </asp:ListItem>

                                </asp:DropDownList>

                            </div>


                            <!-- SECTION -->

                            <div class="form-group">

                                <asp:Label
                                    ID="lblSection"
                                    runat="server"
                                    Text="Section"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:DropDownList
                                    ID="ddlSection"
                                    runat="server"
                                    CssClass="form-input">

                                    <asp:ListItem
                                        Text="Select Section"
                                        Value="">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Section A"
                                        Value="A">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Section B"
                                        Value="B">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Section C"
                                        Value="C">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Section D"
                                        Value="D">
                                    </asp:ListItem>

                                </asp:DropDownList>

                            </div>


                            <!-- STATUS -->

                            <div class="form-group">

                                <asp:Label
                                    ID="lblStatus"
                                    runat="server"
                                    Text="Status"
                                    CssClass="form-label">
                                </asp:Label>

                                <asp:DropDownList
                                    ID="ddlStatus"
                                    runat="server"
                                    CssClass="form-input">

                                    <asp:ListItem
                                        Text="Active"
                                        Value="Active">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Inactive"
                                        Value="Inactive">
                                    </asp:ListItem>

                                </asp:DropDownList>

                            </div>


                        </div>


                        <!-- ADDRESS -->

                        <div class="form-group"
                             style="width:100%; margin-right:0;">

                            <asp:Label
                                ID="lblAddress"
                                runat="server"
                                Text="Address"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtAddress"
                                runat="server"
                                CssClass="form-input"
                                TextMode="MultiLine"
                                Rows="4">
                            </asp:TextBox>

                        </div>


                        <!-- BUTTONS -->

                        <div class="form-actions">

                            <asp:Button
                                ID="btnUpdate"
                                runat="server"
                                Text="Update Student"
                                CssClass="btn btn-primary"
                                OnClick="btnUpdate_Click" />


                            <asp:Button
                                ID="btnCancel"
                                runat="server"
                                Text="Cancel"
                                CssClass="btn btn-secondary"
                                CausesValidation="False"
                                OnClick="btnCancel_Click" />

                        </div>


                    </div>

                </div>

            </div>


            <div class="footer">
                Online Exam Hall Allocation System | Administration Module
            </div>


        </section>

    </main>

</div>

</form>

</body>

</html>