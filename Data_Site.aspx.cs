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


public partial class sin_Data_Site : System.Web.UI.Page
{
    string sin = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            ViewState["area"] = "1";
            ViewState["eid"] = "1";
            year.SelectedValue = "108";
            season.SelectedValue = "1";
            q.Value = "Q1";

            dsearch();
        }
    }
    protected void search_Click(object sender, EventArgs e)
    {
        dsearch();
    }
    protected void dsearch() 
    {
        if (area.SelectedValue != "")
            ViewState["area"] = area.SelectedValue;
        if (eid.SelectedValue != "")
            ViewState["eid"] = eid.SelectedValue;

        ShowMaps();
    
    }
    private void ShowMaps()
    {
        string sql = "", sql1 = "", sql2 = "", sql3 = "", cStr = "A", qStr = "", qStr1 = "", qStr2 = "", qStr3 = "";
        if (season.SelectedValue == "1")
            q.Value = "Q1";
        if (season.SelectedValue == "2")
            q.Value = "Q2";
        if (season.SelectedValue == "3")
            q.Value = "Q3";
        if (season.SelectedValue == "4")
            q.Value = "Q4";

        string NowYear = (int.Parse(year.SelectedValue) + 1911).ToString();
        string preYear = (int.Parse(year.SelectedValue) + 1912).ToString();

       

        if (q.Value == "Q1")
        {
            qStr = NowYear + "-01-01 00:00.001' and '" + NowYear + "-03-31 23:59.001";
            qStr1 = NowYear + "-01-01 00:00.001' and '" + NowYear + "-01-31 23:59.001";
            qStr2 = NowYear + "-02-01 00:00.001' and '" + NowYear + "-03-01 00:00.001";
            qStr3 = NowYear + "-03-01 00:00.001' and '" + NowYear + "-03-31 23:59.001";
            Label1.Text = "今年第一季";
            Label2.Text = "1月";
            Label3.Text = "2月";
            Label4.Text = "3月";
        }
        if (q.Value == "Q2")
        {
            qStr = NowYear + "-04-01 00:00.001' and '" + NowYear + "-06-30 23:59.001";
            qStr1 = NowYear + "-04-01 00:00.001' and '" + NowYear + "-04-30 23:59.001";
            qStr2 = NowYear + "-05-01 00:00.001' and '" + NowYear + "-05-31 23:59.001";
            qStr3 = NowYear + "-06-01 00:00.001' and '" + NowYear + "-06-30 23:59.001";
            Label1.Text = "今年第二季";
            Label2.Text = "4月";
            Label3.Text = "5月";
            Label4.Text = "6月";
        }
        if (q.Value == "Q3")
        {
            qStr = NowYear + "-07-01 00:00.001' and '" + NowYear + "-09-30 23:59.001";
            qStr1 = NowYear + "-07-01 00:00.001' and '" + NowYear + "-07-31 23:59.001";
            qStr2 = NowYear + "-08-01 00:00.001' and '" + NowYear + "-08-31 23:59.001";
            qStr3 = NowYear + "-09-01 00:00.001' and '" + NowYear + "-09-30 23:59.001";
            Label1.Text = "今年第三季";
            Label2.Text = "7月";
            Label3.Text = "8月";
            Label4.Text = "9月";
        }
           
        if (q.Value == "Q4")
        {
            qStr = NowYear + "-10-01 00:00.001' and '" + NowYear + "-12-31 23:59.001";
            qStr1 = NowYear + "-10-01 00:00.001' and '" + NowYear + "-10-31 23:59.001";
            qStr2 = NowYear + "-11-01 00:00.001' and '" + NowYear + "-11-30 23:59.001";
            qStr3 = NowYear + "-12-01 00:00.001' and '" + NowYear + "-12-31 23:59.001";
            Label1.Text = "今年第四季";
            Label2.Text = "10月";
            Label3.Text = "11月";
            Label4.Text = "12月";
        }
        string sqlStr = @"SELECT 
                            distinct convert(char(20),t2.siteName) as siteName,gis_x,gis_y

                        FROM [Data] as t1
                        inner join DetectSite_A as t2
                        on t1.[class] = t2.class_id and t1.[site] = t2.site_id "

                    + @" where gis_x is not null and gis_y is not null and gis_x <> '' and gis_y <> '' and isDel = 0   and  time between '";


        string sqlStr2 = "";
        if (ViewState["eid"].ToString() != "0")
            sqlStr2 += " and class_id = '" + ViewState["eid"].ToString() + @"'";
        if (ViewState["area"].ToString() != "0")
            sqlStr2 += " and area_id = '" + ViewState["area"].ToString() + @"'";


        sql = sqlStr + qStr + "' " + sqlStr2;

     
      


        //Response.Write(sql);

        DataTable dt = this.GetData(sql);
        Label1.Text += "人工監測測點數：" + dt.Rows.Count.ToString() + "";
        rptMarkers.DataSource = dt;
        rptMarkers.DataBind();

        //第一個月
        sql1 = sqlStr + qStr1 + "' " + sqlStr2;

        DataTable dt1 = this.GetData(sql1);
        Label2.Text += "人工監測測點數：" + dt1.Rows.Count.ToString() + "";
        rptMarkers1.DataSource = dt1;
        rptMarkers1.DataBind();

        //第二個月
        sql2 = sqlStr + qStr2 + "' " + sqlStr2;

        DataTable dt2 = this.GetData(sql2);
        Label3.Text += "人工監測測點數：" + dt2.Rows.Count.ToString() + "";
        rptMarkers2.DataSource = dt2;
        rptMarkers2.DataBind();

        //第三個月
        sql3 = sqlStr + qStr3 + "' " + sqlStr2;

        DataTable dt3 = this.GetData(sql3);
        Label4.Text += "人工監測測點數：" + dt3.Rows.Count.ToString() + "";
        rptMarkers3.DataSource = dt3;
        rptMarkers3.DataBind();
    }
    private DataTable GetData(string query)
    {

        SqlCommand cmd = new SqlCommand(query);
        using (SqlConnection con = new SqlConnection(sin))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;

                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    return dt;
                }
            }
        }
    }


    protected void area_DataBound(object sender, EventArgs e)
    {
        #region 抓封鎖的測站
        //for (int i = 0; i < area.Items.Count; i++)
        //{

        //    using (SqlConnection cn = new SqlConnection(sin))
        //    {

        //        string sql1 = @"SELECT   [area_id] FROM [ShowToArea] where area_id=@area_id ";


        //        SqlCommand cmd = new SqlCommand(sql1, cn);
        //        cmd.Parameters.AddWithValue("area_id", area.Items[i].Value);
        //        cn.Open();
        //        SqlDataReader dr = cmd.ExecuteReader();


        //        if (dr.Read())
        //        {

        //        }
        //        else
        //        {
        //            area.Items.Remove(area.Items[i]);
        //        }
        //    }

        //}
        #endregion

    }
    protected void eid_DataBound(object sender, EventArgs e)
    {
        if (area.SelectedValue == "1")
        {
            for (int i = 0; i < eid.Items.Count; i++)
            {

                using (SqlConnection cn = new SqlConnection(sin))
                {

                    string sql1 = @"SELECT   [class_id] FROM [ShowToFront] where area_id=1 and class_id=@class_id and cause_id=1 ";


                    SqlCommand cmd = new SqlCommand(sql1, cn);
                    cmd.Parameters.AddWithValue("class_id", eid.Items[i].Value);
                    cn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();


                    if (dr.Read())
                    {

                    }
                    else
                    {
                        eid.Items.Remove(eid.Items[i]);
                        i--;
                    }
                }

            }
        }
        else if (area.SelectedValue == "2")
        {
            for (int i = 0; i < eid.Items.Count; i++)
            {

                using (SqlConnection cn = new SqlConnection(sin))
                {

                    string sql1 = @"SELECT   [class_id] FROM [ShowToFront] where area_id=2 and class_id=@class_id and cause_id=1 ";


                    SqlCommand cmd = new SqlCommand(sql1, cn);
                    cmd.Parameters.AddWithValue("class_id", eid.Items[i].Value);
                    cn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();


                    if (dr.Read())
                    {

                    }
                    else
                    {
                        eid.Items.Remove(eid.Items[i]);
                        i--;
                    }
                }

            }

        }
    }
    protected void area_SelectedIndexChanged(object sender, EventArgs e)
    {
        eid.DataBind();
    }
}