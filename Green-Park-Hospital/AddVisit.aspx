<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddVisit.aspx.cs"
    Inherits="Assignment2.DoctorPatientInfo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <div class="GreyBox">
        <div class="form_wide">
            <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
            </asp:ToolkitScriptManager>

            <asp:AutoCompleteExtender ServiceMethod="SearchDoctor" 
                MinimumPrefixLength="0"
                CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" 
                TargetControlID="txtDoctor"
                ID="AutoCompleteExtender1" runat="server" FirstRowSelected = "false">
            </asp:AutoCompleteExtender>
            
            <asp:AutoCompleteExtender ServiceMethod="SearchPatient" 
                MinimumPrefixLength="1"
                CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" 
                TargetControlID="txtPatient"
                ID="AutoCompleteExtender2" runat="server" FirstRowSelected = "false">
            </asp:AutoCompleteExtender>

            <strong>View Treatment History</strong>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/tables/VisitHistory.aspx">Here &gt;</asp:HyperLink>
            <br />
            <table>
                <tr>
                    <td style="width: 100px; height: 29px;">Doctor Name:</td>
                    <td style="width: 180px; height: 29px;">
                        <asp:TextBox ID="txtDoctor" runat="server"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDoctor" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                    <td style="width: 100px; height: 29px;">Patient Name:</td>
                    <td style="width: 180px; height: 29px;">
                        <asp:TextBox ID="txtPatient" runat="server"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPatient" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:CheckBox ID="chkAssignToBed" runat="server" Text="Assign patient to bed" AutoPostBack="True" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 91px">Ward:</td>
                    <td style="width: 134px">
                        <asp:DropDownList ID="ddlWard" runat="server" Height="19px" Width="131px" AutoPostBack="True" Enabled="False">
                            <asp:ListItem Selected="True">General</asp:ListItem>
                            <asp:ListItem>Cardiology</asp:ListItem>
                            <asp:ListItem>Intensive Care</asp:ListItem>
                            <asp:ListItem>Maternity</asp:ListItem>
                            <asp:ListItem>Oncology</asp:ListItem>
                            <asp:ListItem>Pediatrics</asp:ListItem>
                            <asp:ListItem>Rehabilitation</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 112px">Position:</td>
                    <td style="width: 194px">
                        <asp:DropDownList ID="ddlBedNumber" runat="server" Width="80px" Enabled="False" DataSourceID="sdsBedsAvailable" DataTextField="Bed_Number" DataValueField="Bed_Number">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsBedsAvailable" runat="server" ConnectionString="<%$ ConnectionStrings:HospitalConnection %>">
                            <FilterParameters>
                                <asp:ControlParameter ControlID="ddlWard" Name="newparameter" PropertyName="SelectedValue" />
                            </FilterParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 26px"><asp:CheckBox ID="chkAddVisit" runat="server" Text="Add Sheduled Visit" ForeColor="Black" AutoPostBack="True" Enabled="False" /></td>
                    <td style="height: 26px">&nbsp;</td>
                </tr>
            
            </table>
            &nbsp;Symptoms
            <asp:TextBox ID="txtSymptoms" runat="server" Height="100px" TextMode="MultiLine" Width="832px" Font-Names="Arial" Font-Size="Medium"></asp:TextBox>
            Disease<asp:TextBox ID="txtDisease" runat="server" Font-Names="Arial" Font-Size="Medium" Height="100px" TextMode="MultiLine" Width="832px"></asp:TextBox>
            <br />
            Treatement<asp:TextBox ID="txtTreatment" runat="server" Font-Names="Arial" Font-Size="Medium" Height="100px" TextMode="MultiLine" Width="832px"></asp:TextBox>
            <br />
            <p align="center">
            <asp:Button ID="btnAddVisit" runat="server" OnClick="btnAddVisit_Click" Text="Add Visit" />
           </p>
            <p align="center">
                &nbsp;<asp:Image ID="imgInfo" runat="server" Height="16px" ImageUrl="~/images/info.gif" Visible="False" Width="16px" />
                <asp:Label ID="lblConfirmation" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#0000CC" Text="Doctor assigned to patient sucessfully." Visible="False"></asp:Label>
                &nbsp;<asp:HyperLink ID="lnkAddAnother" runat="server" NavigateUrl="~/AddVisit.aspx" Visible="False">Add Another</asp:HyperLink>
                <asp:Button ID="btnAddAnother" runat="server" OnClick="btnAddAnother_Click" PostBackUrl="~/AddVisit.aspx" Text="Add Another" Visible="False" />
            </p>
        </div><!-- end of form_wide-->
    </div><!-- end of GreyBox -->

</asp:Content>