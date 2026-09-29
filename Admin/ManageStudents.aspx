<%@ Page Language="VB"
    AutoEventWireup="false"
    CodeFile="ManageStudents.aspx.vb"
    Inherits="Admin_ManageStudents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Manage Students - Online Exam Hall Allocation System</title>

    <link href="../Css/style.css"
        rel="stylesheet"
        type="text/css" />

    <link href="../Css/dashboard.css"
        rel="stylesheet"
        type="text/css" />

    <link href="../Css/forms.css"
        rel="stylesheet"
        type="text/css" />

</head>

<body>

<form id="form1" runat="server">

<div class="dashboard">

    <aside class="sidebar">

        <div class="sidebar-brand">

            <div class="sidebar-logo">
                OE
            </div>

            <div>
                <div class="brand-title">
                    Online Exam
                </div>

                <div class="brand-subtitle">
                    Hall Allocation
                </div>
            </div>

        </div>

        <nav class="sidebar-nav">

            <a href="AdminDashboard.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#127968;
                </span>

                <span>
                    Dashboard
                </span>

            </a>

            <a href="ManageStudents.aspx"
               class="nav-item active">

                <span class="nav-icon">
                    &#128101;
                </span>

                <span>
                    Students
                </span>

            </a>

            <a href="ManageExams.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#128221;
                </span>

                <span>
                    Exams
                </span>

            </a>

            <a href="ManageHalls.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#127970;
                </span>

                <span>
                    Halls
                </span>

            </a>

            <a href="ManageInvigilators.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#128100;
                </span>

                <span>
                    Invigilators
                </span>

            </a>

            <a href="ManageSchedule.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#128197;
                </span>

                <span>
                    Schedule
                </span>

            </a>

            <a href="AllocateHalls.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#128203;
                </span>

                <span>
                    Allocations
                </span>

            </a>

            <a href="AssignInvigilators.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#128274;
                </span>

                <span>
                    Invigilators Assignment
                </span>

            </a>

            <a href="ViewAllocations.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#128065;
                </span>

                <span>
                    View Allocations
                </span>

            </a>

            <a href="Reports.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#128202;
                </span>

                <span>
                    Reports
                </span>

            </a>

            <a href="../Account/Logout.aspx"
               class="nav-item">

                <span class="nav-icon">
                    &#128682;
                </span>

                <span>
                    Logout
                </span>

            </a>

        </nav>

    </aside>


    <main class="dashboard-main">

        <header class="topbar">

            <div class="topbar-title">
                Students
            </div>

            <div class="topbar-right">

                <div class="user-profile">

                    <div class="user-avatar">
                        A
                    </div>

                    <div>

                        <div class="user-name">
                            System Administrator
                        </div>

                        

                    </div>

                </div>

            </div>

        </header>


        <section class="dashboard-content">


            <div class="welcome-section">

                <div>

                    <h1 class="welcome-title">
                        Student Management
                    </h1>

                    <p class="welcome-subtitle">
                        Manage student records, registration details
                        and academic information.
                    </p>

                </div>

            </div>


            <div class="stats-grid">


                <div class="stat-card">

                    <div class="stat-icon">
                        &#128101;
                    </div>

                    <div class="stat-number">

                        <asp:Label
                            ID="lblTotalStudents"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </div>

                    <div class="stat-label">
                        Total Students
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-icon">
                        &#10004;
                    </div>

                    <div class="stat-number">

                        <asp:Label
                            ID="lblActiveStudents"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </div>

                    <div class="stat-label">
                        Active Students
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-icon">
                        &#10006;
                    </div>

                    <div class="stat-number">

                        <asp:Label
                            ID="lblInactiveStudents"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </div>

                    <div class="stat-label">
                        Inactive Students
                    </div>

                </div>



            </div>


            <div class="dashboard-panel">

                <div class="panel-header">

                    <div>

                        <div class="panel-title">
                            Student Records
                        </div>

                        <div class="panel-subtitle">
                            View and manage registered students
                        </div>

                    </div>

                    <asp:Button
                        ID="btnAddStudent"
                        runat="server"
                        Text="+ Add Student"
                        CssClass="btn btn-primary"
                        OnClick="btnAddStudent_Click" />

                </div>


                <div class="panel-body">


                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        Text=""
                        CssClass="alert">
                    </asp:Label>


                    <div class="search-section">

                        <div class="search-box">

                            <asp:TextBox
                                ID="txtSearch"
                                runat="server"
                                CssClass="form-control"
                                Width="100%">
                            </asp:TextBox>

                        </div>


                        <asp:Button
                            ID="btnSearch"
                            runat="server"
                            Text="Search"
                            CssClass="btn btn-primary"
                            OnClick="btnSearch_Click" />


                        <asp:Button
                            ID="btnClear"
                            runat="server"
                            Text="Clear"
                            CssClass="btn btn-secondary"
                            OnClick="btnClear_Click" />

                    </div>


                    <div class="table-responsive">

                        <asp:GridView
                            ID="gvStudents"
                            runat="server"
                            AutoGenerateColumns="False"
                            CssClass="data-table"
                            GridLines="None"
                            AllowPaging="False"
                            OnRowCommand="gvStudents_RowCommand">

                            <Columns>

                                <asp:BoundField
                                    DataField="StudentID"
                                    HeaderText="ID" />

                                     <asp:BoundField
        DataField="Name"
        HeaderText="Name" />

                                <asp:BoundField
                                    DataField="RegisterNumber"
                                    HeaderText="Register Number" />

                                <asp:BoundField
                                    DataField="Department"
                                    HeaderText="Department" />

                                <asp:BoundField
                                    DataField="Year"
                                    HeaderText="Year" />

                                <asp:BoundField
                                    DataField="Section"
                                    HeaderText="Section" />

                                <asp:TemplateField
                                    HeaderText="Status">

                                    <ItemTemplate>

                                        <span class="status-badge">
                                            <%# Eval("Status") %>
                                        </span>

                                    </ItemTemplate>

                                </asp:TemplateField>


                                <asp:TemplateField
                                    HeaderText="Actions">

                                    <ItemTemplate>

                                        <asp:LinkButton
                                            ID="btnEdit"
                                            runat="server"
                                            Text="Edit"
                                            CommandName="EditStudent"
                                            CommandArgument='<%# Eval("StudentID") %>'
                                            CssClass="btn btn-small">
                                        </asp:LinkButton>


                                        <asp:LinkButton
                                            ID="btnDelete"
                                            runat="server"
                                            Text="Delete"
                                            CommandName="DeleteStudent"
                                            CommandArgument='<%# Eval("StudentID") %>'
                                            CssClass="btn btn-small btn-danger"
                                            OnClientClick="return confirm('Are you sure you want to delete this student?');">
                                        </asp:LinkButton>

                                    </ItemTemplate>

                                </asp:TemplateField>

                            </Columns>

                            <EmptyDataTemplate>

                                <div class="empty-state">

                                    <div class="empty-icon">
                                        &#128101;
                                    </div>

                                    <h3>
                                        No Students Found
                                    </h3>

                                    <p>
                                        There are currently no student
                                        records available.
                                    </p>

                                </div>

                            </EmptyDataTemplate>

                        </asp:GridView>

                    </div>

                </div>

            </div>

        </section>

    </main>

</div>

</form>

</body>

</html>