<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VisitList.aspx.cs" Inherits="Assignment2.PatientVisit" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
            </asp:ToolkitScriptManager>
    <h1>History Of Visits</h1>
    <div style="margin:10px;">
        <h2><strong>            
            Filters</strong></h2>
        <strong>Patient
        Name:</strong>
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        &nbsp;<span style="font-size:x-small;">(Include comma(,) if typing in full name)</span>
                <br />
                <strong>Date (dd/mm/yyyy): </strong>Between
        <asp:TextBox ID="txtDateStart" runat="server" Width="100px"></asp:TextBox>
        <asp:CalendarExtender ID="txtDateStart_CalendarExtender" runat="server" Enabled="True" TargetControlID="txtDateStart">
        </asp:CalendarExtender>
        &nbsp;and&nbsp;
        <asp:TextBox ID="txtDateEnd" runat="server" Width="100px"></asp:TextBox>
        <asp:CalendarExtender ID="txtDateEnd_CalendarExtender" runat="server" Enabled="True" TargetControlID="txtDateEnd">
        </asp:CalendarExtender>
        &nbsp;in 
        <asp:RadioButtonList ID="rblDateType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem Selected="True">Visit</asp:ListItem>
            <asp:ListItem>Discharge</asp:ListItem>
        </asp:RadioButtonList>
        <br />
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    </div>
    <asp:GridView ID="GridViewVisits" runat="server" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None"
        AutoGenerateColumns="False" style="text-align: left" Font-Size="Small" AllowPaging="True" OnPageIndexChanging="GridViewVisits_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="Patient_Name" HeaderText="Patient Name" SortExpression="Patient Name" />
            <asp:BoundField DataField="Doctor_Name" HeaderText="Doctor Name" SortExpression="Doctor Name" />
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblStatus" OnDataBinding="lblStatus_DataBinding" />
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:BoundField DataField="Date_Of_Visit" HeaderText="Date Of Visit" SortExpression="Date Of Visit" />
            <asp:BoundField DataField="Date_Of_Discharge" HeaderText="Date Of Discharge" SortExpression="Date Of Discharge" />
            <asp:BoundField DataField="Symptoms" HeaderText="Symptoms" SortExpression="Symptoms" />
            <asp:BoundField DataField="Disease" HeaderText="Disease" SortExpression="Disease" />
            <asp:BoundField DataField="Treatment" HeaderText="Treatment" SortExpression="Treatment" />
        </Columns>
        <EmptyDataTemplate>There were no records found matching your Criteria.</EmptyDataTemplate>
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#594B9C" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#33276A" />
    </asp:GridView>
</asp:Content>