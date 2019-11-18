using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Configuration;

using Assignment2.models;

namespace Assignment2
{
    public partial class VisitHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (txtDoctor.Text != "")
            {
                using (HospitalEntities HospitalDB = new HospitalEntities())
                {
                    IQueryable<VisitsView> visitsFound = HospitalDB.VisitsViews
                           .Where(v => v.Doctor_Name == txtDoctor.Text);

                    GridViewVisitHistory.DataSource = visitsFound.ToList();
                    GridViewVisitHistory.DataBind();

                }
            }
        }
        
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            
        }

        protected void lblStatus_DataBinding(object sender, EventArgs e)
        {
            Label statusValue = sender as Label;

            VisitsView visit = GetDataItem() as VisitsView;

            statusValue.ForeColor = System.Drawing.Color.Black;

            if (visit.In_Patient == true)
            {
                statusValue.Text = "In";
            }
            else
            {
                statusValue.Text = "Out";
            }
        }

        // method used for Ajax autcomplete Extender
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
                    cmd.CommandText = "select Name from Doctor " +
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
        }

    }
}