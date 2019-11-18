<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegPatient.aspx.cs" Inherits="Assignment2.RegPatient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <div class="GreyBox">
    <div class="reg_form">
         <table width="100%">
            <tr>
                <td colspan="4" align="center" bgcolor="#003366" style="color:#fff">
                Patient Registration
                </td>
            </tr>
         </table>
        <div id="regForm" runat="server">                        
            <table cellspacing="5" width="100%">
                <tr>
                    <td colspan="2">Names</td>
                </tr>
                <tr>
                    <td class="label">First<span>*</span></td>
                    <td style="width: 254px" ><asp:TextBox ID="txtFirstname" runat="server" Width="250px"></asp:TextBox></td>                         
                    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="txtFirstname"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="label">Last<span>*</span></td>
                    <td style="width: 254px" ><asp:TextBox ID="txtLastName" runat="server" Width="250px"></asp:TextBox></td>
                    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ControlToValidate="txtLastName"></asp:RequiredFieldValidator></td>
                </tr>         
                </table>

        <hr />
        <table>
            <tr>
                <td class="label"">Date Of Birth<span>*</span></td>
                <td>
                    &nbsp;Day:
                    <asp:TextBox ID="txtDay" runat="server" Width="50px"></asp:TextBox>
    &nbsp;Month: <asp:TextBox ID="txtMonth" runat="server" Width="49px"></asp:TextBox>
    &nbsp;Year: <asp:TextBox ID="txtYear" runat="server" Width="43px"></asp:TextBox>
                    <asp:CustomValidator ID="DateValidator" runat="server" ErrorMessage="Invalid Date Entered" OnServerValidate="DateValidator_ServerValidate"></asp:CustomValidator>
                </td>
            </tr>
   
        </table>
        <hr />

            <table cellspacing="5" style="width: 650px">
                <tr>
                    <td colspan="4">Address</td>  
                </tr>
                <tr>
                    <td class="label">Street Address<span>*</span></td> 
                    <td style="width: 231px"><asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="StreetAddressValidator" runat="server" ControlToValidate="txtAddress" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </td>
                    <td class="label" style="width: 89px">City<span>*</span></td> 
                    <td style="width: 183px"><asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="CityValidator" runat="server" ControlToValidate="txtCity" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </td>         
                </tr>
                <tr>
                    <td class="label">State<span>*</span></td> 
                    <td style="width: 231px"><asp:TextBox ID="txtRegion" runat="server"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="RegionValidator" runat="server" ControlToValidate="txtRegion" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </td>
                    <td class="label" style="width: 89px">Country<span>*</span></td> 
                    <td style="width: 183px">
                        <asp:DropDownList ID="CountryList" runat="server" DataSourceID="CountryXmlData" DataTextField="countryName" DataValueField="countryName">
                        </asp:DropDownList>
                        &nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td class="label">Post/Zip Code<span>*</span></td> 
                    <td style="width: 231px"><asp:TextBox ID="txtPostCode" runat="server"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="PostCodeValidator" runat="server" ControlToValidate="txtPostCode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="PostCodeExpressionValidator" runat="server" ControlToValidate="txtPostCode" ErrorMessage="Invalid" ValidationExpression="^([0-9]+-)*[0-9]+$"></asp:RegularExpressionValidator>
                    </td>
                    <td colspan="2">
                        <asp:XmlDataSource ID="CountryXmlData" runat="server" DataFile="xml/countries.xml"></asp:XmlDataSource>
                    </td>
                </tr>
            </table>
        <hr />
            <table cellspacing="5">
                <tr>
                    <td colspan="2">Phone Number</td>
                </tr>
                <tr>
                    <td class="label">Home/Work<span>*</span></td>
                    <td><asp:TextBox ID="txtHomeNumber" runat="server"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator ID="HomePhoneEmptyValidator" runat="server" ControlToValidate="txtHomeNumber" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="ContactNumberRegularExpressionValidator1" runat="server" ControlToValidate="txtHomeNumber" ErrorMessage="Invalid" ValidationExpression="(\d{3}-\d{2}-\d{4}|\(\d{2}\)\s?\d{4}\s?\d{4}|(\d{2})?\s?\d{4}\s?\d{4})"></asp:RegularExpressionValidator>
                    </td> 
                </tr>
                <tr>
                    <td class="label">Mobile</td>
                    <td><asp:TextBox ID="txtMobileNumber" runat="server"></asp:TextBox>&nbsp;<asp:RegularExpressionValidator ID="MobilePhoneRegularExpressionValidator" runat="server" ControlToValidate="txtMobileNumber" ErrorMessage="Invalid" ValidationExpression="(\d{3}-\d{2}-\d{4}|\(\d{2}\)\s?\d{4}\s?\d{4}|(\d{2})?\s?\d{4}\s?\d{4})"></asp:RegularExpressionValidator>
                    </td>
                </tr>
            </table>        
        <hr />
            <table cellspacing="5" >
                <tr>
                    <td colspan="4">Emergency Contact Details</td>
                </tr>
                <tr>
                    <td colspan="4" >Name</td>
                </tr>
                <tr>
                    <td class="label">First</td>
                    <td><asp:TextBox ID="txtEmergencyFirstName" runat="server"></asp:TextBox>&nbsp;</td>
                    <td class="label">Last</td>
                    <td><asp:TextBox ID="txtEmergencyLastName" runat="server"></asp:TextBox>&nbsp;</td>
                </tr>
                <tr>
                    <td class="label">Contact Number</td>
                        &nbsp;<td><asp:TextBox ID="txtEmergencyNumber" runat="server"></asp:TextBox></td>
                    <td colspan="2"> <asp:RegularExpressionValidator ID="ContactNumberRegularExpressionValidator0" runat="server" ControlToValidate="txtEmergencyNumber" ErrorMessage="Invalid" ValidationExpression="(\d{3}-\d{2}-\d{4}|\(\d{2}\)\s?\d{4}\s?\d{4}|(\d{2})?\s?\d{4}\s?\d{4})"></asp:RegularExpressionValidator></td>
                </tr>
            </table> 
           
        <div align="center">
        <asp:Button ID="btnSubmit" runat="server" Text="Submit Registration" OnClick="btnSubmit_Click" /> 
            <br />
            <br />
        </div>
   </div> <!-- end of regForm -->
         <div id="regConfirm" runat="server" align="center">
             <table>
                 <tr>
                     <td><asp:Image ID="imgInfo" runat="server" Height="32px" ImageUrl="~/images/info.gif" Width="32px" /></td>
                     <td style="width: 394px">
                         <asp:Label ID="lblConfirmation" runat="server" Text="The New Patient has been succesfully added to the Database" Font-Size="Small" ForeColor="Black"></asp:Label>
                         <br />
                         <asp:HyperLink ID="linkGoBack" runat="server" NavigateUrl="~/default.aspx" Font-Underline="False" Font-Size="Small">Return To Home Page &gt;</asp:HyperLink>
                     </td>
                 </tr>
             </table> 
            </div>

        </div><!-- end of registration form-->
    </div><!-- end of greybox-->
</asp:Content>