<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DoctorList.aspx.cs" Inherits="Assignment2.DoctorsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">    
    <div align="center">
        <h1>Doctors</h1>
        <asp:GridView ID="GridViewDcotor" runat="server" DataSourceID="sdsDoctors" AllowPaging="True" PageSize="15" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None">
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
    </div>  
    <asp:SqlDataSource ID="sdsDoctors" runat="server" ConnectionString="<%$ ConnectionStrings:HospitalConnection %>">
    </asp:SqlDataSource>
</asp:Content>