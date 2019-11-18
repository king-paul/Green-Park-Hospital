<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegUser.aspx.cs" MasterPageFile="~/Site.Master"  Inherits="Assignment2.RegUser2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <div class="GreyBox">
        <div class="reg_form" style="width:440px;">
            <table cellspacing="5" style="width: 423px">
                <tr>
                    <td colspan="3" align="center" bgcolor="#003366" style="color:#fff">Add a new user account</td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">User Name: </td>
                    <td style="width: 128px" >
                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 119px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" ErrorMessage="* Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">Password: </td>
                    <td style="width: 128px">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                    <td style="width: 119px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="* Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="height: 26px; width: 150px;">Confirm Password: </td>
                    <td style="height: 26px; width: 128px;">
                        <asp:TextBox ID="txtPasswordConfirm" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                    <td style="height: 26px; width: 119px;">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPasswordConfirm" ErrorMessage="* Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">Email Address: </td>
                    <td style="width: 128px"> <asp:TextBox ID="txtEmailAddress" runat="server" TextMode="Email"></asp:TextBox>    
                    </td>
                    <td style="width: 119px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmailAddress" ErrorMessage="* Required" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmailAddress" ErrorMessage="* Invalid" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:CustomValidator ID="UsernameValidator" runat="server" ControlToValidate="txtUserName" ErrorMessage="A User with that name already exists. Please choose another." OnServerValidate="UsernameValidator_ServerValidate" Font-Size="Small" ForeColor="Black"></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtPasswordConfirm" ErrorMessage="The password and confirmation password must match" ForeColor="Black" ValueToCompare="txtPassword.Text" Font-Size="Small"></asp:CompareValidator>
                        .</td>
                </tr>
                <tr>
                    <td colspan="3"><asp:Label ID="lblAccountCreated" runat="server" Text="The user account was created successfully" ForeColor="Black" Visible="False" Font-Size="Small"></asp:Label>.</td>
                </tr>
                <tr>
                    <td colspan="4" align="right">
                        <asp:Button ID="btnSubmit" runat="server" Text="Create User" OnClick="btnSubmit_Click" />
                    </td>
                </tr>

            </table>
        </div>
    </div>
</asp:Content>