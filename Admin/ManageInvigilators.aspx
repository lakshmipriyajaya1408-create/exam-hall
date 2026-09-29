<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ManageInvigilators.aspx.vb" Inherits="Admin_ManageInvigilators" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Manage Invigilators</title>

    <link href="../Css/dashboard.css" rel="stylesheet" type="text/css" />

    <style type="text/css">

        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #172b4d;
        }

        .dashboard-main {
            margin-left: 250px;
            min-height: 700px;
            background: #f4f7fb;
        }

        .top-header {
            height: 80px;
            background: #ffffff;
            border-bottom: 1px solid #e1e7ef;
            padding: 0 32px;
        }

        .top-header h1 {
            float: left;
            line-height: 80px;
            margin: 0;
            font-size: 23px;
            color: #172b4d;
        }

        .admin-profile {
            float: right;
            height: 80px;
            line-height: 80px;
            font-size: 14px;
        }

        .admin-avatar {
            display: inline-block;
            width: 38px;
            height: 38px;
            line-height: 38px;
            text-align: center;
            background: #e8f0fc;
            color: #2367b1;
            font-weight: bold;
            border-radius: 50%;
            margin-right: 8px;
            vertical-align: middle;
        }

        .content-area {
            padding: 35px 32px;
        }

        .page-heading {
            margin-bottom: 25px;
        }

        .page-heading h2 {
            margin: 0 0 7px 0;
            font-size: 27px;
            color: #172b4d;
        }

        .page-heading p {
            margin: 0;
            font-size: 14px;
            color: #7b8ca5;
        }

        /* STATISTICS */

        .stats-row {
            width: 100%;
            overflow: hidden;
            margin-bottom: 28px;
        }

        .stat-card {
            float: left;
            width: 22%;
            margin-right: 4%;
            height: 105px;
            background: #ffffff;
            border: 1px solid #e1e7ef;
            border-radius: 10px;
            position: relative;
        }

        .stat-card-last {
            margin-right: 0;
        }

        .stat-number {
            display: block;
            margin: 25px 20px 5px 75px;
            font-size: 25px;
            font-weight: bold;
            color: #172b4d;
        }

        .stat-label {
            display: block;
            margin-left: 75px;
            font-size: 13px;
            color: #7b8ca5;
        }

        .stat-icon {
            position: absolute;
            left: 20px;
            top: 22px;
            width: 42px;
            height: 42px;
            line-height: 42px;
            text-align: center;
            border-radius: 8px;
            font-size: 18px;
            font-weight: bold;
        }

        .icon-blue {
            background: #e8f1fd;
            color: #2367b1;
        }

        .icon-green {
            background: #e5f7ef;
            color: #1b9a68;
        }

        .icon-orange {
            background: #fff3dc;
            color: #c88716;
        }

        .icon-purple {
            background: #f0e8ff;
            color: #7a4ac7;
        }

        /* RECORD CARD */

        .records-card {
            background: #ffffff;
            border: 1px solid #e1e7ef;
            border-radius: 10px;
            overflow: hidden;
        }

        .records-header {
            height: 80px;
            border-bottom: 1px solid #e5eaf0;
            padding: 0 22px;
        }

        .records-title {
            float: left;
            line-height: 80px;
            font-size: 16px;
            font-weight: bold;
            color: #172b4d;
        }

        .add-button {
            float: right;
            margin-top: 20px;
            padding: 12px 20px;
            background: #2367b1;
            border: 1px solid #2367b1;
            border-radius: 6px;
            color: #ffffff;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
        }

        .search-area {
            padding: 20px 22px 12px 22px;
            overflow: hidden;
        }

        .search-box {
            float: left;
            width: 78%;
            height: 42px;
            padding: 0 12px;
            border: 1px solid #d5deea;
            border-radius: 6px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
        }

        .search-button {
            float: left;
            margin-left: 8px;
            height: 44px;
            padding: 0 20px;
            border: 1px solid #2367b1;
            border-radius: 6px;
            background: #2367b1;
            color: #ffffff;
            font-weight: bold;
            cursor: pointer;
        }

        .clear-button {
            float: left;
            margin-left: 6px;
            height: 44px;
            padding: 0 18px;
            border: 1px solid #d5deea;
            border-radius: 6px;
            background: #eef2f7;
            color: #42526e;
            font-weight: bold;
            cursor: pointer;
        }

        /* GRID */

        .grid-wrapper {
            padding: 0 22px 22px 22px;
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 13px;
        }

        .data-table th {
            padding: 13px 10px;
            text-align: left;
            background: #f7f9fc;
            color: #526581;
            font-size: 11px;
            text-transform: uppercase;
            border-bottom: 1px solid #e1e7ef;
        }

        .data-table td {
            padding: 15px 10px;
            color: #42526e;
            border-bottom: 1px solid #edf0f4;
        }

        .btn-edit {
            color: #2367b1;
            text-decoration: none;
            margin-right: 8px;
        }

        .btn-delete {
            color: #d9534f;
            text-decoration: none;
        }

        @media screen and (max-width: 900px) {

            .dashboard-main {
                margin-left: 0;
            }

            .content-area {
                padding: 25px 20px;
            }

            .stat-card {
                width: 48%;
                margin-right: 4%;
                margin-bottom: 15px;
            }

            .stat-card:nth-child(even) {
                margin-right: 0;
            }

            .search-box {
                width: 60%;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="dashboard-wrapper">

    <!-- SIDEBAR -->

    <aside class="sidebar">

        <div class="sidebar-brand">

            <span class="sidebar-logo">OE</span>

            <span class="brand-title">
                Online Exam
            </span>

            <span class="brand-subtitle">
                Hall Allocation
            </span>

        </div>

        <nav class="sidebar-nav">

            <a href="AdminDashboard.aspx" class="nav-item">
                Dashboard
            </a>

            <a href="ManageStudents.aspx" class="nav-item">
                Students
            </a>

            <a href="ManageExams.aspx" class="nav-item">
                Exams
            </a>

            <a href="ManageHalls.aspx" class="nav-item">
                Halls
            </a>

            <a href="ManageInvigilators.aspx" class="nav-item active">
                Invigilators
            </a>

            <a href="ManageSchedule.aspx" class="nav-item">
                Schedule
            </a>

            <a href="AllocateHalls.aspx" class="nav-item">
                Allocate Halls
            </a>

            <a href="AssignInvigilators.aspx" class="nav-item">
                Assign Invigilators
            </a>

            <a href="ViewAllocations.aspx" class="nav-item">
                View Allocations
            </a>

            <a href="Reports.aspx" class="nav-item">
                Reports
            </a>

        </nav>

    </aside>


    <!-- MAIN -->

    <main class="dashboard-main">

        <header class="top-header">

            <h1>
                Manage Invigilators
            </h1>

            <div class="admin-profile">

                <span class="admin-avatar">A</span>

                Administrator

            </div>

        </header>


        <section class="content-area">

            <div class="page-heading">

                <h2>
                    Invigilator Management
                </h2>

                <p>
                    Add, edit, search and manage examination invigilators.
                </p>

            </div>


            <!-- STATISTICS -->

            <div class="stats-row">

                <div class="stat-card">

                    <span class="stat-icon icon-blue">♟</span>

                    <span class="stat-number">
                        <asp:Label ID="lblTotalInvigilators"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </span>

                    <span class="stat-label">
                        Total Invigilators
                    </span>

                </div>


                <div class="stat-card">

                    <span class="stat-icon icon-green">✓</span>

                    <span class="stat-number">
                        <asp:Label ID="lblAvailableInvigilators"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </span>

                    <span class="stat-label">
                        Available
                    </span>

                </div>


                <div class="stat-card">

                    <span class="stat-icon icon-orange">!</span>

                    <span class="stat-number">
                        <asp:Label ID="lblUnavailableInvigilators"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </span>

                    <span class="stat-label">
                        Unavailable
                    </span>

                </div>


                <div class="stat-card stat-card-last">

                    <span class="stat-icon icon-purple">✓</span>

                    <span class="stat-number">
                        <asp:Label ID="lblActiveInvigilators"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </span>

                    <span class="stat-label">
                        Active
                    </span>

                </div>

            </div>


            <!-- RECORDS -->

            <div class="records-card">

                <div class="records-header">

                    <span class="records-title">
                        Invigilator Records
                    </span>

                    <asp:Button
                        ID="btnAddInvigilator"
                        runat="server"
                        Text="+ Add Invigilator"
                        CssClass="add-button" />

                </div>


                <div class="search-area">

                    <asp:TextBox
                        ID="txtSearch"
                        runat="server"
                        CssClass="search-box">
                    </asp:TextBox>

                    <asp:Button
                        ID="btnSearch"
                        runat="server"
                        Text="Search"
                        CssClass="search-button" />

                    <asp:Button
                        ID="btnClear"
                        runat="server"
                        Text="Clear"
                        CssClass="clear-button"
                        CausesValidation="False" />

                </div>


                <div class="grid-wrapper">

                    <asp:GridView
                        ID="gvInvigilators"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="data-table"
                        GridLines="None">

                        <Columns>

                            <asp:BoundField
                                DataField="InvigilatorID"
                                HeaderText="ID" />

                            <asp:BoundField
                                DataField="Name"
                                HeaderText="Name" />

                            <asp:BoundField
                                DataField="Email"
                                HeaderText="Email" />

                            <asp:BoundField
                                DataField="Department"
                                HeaderText="Department" />

                            <asp:BoundField
                                DataField="Availability"
                                HeaderText="Availability" />

                            <asp:BoundField
                                DataField="Status"
                                HeaderText="Status" />

                            <asp:TemplateField
                                HeaderText="Actions">

                                <ItemTemplate>

                                    <asp:LinkButton
                                        ID="btnEdit"
                                        runat="server"
                                        CommandName="EditInvigilator"
                                        CommandArgument='<%# Eval("InvigilatorID") %>'
                                        CssClass="btn-edit">
                                        Edit
                                    </asp:LinkButton>

                                    <asp:LinkButton
                                        ID="btnDelete"
                                        runat="server"
                                        CommandName="DeleteInvigilator"
                                        CommandArgument='<%# Eval("InvigilatorID") %>'
                                        CssClass="btn-delete"
                                        OnClientClick="return confirm('Are you sure you want to delete this invigilator?');">
                                        Delete
                                    </asp:LinkButton>

                                </ItemTemplate>

                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>

            </div>

        </section>

    </main>

</div>

</form>

</body>

</html>