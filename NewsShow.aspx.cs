using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FrontEnd_NewsShow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["id"] != null)
        {
            string sin = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;
            SqlConnection cn = new SqlConnection(sin);
            cn.Open();
            string sql1 = @"SELECT [News_id]
                                  ,[title]
                                  ,[content]
                                  ,[start_time]
                                  ,[end_time]
                                  FROM [News] where start_time<=@time and end_time>@time AND News_id=@ID  and dele = 0 order by start_time";
            SqlCommand cmd = new SqlCommand(sql1, cn);
            cmd.Parameters.AddWithValue("@time", DateTime.Now.ToString("yyyy/MM/dd 00:00"));
            cmd.Parameters.AddWithValue("@ID", Request["id"]);
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read()) {
                labTitle.Text = rd["title"].ToString();
                labDt.Text =DateTime .Parse ( rd["start_time"].ToString()).ToString ("yyyy/MM/dd");
                labContent.Text = rd["content"].ToString();
            }
            rd.Close();
            cn.Close();
        }
    }
}