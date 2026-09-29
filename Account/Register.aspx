<%@ Page Language="VB" AutoEventWireup="false"
    CodeFile="Register.aspx.vb"
    Inherits="Account_Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Register - ExamHall</title>

    <link href="../CSS/login.css"
          rel="stylesheet"
          type="text/css" />

    <style type="text/css">

        .register-card {
            width: 520px;
            background: #ffffff;
            padding: 35px;
            border: 1px solid #e1e6ef;
        }

        .register-heading {
            margin-bottom: 25px;
        }

        .register-heading h2 {
            color: #172033;
            font-size: 25px;
            margin-bottom: 7px;
        }

        .register-heading p {
            color: #7b8799;
            font-size: 13px;
        }

        .form-row {
            width: 100%;
            overflow: hidden;
        }

        .form-half {
            width: 47%;
            float: left;
            margin-right: 5%;
        }

        .form-half.last {
            margin-right: 0;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-label {
            display: block;
            margin-bottom: 7px;
            color: #344054;
            font-size: 12px;
            font-weight: bold;
        }

        .form-input,
        .form-select {
            width: 100%;
            height: 40px;
            border: 1px solid #d5dce7;
            padding: 0 10px;
            font-size: 13px;
            color: #344054;
        }

        .form-select {
            background: #ffffff;
        }

        .register-button {
            width: 100%;
            height: 42px;
            border: none;
            background: #4f8cff;
            color: #ffffff;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 5px;
        }

        .register-button:hover {
            background: #3b78e8;
        }

        .message {
            display: block;
            margin-top: 15px;
            padding: 10px;
            font-size: 12px;
        }

        .success-message {
            background: #edf9f0;
            color: #26733a;
            border: 1px solid #b8e3c1;
        }

        .error-message {
            background: #fff0f0;
            color: #a33131;
            border: 1px solid #efb5b5;
        }

        .login-link {
            text-align: center;
            margin-top: 18px;
            font-size: 12px;
            color: #7b8799;
        }

        .login-link a {
            color: #4f8cff;
            text-decoration: none;
            font-weight: bold;
        }

        .section-title {
            font-size: 12px;
            font-weight: bold;
            color: #4f8cff;
            border-bottom: 1px solid #e5eaf1;
            padding-bottom: 8px;
            margin-bottom: 16px;
            text-transform: uppercase;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="login-page">

    <!-- LEFT PANEL -->

    <div class="login-left">

        <div class="brand-content">

            <div class="brand-icon">
                🎓
            </div>

            <div class="brand-name">
                EXAMHALL
            </div>

            <h1>
                Online Exam Hall
                <br />
                Allocation System
            </h1>

            <p>
                Create your account to access examination
                schedules, hall allocations and examination
                information.
            </p>

            <div class="feature-list">

                <div class="feature">
                    <div class="feature-icon">✓</div>
                    <span>View examination schedules</span>
                </div>

                <div class="feature">
                    <div class="feature-icon">✓</div>
                    <span>Access hall allocation details</span>
                </div>

                <div class="feature">
                    <div class="feature-icon">✓</div>
                    <span>Secure role-based access</span>
                </div>

            </div>

        </div>

    </div>


    <!-- RIGHT PANEL -->

    <div class="login-right">

        <div class="register-card">

            <div class="register-heading">

                <h2>Create Account</h2>

                <p>
                    Register to access the examination portal.
                </p>

            </div>


            <!-- BASIC DETAILS -->

            <div class="section-title">
                Account Details
            </div>


            <!-- NAME -->

            <div class="form-group">

                <asp:Label
                    ID="lblName"
                    runat="server"
                    Text="Full Name *"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="txtName"
                    runat="server"
                    CssClass="form-input">
                </asp:TextBox>

            </div>


            <!-- EMAIL -->

            <div class="form-group">

                <asp:Label
                    ID="lblEmail"
                    runat="server"
                    Text="Email Address *"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="txtEmail"
                    runat="server"
                    CssClass="form-input">
                </asp:TextBox>

            </div>


            <!-- PASSWORD -->

            <div class="form-group">

                <asp:Label
                    ID="lblPassword"
                    runat="server"
                    Text="Password *"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    TextMode="Password"
                    CssClass="form-input">
                </asp:TextBox>

            </div>


            <!-- PHONE + ROLE -->

            <div class="form-row">

                <div class="form-half">

                    <div class="form-group">

                        <asp:Label
                            ID="lblPhone"
                            runat="server"
                            Text="Phone Number"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtPhone"
                            runat="server"
                            CssClass="form-input">
                        </asp:TextBox>

                    </div>

                </div>


                <div class="form-half last">

                    <div class="form-group">

                        <asp:Label
                            ID="lblRole"
                            runat="server"
                            Text="Role *"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:DropDownList
                            ID="ddlRole"
                            runat="server"
                            CssClass="form-select"
                            AutoPostBack="True">

                            <asp:ListItem
                                Text="-- Select Role --"
                                Value="">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Student"
                                Value="Student">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Invigilator"
                                Value="Invigilator">
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>

                </div>

            </div>


            <!-- ADDRESS -->

            <div class="form-group">

                <asp:Label
                    ID="lblAddress"
                    runat="server"
                    Text="Address"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="txtAddress"
                    runat="server"
                    CssClass="form-input">
                </asp:TextBox>

            </div>


            <!-- ============================================= -->
            <!-- STUDENT DETAILS -->
            <!-- ============================================= -->

            <asp:Panel
                ID="pnlStudent"
                runat="server"
                Visible="False">

                <div class="section-title">
                    Student Details
                </div>


                <div class="form-row">

                    <div class="form-half">

                        <div class="form-group">

                            <asp:Label
                                ID="lblRegisterNumber"
                                runat="server"
                                Text="Register Number *"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtRegisterNumber"
                                runat="server"
                                CssClass="form-input">
                            </asp:TextBox>

                        </div>

                    </div>


                    <div class="form-half last">

                        <div class="form-group">

                            <asp:Label
                                ID="lblDepartment"
                                runat="server"
                                Text="Department *"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtDepartment"
                                runat="server"
                                CssClass="form-input">
                            </asp:TextBox>

                        </div>

                    </div>

                </div>


                <div class="form-row">

                    <div class="form-half">

                        <div class="form-group">

                            <asp:Label
                                ID="lblYear"
                                runat="server"
                                Text="Year *"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:DropDownList
                                ID="ddlYear"
                                runat="server"
                                CssClass="form-select">

                                <asp:ListItem
                                    Text="-- Select Year --"
                                    Value="">
                                </asp:ListItem>

                                <asp:ListItem Text="1" Value="1" />
                                <asp:ListItem Text="2" Value="2" />
                                <asp:ListItem Text="3" Value="3" />
                                <asp:ListItem Text="4" Value="4" />

                            </asp:DropDownList>

                        </div>

                    </div>


                    <div class="form-half last">

                        <div class="form-group">

                            <asp:Label
                                ID="lblSection"
                                runat="server"
                                Text="Section *"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtSection"
                                runat="server"
                                CssClass="form-input">
                            </asp:TextBox>

                        </div>

                    </div>

                </div>

            </asp:Panel>


            <!-- ============================================= -->
            <!-- INVIGILATOR DETAILS -->
            <!-- ============================================= -->

            <asp:Panel
                ID="pnlInvigilator"
                runat="server"
                Visible="False">

                <div class="section-title">
                    Invigilator Details
                </div>


                <div class="form-row">

                    <div class="form-half">

                        <div class="form-group">

                            <asp:Label
                                ID="lblInvDepartment"
                                runat="server"
                                Text="Department *"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtInvDepartment"
                                runat="server"
                                CssClass="form-input">
                            </asp:TextBox>

                        </div>

                    </div>


                    <div class="form-half last">

                        <div class="form-group">

                            <asp:Label
                                ID="lblAvailability"
                                runat="server"
                                Text="Availability"
                                CssClass="form-label">
                            </asp:Label>

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

                </div>

            </asp:Panel>


            <!-- REGISTER BUTTON -->

            <asp:Button
                ID="btnRegister"
                runat="server"
                Text="Create Account"
                CssClass="register-button">
            </asp:Button>


            <!-- MESSAGE -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message"
                Visible="False">
            </asp:Label>


            <!-- LOGIN -->

            <div class="login-link">

                Already have an account?

                <a href="Login.aspx">
                    Sign In
                </a>

            </div>

        </div>

    </div>

</div>

</form>

</body>

</html>