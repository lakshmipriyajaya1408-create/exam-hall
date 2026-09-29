<%@ Page Language="VB"
    AutoEventWireup="false"
    CodeFile="AddStudent.aspx.vb"
    Inherits="Admin_AddStudent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Add Student - ExamHall</title>

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
               class="nav-item">

                <span class="nav-icon">▦</span>
                <span>Dashboard</span>

            </a>


            <a href="ManageStudents.aspx"
               class="nav-item active">

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

        </nav>

    </aside>



    <!-- =====================================================
         MAIN CONTENT
         ===================================================== -->

    <main class="dashboard-main">


        <!-- TOP BAR -->

        <header class="topbar">

            <div class="topbar-title">
                Add Student
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

                        <div class="user-role">
                            Administrator
                        </div>

                    </div>

                </div>

            </div>

        </header>



        <!-- =================================================
             CONTENT
             ================================================= -->

        <section class="dashboard-content">


            <div class="welcome-section">

                <div class="welcome-title">
                    Add New Student
                </div>

                <div class="welcome-subtitle">
                    Create a student account and examination profile.
                </div>

            </div>


            <!-- MESSAGE -->

            <asp:Label ID="lblMessage"
                       runat="server"
                       CssClass="alert">
            </asp:Label>


            <!-- FORM -->

            <div class="card">


                <div class="card-title">
                    Student Information
                </div>

                <div class="card-subtitle"
                     style="margin-bottom:25px;">

                    Enter the student's personal and academic details.

                </div>


                <div class="form-grid">


                    <!-- NAME -->

                    <div class="form-group">

                        <asp:Label ID="lblName"
                                   runat="server"
                                   Text="Full Name"
                                   CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox ID="txtName"
                                     runat="server"
                                     CssClass="form-control">
                        </asp:TextBox>

                    </div>


                    <!-- REGISTER NUMBER -->

                    <div class="form-group">

                        <asp:Label ID="lblRegisterNumber"
                                   runat="server"
                                   Text="Register Number"
                                   CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox ID="txtRegisterNumber"
                                     runat="server"
                                     CssClass="form-control">
                        </asp:TextBox>

                    </div>


                    <!-- EMAIL -->

                    <div class="form-group">

                        <asp:Label ID="lblEmail"
                                   runat="server"
                                   Text="Email Address"
                                   CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox ID="txtEmail"
                                     runat="server"
                                     CssClass="form-control">
                        </asp:TextBox>

                    </div>


                    <!-- PHONE -->

                    <div class="form-group">

                        <asp:Label ID="lblPhone"
                                   runat="server"
                                   Text="Phone Number"
                                   CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox ID="txtPhone"
                                     runat="server"
                                     CssClass="form-control">
                        </asp:TextBox>

                    </div>


                    <!-- PASSWORD -->

                    <div class="form-group">

                        <asp:Label ID="lblPassword"
                                   runat="server"
                                   Text="Password"
                                   CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox ID="txtPassword"
                                     runat="server"
                                     TextMode="Password"
                                     CssClass="form-control">
                        </asp:TextBox>

                    </div>


                    <!-- DEPARTMENT -->

                    <div class="form-group">

                        <asp:Label ID="lblDepartment"
                                   runat="server"
                                   Text="Department"
                                   CssClass="form-label">
                        </asp:Label>

                        <asp:DropDownList ID="ddlDepartment"
                                          runat="server"
                                          CssClass="form-control">

                            <asp:ListItem Value="">
                                Select Department
                            </asp:ListItem>

                            <asp:ListItem Value="CSE">
                                Computer Science &amp; Engineering
                            </asp:ListItem>

                            <asp:ListItem Value="IT">
                                Information Technology
                            </asp:ListItem>

                            <asp:ListItem Value="ECE">
                                Electronics &amp; Communication
                            </asp:ListItem>

                            <asp:ListItem Value="EEE">
                                Electrical &amp; Electronics
                            </asp:ListItem>

                            <asp:ListItem Value="MECH">
                                Mechanical Engineering
                            </asp:ListItem>

                            <asp:ListItem Value="CIVIL">
                                Civil Engineering
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>


                    <!-- YEAR -->

                    <div class="form-group">

                        <asp:Label ID="lblYear"
                                   runat="server"
                                   Text="Year"
                                   CssClass="form-label">
                        </asp:Label>

                      <asp:DropDownList
    ID="ddlYear"
    runat="server"
    CssClass="form-input">

    <asp:ListItem Text="Select Year" Value=""></asp:ListItem>
    <asp:ListItem Text="I Year" Value="1"></asp:ListItem>
    <asp:ListItem Text="II Year" Value="2"></asp:ListItem>
    <asp:ListItem Text="III Year" Value="3"></asp:ListItem>
    <asp:ListItem Text="IV Year" Value="4"></asp:ListItem>

</asp:DropDownList>

                    </div>


                    <!-- SECTION -->

                    <div class="form-group">

                        <asp:Label ID="lblSection"
                                   runat="server"
                                   Text="Section"
                                   CssClass="form-label">
                        </asp:Label>

                        <asp:DropDownList
    ID="ddlSection"
    runat="server"
    CssClass="form-input">

    <asp:ListItem Text="Select Section" Value=""></asp:ListItem>
    <asp:ListItem Text="Section A" Value="A"></asp:ListItem>
    <asp:ListItem Text="Section B" Value="B"></asp:ListItem>
    <asp:ListItem Text="Section C" Value="C"></asp:ListItem>
    <asp:ListItem Text="Section D" Value="D"></asp:ListItem>

</asp:DropDownList>
                     

                    </div>


                    <!-- ADDRESS -->

                    <div class="form-group"
                         style="grid-column:1 / -1;">

                        <asp:Label ID="lblAddress"
                                   runat="server"
                                   Text="Address"
                                   CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox ID="txtAddress"
                                     runat="server"
                                     TextMode="MultiLine"
                                     CssClass="form-control"
                                     Rows="4">
                        </asp:TextBox>

                    </div>


                </div>


                <!-- FORM ACTIONS -->

                <div class="form-actions">

                    <asp:Button ID="btnSave"
                                runat="server"
                                Text="Save Student"
                                CssClass="btn btn-primary" />


                    <asp:Button ID="btnCancel"
                                runat="server"
                                Text="Cancel"
                                CssClass="btn btn-secondary"
                                CausesValidation="False" />

                </div>


            </div>


        </section>

    </main>

</div>

</form>

</body>

</html>