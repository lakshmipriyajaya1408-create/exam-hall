<%@ Page Language="VB"
    AutoEventWireup="false"
    CodeFile="ManageExams.aspx.vb"
    Inherits="Admin_ManageExams" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <title>Manage Exams - Online Exam Hall Allocation System</title>

    <link href="../Css/style.css" rel="stylesheet" type="text/css" />
    <link href="../Css/dashboard.css" rel="stylesheet" type="text/css" />
    <link href="../Css/forms.css" rel="stylesheet" type="text/css" />

</head>

<body>

<form id="form1" runat="server">

<div class="dashboard">

    <!-- ================= SIDEBAR ================= -->

    <div class="sidebar">

        <div class="sidebar-brand">

            <span class="sidebar-logo">OE</span>

            <span class="brand-title">
                Online Exam
            </span>

            <span class="brand-subtitle">
                Hall Allocation
            </span>

        </div>

        <div class="sidebar-nav">

            <div class="nav-section-title">
                MAIN MENU
            </div>

            <a href="AdminDashboard.aspx" class="nav-item">
                <span class="nav-icon">⌂</span>
                Dashboard
            </a>

            <a href="ManageStudents.aspx" class="nav-item">
                <span class="nav-icon">♙</span>
                Students
            </a>

            <a href="ManageExams.aspx" class="nav-item active">
                <span class="nav-icon">▣</span>
                Exams
            </a>

            <a href="ManageHalls.aspx" class="nav-item">
                <span class="nav-icon">▦</span>
                Halls
            </a>

            <a href="ManageInvigilators.aspx" class="nav-item">
                <span class="nav-icon">♟</span>
                Invigilators
            </a>

            <a href="ManageSchedule.aspx" class="nav-item">
                <span class="nav-icon">◷</span>
                Schedule
            </a>

            <a href="AllocateHalls.aspx" class="nav-item">
                <span class="nav-icon">▤</span>
                Allocate Halls
            </a>

            <a href="AssignInvigilators.aspx" class="nav-item">
                <span class="nav-icon">✓</span>
                Assign Invigilators
            </a>

            <a href="ViewAllocations.aspx" class="nav-item">
                <span class="nav-icon">☷</span>
                View Allocations
            </a>

            <a href="Reports.aspx" class="nav-item">
                <span class="nav-icon">▤</span>
                Reports
            </a>

        </div>

    </div>


    <!-- ================= MAIN AREA ================= -->

    <div class="dashboard-main">

        <!-- TOP BAR -->

        <div class="topbar">

            <span class="topbar-title">
                Manage Exams
            </span>

            <div class="topbar-right">

                <div class="user-profile">

                    <span class="user-avatar">
                        A
                    </span>

                    <span class="user-name">
                        Administrator
                    </span>

                    <span class="user-role">
                        Admin
                    </span>

                </div>

            </div>

        </div>


        <!-- ================= CONTENT ================= -->

        <div class="dashboard-content">

            <div class="welcome-section">

                <h1 class="welcome-title">
                    Exam Management
                </h1>

                <div class="welcome-subtitle">
                    Add, edit, search and manage examination details.
                </div>

            </div>


            <!-- ================= STATISTICS ================= -->

            <div class="stats-grid">

                <div class="stat-card">

                    <div class="stat-icon blue">
                        ▣
                    </div>

                    <span class="stat-number">
                        <asp:Label ID="lblTotalExams"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </span>

                    <div class="stat-label">
                        Total Exams
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-icon green">
                        ✓
                    </div>

                    <span class="stat-number">
                        <asp:Label ID="lblActiveExams"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </span>

                    <div class="stat-label">
                        Active Exams
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-icon orange">
                        ◷
                    </div>

                    <span class="stat-number">
                        <asp:Label ID="lblUpcomingExams"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </span>

                    <div class="stat-label">
                        Upcoming Exams
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-icon purple">
                        □
                    </div>

                    <span class="stat-number">
                        <asp:Label ID="lblCompletedExams"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </span>

                    <div class="stat-label">
                        Completed Exams
                    </div>

                </div>

            </div>


            <!-- ================= EXAM RECORDS ================= -->

            <div class="dashboard-panel">

                <div class="panel-header">

                    <span class="panel-title">
                        Examination Records
                    </span>

                    <asp:Button
                        ID="btnAddExam"
                        runat="server"
                        Text="+ Add Exam"
                        CssClass="btn btn-primary" />

                </div>


                <div class="panel-body">

                    <!-- SEARCH -->

                    <div class="form-row">

                        <div class="form-group">

                            <asp:TextBox
                                ID="txtSearch"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>

                        <div class="form-group">

                            <asp:Button
                                ID="btnSearch"
                                runat="server"
                                Text="Search"
                                CssClass="btn btn-primary" />

                            <asp:Button
                                ID="btnClear"
                                runat="server"
                                Text="Clear"
                                CssClass="btn btn-secondary" />

                        </div>

                    </div>


                    <asp:Label
                        ID="lblMessage"
                        runat="server">
                    </asp:Label>


                    <!-- ================= EXAM TABLE ================= -->

                    <div class="table-container">

                        <asp:GridView
                            ID="gvExams"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="data-table"
                            GridLines="None"
                            AllowPaging="False">

                            <Columns>

                                <asp:BoundField
                                    DataField="ExamID"
                                    HeaderText="ID" />

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
                                    DataField="Department"
                                    HeaderText="Department" />

                                <asp:BoundField
                                    DataField="Year"
                                    HeaderText="Year" />

                                <asp:BoundField
                                    DataField="Status"
                                    HeaderText="Status" />

                                <asp:TemplateField
                                    HeaderText="Actions">

                                    <ItemTemplate>

                                        <asp:LinkButton
                                            ID="btnEdit"
                                            runat="server"
                                            CommandName="EditExam"
                                            CommandArgument='<%# Eval("ExamID") %>'
                                            CssClass="btn btn-small btn-primary">
                                            Edit
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnDelete"
                                            runat="server"
                                            CommandName="DeleteExam"
                                            CommandArgument='<%# Eval("ExamID") %>'
                                            CssClass="btn btn-small btn-danger">
                                            Delete
                                        </asp:LinkButton>

                                    </ItemTemplate>

                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</form>

</body>
</html>