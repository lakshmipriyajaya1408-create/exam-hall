<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ViewAllocations.aspx.vb" Inherits="Admin_ViewAllocations" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View Allocations - Online Exam Hall Allocation System</title>

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

        /* ================= SIDEBAR ================= */

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

        /* ================= MAIN ================= */

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

        /* ================= STATS ================= */

        .stats-row {
            width: 100%;
            margin-bottom: 25px;
            overflow: hidden;
        }

        .stat-card {
            width: 22%;
            min-height: 105px;
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

        /* ================= PANEL ================= */

        .panel {
            background: #ffffff;
            border: 1px solid #e1e6ef;
            margin-bottom: 25px;
        }

        .panel-header {
            padding: 18px 20px;
            border-bottom: 1px solid #e8ecf2;
            overflow: hidden;
        }

        .panel-title {
            float: left;
            font-size: 17px;
            font-weight: bold;
            color: #172033;
        }

        .panel-description {
            clear: both;
            padding-top: 5px;
            font-size: 12px;
            color: #8792a4;
        }

        .panel-body {
            padding: 20px;
        }

        /* ================= SEARCH ================= */

        .search-area {
            width: 100%;
            overflow: hidden;
        }

        .search-box {
            width: 65%;
            height: 40px;
            border: 1px solid #d5dce7;
            padding: 0 12px;
            font-size: 13px;
            float: left;
            color: #333333;
        }

        .btn {
            display: inline-block;
            height: 40px;
            line-height: 40px;
            padding-left: 18px;
            padding-right: 18px;
            margin-left: 8px;
            border: none;
            text-decoration: none;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-search {
            background: #4f8cff;
            color: #ffffff;
        }

        .btn-search:hover {
            background: #3b78e8;
        }

        .btn-clear {
            background: #e9edf3;
            color: #445064;
        }

        .btn-clear:hover {
            background: #dce2eb;
        }

        /* ================= MESSAGE ================= */

        .message {
            display: block;
            padding: 12px 15px;
            margin-bottom: 18px;
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

        /* ================= TABLE ================= */

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
            border: none;
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

        .data-table td:first-child {
            font-weight: bold;
            color: #172033;
        }

        /* ================= STATUS ================= */

        .status-active {
            display: inline-block;
            padding: 5px 9px;
            background: #e9f8ee;
            color: #28783d;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .status-inactive {
            display: inline-block;
            padding: 5px 9px;
            background: #fff0f0;
            color: #a33131;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .status-completed {
            display: inline-block;
            padding: 5px 9px;
            background: #eef1f7;
            color: #586477;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
        }

        /* ================= DELETE BUTTON ================= */

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

        /* ================= EMPTY ================= */

        .empty-message {
            padding: 35px;
            text-align: center;
            color: #8a95a6;
            font-size: 13px;
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

    <!-- ================= SIDEBAR ================= -->

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

            <a href="ViewAllocations.aspx" class="active">
                View Allocations
            </a>

            <a href="AssignInvigilators.aspx">
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


    <!-- ================= MAIN CONTENT ================= -->

    <div class="main-content">

        <div class="topbar">

            <div class="topbar-title">
                View Allocations
            </div>

            <div class="topbar-subtitle">
                View and manage student examination hall allocations
            </div>

        </div>


        <div class="content">

            <!-- ================= STATISTICS ================= -->

            <div class="stats-row">

                <div class="stat-card">
                    <div class="stat-label">Total Allocations</div>

                    <asp:Label
                        ID="lblTotalAllocations"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                    <div class="stat-description">
                        All allocation records
                    </div>
                </div>


                <div class="stat-card">
                    <div class="stat-label">Active Allocations</div>

                    <asp:Label
                        ID="lblActiveAllocations"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                    <div class="stat-description">
                        Currently active seats
                    </div>
                </div>


                <div class="stat-card">
                    <div class="stat-label">Halls Used</div>

                    <asp:Label
                        ID="lblHallsUsed"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                    <div class="stat-description">
                        Halls containing allocations
                    </div>
                </div>


                <div class="stat-card last">
                    <div class="stat-label">Allocation Status</div>

                    <div class="stat-value">
                        Ready
                    </div>

                    <div class="stat-description">
                        Allocation system status
                    </div>
                </div>

            </div>


            <!-- ================= ALLOCATIONS PANEL ================= -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Examination Hall Allocations
                    </div>

                    <div class="panel-description">
                        Students assigned to examination halls and seat numbers
                    </div>

                </div>


                <div class="panel-body">

                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="message"
                        Visible="False">
                    </asp:Label>


                    <!-- SEARCH -->

                    <div class="search-area">

                        <asp:TextBox
                            ID="txtSearch"
                            runat="server"
                            CssClass="search-box">
                        </asp:TextBox>

                        <asp:Button
                            ID="btnSearch"
                            runat="server"
                            Text="SEARCH"
                            CssClass="btn btn-search">
                        </asp:Button>

                        <asp:Button
                            ID="btnClear"
                            runat="server"
                            Text="CLEAR"
                            CssClass="btn btn-clear">
                        </asp:Button>

                    </div>

                    <br />

                    <!-- TABLE -->

                    <div class="table-wrapper">

                        <asp:GridView
                            ID="gvAllocations"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="data-table"
                            GridLines="None"
                            EmptyDataText="No hall allocations found.">

                            <Columns>

                                <asp:BoundField
                                    DataField="AllocationID"
                                    HeaderText="ID" />

                                <asp:BoundField
                                    DataField="ExamName"
                                    HeaderText="EXAM" />

                                <asp:BoundField
                                    DataField="Subject"
                                    HeaderText="SUBJECT" />

                                <asp:BoundField
                                    DataField="StudentName"
                                    HeaderText="STUDENT" />

                                <asp:BoundField
                                    DataField="RegisterNumber"
                                    HeaderText="REGISTER NO." />

                                <asp:BoundField
                                    DataField="Department"
                                    HeaderText="DEPARTMENT" />

                                <asp:BoundField
                                    DataField="Year"
                                    HeaderText="YEAR" />

                                <asp:BoundField
                                    DataField="HallName"
                                    HeaderText="HALL" />

                                <asp:BoundField
                                    DataField="SeatNumber"
                                    HeaderText="SEAT NO." />

                                <asp:BoundField
                                    DataField="AllocationDate"
                                    HeaderText="ALLOCATED ON"
                                    DataFormatString="{0:dd-MM-yyyy HH:mm}" />

                                <asp:TemplateField HeaderText="STATUS">

                                    <ItemTemplate>

                                        <asp:Label
                                            ID="lblStatus"
                                            runat="server"
                                            Text='<%# Eval("Status") %>'
                                            CssClass='<%# GetStatusClass(Eval("Status").ToString()) %>'>
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
                                            CommandName="DeleteAllocation"
                                            CommandArgument='<%# Eval("AllocationID") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this allocation?');">
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