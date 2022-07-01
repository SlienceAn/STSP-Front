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
using System.Text;

public partial class index_index2 : System.Web.UI.Page
{
    string sin = WebConfigurationManager.ConnectionStrings["DBcs"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        

        using (SqlConnection cn = new SqlConnection(sin))
        {

            string sql1 = "";
            //園區
            sql1 = @"SELECT top 1  [Date_Time]
                      FROM [TainanD02] order by  [Date_Time] desc";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                examtime.Text = DateTime.Parse(dr["Date_Time"].ToString()).AddHours(0).ToString();
            }
            cn.Close();
        }

        ////

        chart1();
        chart2();
    }
    protected void chart1()
    {

        string strContent = "";
        StringBuilder tsvstring = new StringBuilder();
        using (SqlConnection cn = new SqlConnection(sin))
        {

            string sql1 = "";
            //園區
            sql1 = @"SELECT top 1  [Date_Time]
                          ,[station]
                          ,[DP_NO]
                          ,[化學需氧量]
                          ,[Status1]
                          ,[氫離子濃度]
                          ,[Status2]
                          ,[導電度]
                          ,[Status3]
                          ,[水溫]
                          ,[Status4]
                          ,[懸浮固體度]
                          ,[Status5]
                       
                      FROM [TainanD01] where DP_NO='D01' order by  [Date_Time] desc ";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                decimal ss = decimal.Parse(dr["懸浮固體度"].ToString());
                decimal cod = decimal.Parse(dr["化學需氧量"].ToString());
                decimal ph = decimal.Parse(dr["氫離子濃度"].ToString());
                decimal te = decimal.Parse(dr["水溫"].ToString());

                string alert1 = "0,128,0";
                string alert2 = "0,128,0";
                string alert3 = "0,128,0";
                string alert4 = "0,128,0";

                if (ss > 20)
                    alert1 = "255,0,0";
                if (cod > 80)
                    alert2 = "255,0,0";
                if (ph > 9)
                    alert3 = "255,0,0";
                if (te > 38)
                    alert4 = "255,0,0";


                val1.Text = "<span style='color:blue'>監測值：" + ss.ToString("#.0") + "</span>";
                val2.Text = "<span style='color:blue'>監測值：" + cod.ToString("#.0") + "</span>";
                val3.Text = "<span style='color:blue'>監測值：" + ph.ToString("#.0") + "</span>";
                val4.Text = "<span style='color:blue'>監測值：" + te.ToString("#.0") + "</span>";

                #region 異常狀態
                if (dr["Status5"].ToString() == "10" || dr["Status5"].ToString() == "11")
                { }
                else if (dr["Status5"].ToString() == "00")
                {
                    val1.Text = "暫停監測";
                }
                else if (dr["Status5"].ToString() == "20")
                {
                    val1.Text = "設備校正";
                }
                else if (dr["Status5"].ToString() == "30" || dr["Status5"].ToString() == "31" || dr["Status5"].ToString() == "32" || dr["Status5"].ToString() == "40")
                {
                    val1.Text = "設備校正保養維護";
                }

                if (dr["Status1"].ToString() == "10" || dr["Status1"].ToString() == "11")
                { }
                else if (dr["Status1"].ToString() == "00")
                {
                    val2.Text = "暫停監測";
                }
                else if (dr["Status1"].ToString() == "20")
                {
                    val2.Text = "設備校正";
                }
                else if (dr["Status1"].ToString() == "30" || dr["Status1"].ToString() == "31" || dr["Status1"].ToString() == "32" || dr["Status1"].ToString() == "40")
                {
                    val2.Text = "設備校正保養維護";
                }


                if (dr["Status2"].ToString() == "10" || dr["Status2"].ToString() == "11")
                { }
                else if (dr["Status2"].ToString() == "00")
                {
                    val3.Text = "暫停監測";
                }
                else if (dr["Status2"].ToString() == "20")
                {
                    val3.Text = "設備校正";
                }
                else if (dr["Status2"].ToString() == "30" || dr["Status2"].ToString() == "31" || dr["Status2"].ToString() == "32" || dr["Status2"].ToString() == "40")
                {
                    val3.Text = "設備校正保養維護";
                }


                if (dr["Status4"].ToString() == "10" || dr["Status4"].ToString() == "11")
                { }
                else if (dr["Status4"].ToString() == "00")
                {
                    val4.Text = "暫停監測";
                }
                else if (dr["Status4"].ToString() == "20")
                {
                    val4.Text = "設備校正";
                }
                else if (dr["Status4"].ToString() == "30" || dr["Status4"].ToString() == "31" || dr["Status4"].ToString() == "32" || dr["Status4"].ToString() == "40")
                {
                    val4.Text = "設備校正保養維護";
                }
                #endregion



                ss = ss * 200 / 15;
                cod = cod * 200 / 60;
                ph = ph * 200 / 8;
                te = te * 200 / 48;


                line1.Text = "<svg height='10' width='400'> <line x1='0' y1='0' x2='" + ss + "' y2='0' style='stroke:rgb(" + alert1 + ");stroke-width:10' /></svg>";
                line2.Text = "<svg height='10' width='400'> <line x1='0' y1='0' x2='" + cod + "' y2='0' style='stroke:rgb(" + alert2 + ");stroke-width:10' /></svg>";
                line3.Text = "<svg height='10' width='400'> <line x1='0' y1='0' x2='" + ph + "' y2='0' style='stroke:rgb(" + alert3 + ");stroke-width:10' /></svg>";
                line4.Text = "<svg height='10' width='400'> <line x1='0' y1='0' x2='" + te + "' y2='0' style='stroke:rgb(" + alert4 + ");stroke-width:10' /></svg>";



            }
            cn.Close();
        }

    }


    protected void chart2()
    {

        string strContent = "";
        StringBuilder tsvstring = new StringBuilder();
        using (SqlConnection cn = new SqlConnection(sin))
        {

            string sql1 = "";
            //園區
            sql1 = @"SELECT top 1  [Date_Time]
                          ,[station]
                          ,[DP_NO]
                          ,[化學需氧量]
                          ,[Status1]
                          ,[氫離子濃度]
                          ,[Status2]
                          ,[導電度]
                          ,[Status3]
                          ,[水溫]
                          ,[Status4]
                          ,[懸浮固體度]
                          ,[Status5]
                       
                      FROM [TainanD02] where DP_NO='D02' order by  [Date_Time] desc ";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                decimal ss = decimal.Parse(dr["懸浮固體度"].ToString());
                decimal cod = decimal.Parse(dr["化學需氧量"].ToString());
                decimal ph = decimal.Parse(dr["氫離子濃度"].ToString());
                decimal te = decimal.Parse(dr["水溫"].ToString());

                string alert1 = "0,128,0";
                string alert2 = "0,128,0";
                string alert3 = "0,128,0";
                string alert4 = "0,128,0";

                if (ss > 20)
                    alert1 = "255,0,0";
                if (cod > 80)
                    alert2 = "255,0,0";
                if (ph > 9)
                    alert3 = "255,0,0";
                if (te > 38)
                    alert4 = "255,0,0";

                val5.Text = "<span style='color:blue'>監測值：" + ss.ToString("#.0") + "</span>";
                val6.Text = "<span style='color:blue'>監測值：" + cod.ToString("#.0") + "</span>";
                val7.Text = "<span style='color:blue'>監測值：" + ph.ToString("#.0") + "</span>";
                val8.Text = "<span style='color:blue'>監測值：" + te.ToString("#.0") + "</span>";

                #region 異常狀態
                if (dr["Status5"].ToString() == "10" || dr["Status5"].ToString() == "11")
                { }
                else if (dr["Status5"].ToString() == "00")
                {
                    val5.Text = "暫停監測";
                }
                else if (dr["Status5"].ToString() == "20")
                {
                    val5.Text = "設備校正";
                }
                else if (dr["Status5"].ToString() == "30" || dr["Status5"].ToString() == "31" || dr["Status5"].ToString() == "32" || dr["Status5"].ToString() == "40")
                {
                    val5.Text = "設備校正保養維護";
                }

                if (dr["Status1"].ToString() == "10" || dr["Status1"].ToString() == "11")
                { }
                else if (dr["Status1"].ToString() == "00")
                {
                    val6.Text = "暫停監測";
                }
                else if (dr["Status1"].ToString() == "20")
                {
                    val6.Text = "設備校正";
                }
                else if (dr["Status1"].ToString() == "30" || dr["Status1"].ToString() == "31" || dr["Status1"].ToString() == "32" || dr["Status1"].ToString() == "40")
                {
                    val6.Text = "設備校正保養維護";
                }


                if (dr["Status2"].ToString() == "10" || dr["Status2"].ToString() == "11")
                { }
                else if (dr["Status2"].ToString() == "00")
                {
                    val7.Text = "暫停監測";
                }
                else if (dr["Status2"].ToString() == "20")
                {
                    val7.Text = "設備校正";
                }
                else if (dr["Status2"].ToString() == "30" || dr["Status2"].ToString() == "31" || dr["Status2"].ToString() == "32" || dr["Status2"].ToString() == "40")
                {
                    val7.Text = "設備校正保養維護";
                }


                if (dr["Status4"].ToString() == "10" || dr["Status4"].ToString() == "11")
                { }
                else if (dr["Status4"].ToString() == "00")
                {
                    val8.Text = "暫停監測";
                }
                else if (dr["Status4"].ToString() == "20")
                {
                    val8.Text = "設備校正";
                }
                else if (dr["Status4"].ToString() == "30" || dr["Status4"].ToString() == "31" || dr["Status4"].ToString() == "32" || dr["Status4"].ToString() == "40")
                {
                    val8.Text = "設備校正保養維護";
                }
                #endregion

                ss = ss * 200 / 15;
                cod = cod * 200 / 60;
                ph = ph * 200 / 8;
                te = te * 200 / 48;


                line5.Text = "<svg height='10' width='400'> <line x1='0' y1='0' x2='" + ss + "' y2='0' style='stroke:rgb(" + alert1 + ");stroke-width:10' /></svg>";
                line6.Text = "<svg height='10' width='400'> <line x1='0' y1='0' x2='" + cod + "' y2='0' style='stroke:rgb(" + alert2 + ");stroke-width:10' /></svg>";
                line7.Text = "<svg height='10' width='400'> <line x1='0' y1='0' x2='" + ph + "' y2='0' style='stroke:rgb(" + alert3 + ");stroke-width:10' /></svg>";
                line8.Text = "<svg height='10' width='400'> <line x1='0' y1='0' x2='" + te + "' y2='0' style='stroke:rgb(" + alert4 + ");stroke-width:10' /></svg>";


            }
            cn.Close();
        }

    }
}