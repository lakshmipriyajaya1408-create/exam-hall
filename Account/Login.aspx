<%@ Page Language="VB" AutoEventWireup="false"
    CodeFile="Login.aspx.vb"
    Inherits="Account_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Login - ExamHall</title>

    <link href="../CSS/login.css"
          rel="stylesheet"
          type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <div class="login-page">

        <!-- =================================================
             LEFT BRANDING PANEL
             ================================================= -->

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
                    A centralized platform for managing examinations,
                    allocating examination halls, organizing students
                    and coordinating invigilators efficiently.
                </p>

                <div class="feature-list">

                    <div class="feature">

                        <div class="feature-icon">
                            ✓
                        </div>

                        <span>
                            Simple examination management
                        </span>

                    </div>

                    <div class="feature">

                        <div class="feature-icon">
                            ✓
                        </div>

                        <span>
                            Organized hall allocation
                        </span>

                    </div>

                    <div class="feature">

                        <div class="feature-icon">
                            ✓
                        </div>

                        <span>
                            Secure role-based access
                        </span>

                    </div>

                </div>

            </div>

        </div>


        <!-- =================================================
             RIGHT LOGIN PANEL
             ================================================= -->

        <div class="login-right">

            <div class="login-card">

                <div class="login-heading">

                    <h2>
                        Welcome Back
                    </h2>

                    <p>
                        Sign in to access your examination portal.
                    </p>

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
                                 CssClass="form-input"
                                 placeholder="Enter your email address">
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
                                 CssClass="form-input"
                                 placeholder="Enter your password">
                    </asp:TextBox>

                </div>


                <!-- LOGIN BUTTON -->

                <asp:Button ID="btnLogin"
                            runat="server"
                            Text="Sign In"
                            CssClass="login-button" />


                <!-- MESSAGE -->

                <asp:Label ID="lblMessage"
                           runat="server"
                           CssClass="message">
                </asp:Label>


                <!-- SECURITY NOTE -->

                <div class="security-note">

                    🔒 Secure access to your examination portal

                </div>


                <!-- FOOTER -->

                <div class="login-footer">

                    <strong>EXAMHALL</strong>
                    <br />
                    Online Examination Management System

                </div>

            </div>

        </div>

    </div>

</form>

</body>

</html>