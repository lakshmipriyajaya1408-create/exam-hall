<%@ Page Language="VB" AutoEventWireup="false" CodeFile="StudentList.aspx.vb" Inherits="Invigilator_StudentList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Student List - Invigilator</title>

    <style type="text/css">
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f6fa;
            color: #172033;
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 230px;
            background: #162033;
            color: #ffffff;
        }

        .brand {
            padding: 24px 20px;
            border-bottom: 1px solid #29354a;
        }

        .brand h2 {
            margin: 0;
            font-size: 20px;
        }

        .brand span {
            display: block;
            margin-top: 7px;
            font-size: 12px;
            color: #9eacc3;
        }

        .menu-title {
            padding: 24px 20px 10px;
            font-size: 11px;
            color: #8795ad;
            font-weight: bold;
            text-transform: uppercase;
        }

        .sidebar a {
            display: block;
            padding: 13px 22px;
            color: #ffffff;
            text-decoration: none;
            font-size: 14px;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background: #24324b;
            border-left: 3px solid #3f8cff;
            padding-left: 19px;
        }

        .content {
            margin-left: 230px;
            min-height: 100vh;
        }

        .topbar {
            background: #ffffff;
            padding: 18px 30px;
            border-bottom: 1px solid #dfe4ec;
        }

        .topbar h1 {
            margin: 0;
            font-size: 24px;
        }

        .topbar p {
            margin: 6px 0 0;
            color: #75839a;
            font-size: 13px;
        }

        .main {
            padding: 30px;
        }

        .intro {
            background: #ffffff;
            border: 1px solid #dce2eb;
            padding: 22px;
            margin-bottom: 24px;
        }

        .intro h2 {
            margin: 0;
            font-size: 20px;
        }

        .intro p {
            margin: 7px 0 0;
            color: #75839a;
            font-size: 13px;
        }

        .table-card {
            background: #ffffff;
            border: 1px solid #dce2eb;
        }

        .table-header {
            padding: 20px;
            border-bottom: 1px solid #e3e7ee;
        }

        .table-header h2 {
            margin: 0;
            font-size: 19px;
        }

        .table-header p {
            margin: 6px 0 0;
            color: #75839a;
            font-size: 13px;
        }

        .grid-container {
            padding: 20px;
            overflow-x: auto;
        }

        .student-grid {
            width: 100%;
            border-collapse: collapse;
        }

        .student-grid th {
            background: #172033;
            color: #ffffff;
            padding: 13px 10px;
            text-align: left;
            font-size: 12px;
            font-weight: bold;
        }

        .student-grid td {
            padding: 13px 10px;
            border-bottom: 1px solid #e3e7ee;
            font-size: 13px;
            color: #39465c;
        }

        .student-grid tr:hover td {
            background: #f7f9fc;
        }

        .seat {
            font-weight: bold;
            color: #172033;
        }

        .status {
            display: inline-block;
            padding: 5px 9px;
            background: #e5f6ec;
            color: #15803d;
            font-size: 10px;
            font-weight: bold;
        }

        .empty {
            padding: 35px;
            text-align: center;
            color: #75839a;
            font-size: 14px;
        }

        .back-button {
            display: inline-block;
            margin-top: 22px;
            padding: 11px 18px;
            background: #172033;
            color: #ffffff;
            text-decoration: none;
            font-size: 13px;
        }

        .footer {
            text-align: center;
            color: #8a96aa;
            font-size: 11px;
            padding: 20px;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="sidebar">

            <div class="brand">
                <h2>Exam Allocation</h2>
                <span>Invigilator Portal</span>
            </div>

            <div class="menu-title">Main</div>

            <a href="InvigilatorDashboard.aspx">Dashboard</a>

            <div class="menu-title">Examination</div>

            <a href="ExamSchedule.aspx">Exam Schedule</a>
            <a href="AssignedHalls.aspx">Assigned Halls</a>
            <a href="StudentList.aspx" class="active">Student List</a>

            <div class="menu-title">Account</div>

            <a href="../Account/ChangePassword.aspx">Change Password</a>
            <a href="../Account/Logout.aspx">Logout</a>

        </div>

        <div class="content">

            <div class="topbar">
                <h1>Student List</h1>
                <p>View students assigned to your examination halls</p>
            </div>

            <div class="main">

                <div class="intro">
                    <h2>Students in Assigned Halls</h2>
                    <p>
                        View the students allocated to the examination halls assigned to you.
                    </p>
                </div>

                <div class="table-card">

                    <div class="table-header">
                        <h2>Assigned Students</h2>
                        <p>
                            Student allocation and seating information
                        </p>
                    </div>

                    <div class="grid-container">

                        <asp:GridView
                            ID="gvStudents"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="student-grid"
                            GridLines="None"
                            EmptyDataText="No students are assigned to your examination halls.">

                            <Columns>

                                <asp:BoundField
                                    DataField="RegisterNumber"
                                    HeaderText="Register Number" />

                                <asp:BoundField
                                    DataField="StudentName"
                                    HeaderText="Student Name" />

                                <asp:BoundField
                                    DataField="Department"
                                    HeaderText="Department" />

                                <asp:BoundField
                                    DataField="Year"
                                    HeaderText="Year" />

                                <asp:BoundField
                                    DataField="Section"
                                    HeaderText="Section" />

                                <asp:BoundField
                                    DataField="ExamName"
                                    HeaderText="Exam" />

                                <asp:BoundField
                                    DataField="HallName"
                                    HeaderText="Hall" />

                                <asp:TemplateField HeaderText="Seat">
                                    <ItemTemplate>
                                        <span class="seat">
                                            <%# Eval("SeatNumber") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="status">
                                            <%# Eval("AllocationStatus") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>

                <a href="InvigilatorDashboard.aspx" class="back-button">
                    ← Back to Dashboard
                </a>

            </div>

            <div class="footer">
                Online Exam Hall Allocation System | Invigilator Portal
            </div>

        </div>

    </form>

</body>
</html>
