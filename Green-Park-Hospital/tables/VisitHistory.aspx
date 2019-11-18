<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VisitHistory.aspx.cs" Inherits="Assignment2.VisitHistory" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    <div class="content_left">
        <h1>Visit History</h1>
        <p>
        Select Doctor:
    
    &nbsp;<asp:TextBox ID="txtDoctor" runat="server"></asp:TextBox>
        
    &nbsp;<asp:Button ID="btnUpdate" runat="server" Text="Show History" />
        <asp:GridView ID="GridViewVisitHistory" runat="server" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None"
            AutoGenerateColumns="False" style="text-align: left" Font-Size="Small" AllowPaging="True">
            <Columns>
                <asp:BoundField DataField="Patient_Name" HeaderText="Patient Name" SortExpression="Patient Name" />
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
        </p>
    </div>

    <asp:AutoCompleteExtender ServiceMethod="SearchDoctor" 
        MinimumPrefixLength="0"
        CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" 
        TargetControlID="txtDoctor"
        ID="AutoCompleteExtender1" runat="server" FirstRowSelected = "false">
    </asp:AutoCompleteExtender>
</asp:Content>
