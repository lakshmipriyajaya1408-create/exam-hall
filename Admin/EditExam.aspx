<%@ Page Language="VB"
    AutoEventWireup="false"
    CodeFile="EditExam.aspx.vb"
    Inherits="Admin_EditExam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Edit Exam - Online Exam Hall Allocation System</title>

    <link href="../Css/style.css" rel="stylesheet" type="text/css" />
    <link href="../Css/dashboard.css" rel="stylesheet" type="text/css" />
    <link href="../Css/forms.css" rel="stylesheet" type="text/css" />

</head>

<body>

<form id="form1" runat="server">

<div class="dashboard">

    <!-- SIDEBAR -->

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


    <!-- MAIN -->

    <div class="dashboard-main">

        <div class="topbar">

            <span class="topbar-title">
                Edit Exam
            </span>

            <div class="topbar-right">

                <div class="user-profile">

                    <span class="user-avatar">A</span>

                    <span class="user-name">
                        Administrator
                    </span>

                    <span class="user-role">
                        Admin
                    </span>

                </div>

            </div>

        </div>


        <div class="dashboard-content">

            <div class="welcome-section">

                <h1 class="welcome-title">
                    Edit Examination
                </h1>

                <div class="welcome-subtitle">
                    Update the examination details below.
                </div>

            </div>


            <div class="dashboard-panel">

                <div class="panel-header">

                    <span class="panel-title">
                        Examination Details
                    </span>

                </div>


                <div class="panel-body">

                    <asp:Label
                        ID="lblMessage"
                        runat="server">
                    </asp:Label>


                    <!-- EXAM NAME / SUBJECT -->

                    <div class="form-row">

                        <div class="form-group">

                            <label>Exam Name</label>

                            <asp:TextBox
                                ID="txtExamName"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <div class="form-group">

                            <label>Subject</label>

                            <asp:TextBox
                                ID="txtSubject"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>

                    </div>


                    <!-- DATE / START TIME -->

                    <div class="form-row">

                        <div class="form-group">

                            <label>Exam Date</label>

                            <asp:TextBox
                                ID="txtExamDate"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <div class="form-group">

                            <label>Start Time</label>

                            <asp:TextBox
                                ID="txtStartTime"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>

                    </div>


                    <!-- END TIME / DEPARTMENT -->

                    <div class="form-row">

                        <div class="form-group">

                            <label>End Time</label>

                            <asp:TextBox
                                ID="txtEndTime"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <div class="form-group">

                            <label>Department</label>

                            <asp:TextBox
                                ID="txtDepartment"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>

                    </div>


                    <!-- YEAR / STATUS -->

                    <div class="form-row">

                        <div class="form-group">

                            <label>Year</label>

                            <asp:DropDownList
                                ID="ddlYear"
                                runat="server"
                                CssClass="form-control">

                                <asp:ListItem
                                    Text="Select Year"
                                    Value="">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="I Year"
                                    Value="1">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="II Year"
                                    Value="2">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="III Year"
                                    Value="3">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="IV Year"
                                    Value="4">
                                </asp:ListItem>

                            </asp:DropDownList>

                        </div>


                        <div class="form-group">

                            <label>Status</label>

                            <asp:DropDownList
                                ID="ddlStatus"
                                runat="server"
                                CssClass="form-control">

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

                    </div>


                    <!-- BUTTONS -->

                    <div class="form-actions">

                        <asp:Button
                            ID="btnUpdate"
                            runat="server"
                            Text="Update Exam"
                            CssClass="btn btn-primary" />

                        <asp:Button
                            ID="btnCancel"
                            runat="server"
                            Text="Cancel"
                            CssClass="btn btn-secondary"
                            CausesValidation="False" />

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</form>

</body>

</html>