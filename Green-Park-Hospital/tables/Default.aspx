<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Assignment2.tables._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SiteBody" runat="server">
        <h1 align="center">Select which table you wish to view</h1>
            <table align="center" cellpadding="50" cellspacing="0" class="icon_label">
                <tr>
                    <td align="center">
                        <a href="PatientList.aspx"><img alt="" src="/images/icons/patient_large.png" style="width: 128px; height: 128px" /><br />
                        Patients</a>
                        </td>
                    <td align="center">
                        <a href="DoctorList.aspx">
                        <img alt="" src="../images/icons/doctor_large.png" style="width: 128px; height: 128px" /><br />
                        Doctors</a>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <a href="BedList.aspx">
                        <img alt="" src="/images/icons/medical-bed_large.png" style="width: 128px; height: 128px" /><br />
                        Beds</a>
                    </td>
                    <td align="center">
                        <a href="VisitList.aspx">
                        <img alt="" src="/images/icons/medical-report_large.png" style="width: 128px; height: 128px" /><br />
                        Visits</a>
                    </td>
                </tr>
            </table>
    </asp:Content>