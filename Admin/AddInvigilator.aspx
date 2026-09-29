<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddInvigilator.aspx.vb" Inherits="Admin_AddInvigilator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Add Invigilator</title>

    <link href="../Css/dashboard.css" rel="stylesheet" type="text/css" />

    <style type="text/css">

        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #172b4d;
        }

        .dashboard-main {
            margin-left: 250px;
            background: #f4f7fb;
            min-height: 700px;
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
            margin-bottom: 7px;
            font-size: 27px;
            color: #172b4d;
        }

        .page-heading p {
            font-size: 14px;
            color: #7b8ca5;
        }

        .form-card {
            background: #ffffff;
            border: 1px solid #e1e7ef;
            border-radius: 10px;
            padding: 32px;
            min-height: 400px;
        }

        .form-row {
            width: 100%;
            overflow: hidden;
            margin-bottom: 24px;
        }

        .form-column {
            float: left;
            width: 48%;
        }

        .form-column-right {
            float: right;
            width: 48%;
        }

        .field-label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: bold;
            color: #263b5a;
        }

        .form-input {
            display: block;
            width: 100%;
            height: 44px;
            padding: 0 12px;
            border: 1px solid #d5deea;
            border-radius: 6px;
            background: #ffffff;
            color: #263b5a;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
        }

        .form-input:focus {
            border-color: #2874c6;
            outline: none;
        }

        .form-select {
            display: block;
            width: 100%;
            height: 46px;
            padding: 0 12px;
            border: 1px solid #d5deea;
            border-radius: 6px;
            background: #ffffff;
            color: #263b5a;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
        }

        .validation-error {
            display: block;
            margin-top: 6px;
            font-size: 12px;
            color: #d9534f;
        }

        .button-area {
            clear: both;
            margin-top: 8px;
            padding-top: 22px;
            border-top: 1px solid #e6ebf2;
        }

        .save-button {
            display: inline-block;
            padding: 11px 24px;
            border: 1px solid #2367b1;
            border-radius: 6px;
            background: #2367b1;
            color: #ffffff;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            margin-right: 8px;
        }

        .cancel-button {
            display: inline-block;
            padding: 11px 24px;
            border: 1px solid #d5deea;
            border-radius: 6px;
            background: #eef2f7;
            color: #42526e;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        .message {
            display: block;
            margin-top: 15px;
            font-size: 13px;
            color: #d9534f;
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


    <!-- MAIN CONTENT -->

    <main class="dashboard-main">

        <header class="top-header">

            <h1>
                Add Invigilator
            </h1>

            <div class="admin-profile">

                <span class="admin-avatar">A</span>

                Administrator

            </div>

        </header>


        <section class="content-area">

            <div class="page-heading">

                <h2>
                    Add New Invigilator
                </h2>

                <p>
                    Enter the invigilator details below.
                </p>

            </div>


            <div class="form-card">

                <!-- ROW 1 -->

                <div class="form-row">

                    <div class="form-column">

                        <label class="field-label">
                            Full Name
                        </label>

                        <asp:TextBox
                            ID="txtName"
                            runat="server"
                            CssClass="form-input">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvName"
                            runat="server"
                            ControlToValidate="txtName"
                            ErrorMessage="Name is required."
                            CssClass="validation-error">
                        </asp:RequiredFieldValidator>

                    </div>


                    <div class="form-column-right">

                        <label class="field-label">
                            Email
                        </label>

                        <asp:TextBox
                            ID="txtEmail"
                            runat="server"
                            CssClass="form-input">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvEmail"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="Email is required."
                            CssClass="validation-error">
                        </asp:RequiredFieldValidator>

                    </div>

                </div>


                <!-- ROW 2 -->

                <div class="form-row">

                    <div class="form-column">

                        <label class="field-label">
                            Password
                        </label>

                        <asp:TextBox
                            ID="txtPassword"
                            runat="server"
                            TextMode="Password"
                            CssClass="form-input">
                        </asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ErrorMessage="Password is required."
                            CssClass="validation-error">
                        </asp:RequiredFieldValidator>

                    </div>


                    <div class="form-column-right">

                        <label class="field-label">
                            Phone
                        </label>

                        <asp:TextBox
                            ID="txtPhone"
                            runat="server"
                            CssClass="form-input">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- ROW 3 -->

                <div class="form-row">

                    <div class="form-column">

                        <label class="field-label">
                            Department
                        </label>

                        <asp:TextBox
                            ID="txtDepartment"
                            runat="server"
                            CssClass="form-input">
                        </asp:TextBox>

                    </div>


                    <div class="form-column-right">

                        <label class="field-label">
                            Availability
                        </label>

                        <asp:DropDownList
                            ID="ddlAvailability"
                            runat="server"
                            CssClass="form-select">

                            <asp:ListItem
                                Text="Available"
                                Value="Available">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Unavailable"
                                Value="Unavailable">
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>

                </div>


                <!-- ROW 4 -->

                <div class="form-row">

                    <div class="form-column">

                        <label class="field-label">
                            Status
                        </label>

                        <asp:DropDownList
                            ID="ddlStatus"
                            runat="server"
                            CssClass="form-select">

                            <asp:ListItem
                                Text="Active"
                                Value="Active">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Inactive"
                                Value="Inactive">
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>

                </div>


                <!-- BUTTONS -->

                <div class="button-area">

                    <asp:Button
                        ID="btnSave"
                        runat="server"
                        Text="Save Invigilator"
                        CssClass="save-button" />

                    <asp:Button
                        ID="btnCancel"
                        runat="server"
                        Text="Cancel"
                        CssClass="cancel-button"
                        CausesValidation="False" />

                </div>


                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="message">
                </asp:Label>

            </div>

        </section>

    </main>

</div>

</form>

</body>

</html>