using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Data.SqlClient;

using Assignment2.models;

namespace Assignment2.classes
{
    public class LinqQueries
    {
        private static HospitalEntities HospitalDB = new HospitalEntities();

        protected static void getAvailableBeds(string wardType)
        {
            using(HospitalDB)
            {


                /*
                List<string> freeBeds = HospitalDB.Beds
                    .Where(b => b.Ward_Type == wardType)
                    .Select(b => b.Bed_Number).ToString();

                freeBeds.*/
            }
        }

    }
}