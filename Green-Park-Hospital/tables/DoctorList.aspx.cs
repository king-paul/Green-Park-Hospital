using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment2
{
    public partial class DoctorsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            sdsDoctors.SelectCommand = "SELECT [Name], [Doctor Type], [Address], [Home Phone], [Mobile] FROM [Doctor] " +
                                       "Order By [Doctor Type]";
        }
    }
}