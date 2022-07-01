using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Web.Configuration;
using System.Drawing;

public partial class index_Default2 : System.Web.UI.Page
{
    string sin = WebConfigurationManager.ConnectionStrings["DBcs"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection cn = new SqlConnection(sin))
        {

            string sql1 = "";
            //園區
            sql1 = @"Select Colno,Parameter,Unit,DecimalPoint From STSP.dbo.STSP_Parameter_air Where station='南科實中測站'  Order By Colno";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
         

            while (dr.Read())
            {
                Response.Write(dr["Parameter"].ToString() + " " + dr["Unit"].ToString() + " " + dr["DecimalPoint"].ToString() + "<br>");
            }
            cn.Close();
        }



        string[] selectPar = { "1", "2", "4", "5", "8", "14" };
        int[] DecimalPoint = { 0, 1, 2, 1, 1, 0 };
        for (int i = 0; i < 6; i++)
        {
            using (SqlConnection cn = new SqlConnection(sin))
            {

                string sql1 = "";
                //園區
                // sql1 = @"Select Colno,Parameter,Unit,DecimalPoint From STSP.dbo.STSP_Parameter_air Where station='南科實中測站'  Order By Colno";

                string sp = "Value" + selectPar[i];

                if(i==5)
                    sp = "convert(decimal(9,0),Value" + selectPar[i] + ")";


                sql1 = @"Select Top 1 " + sp + " as Value" + selectPar[i] + " From STSP_S502T60 Where station='南科實中測站' AND  Date_Time= '" + DateTime.Now.AddHours(-1).ToString("yyyy/MM/dd HH:00:00") + "'  Order By Date_Time Desc";
                SqlCommand cmd = new SqlCommand(sql1, cn);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();


                while (dr.Read())
                {

                    string val = dr["Value" + selectPar[i]].ToString();

                    if (val == "")
                        val = "--";
                    else
                        val = Math.Round(Decimal.Parse(val), DecimalPoint[i]).ToString();

                    Response.Write(val + "<br>");
                }
                cn.Close();
            }
        }
    }




}