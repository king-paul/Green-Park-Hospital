<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Assignment2.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <div class="GreyBox">
        <table class="reg_form" cellspacing="10" style="width:400px;">
            <tr>
                <td colspan="3" align="center" bgcolor="#003366" style="color:#fff">User Login</td>
            </tr>
            <tr>
                <td align="right" width="33%">Username: </td>
                <td><asp:TextBox ID="txtUsername" runat="server" Width="128px" /></td>
                <td width="33%">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">Password:</td>
                <td><asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="128px" /></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Label ID="lblLoginFail" runat="server" Font-Names="Verdana" ForeColor="Black" Text="Login was not successful. Please check the username and password." Visible="False" Font-Size="Small"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="right"><asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" Width="76px" /></td>
            </tr>
        </table>
    </div>    
</asp:Content>