<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Reports.aspx.vb" Inherits="Admin_Reports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Reports - Online Exam Hall Allocation System</title>

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

        /* STATISTICS */

        .stats-row {
            width: 100%;
            margin-bottom: 25px;
            overflow: hidden;
        }

        .stat-card {
            width: 17%;
            min-height: 95px;
            background: #ffffff;
            border: 1px solid #e1e6ef;
            float: left;
            margin-right: 2%;
            padding: 17px;
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
            font-size: 26px;
            font-weight: bold;
            color: #172033;
            margin-top: 12px;
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

        /* FILTER */

        .filter-row {
            width: 100%;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .filter-group {
            width: 60%;
            float: left;
        }

        .filter-label {
            display: block;
            font-size: 13px;
            font-weight: bold;
            color: #39465a;
            margin-bottom: 8px;
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

        .btn {
            display: inline-block;
            padding: 12px 20px;
            border: none;
            text-decoration: none;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            margin-right: 8px;
            margin-top: 24px;
        }

        .btn-generate {
            background: #4f8cff;
            color: #ffffff;
        }

        .btn-generate:hover {
            background: #3b78e8;
        }

        .btn-print {
            background: #16894f;
            color: #ffffff;
        }

        .btn-print:hover {
            background: #11723f;
        }

        /* MESSAGE */

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

        /* REPORT TABLE */

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

        .empty-message {
            padding: 30px;
            text-align: center;
            color: #8a95a6;
        }

        .footer-note {
            text-align: center;
            color: #9aa4b3;
            font-size: 11px;
            padding: 20px;
        }

        /* PRINT */

        @media print {

            .sidebar,
            .topbar,
            .filter-panel,
            .print-button {
                display: none;
            }

            .main-content {
                margin-left: 0;
            }

            .content {
                padding: 0;
            }

            .panel {
                border: none;
            }

            body {
                background: #ffffff;
            }

        }

    </style>

    <script type="text/javascript">

        function printReport() {
            window.print();
            return false;
        }

    </script>

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

            <a href="AssignInvigilators.aspx">
                Assign Invigilators
            </a>

            <div class="menu-title">Reports</div>

            <a href="Reports.aspx" class="active">
                Reports
            </a>

            <div class="menu-title">Account</div>

            <a href="../Account/Logout.aspx">
                Logout
            </a>

        </div>

    </div>


    <!-- MAIN CONTENT -->

    <div class="main-content">

        <div class="topbar">

            <div class="topbar-title">
                Reports
            </div>

            <div class="topbar-subtitle">
                Examination hall allocation and invigilator assignment reports
            </div>

        </div>


        <div class="content">

            <!-- STATISTICS -->

            <div class="stats-row">

                <div class="stat-card">

                    <div class="stat-label">
                        Students
                    </div>

                    <asp:Label
                        ID="lblStudents"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>


                <div class="stat-card">

                    <div class="stat-label">
                        Exams
                    </div>

                    <asp:Label
                        ID="lblExams"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>


                <div class="stat-card">

                    <div class="stat-label">
                        Halls
                    </div>

                    <asp:Label
                        ID="lblHalls"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>


                <div class="stat-card">

                    <div class="stat-label">
                        Allocations
                    </div>

                    <asp:Label
                        ID="lblAllocations"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>


                <div class="stat-card last">

                    <div class="stat-label">
                        Assignments
                    </div>

                    <asp:Label
                        ID="lblAssignments"
                        runat="server"
                        CssClass="stat-value"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <!-- FILTER PANEL -->

            <div class="panel filter-panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Generate Report
                    </div>

                    <div class="panel-description">
                        Select an examination to generate its allocation report
                    </div>

                </div>


                <div class="panel-body">

                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="message"
                        Visible="False">
                    </asp:Label>


                    <div class="filter-row">

                        <div class="filter-group">

                            <label class="filter-label">
                                Examination
                            </label>

                            <asp:DropDownList
                                ID="ddlExam"
                                runat="server"
                                CssClass="form-control">
                            </asp:DropDownList>

                        </div>


                        <asp:Button
                            ID="btnGenerate"
                            runat="server"
                            Text="GENERATE REPORT"
                            CssClass="btn btn-generate">
                        </asp:Button>


                        <asp:Button
                            ID="btnPrint"
                            runat="server"
                            Text="PRINT REPORT"
                            CssClass="btn btn-print print-button"
                            OnClientClick="return printReport();"
                            CausesValidation="False">
                        </asp:Button>

                    </div>

                </div>

            </div>


            <!-- REPORT -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Examination Allocation Report
                    </div>

                    <div class="panel-description">
                        Student hall and seat allocation details
                    </div>

                </div>


                <div class="panel-body">

                    <div class="table-wrapper">

                        <asp:GridView
                            ID="gvReport"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="data-table"
                            GridLines="None"
                            EmptyDataText="Select an examination and generate the report.">

                            <Columns>

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
                                    DataField="InvigilatorName"
                                    HeaderText="INVIGILATOR" />

                                <asp:BoundField
                                    DataField="Status"
                                    HeaderText="STATUS" />

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

            </div>


            <!-- INVIGILATOR SUMMARY -->

            <div class="panel">

                <div class="panel-header">

                    <div class="panel-title">
                        Invigilator Assignment Summary
                    </div>

                    <div class="panel-description">
                        Invigilators assigned to halls for the selected examination
                    </div>

                </div>


                <div class="panel-body">

                    <div class="table-wrapper">

                        <asp:GridView
                            ID="gvInvigilators"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="data-table"
                            GridLines="None"
                            EmptyDataText="No invigilator assignments found.">

                            <Columns>

                                <asp:BoundField
                                    DataField="ExamName"
                                    HeaderText="EXAM" />

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

                                <asp:BoundField
                                    DataField="Status"
                                    HeaderText="STATUS" />

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

            </div>


            <div class="footer-note">
                Online Exam Hall Allocation System &nbsp;|&nbsp; Reports Module
            </div>

        </div>

    </div>

</div>

</form>

</body>

</html>