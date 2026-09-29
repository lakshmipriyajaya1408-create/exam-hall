<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChangePassword.aspx.vb" Inherits="Account_ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Change Password - Exam Allocation</title>

    <style type="text/css">
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f6fa;
            color: #172033;
        }

        .page {
            width: 100%;
            min-height: 100vh;
        }

        .header {
            background: #162033;
            color: #ffffff;
            padding: 22px 35px;
        }

        .header h1 {
            margin: 0;
            font-size: 23px;
        }

        .header p {
            margin: 6px 0 0;
            color: #aab6ca;
            font-size: 13px;
        }

        .container {
            width: 520px;
            margin: 55px auto;
        }

        .card {
            background: #ffffff;
            border: 1px solid #dce2eb;
        }

        .card-header {
            padding: 23px;
            border-bottom: 1px solid #e3e7ee;
        }

        .card-header h2 {
            margin: 0;
            font-size: 20px;
        }

        .card-header p {
            margin: 7px 0 0;
            color: #75839a;
            font-size: 13px;
        }

        .form-area {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 19px;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-size: 13px;
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 11px;
            border: 1px solid #cfd6e1;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
        }

        .form-control:focus {
            border-color: #3f8cff;
            outline: none;
        }

        .button {
            display: inline-block;
            padding: 11px 20px;
            border: none;
            background: #172033;
            color: #ffffff;
            font-weight: bold;
            font-size: 13px;
            cursor: pointer;
        }

        .button:hover {
            background: #24324b;
        }

        .back {
            display: inline-block;
            margin-left: 10px;
            padding: 11px 20px;
            background: #e8edf4;
            color: #172033;
            text-decoration: none;
            font-size: 13px;
        }

        .message-success {
            display: block;
            padding: 11px;
            margin-bottom: 18px;
            background: #e5f6ec;
            border: 1px solid #b9e3c8;
            color: #15803d;
            font-size: 13px;
        }

        .message-error {
            display: block;
            padding: 11px;
            margin-bottom: 18px;
            background: #fdecec;
            border: 1px solid #f2c1c1;
            color: #b42318;
            font-size: 13px;
        }

        .footer {
            text-align: center;
            color: #8a96aa;
            font-size: 11px;
            margin-top: 30px;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="page">

            <div class="header">
                <h1>Exam Allocation</h1>
                <p>Online Exam Hall Allocation System</p>
            </div>

            <div class="container">

                <div class="card">

                    <div class="card-header">
                        <h2>Change Password</h2>
                        <p>Update your account password securely.</p>
                    </div>

                    <div class="form-area">

                        <asp:Label
                            ID="lblMessage"
                            runat="server">
                        </asp:Label>

                        <div class="form-group">

                            <asp:Label
                                ID="lblCurrentPassword"
                                runat="server"
                                Text="Current Password">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtCurrentPassword"
                                runat="server"
                                TextMode="Password"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>

                        <div class="form-group">

                            <asp:Label
                                ID="lblNewPassword"
                                runat="server"
                                Text="New Password">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtNewPassword"
                                runat="server"
                                TextMode="Password"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>

                        <div class="form-group">

                            <asp:Label
                                ID="lblConfirmPassword"
                                runat="server"
                                Text="Confirm New Password">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtConfirmPassword"
                                runat="server"
                                TextMode="Password"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>

                        <asp:Button
                            ID="btnChangePassword"
                            runat="server"
                            Text="Change Password"
                            CssClass="button" />

                        <asp:HyperLink
                            ID="lnkBack"
                            runat="server"
                            NavigateUrl="../Account/Login.aspx"
                            CssClass="back"
                            Text="Back to Login">
                        </asp:HyperLink>

                    </div>

                </div>

                <div class="footer">
                    Online Exam Hall Allocation System
                </div>

            </div>

        </div>

    </form>

</body>
</html>
