<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditInvigilator.aspx.vb" Inherits="Admin_EditInvigilator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Edit Invigilator - Online Exam Hall Allocation System</title>

    <style type="text/css">

        body
        {
            margin:0;
            padding:0;
            font-family:Arial, Helvetica, sans-serif;
            background:#f4f7fb;
            color:#172b4d;
        }

        .page
        {
            width:100%;
            min-height:700px;
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
            font-size:20px;
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
            font-size:10px;
            margin-top:5px;
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

        .heading
        {
            margin-bottom:25px;
        }

        .heading h1
        {
            margin:0;
            font-size:28px;
            color:#17385f;
        }

        .heading p
        {
            margin-top:7px;
            color:#718096;
            font-size:14px;
        }

        .form-card
        {
            width:800px;
            max-width:90%;
            background:white;
            border:1px solid #dce4ee;
            border-radius:8px;
            padding:30px;
        }

        .form-title
        {
            font-size:20px;
            font-weight:bold;
            margin-bottom:25px;
            color:#17385f;
        }

        .row
        {
            width:100%;
            overflow:hidden;
            margin-bottom:18px;
        }

        .field
        {
            width:47%;
            float:left;
            margin-right:3%;
        }

        .field-right
        {
            width:47%;
            float:left;
        }

        .field label
        {
            display:block;
            font-size:13px;
            font-weight:bold;
            margin-bottom:7px;
            color:#34495e;
        }

        .input
        {
            width:100%;
            height:42px;
            border:1px solid #ccd6e0;
            padding:0 12px;
            font-size:14px;
            border-radius:5px;
        }

        .input:focus
        {
            border-color:#2f6fbd;
            outline:none;
        }

        .select
        {
            width:100%;
            height:42px;
            border:1px solid #ccd6e0;
            padding:0 10px;
            font-size:14px;
            border-radius:5px;
            background:white;
        }

        .buttons
        {
            margin-top:25px;
            padding-top:20px;
            border-top:1px solid #e5e9ef;
        }

        .save
        {
            background:#286db8;
            color:white;
            border:0;
            padding:12px 25px;
            font-size:14px;
            font-weight:bold;
            border-radius:5px;
            cursor:pointer;
            margin-right:10px;
        }

        .cancel
        {
            background:#edf1f6;
            color:#34495e;
            border:1px solid #d5dde7;
            padding:11px 25px;
            font-size:14px;
            font-weight:bold;
            border-radius:5px;
            cursor:pointer;
        }

        .message
        {
            display:block;
            margin-top:15px;
            color:#d9534f;
            font-size:13px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="page">

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


    <!-- MAIN CONTENT -->

    <div class="main">

        <div class="heading">

            <h1>Edit Invigilator</h1>

            <p>
                Update examination invigilator information.
            </p>

        </div>


        <div class="form-card">

            <div class="form-title">
                Invigilator Details
            </div>


            <div class="row">

                <div class="field">

                    <label>Full Name</label>

                    <asp:TextBox
                        ID="txtName"
                        runat="server"
                        CssClass="input">
                    </asp:TextBox>

                </div>


                <div class="field-right">

                    <label>Email Address</label>

                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        CssClass="input">
                    </asp:TextBox>

                </div>

            </div>


            <div class="row">

                <div class="field">

                    <label>Phone Number</label>

                    <asp:TextBox
                        ID="txtPhone"
                        runat="server"
                        CssClass="input">
                    </asp:TextBox>

                </div>


                <div class="field-right">

                    <label>Department</label>

                    <asp:TextBox
                        ID="txtDepartment"
                        runat="server"
                        CssClass="input">
                    </asp:TextBox>

                </div>

            </div>


            <div class="row">

                <div class="field">

                    <label>Availability</label>

                    <asp:DropDownList
                        ID="ddlAvailability"
                        runat="server"
                        CssClass="select">

                        <asp:ListItem Text="Available" Value="Available"></asp:ListItem>
                        <asp:ListItem Text="Unavailable" Value="Unavailable"></asp:ListItem>

                    </asp:DropDownList>

                </div>


                <div class="field-right">

                    <label>Status</label>

                    <asp:DropDownList
                        ID="ddlStatus"
                        runat="server"
                        CssClass="select">

                        <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                        <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>

                    </asp:DropDownList>

                </div>

            </div>


            <div class="buttons">

                <asp:Button
                    ID="btnUpdate"
                    runat="server"
                    Text="Update Invigilator"
                    CssClass="save" />

                <asp:Button
                    ID="btnCancel"
                    runat="server"
                    Text="Cancel"
                    CssClass="cancel"
                    CausesValidation="False" />

            </div>


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>

        </div>

    </div>

</div>

</form>

</body>

</html>