<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DischargePatient.aspx.cs" Inherits="Assignment2.DischargePatient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <h5 align="center">
    Below is a list of patients currently in beds</h5>
    <p align="center">
    <asp:GridView ID="GridViewDischargePatient" runat="server" AllowPaging="True" AutoGenerateColumns="False" AutoGenerateSelectButton="True" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" DataSourceID="SqlDataSource1" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowSorting="True" PageSize="15">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Ward Type" HeaderText="Ward Type" SortExpression="Ward Type" />
            <asp:BoundField DataField="Bed Number" HeaderText="Bed Number" SortExpression="Bed Number" />
            <asp:BoundField DataField="Rate Per Day" HeaderText="Rate Per Day" SortExpression="Rate Per Day" />
            <asp:BoundField DataField="Date Of Admission" HeaderText="Date Of Admission" SortExpression="Date Of Admission" DataFormatString="{0:d}" />
            <asp:BoundField DataField="Days In" HeaderText="Days In" ReadOnly="True" SortExpression="Days In" />
            <asp:BoundField DataField="Amount Payable" HeaderText="Amount Payable" ReadOnly="True" SortExpression="Amount Payable" DataFormatString="${0:#,#}" />
        </Columns>
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
    <p align="center">
    
    <asp:Button ID="btnDischarge" runat="server" OnClick="btnDischarge_Click" Text="Discharge Selected Patient" Enabled="False" />
        <br />
        <asp:Label ID="lblErrorMassage" runat="server" Font-Bold="True" Text="Unfortunately there was an error processing your request. The following error message has been generated." Visible="False"></asp:Label>
        <br />
        <asp:Label ID="lblException" runat="server"></asp:Label>
    </p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=localhost;Initial Catalog=&quot;Assignment 2 - Hospital&quot;;Integrated Security=True;MultipleActiveResultSets=True;Application Name=EntityFramework" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [InBedView]"></asp:SqlDataSource>

</asp:Content>