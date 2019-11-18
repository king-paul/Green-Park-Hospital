<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Assignment2._default" %>

<asp:Content ID="content1" ContentPlaceHolderID="SiteBody" runat="server">
    <div class="content_middle">
        <img src="images/doctors-image.jpg" alt="Doctors Photo" width="640" height="292" />
    </div>
    <div class="content_left">      
        <h2>General Information</h2>
        <p>The Green Park Hospital is a modern facility situated clost to parkland and public transport. It also has ample parking. It caters for maternity, pediatrics as well as Cardiologoy and Gaeneral Surgery. The Quiet surrounds also make it suitable for rehabilitation patients. There are up to date operating theatre and Intensive Care unit with all the latest equipment. This hospital also accepts emergency patients.</p>
        <h2>How to use this system</h2>
        <p>If you are not already logged in you will need to be in order to access the . This can be done by click the login link at the top righ-hand corner of the page. One logged in you will have access to the following pages.</p>
        <h3>View database</h3>
        <p>This link will take you to the section where you can view all the records in the database through tables. Tables are split into 4 categories</p>
        <ul>
            <li>Patients</li>
            <li>Doctors</li>
            <li>Beds</li>
            <li>Visits</li>
        </ul>
        <h3>Patient Registration</h3>
        <p>This page allows you add a new patient registration. The patient can also be assign to a free bed during registraion. Once all of the Details of a patient are filled out it they will be added to the patient list.
           The name of that patient will also appear on the bed list if they have been assigned to one.
        </p>
        <h3>Discharge</h3>
        <p>This page shows a list of all in patients currently ocuupying one of the hospital's beds and how much is currently payable upon discharge. Patients can also be discharged on this page and doing so will take you to the invoice page, where payment can be made via credit card.</p>
    </div>
    <div class="content_right">
        <h2><img name="" src="images/hospital_front.jpg" width="250" height="166" alt="" />
        </h2>
        <h2>
            <asp:Calendar ID="Calendar1" runat="server" BackColor="#FFFFCC" BorderColor="#FFCC66" BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" Height="247px" ShowGridLines="True" Width="262px">
                <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="6px" />
                <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                <OtherMonthDayStyle ForeColor="#CC9966" />
                <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                <SelectorStyle BackColor="#FFCC66" />
                <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
            </asp:Calendar>
        </h2>
    </div>
</asp:Content>