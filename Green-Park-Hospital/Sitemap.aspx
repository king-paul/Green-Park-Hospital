<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sitemap.aspx.cs" Inherits="Assignment2.sitemap" %>


<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
    <h1>Sitemap</h1>
    <p>
        <asp:TreeView ID="TreeView1" runat="server" DataSourceID="SiteMapDataSource1">
        </asp:TreeView>
        <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
        
    </p>
</asp:Content>