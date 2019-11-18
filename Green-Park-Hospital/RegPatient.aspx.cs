using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

// additonal namespaces
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

using Assignment2.models;

namespace Assignment2
{
    public partial class RegPatient : System.Web.UI.Page
    {
        private string name, address, phoneHome, phoneMobile, emergContactName, emergContactNumber;
        private DateTime dateOfBirth;

        protected void Page_Load(object sender, EventArgs e)
        {
            regConfirm.Visible = false;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // create new sql connection
            SqlConnection HospitalDB =
            new SqlConnection("server=localhost;Integrated Security=True;database=Assignment 2 - Hospital");

            updateTableVariables();

            SqlCommand command = new SqlCommand("RegisterPatient", HospitalDB);

            command.CommandType = CommandType.StoredProcedure;

            // Add values to new record in Patient table
            command.Parameters.AddWithValue("@Name", name);
            command.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
            command.Parameters.AddWithValue("@Address", address);
            command.Parameters.AddWithValue("@NumberHome", phoneHome);
            command.Parameters.AddWithValue("@NumberMobile", phoneMobile);
            command.Parameters.AddWithValue("@EmergContactName", emergContactName);
            command.Parameters.AddWithValue("@EmergContactNumber", emergContactNumber);
            command.Parameters.AddWithValue("@DateOfRegistration", DateTime.Now);

            // link the command to the sql connection object
            command.Connection = HospitalDB;

            HospitalDB.Open(); // open the connection
            command.ExecuteNonQuery();
            HospitalDB.Close(); // close the connection

            // hide the registration form and show the confirmation message
            regForm.Visible = false;
            regConfirm.Visible = true;
        }

        protected void DateValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            byte day, month;
            short year;

            try
            {
                day = Convert.ToByte(txtDay.Text);
                month = Convert.ToByte(txtMonth.Text);
                year = Convert.ToInt16(txtYear.Text);

                // check that the day, month and year are all in a valid range
                if (day < 1 || day > 31)
                    args.IsValid = false;
                if (month < 1 || month > 12)
                    args.IsValid = false;
                if (year < 0 || year > 9999)
                    args.IsValid = false;

                // if a day in february chosen is greater than 29 or is greater than 28
                // during a non-leap year
                if ((month == 2 && day > 29) || (month == 2 && day > 28 && year % 4 != 0))
                    args.IsValid = false;

                if (day == 31)
                {
                    if (month == 4 || month == 6 || month == 9 || month == 11)
                        args.IsValid = false;
                }

            }
            catch
            {
                args.IsValid = false;
            }
        }

        private void updateTableVariables()
        {

            // add all the data in registration form to their appropriate variables
            name = txtLastName.Text + ", " + txtFirstname.Text;
            string dateString = txtYear.Text + '-' + txtMonth.Text + '-' + txtDay.Text;
            dateOfBirth = Convert.ToDateTime(dateString);
            address = txtAddress.Text + ", " + txtCity.Text + ' ' + txtRegion.Text + ' ' + txtPostCode.Text + ' ' +
                      CountryList.Text;
            phoneHome = txtHomeNumber.Text;
            phoneMobile = txtMobileNumber.Text;
            emergContactName = txtEmergencyLastName.Text + ", " + txtEmergencyFirstName.Text;
            emergContactNumber = txtEmergencyNumber.Text;
        }

    }
}