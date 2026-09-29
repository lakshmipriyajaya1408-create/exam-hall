<%@ Page Language="VB"
    AutoEventWireup="false"
    CodeFile="ManageHalls.aspx.vb"
    Inherits="Admin_ManageHalls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Manage Halls - Online Exam Hall Allocation System</title>

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

            <a href="ManageExams.aspx" class="nav-item">
                <span class="nav-icon">▣</span>
                Exams
            </a>

            <a href="ManageHalls.aspx" class="nav-item active">
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

        <div class="topbar">

            <span class="topbar-title">
                Manage Halls
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
                    Hall Management
                </h1>

                <div class="welcome-subtitle">
                    Add, edit, search and manage examination halls.
                </div>

            </div>


            <!-- ================= STATISTICS ================= -->

            <div class="stats-grid">

                <div class="stat-card">

                    <div class="stat-icon blue">
                        ▦
                    </div>

                    <span class="stat-number">

                        <asp:Label
                            ID="lblTotalHalls"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </span>

                    <div class="stat-label">
                        Total Halls
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-icon green">
                        ✓
                    </div>

                    <span class="stat-number">

                        <asp:Label
                            ID="lblAvailableHalls"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </span>

                    <div class="stat-label">
                        Available Halls
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-icon orange">
                        ♟
                    </div>

                    <span class="stat-number">

                        <asp:Label
                            ID="lblOccupiedHalls"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </span>

                    <div class="stat-label">
                        Occupied Halls
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-icon purple">
                        #
                    </div>

                    <span class="stat-number">

                        <asp:Label
                            ID="lblTotalCapacity"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </span>

                    <div class="stat-label">
                        Total Capacity
                    </div>

                </div>

            </div>


            <!-- ================= HALL RECORDS ================= -->

            <div class="dashboard-panel">

                <div class="panel-header">

                    <span class="panel-title">
                        Examination Hall Records
                    </span>

                    <asp:Button
                        ID="btnAddHall"
                        runat="server"
                        Text="+ Add Hall"
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


                    <!-- ================= HALL TABLE ================= -->

                    <div class="table-container">

                   <asp:GridView ID="gvHalls" runat="server"
    AutoGenerateColumns="False"
    CssClass="data-table"
    GridLines="None"
    OnRowCommand="gvHalls_RowCommand">

    <Columns>

        <asp:BoundField DataField="HallID"
            HeaderText="ID" />

        <asp:BoundField DataField="HallName"
            HeaderText="Hall Name" />

        <asp:BoundField DataField="Building"
            HeaderText="Building" />

        <asp:BoundField DataField="Floor"
            HeaderText="Floor" />

        <asp:BoundField DataField="Capacity"
            HeaderText="Capacity" />

        <asp:BoundField DataField="Status"
            HeaderText="Status" />

        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>

                <asp:LinkButton ID="btnEdit"
                    runat="server"
                    CommandName="EditHall"
                    CommandArgument='<%# Eval("HallID") %>'
                    CssClass="btn-edit">
                    Edit
                </asp:LinkButton>

                <asp:LinkButton ID="btnDelete"
                    runat="server"
                    CommandName="DeleteHall"
                    CommandArgument='<%# Eval("HallID") %>'
                    CssClass="btn-delete"
                    OnClientClick="return confirm('Are you sure you want to delete this hall?');">
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
