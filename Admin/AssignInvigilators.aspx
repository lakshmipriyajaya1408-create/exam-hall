<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AssignInvigilators.aspx.vb" Inherits="Admin_AssignInvigilators" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Assign Invigilators - Online Exam Hall Allocation System</title>

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

        /* STATS */

        .stats-row {
            width: 100%;
            margin-bottom: 25px;
            overflow: hidden;
        }

        .stat-card {
            width: 29%;
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
            font-size: 12px;
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
            padding: 25px;
        }

        /* FORM */

        .form-row {
            width: 100%;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .form-group {
            width: 47%;
            float: left;
            margin-right: 6%;
        }

        .form-group.last {
            margin-right: 0;
        }

        .form-label {
            display: block;
            font-size: 13px;
            font-weight: bold;
            color: #39465a;
            margin-bottom: 8px;
        }

        .required {
            color: #d9534f;
        }

        .form-control {
            width: 100%;
            height: 42px;
            border: 1px solid #d4dce8;
            padding: 0 12px;
            font-size: 13px;
            color: #344054;
            background: #ffffff;
        }

        .form-control:focus {
            border-color: #4f8cff;
            outline: none;
        }

        .help-text {
            font-size: 11px;
            color: #8a95a6;
            margin-top: 6px;
        }

        /* BUTTONS */

        .button-row {
            margin-top: 10px;
            padding-top: 20px;
            border-top: 1px solid #e8ecf2;
        }

        .btn {
            display: inline-block;
            padding: 12px 22px;
            border: none;
            text-decoration: none;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            margin-right: 8px;
        }

        .btn-assign {
            background: #16894f;
            color: #ffffff;
        }

        .btn-assign:hover {
            background: #11723f;
        }

        .btn-back {
            background: #e8edf4;
            color: #344054;
        }

        .btn-back:hover {
            background: #dce3ed;
        }

        /* MESSAGE */

        .message {
            display: block;
            padding: 12px 15px;
            margin-bottom: 20px;
            font-size: 13px;
            border: 1px solid;
        }

        .success-message {
            background: #edf9f0;
            color: #26733a;
            border-color: #b8e3c1;
        }

        .danger-message {
            background: #fff0f0;
            color: #a33131;
            border-color: #efb5b5;
        }

        /* TABLE */

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
        }

        .data-table th {
            background: #172033;
            color: #ffffff;
            padding: 13px 10px;
            text-align: left;
            font-size: 11px;
            text-transform: uppercase;
        }

        .data-table td {
            padding: 13px 10px;
            border-bottom: 1px solid #e8ecf2;
            color: #465164;
            background: #ffffff;
        }

        .data-table tr:hover td {
            background: #f7f9fc;
        }

        .status-assigned {
            display: inline-block;
            padding: 5px 9px;
            background: #e9f8ee;
            color: #28783d;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .btn-delete {
            display: inline-block;
            padding: 7px 12px;
            background: #fff0f0;
            color: #c0392b;
            border: 1px solid #efc0c0;
            text-decoration: none;
            font-size: 11px;
            font-weight: bold;
        }

        .btn-delete:hover {
            background: #c0392b;
            color: #ffffff;
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
            <div class="brand-title">Exam Allocation</div>
            <div class="brand-subtitle">Administration Panel</div>
        </div>

        <div class="menu">

            <div class="menu-title">Main</div>

            <a href="AdminDashboard.aspx">
                Dashboard
            </a>

            <a href="ManageStudents.aspx">
                Manage Students
            </a>

            <a href="ManageExams.aspx">
                Manage Exams
            </a>

            <a href="ManageHalls.aspx">
                Manage Halls
            </a>

            <a href="ManageInvigilators.aspx">
                Manage Invigilators
            </a>

            <div class="menu-title">Examination</div>

            <a href="ManageSchedule.aspx">
                Manage Schedule
            </a>

            <a href="AllocateHalls.aspx">
                Allocate Halls
            </a>

            <a href="ViewAllocations.aspx">
                View Allocations
            </a>

            <a href="AssignInvigilators.aspx" class="active">
                Assign Invigilators
            </a>

            <div class="menu-title">Reports</div>

            <a href="Reports.aspx">
                Reports
            </a>

            <div class="menu-title">Account</div>

            <a href="../Account/Logout.aspx">
                Logout
            </a>

        </div>

    </div>


    <!-- MAIN -->

    <div class="main-content">

        <div class="topbar">

            <div class="topbar-title">
                Assign Invigilators
            </div>

            <div class="topbar-subtitle">
                Assign invigilators to examination halls
            </div>

        </div>


        <div class="content">


            <!-- STATISTICS -->

            <div class="stats-row">

                <div class="stat-card">

                    <div class="stat-label">
                        Total Assignments
                    </div>

                    <asp:Label
                        ID="lblTotalAssignments"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                    <div class="stat-description">
                        All invigilator assignments
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-label">
                        Assigned
                    </div>

                    <asp:Label
                        ID="lblAssigned"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                    <div class="stat-description">
                        Active assignments
                    </div>

                </div>


                <div class="stat-card last">

                    <div class="stat-label">
                        Halls Covered
                    </div>

                    <asp:Label
                        ID="lblHallsCovered"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                    <div class="stat-description">
                        Halls with invigilators
                    </div>

                </div>

            </div>


            <!-- ASSIGNMENT FORM -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Create Invigilator Assignment
                    </div>

                    <div class="panel-description">
                        Select an examination, hall and available invigilator
                    </div>

                </div>


                <div class="panel-body">


                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="message"
                        Visible="False">
                    </asp:Label>


                    <!-- EXAM -->

                    <div class="form-row">

                        <div class="form-group">

                            <label class="form-label">
                                Examination <span class="required">*</span>
                            </label>

                            <asp:DropDownList
                                ID="ddlExam"
                                runat="server"
                                CssClass="form-control"
                                AutoPostBack="True">
                            </asp:DropDownList>

                            <div class="help-text">
                                Select the examination for the assignment.
                            </div>

                        </div>


                        <div class="form-group last">

                            <label class="form-label">
                                Examination Hall <span class="required">*</span>
                            </label>

                            <asp:DropDownList
                                ID="ddlHall"
                                runat="server"
                                CssClass="form-control">
                            </asp:DropDownList>

                            <div class="help-text">
                                Select the hall where the invigilator will supervise.
                            </div>

                        </div>

                    </div>


                    <!-- INVIGILATOR -->

                    <div class="form-row">

                        <div class="form-group">

                            <label class="form-label">
                                Invigilator <span class="required">*</span>
                            </label>

                            <asp:DropDownList
                                ID="ddlInvigilator"
                                runat="server"
                                CssClass="form-control">
                            </asp:DropDownList>

                            <div class="help-text">
                                Only active and available invigilators are displayed.
                            </div>

                        </div>


                        <div class="form-group last">

                            <label class="form-label">
                                Assignment Status
                            </label>

                            <asp:DropDownList
                                ID="ddlStatus"
                                runat="server"
                                CssClass="form-control">

                                <asp:ListItem Text="Assigned" Value="Assigned"></asp:ListItem>
                                <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>

                            </asp:DropDownList>

                        </div>

                    </div>


                    <!-- BUTTONS -->

                    <div class="button-row">

                        <asp:Button
                            ID="btnAssign"
                            runat="server"
                            Text="Assign Invigilator"
                            CssClass="btn btn-assign">
                        </asp:Button>

                        <asp:Button
                            ID="btnBack"
                            runat="server"
                            Text="Back"
                            CssClass="btn btn-back"
                            CausesValidation="False">
                        </asp:Button>

                    </div>


                </div>

            </div>


            <!-- CURRENT ASSIGNMENTS -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Current Invigilator Assignments
                    </div>

                    <div class="panel-description">
                        Invigilators currently assigned to examination halls
                    </div>

                </div>


                <div class="panel-body">

                    <div class="table-wrapper">

                        <asp:GridView
                            ID="gvAssignments"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="data-table"
                            GridLines="None"
                            EmptyDataText="No invigilator assignments found.">

                            <Columns>

                                <asp:BoundField
                                    DataField="AssignmentID"
                                    HeaderText="ID" />

                                <asp:BoundField
                                    DataField="ExamName"
                                    HeaderText="EXAM" />

                                <asp:BoundField
                                    DataField="Subject"
                                    HeaderText="SUBJECT" />

                                <asp:BoundField
                                    DataField="HallName"
                                    HeaderText="HALL" />

                                <asp:BoundField
                                    DataField="InvigilatorName"
                                    HeaderText="INVIGILATOR" />

                                <asp:BoundField
                                    DataField="Email"
                                    HeaderText="EMAIL" />

                                <asp:BoundField
                                    DataField="Department"
                                    HeaderText="DEPARTMENT" />

                                <asp:BoundField
                                    DataField="AssignmentDate"
                                    HeaderText="ASSIGNED ON"
                                    DataFormatString="{0:dd-MM-yyyy HH:mm}" />

                                <asp:TemplateField HeaderText="STATUS">

                                    <ItemTemplate>

                                        <asp:Label
                                            ID="lblAssignmentStatus"
                                            runat="server"
                                            Text='<%# Eval("Status") %>'
                                            CssClass="status-assigned">
                                        </asp:Label>

                                    </ItemTemplate>

                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="ACTIONS">

                                    <ItemTemplate>

                                        <asp:LinkButton
                                            ID="btnDelete"
                                            runat="server"
                                            Text="Delete"
                                            CssClass="btn-delete"
                                            CommandName="DeleteAssignment"
                                            CommandArgument='<%# Eval("AssignmentID") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this invigilator assignment?');">
                                        </asp:LinkButton>

                                    </ItemTemplate>

                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

            </div>


            <div class="footer-note">
                Online Exam Hall Allocation System &nbsp;|&nbsp; Administration Module
            </div>


        </div>

    </div>

</div>

</form>

</body>

</html>