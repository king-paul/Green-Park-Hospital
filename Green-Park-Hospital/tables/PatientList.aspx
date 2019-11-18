<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PatientList.aspx.cs" Inherits="Assignment2.PatientList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    Patient Name:
    <asp:TextBox ID="txtSearchName" runat="server" Width="168px"></asp:TextBox>
    &nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" />
    &nbsp;<span style="font-size:x-small;">(Include comma(,) if typing in full name)</span>
    <br />
    &nbsp;<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="White"
        BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" DataSourceID="sdsSearchName" GridLines="None"
        AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Date_Of_Birth" HeaderText="Date Of Birth" SortExpression="Date_Of_Birth" DataFormatString="{0:d}"  />
            <asp:BoundField DataField="Address" HeaderText="Home Address" SortExpression="Address" />
            <asp:BoundField DataField="phone_home" HeaderText="Phone (Home/Work)" SortExpression="phone_home" />
            <asp:BoundField DataField="phone_mobile" HeaderText="Phone (Mobile)" SortExpression="phone_mobile" />
            <asp:BoundField DataField="Emerg_Contact_Name" HeaderText="Emerg. Contact (Name)" SortExpression="Emerg_Contact_Name" />
            <asp:BoundField DataField="Emerg_Contact_Number" HeaderText="Emerg. Contact (Number)" SortExpression="Emerg_Contact_Number" />
            <asp:BoundField DataField="Date_Of_Registration" HeaderText="Date Of Registration" SortExpression="Date_Of_Registration" DataFormatString="{0:d}" />            
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
    <asp:SqlDataSource ID="sdsSearchName" runat="server" ConnectionString="<%$ ConnectionStrings:HospitalConnection %>" 
        SelectCommand="SELECT PatientID AS ID, [Name], [Date Of Birth] AS Date_Of_Birth, [Address], [Phone (Home_Work)] AS phone_home, [Phone(Mobile)] AS phone_mobile, [Emerg Contact (Name)] AS Emerg_Contact_Name, [Emerg Contact (Number)] AS Emerg_Contact_Number, [Date Of Registration] AS Date_Of_Registration FROM [Patient]" ProviderName="System.Data.SqlClient" >
        <FilterParameters>
            <asp:ControlParameter ControlID="txtSearchName" Name="newparameter" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>

</asp:Content>
