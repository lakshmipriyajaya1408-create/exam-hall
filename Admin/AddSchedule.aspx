<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddSchedule.aspx.vb" Inherits="Admin_AddSchedule" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add Schedule - Online Exam Hall Allocation System</title>

    <style type="text/css">

        body
        {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #333333;
        }

        .sidebar
        {
            position: fixed;
            left: 0;
            top: 0;
            width: 250px;
            height: 100%;
            background: #1e416b;
            color: #ffffff;
        }

        .brand
        {
            height: 90px;
            padding: 20px;
            border-bottom: 1px solid #355579;
        }

        .brand-logo
        {
            float: left;
            width: 42px;
            height: 42px;
            line-height: 42px;
            text-align: center;
            background: #2f73b9;
            font-size: 18px;
            font-weight: bold;
            margin-right: 12px;
        }

        .brand-title
        {
            font-size: 17px;
            font-weight: bold;
            padding-top: 2px;
        }

        .brand-subtitle
        {
            font-size: 10px;
            margin-top: 5px;
            color: #d5e4f4;
        }

        .menu
        {
            padding-top: 20px;
        }

        .menu a
        {
            display: block;
            padding: 14px 25px;
            color: #ffffff;
            text-decoration: none;
            font-size: 14px;
        }

        .menu a:hover
        {
            background: #285481;
        }

        .menu a.active
        {
            background: #2f73b9;
        }

        .main
        {
            margin-left: 250px;
            padding: 40px 30px;
            min-height: 650px;
        }

        .page-title
        {
            font-size: 28px;
            font-weight: bold;
            color: #183f69;
            margin-bottom: 8px;
        }

        .page-description
        {
            color: #6b7c93;
            font-size: 14px;
            margin-bottom: 30px;
        }

        .form-card
        {
            background: #ffffff;
            border: 1px solid #dce4ed;
            padding: 30px;
            width: 700px;
        }

        .form-title
        {
            font-size: 20px;
            font-weight: bold;
            color: #183f69;
            margin-bottom: 25px;
            border-bottom: 1px solid #e2e8ef;
            padding-bottom: 15px;
        }

        .form-row
        {
            margin-bottom: 20px;
        }

        .form-label
        {
            display: block;
            font-size: 13px;
            font-weight: bold;
            color: #425466;
            margin-bottom: 8px;
        }

        .required
        {
            color: #d9534f;
        }

        .form-control
        {
            width: 100%;
            height: 42px;
            padding: 9px 12px;
            border: 1px solid #cbd5e1;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            color: #333333;
            background: #ffffff;
        }

        .form-control:focus
        {
            border-color: #2f73b9;
            outline: none;
        }

        .date-control
        {
            width: 250px;
        }

        .time-control
        {
            width: 180px;
        }

        .select-control
        {
            width: 100%;
        }

        .button-area
        {
            border-top: 1px solid #e2e8ef;
            margin-top: 30px;
            padding-top: 20px;
        }

        .btn-save
        {
            background: #198754;
            color: #ffffff;
            border: none;
            padding: 11px 24px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-save:hover
        {
            background: #157347;
        }

        .btn-cancel
        {
            display: inline-block;
            background: #e9eef4;
            color: #334e68;
            text-decoration: none;
            padding: 11px 24px;
            font-size: 14px;
            font-weight: bold;
        }

        .btn-cancel:hover
        {
            background: #dce4ed;
        }

        .message
        {
            display: block;
            padding: 12px;
            margin-bottom: 20px;
            background: #fff3cd;
            border: 1px solid #ffe69c;
            color: #664d03;
            font-size: 13px;
        }

        .info-box
        {
            background: #eef6ff;
            border: 1px solid #cfe2ff;
            padding: 12px 15px;
            margin-bottom: 25px;
            color: #24527a;
            font-size: 13px;
        }

        @media screen and (max-width: 900px)
        {
            .sidebar
            {
                width: 200px;
            }

            .main
            {
                margin-left: 200px;
            }

            .form-card
            {
                width: auto;
            }
        }

    </style>
</head>

<body>

<form id="form1" runat="server">

    <!-- ========================= -->
    <!-- SIDEBAR -->
    <!-- ========================= -->

    <div class="sidebar">

        <div class="brand">

            <div class="brand-logo">
                OE
            </div>

            <div class="brand-title">
                Online Exam
            </div>

            <div class="brand-subtitle">
                Hall Allocation
            </div>

        </div>

        <div class="menu">

            <a href="AdminDashboard.aspx">
                Dashboard
            </a>

            <a href="ManageStudents.aspx">
                Students
            </a>

            <a href="ManageExams.aspx">
                Exams
            </a>

            <a href="ManageHalls.aspx">
                Halls
            </a>

            <a href="ManageInvigilators.aspx">
                Invigilators
            </a>

            <a href="ManageSchedule.aspx" class="active">
                Schedule
            </a>

            <a href="AllocateHalls.aspx">
                Allocate Halls
            </a>

            <a href="AssignInvigilators.aspx">
                Assign Invigilators
            </a>

            <a href="ViewAllocations.aspx">
                View Allocations
            </a>

            <a href="Reports.aspx">
                Reports
            </a>

        </div>

    </div>


    <!-- ========================= -->
    <!-- MAIN CONTENT -->
    <!-- ========================= -->

    <div class="main">

        <div class="page-title">
            Add Schedule
        </div>

        <div class="page-description">
            Create a new examination schedule.
        </div>


        <div class="form-card">

            <div class="form-title">
                Schedule Details
            </div>


            <!-- MESSAGE -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message"
                Visible="False">
            </asp:Label>


            <!-- INFORMATION -->

            <div class="info-box">
                Select an existing examination and enter its scheduled date and time.
            </div>


            <!-- ========================= -->
            <!-- EXAMINATION -->
            <!-- ========================= -->

            <div class="form-row">

                <asp:Label
                    ID="lblExam"
                    runat="server"
                    CssClass="form-label"
                    AssociatedControlID="ddlExam">

                    Examination <span class="required">*</span>

                </asp:Label>

                <asp:DropDownList
                    ID="ddlExam"
                    runat="server"
                    CssClass="form-control select-control">

                </asp:DropDownList>

            </div>


            <!-- ========================= -->
            <!-- EXAM DATE -->
            <!-- ========================= -->

            <div class="form-row">

                <asp:Label
                    ID="lblExamDate"
                    runat="server"
                    CssClass="form-label"
                    AssociatedControlID="txtExamDate">

                    Exam Date <span class="required">*</span>

                </asp:Label>

                <asp:TextBox
                    ID="txtExamDate"
                    runat="server"
                    CssClass="form-control date-control">
                </asp:TextBox>

            </div>


            <!-- ========================= -->
            <!-- START TIME -->
            <!-- ========================= -->

            <div class="form-row">

                <asp:Label
                    ID="lblStartTime"
                    runat="server"
                    CssClass="form-label"
                    AssociatedControlID="txtStartTime">

                    Start Time <span class="required">*</span>

                </asp:Label>

                <asp:TextBox
                    ID="txtStartTime"
                    runat="server"
                    CssClass="form-control time-control">
                </asp:TextBox>

            </div>


            <!-- ========================= -->
            <!-- END TIME -->
            <!-- ========================= -->

            <div class="form-row">

                <asp:Label
                    ID="lblEndTime"
                    runat="server"
                    CssClass="form-label"
                    AssociatedControlID="txtEndTime">

                    End Time <span class="required">*</span>

                </asp:Label>

                <asp:TextBox
                    ID="txtEndTime"
                    runat="server"
                    CssClass="form-control time-control">
                </asp:TextBox>

            </div>


            <!-- ========================= -->
            <!-- STATUS -->
            <!-- ========================= -->

            <div class="form-row">

                <asp:Label
                    ID="lblStatus"
                    runat="server"
                    CssClass="form-label"
                    AssociatedControlID="ddlStatus">

                    Status <span class="required">*</span>

                </asp:Label>

                <asp:DropDownList
                    ID="ddlStatus"
                    runat="server"
                    CssClass="form-control select-control">

                    <asp:ListItem
                        Text="Scheduled"
                        Value="Scheduled">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Active"
                        Value="Active">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Completed"
                        Value="Completed">
                    </asp:ListItem>

                </asp:DropDownList>

            </div>


            <!-- ========================= -->
            <!-- BUTTONS -->
            <!-- ========================= -->

            <div class="button-area">

                <asp:Button
                    ID="btnSave"
                    runat="server"
                    Text="Save Schedule"
                    CssClass="btn-save" />

                <asp:HyperLink
                    ID="btnCancel"
                    runat="server"
                    NavigateUrl="ManageSchedule.aspx"
                    CssClass="btn-cancel">

                    Cancel

                </asp:HyperLink>

            </div>

        </div>

    </div>

</form>

</body>
</html>