<%@ Page Language="VB" AutoEventWireup="false"
    CodeFile="AdminDashboard.aspx.vb"
    Inherits="Admin_AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Admin Dashboard - ExamHall</title>

    <link href="../CSS/style.css"
          rel="stylesheet"
          type="text/css" />

    <link href="../CSS/dashboard.css"
          rel="stylesheet"
          type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <div class="dashboard">

        <!-- =====================================================
             SIDEBAR
             ===================================================== -->

        <aside class="sidebar">

            <div class="sidebar-brand">

                <div class="sidebar-logo">
                    🎓
                </div>

                <div>

                    <div class="sidebar-brand-text">
                        EXAMHALL
                    </div>

                    <span class="sidebar-brand-subtitle">
                        Examination Portal
                    </span>

                </div>

            </div>


            <nav class="sidebar-nav">

                <div class="nav-section-title">
                    MAIN MENU
                </div>


                <a href="AdminDashboard.aspx"
                   class="nav-item active">

                    <span class="nav-icon">▦</span>
                    <span>Dashboard</span>

                </a>


                <a href="ManageStudents.aspx"
                   class="nav-item">

                    <span class="nav-icon">♙</span>
                    <span>Students</span>

                </a>


                <a href="ManageExams.aspx"
                   class="nav-item">

                    <span class="nav-icon">▤</span>
                    <span>Exams</span>

                </a>


                <a href="ManageHalls.aspx"
                   class="nav-item">

                    <span class="nav-icon">⌂</span>
                    <span>Halls</span>

                </a>


                <a href="ManageInvigilators.aspx"
                   class="nav-item">

                    <span class="nav-icon">♟</span>
                    <span>Invigilators</span>

                </a>


                <div class="nav-section-title"
                     style="margin-top:25px;">

                    ALLOCATION

                </div>


                <a href="ManageSchedule.aspx"
                   class="nav-item">

                    <span class="nav-icon">▣</span>
                    <span>Schedule</span>

                </a>


                <a href="AllocateHalls.aspx"
                   class="nav-item">

                    <span class="nav-icon">⊞</span>
                    <span>Hall Allocation</span>

                </a>


                <a href="AssignInvigilators.aspx"
                   class="nav-item">

                    <span class="nav-icon">✓</span>
                    <span>Invigilator Assignment</span>

                </a>


                <a href="ViewAllocations.aspx"
                   class="nav-item">

                    <span class="nav-icon">☷</span>
                    <span>View Allocations</span>

                </a>


                <div class="nav-section-title"
                     style="margin-top:25px;">

                    REPORTS

                </div>


                <a href="Reports.aspx"
                   class="nav-item">

                    <span class="nav-icon">▥</span>
                    <span>Reports</span>

                </a>


                <a href="../Account/Logout.aspx"
                   class="nav-item">

                    <span class="nav-icon">↪</span>
                    <span>Logout</span>

                </a>

            </nav>

        </aside>



        <!-- =====================================================
             MAIN CONTENT
             ===================================================== -->

        <main class="dashboard-main">


            <!-- TOP BAR -->

            <header class="topbar">

                <div class="topbar-title">
                    Dashboard
                </div>


                <div class="topbar-right">

                    <div class="user-profile">

                        <div class="user-avatar">
                            A
                        </div>


                        <div>

                            <div class="user-name">

                                <asp:Label
                                    ID="lblTopName"
                                    runat="server">
                                </asp:Label>

                            </div>

                        </div>

                    </div>

                </div>

            </header>



            <!-- DASHBOARD CONTENT -->

            <section class="dashboard-content">


                <!-- WELCOME -->

                <div class="welcome-section">

                    <div class="welcome-title">

                        Welcome back,

                        <asp:Label
                            ID="lblWelcome"
                            runat="server">
                        </asp:Label>

                    </div>


                    <div class="welcome-subtitle">

                        Here's an overview of your examination
                        management system.

                    </div>

                </div>



                <!-- =================================================
                     STATISTICS
                     ================================================= -->

                <div class="stats-grid">


                    <!-- STUDENTS -->

                    <div class="stat-card">

                        <div class="stat-icon blue">
                            ♙
                        </div>


                        <div>

                            <div class="stat-number">

                                <asp:Label
                                    ID="lblStudentCount"
                                    runat="server"
                                    Text="0">
                                </asp:Label>

                            </div>


                            <div class="stat-label">
                                Total Students
                            </div>

                        </div>

                    </div>



                    <!-- EXAMS -->

                    <div class="stat-card">

                        <div class="stat-icon green">
                            ▤
                        </div>


                        <div>

                            <div class="stat-number">

                                <asp:Label
                                    ID="lblExamCount"
                                    runat="server"
                                    Text="0">
                                </asp:Label>

                            </div>


                            <div class="stat-label">
                                Total Exams
                            </div>

                        </div>

                    </div>



                    <!-- HALLS -->

                    <div class="stat-card">

                        <div class="stat-icon orange">
                            ⌂
                        </div>


                        <div>

                            <div class="stat-number">

                                <asp:Label
                                    ID="lblHallCount"
                                    runat="server"
                                    Text="0">
                                </asp:Label>

                            </div>


                            <div class="stat-label">
                                Examination Halls
                            </div>

                        </div>

                    </div>



                    <!-- INVIGILATORS -->

                    <div class="stat-card">

                        <div class="stat-icon purple">
                            ♟
                        </div>


                        <div>

                            <div class="stat-number">

                                <asp:Label
                                    ID="lblInvigilatorCount"
                                    runat="server"
                                    Text="0">
                                </asp:Label>

                            </div>


                            <div class="stat-label">
                                Invigilators
                            </div>

                        </div>

                    </div>

                </div>



                <!-- =================================================
                     QUICK ACTIONS
                     ================================================= -->

                <div class="dashboard-grid">


                    <div class="dashboard-panel">

                        <div class="panel-header">

                            <div class="panel-title">
                                Quick Actions
                            </div>

                        </div>


                        <div class="panel-body">

                            <div class="quick-actions">


                                <!-- MANAGE STUDENTS -->

                                <a href="ManageStudents.aspx"
                                   class="quick-action">

                                    <div class="quick-action-icon">
                                        ♙
                                    </div>


                                    <div class="quick-action-title">
                                        Manage Students
                                    </div>


                                    <div class="quick-action-text">
                                        Add and manage student records
                                    </div>

                                </a>



                                <!-- MANAGE EXAMS -->

                                <a href="ManageExams.aspx"
                                   class="quick-action">

                                    <div class="quick-action-icon">
                                        ▤
                                    </div>


                                    <div class="quick-action-title">
                                        Manage Exams
                                    </div>


                                    <div class="quick-action-text">
                                        Create and schedule examinations
                                    </div>

                                </a>



                                <!-- MANAGE HALLS -->

                                <a href="ManageHalls.aspx"
                                   class="quick-action">

                                    <div class="quick-action-icon">
                                        ⌂
                                    </div>


                                    <div class="quick-action-title">
                                        Manage Halls
                                    </div>


                                    <div class="quick-action-text">
                                        Maintain examination hall details
                                    </div>

                                </a>



                                <!-- ALLOCATE HALLS -->

                                <a href="AllocateHalls.aspx"
                                   class="quick-action">

                                    <div class="quick-action-icon">
                                        ⊞
                                    </div>


                                    <div class="quick-action-title">
                                        Allocate Halls
                                    </div>


                                    <div class="quick-action-text">
                                        Assign students to examination halls
                                    </div>

                                </a>


                            </div>

                        </div>

                    </div>


                </div>



                <!-- =================================================
                     LOGOUT
                     ================================================= -->

                <div style="margin-top:25px;
                            text-align:right;">

                    <asp:Button
                        ID="btnLogout"
                        runat="server"
                        Text="Logout"
                        CssClass="btn btn-secondary"
                        Width="100px" />

                </div>


            </section>

        </main>

    </div>

</form>

</body>

</html>