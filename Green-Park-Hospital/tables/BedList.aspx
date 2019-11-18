<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BedList.aspx.cs" Inherits="Assignment2.BedList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsBeds" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="2" CellSpacing="1" GridLines="None" AllowPaging="True" style="text-align: left" CssClass="content_middle" PageSize="20" AutoGenerateColumns="False" Font-Size="Small">
        <Columns>
            <asp:BoundField DataField="Ward Type" HeaderText="Ward Type" SortExpression="Ward Type" />
            <asp:BoundField DataField="Number" HeaderText="Number" SortExpression="Number" />
            <asp:BoundField DataField="Rate Per Day" HeaderText="Rate Per Day" SortExpression="Rate Per Day" />
            <asp:BoundField DataField="Occupied By" HeaderText="Occupied By" SortExpression="Occupied By" />
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
    <asp:SqlDataSource ID="sdsBeds" runat="server" ConnectionString="<%$ ConnectionStrings:HospitalConnection %>" SelectCommand="SELECT * FROM [BedView]"></asp:SqlDataSource>
</asp:Content>