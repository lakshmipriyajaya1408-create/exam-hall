<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MySQL Connection Test</title>
</head>

<body>

    <form id="form1" runat="server">

        <div style="text-align:center; margin-top:100px;">

            <h1>Online Exam Hall Allocation System</h1>

            <h2>MySQL Database Connection Test</h2>

            <asp:Button ID="btnTestConnection"
                        runat="server"
                        Text="Test MySQL Connection"
                        Width="200px"
                        Height="40px" />

            <br /><br />

            <asp:Label ID="lblMessage"
                       runat="server"
                       Font-Size="Large">
            </asp:Label>

        </div>

    </form>

</body>
</html>