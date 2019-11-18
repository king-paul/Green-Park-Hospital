<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="Assignment2.Invoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <script type="text/javascript" src="script/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="script/ccvalidate.js"></script>

    <h1 align="center">Invoice</h1>
    <div class="content_full">
        <h5>The following patient has been discharged from the hospital.</h5>

        <table border="1" cellspacing="0">
            <tr>
                <td><strong>Name: </strong> </td>
                <td colspan="4">
                    <asp:Label ID="lblName" runat="server" ForeColor="Black"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 24px"><strong>Ward: </strong> </td>
                <td width="100" style="height: 24px">
                    <asp:Label ID="lblWard" runat="server" ForeColor="Black"></asp:Label>
                </td>
                <td style="width: 141px; height: 24px;"><strong>Position: </strong> </td>
                <td style="width: 100px; height: 24px;">
                    <asp:Label ID="lblBedNumber" runat="server" ForeColor="Black"></asp:Label>
                </td>
            </tr>
            <tr>
                <td><strong>Date In: </strong> </td>
                <td width="100">
                    <asp:Label ID="lblDateIn" runat="server" ForeColor="Black"></asp:Label>
                </td>
                <td style="width: 141px"><strong>Date of Discharge:</strong> </td>
                <td style="width: 100px">
                    <asp:Label ID="lblDateOfDischarge" runat="server" ForeColor="Black"></asp:Label>
                </td>
            </tr>
            <tr>
                <td><strong>Days in:</strong></td>
                <td width="100">
                    <asp:Label ID="lblDaysIn" runat="server" ForeColor="Black"></asp:Label>
                </td>
                    <td style="width: 141px"><strong>Rate Per Day: </strong> </td>
                <td style="width: 100px">$<asp:Label ID="lblRatePerDay" runat="server" ForeColor="Black"></asp:Label>
                </td>
            </tr>
            <tr>
                <td><strong>Total Cost:</strong> </td>
                <td colspan="4">$<asp:Label ID="lblTotalCost" runat="server" ForeColor="Black"></asp:Label>
                </td>
            </tr>
        </table>
    </div>

    <div class="reg_form" id="paymentSection" runat="server">
        <table cellspacing="0">
            <tr>
                <td style="width: 96px">Card Type: </td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlCardType" runat="server"  class="CardType">
                        <asp:ListItem Value="mcd">Master Card</asp:ListItem>
                        <asp:ListItem Value="vis">Visa Card</asp:ListItem>
                        <asp:ListItem Value="amx">American Express</asp:ListItem>
                        <asp:ListItem Value="dnr">Dinner Club</asp:ListItem>
                        <asp:ListItem Value="dis">Discover</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 96px">Name: </td>
                <td colspan="7">
                    <asp:TextBox ID="txtCardName" runat="server" Width="270px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtCardName"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 96px; height: 27px;">Number: </td>
                <td colspan="7" style="height: 27px">
                    <asp:TextBox ID="txtCardNumber" runat="server" class="CardNumber" Width="270px"></asp:TextBox>
                &nbsp;
                    <label id="lblInvalidNumber"></label>
                </td>
            </tr>

            <tr>
                <td style="width: 96px;">Expiry Date:</td>
                <td style="width: 62px;">
                    <asp:TextBox ID="txtYear" runat="server" width="40px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtYear"></asp:RequiredFieldValidator>
                </td>
                <td>CVN:</td>
                <td style="width: 103px">
                    <asp:TextBox ID="txtCVN" runat="server" MaxLength="3" Width="40px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="txtCVN"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td colspan="5" align="center" style="height: 30px">
                    <asp:Button ID="btnConfirm" runat="server" Text="Confirm Payment" class="submitPayment" OnClick="btnConfirm_Click"/>
                </td>
            </tr>
        </table>

    </div>

    <div id="paymentConfirmation" runat="server">
        <h5>You payment for this discharge has been successful.</h5>
    </div>

    <a href="DischargePatient.aspx">&lt; Retrun To Discharge List</a>

</asp:Content>