<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ManageSchedule.aspx.vb" Inherits="Admin_ManageSchedule" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Manage Schedule - Online Exam Hall Allocation System</title>

    <style type="text/css">

        body
        {
            margin:0;
            padding:0;
            font-family:Arial, Helvetica, sans-serif;
            background:#f4f7fb;
            color:#172b4d;
        }

        .sidebar
        {
            width:250px;
            position:fixed;
            left:0;
            top:0;
            bottom:0;
            background:#19375f;
            color:white;
            overflow-y:auto;
        }

        .brand
        {
            height:90px;
            border-bottom:1px solid #31527a;
            padding-left:20px;
        }

        .logo
        {
            width:42px;
            height:42px;
            background:#2f6fbd;
            display:inline-block;
            margin-top:20px;
            margin-right:10px;
            text-align:center;
            line-height:42px;
            font-size:18px;
            font-weight:bold;
            vertical-align:top;
        }

        .brand-text
        {
            display:inline-block;
            margin-top:20px;
        }

        .brand-title
        {
            font-size:16px;
            font-weight:bold;
        }

        .brand-subtitle
        {
            display:block;
            margin-top:5px;
            font-size:10px;
            color:#b9cce5;
        }

        .nav
        {
            padding:25px 14px;
        }

        .nav a
        {
            display:block;
            padding:14px 12px;
            color:white;
            text-decoration:none;
            font-size:14px;
            margin-bottom:3px;
        }

        .nav a:hover
        {
            background:#2868b2;
        }

        .main
        {
            margin-left:250px;
            padding:30px;
        }

        .header
        {
            margin-bottom:25px;
        }

        .header h1
        {
            margin:0;
            font-size:28px;
            color:#17385f;
        }

        .header p
        {
            margin-top:7px;
            color:#718096;
            font-size:14px;
        }

        .stats
        {
            width:100%;
            overflow:hidden;
            margin-bottom:25px;
        }

        .stat-card
        {
            width:21%;
            float:left;
            background:white;
            border:1px solid #dce4ee;
            margin-right:2%;
            padding:20px;
            border-radius:7px;
        }

        .stat-title
        {
            color:#718096;
            font-size:12px;
            text-transform:uppercase;
            font-weight:bold;
        }

        .stat-value
        {
            display:block;
            margin-top:8px;
            font-size:28px;
            font-weight:bold;
            color:#17385f;
        }

        .toolbar
        {
            background:white;
            border:1px solid #dce4ee;
            padding:18px;
            margin-bottom:20px;
            border-radius:7px;
            overflow:hidden;
        }

        .search-box
        {
            width:350px;
            height:40px;
            border:1px solid #ccd6e0;
            padding:0 12px;
            font-size:14px;
            border-radius:5px;
            float:left;
            margin-right:10px;
        }

        .button
        {
            height:40px;
            padding:0 20px;
            border:0;
            background:#286db8;
            color:white;
            font-size:13px;
            font-weight:bold;
            cursor:pointer;
            border-radius:5px;
            margin-right:7px;
        }

        .clear-button
        {
            background:#edf1f6;
            color:#34495e;
            border:1px solid #d5dde7;
        }

        .add-button
        {
            float:right;
            background:#198754;
        }

        .table-card
        {
            background:white;
            border:1px solid #dce4ee;
            border-radius:7px;
            padding:20px;
            overflow-x:auto;
        }

        .data-table
        {
            width:100%;
            border-collapse:collapse;
            font-size:13px;
        }

        .data-table th
        {
            background:#f0f4f8;
            color:#34495e;
            padding:13px 10px;
            text-align:left;
            border-bottom:2px solid #dce4ee;
        }

        .data-table td
        {
            padding:13px 10px;
            border-bottom:1px solid #e8edf2;
            color:#4a5568;
        }

        .data-table tr:hover td
        {
            background:#f8fafc;
        }

        .action-link
        {
            color:#286db8;
            text-decoration:none;
            font-weight:bold;
            margin-right:8px;
        }

        .delete-link
        {
            color:#d9534f;
        }

        .message
        {
            display:block;
            margin-bottom:15px;
            font-size:13px;
            color:#198754;
        }

        .status
        {
            font-weight:bold;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <!-- SIDEBAR -->

    <div class="sidebar">

        <div class="brand">

            <span class="logo">OE</span>

            <span class="brand-text">

                <span class="brand-title">
                    Online Exam
                </span>

                <span class="brand-subtitle">
                    Hall Allocation
                </span>

            </span>

        </div>

        <div class="nav">

            <a href="AdminDashboard.aspx">Dashboard</a>
            <a href="ManageStudents.aspx">Students</a>
            <a href="ManageExams.aspx">Exams</a>
            <a href="ManageHalls.aspx">Halls</a>
            <a href="ManageInvigilators.aspx">Invigilators</a>
            <a href="ManageSchedule.aspx">Schedule</a>
            <a href="AllocateHalls.aspx">Allocate Halls</a>
            <a href="AssignInvigilators.aspx">Assign Invigilators</a>
            <a href="ViewAllocations.aspx">View Allocations</a>
            <a href="Reports.aspx">Reports</a>

        </div>

    </div>


    <!-- MAIN -->

    <div class="main">

        <div class="header">

            <h1>Manage Schedule</h1>

            <p>
                Create and manage examination schedules.
            </p>

        </div>


        <!-- STATISTICS -->

        <div class="stats">

            <div class="stat-card">

                <span class="stat-title">
                    Total Schedules
                </span>

                <asp:Label
                    ID="lblTotalSchedules"
                    runat="server"
                    CssClass="stat-value"
                    Text="0">
                </asp:Label>

            </div>


            <div class="stat-card">

                <span class="stat-title">
                    Scheduled
                </span>

                <asp:Label
                    ID="lblScheduled"
                    runat="server"
                    CssClass="stat-value"
                    Text="0">
                </asp:Label>

            </div>


            <div class="stat-card">

                <span class="stat-title">
                    Active
                </span>

                <asp:Label
                    ID="lblActive"
                    runat="server"
                    CssClass="stat-value"
                    Text="0">
                </asp:Label>

            </div>


            <div class="stat-card">

                <span class="stat-title">
                    Completed
                </span>

                <asp:Label
                    ID="lblCompleted"
                    runat="server"
                    CssClass="stat-value"
                    Text="0">
                </asp:Label>

            </div>

        </div>


        <!-- TOOLBAR -->

        <div class="toolbar">

            <asp:TextBox
                ID="txtSearch"
                runat="server"
                CssClass="search-box">
            </asp:TextBox>


            <asp:Button
                ID="btnSearch"
                runat="server"
                Text="Search"
                CssClass="button">
            </asp:Button>


            <asp:Button
                ID="btnClear"
                runat="server"
                Text="Clear"
                CssClass="button clear-button">
            </asp:Button>


            <asp:Button
                ID="btnAddSchedule"
                runat="server"
                Text="+ Add Schedule"
                CssClass="button add-button">
            </asp:Button>

        </div>


        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message">
        </asp:Label>


        <!-- TABLE -->

        <div class="table-card">

            <asp:GridView
                ID="gvSchedule"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="data-table"
                GridLines="None">

                <Columns>

                    <asp:BoundField
                        DataField="ScheduleID"
                        HeaderText="ID" />

                    <asp:BoundField
                        DataField="ExamName"
                        HeaderText="EXAM" />

                    <asp:BoundField
                        DataField="Subject"
                        HeaderText="SUBJECT" />

                    <asp:BoundField
                        DataField="ExamDate"
                        HeaderText="DATE"
                        DataFormatString="{0:dd-MM-yyyy}" />

                    <asp:BoundField
                        DataField="StartTime"
                        HeaderText="START TIME" />

                    <asp:BoundField
                        DataField="EndTime"
                        HeaderText="END TIME" />

                    <asp:BoundField
                        DataField="Department"
                        HeaderText="DEPARTMENT" />

                    <asp:BoundField
                        DataField="Year"
                        HeaderText="YEAR" />

                    <asp:BoundField
                        DataField="Status"
                        HeaderText="STATUS" />

                    <asp:TemplateField HeaderText="ACTIONS">

                        <ItemTemplate>

                            <asp:LinkButton
                                ID="btnEdit"
                                runat="server"
                                Text="Edit"
                                CommandName="EditSchedule"
                                CommandArgument='<%# Eval("ScheduleID") %>'
                                CssClass="action-link"
                                CausesValidation="False">
                            </asp:LinkButton>

                            <asp:LinkButton
                                ID="btnDelete"
                                runat="server"
                                Text="Delete"
                                CommandName="DeleteSchedule"
                                CommandArgument='<%# Eval("ScheduleID") %>'
                                CssClass="action-link delete-link"
                                CausesValidation="False"
                                OnClientClick="return confirm('Are you sure you want to delete this schedule?');">
                            </asp:LinkButton>

                        </ItemTemplate>

                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

        </div>

    </div>

</form>

</body>

</html>