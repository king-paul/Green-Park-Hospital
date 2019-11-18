using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using Assignment2.models;

namespace Assignment2
{
    public partial class DoctorPatientInfo : System.Web.UI.Page
    {
        HospitalEntities HospitalDB = new HospitalEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            // enable appropriate controls if the assign to bed checkbox is checked
            if (chkAssignToBed.Checked)
            {
                ddlWard.Enabled = true;
                ddlBedNumber.Enabled = true;
            }
            else
            {
                ddlWard.Enabled = false;
                ddlBedNumber.Enabled = false;
            }

            // assign appropriate data to the bed position drop down
            sdsBedsAvailable.SelectCommand = "SELECT [Bed Number] AS Bed_Number FROM [Bed]"
                +" Where [Ward Type] = '"+ddlWard.Text+"'";
        }

        protected void btnAddVisit_Click(object sender, EventArgs e)
        { 
            // make a new sql connection connecting to the hostpital databse
            SqlConnection hospitalDB =
            new SqlConnection("server=localhost;Integrated Security=True;database=Assignment 2 - Hospital");

            // create an sql command connecting to the stored preocdure
            SqlCommand VisitCommand = new SqlCommand("AddVisit", hospitalDB);
            // tell the system that the command type is a stored procedure
            VisitCommand.CommandType = CommandType.StoredProcedure;
            // link the command to the sql connection object
            VisitCommand.Connection = hospitalDB;

            hospitalDB.Open(); // open the connection

            // get IDs from table using names
            string doctorID = getDoctorID();
            string patientID = getPatientID();

            VisitCommand.Parameters.AddWithValue("@DoctorID", doctorID);
            VisitCommand.Parameters.AddWithValue("@PatientID", patientID);

            // check if the assign to bed checkbox is checked
            if(chkAssignToBed.Checked)
            {
                int bedID = getBedID(false);

                // add the parameters for the visit table 
                VisitCommand.Parameters.AddWithValue("@InPatient", true);
                VisitCommand.Parameters.AddWithValue("@BedID", bedID);
                VisitCommand.Parameters.AddWithValue("@DateOfDischarge", DBNull.Value);

                // set up query for the assign to bed procedure
                SqlCommand BedCommand = new SqlCommand("AssignToBed", hospitalDB);
                BedCommand.CommandType = CommandType.StoredProcedure;

                BedCommand.Parameters.AddWithValue("@BedID", bedID);
                BedCommand.Parameters.AddWithValue("@OccupiedID", patientID);
                BedCommand.ExecuteNonQuery(); // execute the query
   
            }
            else
            {
                int bedID = getBedID(true);

                VisitCommand.Parameters.AddWithValue("@InPatient", true);
                VisitCommand.Parameters.AddWithValue("@BedID", bedID);
                
                if(bedID == 0)
                    VisitCommand.Parameters.AddWithValue("@DateOfDischarge", DateTime.Now);
                else
                    VisitCommand.Parameters.AddWithValue("@DateOfDischarge", DBNull.Value);
            }

            if(chkAddVisit.Checked)
            {
                // add The current date and time to date of visit field
                VisitCommand.Parameters.AddWithValue("@DateOfVisit", DateTime.Now);            

                // Add text in the symptoms, disease and treatment fields to the database
                // if they are not null
                if (txtSymptoms.Text != null)
                    VisitCommand.Parameters.AddWithValue("@Symptoms", txtSymptoms.Text);
                if (txtSymptoms.Text != null)
                    VisitCommand.Parameters.AddWithValue("@Disease", txtDisease.Text);
                if (txtSymptoms.Text != null)
                    VisitCommand.Parameters.AddWithValue("@Treatment", txtTreatment.Text);  

                try
                {
                    VisitCommand.ExecuteNonQuery(); // execute the query
                    // disable all the controls on the form
                    disableAll();
                    lnkAddAnother.Visible = true;
                }
                catch (SqlException)
                {
                    lblConfirmation.Text = "Error: An Invalid doctor or patient name was entered.";
                }
            }
                btnAddVisit.Visible = false;

            // make the confiramtion image, label and link visitble 
            imgInfo.Visible = true;
            lblConfirmation.Visible = true;
            
            //btnAddAnother.Visible = true;

            hospitalDB.Close(); // close the connection         
        }

        // get the doctorID using doctor name
        private string getDoctorID()
        {
                return HospitalDB.Doctors
                       .Where(at => at.Name == txtDoctor.Text)
                       .Select(at => at.DoctorID)
                       .SingleOrDefault()
                       .ToString();
        }

        // get the patientID using patient name
        private string getPatientID()
        {
                return HospitalDB.Patients
                       .Where(at => at.Name == txtPatient.Text)
                       .Select(at => at.PatientID)
                       .SingleOrDefault()
                       .ToString();
        }

        // get the patientID using patient name
        private int getBedID(bool currentlyIn)
        {
            if (!currentlyIn)
            {
                int bedNumber = Int32.Parse(ddlBedNumber.Text);

                return HospitalDB.Beds
                        .Where(at => at.Ward_Type == ddlWard.Text
                            && at.Bed_Number == bedNumber)
                        .Select(at => at.BedID)
                        .SingleOrDefault();
            }
            else
            {
                int patientID = Int32.Parse(getPatientID());

                return HospitalDB.Beds
                        .Where(at => at.OccupiedID == patientID)
                        .Select(at => at.BedID)
                        .SingleOrDefault();
            }
                
        }

        private void disableAll()
        {
            ddlBedNumber.Enabled = false;
            txtDoctor.Enabled = false;
            txtPatient.Enabled = false;
            ddlWard.Enabled = false;
            chkAssignToBed.Enabled = false;
            txtDisease.Enabled = false;
            txtSymptoms.Enabled = false;
            txtTreatment.Enabled = false;
            btnAddVisit.Enabled = false;
        }

        // method used for Ajax autcomplete Extender in the doctor name textbox
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchDoctor(string prefixText, int count)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["HospitalConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "Select Name from Doctor " +
                    "Where Name like @SearchText + '%' " +
                    "OR Name like '%, ' + @SearchText + '%'";
                    cmd.Parameters.AddWithValue("@SearchText", prefixText);
                    cmd.Connection = conn;
                    conn.Open();
                    List<string> doctorNames = new List<string>();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            doctorNames.Add(sdr["Name"].ToString());
                        }
                    }
                    conn.Close();
                    return doctorNames;
                }
            }
        } // end of method

        // method used for Ajax autcomplete Extender in the patient name textbox
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchPatient(string prefixText, int count)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["HospitalConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "select Name from Patient " +
                    "Where Name like @SearchText + '%' " +
                    "OR Name like '%, ' + @SearchText + '%'";
                    cmd.Parameters.AddWithValue("@SearchText", prefixText);
                    cmd.Connection = conn;
                    conn.Open();
                    List<string> patientNames = new List<string>();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            patientNames.Add(sdr["Name"].ToString());
                        }
                    }
                    conn.Close();
                    return patientNames;
                }
            }
        }

        protected void btnAddAnother_Click(object sender, EventArgs e)
        {
            txtPatient.Text = String.Empty;
            txtSymptoms.Text = String.Empty;
            txtDisease.Text = String.Empty;
            txtTreatment.Text = String.Empty;

        } // end of method
    
    }
}