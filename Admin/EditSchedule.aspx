<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditSchedule.aspx.vb" Inherits="Admin_EditSchedule" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Edit Schedule - Online Exam Hall Allocation System</title>

    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #172b4d;
        }

        .sidebar {
            width: 250px;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            background: #19375f;
            color: white;
        }

        .brand {
            height: 90px;
            border-bottom: 1px solid #31527a;
            padding-left: 20px;
        }

        .logo {
            width: 42px;
            height: 42px;
            background: #2f6fbd;
            display: inline-block;
            margin-top: 20px;
            margin-right: 10px;
            text-align: center;
            line-height: 42px;
            font-size: 18px;
            font-weight: bold;
            vertical-align: top;
        }

        .brand-text {
            display: inline-block;
            margin-top: 20px;
        }

        .brand-title {
            font-size: 16px;
            font-weight: bold;
        }

        .brand-subtitle {
            display: block;
            margin-top: 5px;
            font-size: 10px;
            color: #b9cce5;
        }

        .nav {
            padding: 25px 14px;
        }

        .nav a {
            display: block;
            padding: 14px 12px;
            color: white;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 3px;
        }

        .nav a:hover {
            background: #2868b2;
        }

        .main {
            margin-left: 250px;
            padding: 30px;
        }

        .header {
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            color: #17385f;
        }

        .header p {
            margin-top: 7px;
            color: #718096;
            font-size: 14px;
        }

        .card {
            background: white;
            border: 1px solid #dce4ee;
            border-radius: 7px;
            padding: 25px;
            max-width: 850px;
        }

        .form-row {
            width: 100%;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .form-group {
            width: 48%;
            float: left;
            margin-right: 4%;
        }

        .form-group.last {
            margin-right: 0;
        }

        .form-group.full {
            width: 100%;
            margin-right: 0;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-size: 13px;
            font-weight: bold;
            color: #34495e;
        }

        .form-control {
            width: 100%;
            height: 40px;
            border: 1px solid #ccd6e0;
            padding: 0 10px;
            box-sizing: border-box;
            font-size: 13px;
            background: white;
        }

        .form-control:focus {
            border-color: #286db8;
            outline: none;
        }

        .readonly {
            background: #f0f4f8;
            color: #68778a;
        }

        .button {
            height: 40px;
            padding: 0 22px;
            border: 0;
            background: #198754;
            color: white;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            margin-right: 8px;
        }

        .button:hover {
            background: #157347;
        }

        .cancel-button {
            display: inline-block;
            height: 40px;
            line-height: 40px;
            padding: 0 22px;
            background: #edf1f6;
            color: #34495e;
            text-decoration: none;
            font-size: 13px;
        }

        .message {
            display: block;
            padding: 12px;
            margin-bottom: 20px;
            font-size: 13px;
            background: #fdecec;
            border: 1px solid #f2c1c1;
            color: #b42318;
        }

        .info {
            display: block;
            padding: 12px;
            margin-bottom: 20px;
            font-size: 13px;
            background: #eef5ff;
            border: 1px solid #c9ddf5;
            color: #285a91;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="sidebar">

            <div class="brand">
                <span class="logo">OE</span>

                <span class="brand-text">
                    <span class="brand-title">Online Exam</span>
                    <span class="brand-subtitle">Hall Allocation</span>
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
                <a href="../Account/Logout.aspx">Logout</a>

            </div>

        </div>

        <div class="main">

            <div class="header">
                <h1>Edit Schedule</h1>
                <p>Update the examination schedule details.</p>
            </div>

            <div class="card">

                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="message"
                    Visible="false">
                </asp:Label>

                <asp:Label
                    ID="lblInfo"
                    runat="server"
                    CssClass="info"
                    Visible="false">
                </asp:Label>

                <div class="form-row">

                    <div class="form-group full">

                        <asp:Label
                            ID="lblExam"
                            runat="server"
                            Text="Examination">
                        </asp:Label>

                        <asp:DropDownList
                            ID="ddlExam"
                            runat="server"
                            CssClass="form-control">
                        </asp:DropDownList>

                    </div>

                </div>

                <div class="form-row">

                    <div class="form-group">

                        <asp:Label
                            ID="lblExamDate"
                            runat="server"
                            Text="Exam Date">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtExamDate"
                            runat="server"
                            CssClass="form-control">
                        </asp:TextBox>

                    </div>

                    <div class="form-group last">

                        <asp:Label
                            ID="lblStatus"
                            runat="server"
                            Text="Status">
                        </asp:Label>

                        <asp:DropDownList
                            ID="ddlStatus"
                            runat="server"
                            CssClass="form-control">

                            <asp:ListItem Text="Scheduled" Value="Scheduled"></asp:ListItem>
                            <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                            <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>

                        </asp:DropDownList>

                    </div>

                </div>

                <div class="form-row">

                    <div class="form-group">

                        <asp:Label
                            ID="lblStartTime"
                            runat="server"
                            Text="Start Time">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtStartTime"
                            runat="server"
                            CssClass="form-control">
                        </asp:TextBox>

                    </div>

                    <div class="form-group last">

                        <asp:Label
                            ID="lblEndTime"
                            runat="server"
                            Text="End Time">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtEndTime"
                            runat="server"
                            CssClass="form-control">
                        </asp:TextBox>

                    </div>

                </div>

                <asp:Button
                    ID="btnUpdate"
                    runat="server"
                    Text="Update Schedule"
                    CssClass="button"
                    CausesValidation="False" />

                <a href="ManageSchedule.aspx" class="cancel-button">
                    Cancel
                </a>

            </div>

        </div>

    </form>

</body>
</html>