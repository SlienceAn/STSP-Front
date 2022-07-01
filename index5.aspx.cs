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

public partial class index_index5 : System.Web.UI.Page
{
    string sin = WebConfigurationManager.ConnectionStrings["DBcs"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        // lv1.Text = "敏感者<br>不健康";
        //    AQI1.Text = "100";
        //   item1.Text = "XXX";

        Response.Redirect("index1.aspx");

        sitebgA.ImageUrl = "image/circle/circleMAP_1_01.png";
        sitebg5.ImageUrl = "image/circle/circleMAP_A_01.png";
        sitebg6.ImageUrl = "image/circle/circleMAP_B_01.png";
        sitebg7.ImageUrl = "image/circle/circleMAP_C_01.png";
        sitebg8.ImageUrl = "image/circle/circleMAP_D_01.png";

        using (SqlConnection cn = new SqlConnection(sin))
        {

            string sql1 = "";
            //園區
            sql1 = @"select top 5  [Station_ID]
                           ,[Station]
                           ,[AQI_Item]
                           ,[AQI_Value],[Date_Time] from [STSP].[dbo].[AQI_Log_Report] order by Date_Time desc ";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
               
                    if (dr["Station_ID"].ToString() == "B01")
                    {
                        Label tb = (Label)Panel2.FindControl("lvA");
                        Label aqi = (Label)Panel2.FindControl("AQIA" );
                        Label item = (Label)Panel2.FindControl("itemA" );
                        Literal li = (Literal)Panel2.FindControl("LiteralA" );
                        System.Web.UI.WebControls.Image im = (System.Web.UI.WebControls.Image)Panel2.FindControl("siteimgA" );
                        System.Web.UI.WebControls.Image bg = (System.Web.UI.WebControls.Image)Panel2.FindControl("sitebgA" );
                        ImageButton site = (ImageButton)Panel2.FindControl("siteA");

                        aqi.Text = dr["AQI_Value"].ToString();
                        item.Text = dr["AQI_Item"].ToString();
                        examtime.Text = DateTime.Parse(dr["Date_Time"].ToString()).AddHours(1).ToString();
                        examtime2.Text = DateTime.Parse(dr["Date_Time"].ToString()).AddHours(1).ToString();

                        double val = double.Parse(dr["AQI_Value"].ToString());
                        if (dr["AQI_Item"].ToString() == "PM2.5")
                            item.Text = "PM<sub>2.5</sub>";
                        if (dr["AQI_Item"].ToString() == "O3_8")
                            item.Text = "O<sub>3</sub>";
                        if (dr["AQI_Item"].ToString() == "O3")
                            item.Text = "O<sub>3</sub>";
                        if (val <= 25)
                        {
                            tb.Text = "良好";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_01.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "01");
                            site.ImageUrl = site.ImageUrl.Replace("01", "01");
                            li.Text = "style='text-align:center;border-color:#00e800;border-width: thick' ";
                        }
                        else if (val <= 50)
                        {
                           tb.Text = "良好";
                           im.ImageUrl = "image/index/board2/DashboardPic_2_02.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "01");
                            site.ImageUrl = site.ImageUrl.Replace("01", "01");
                            li.Text = "style='text-align:center;border-color:#00e800;border-width: thick' ";
                        }
                        else if (val <= 75)
                        {
                            tb.Text = "普通";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_03.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "02");
                            site.ImageUrl = site.ImageUrl.Replace("01", "02");
                            li.Text = "style='text-align:center;border-color:#ffff00;border-width: thick' ";
                        }
                        else if (val <= 100)
                        {
                            tb.Text = "普通";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_04.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "02");
                            site.ImageUrl = site.ImageUrl.Replace("01", "02");
                            li.Text = "style='text-align:center;border-color:#ffff00;border-width: thick' ";
                        }
                        else if (val <= 125)
                        {
                            tb.Attributes.Add("style", "font-size:16px");
                            tb.Text = "敏感者不健康";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_05.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "03");
                            site.ImageUrl = site.ImageUrl.Replace("01", "03");
                            li.Text = "style='text-align:center;border-color:#ff7e00;border-width: thick' ";
                        }
                        else if (val <= 150)
                        {
                            tb.Attributes.Add("style", "font-size:16px");
                            tb.Text = "敏感者不健康";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_06.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "03");
                            site.ImageUrl = site.ImageUrl.Replace("01", "03");
                            li.Text = "style='text-align:center;border-color:#ff7e00;border-width: thick' ";
                        }
                        else if (val <= 175)
                        {
                            tb.Text = "不健康";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_07.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "04");
                            site.ImageUrl = site.ImageUrl.Replace("01", "04");
                            li.Text = "style='text-align:center;border-color:red;border-width: thick' ";
                        }
                        else if (val <= 200)
                        {
                            tb.Text = "不健康";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_08.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "04");
                            site.ImageUrl = site.ImageUrl.Replace("01", "04");
                            li.Text = "style='text-align:center;border-color:red;border-width: thick' ";
                        }
                        else if (val <= 250)
                        {
                            tb.Attributes.Add("style", "font-size:16px");
                            tb.Text = "非常不健康";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_10.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "05");
                            site.ImageUrl = site.ImageUrl.Replace("01", "05");
                            li.Text = "style='text-align:center;border-color:#b74fc9;border-width: thick' ";
                        }
                        else if (val <= 300)
                        {
                            tb.Attributes.Add("style", "font-size:16px");
                            tb.Text = "非常不健康";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_12.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "05");
                            site.ImageUrl = site.ImageUrl.Replace("01", "05");
                            li.Text = "style='text-align:center;border-color:#b74fc9;border-width: thick' ";
                        }
                        else if (val <= 400)
                        {
                            tb.Text = "危害";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_17.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "06");
                            site.ImageUrl = site.ImageUrl.Replace("01", "06");
                            li.Text = "style='text-align:center;border-color:#7e0023;border-width: thick' ";
                        }
                        else if (val <= 500)
                        {
                            tb.Text = "危害";
                            im.ImageUrl = "image/index/board2/DashboardPic_2_19.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "06");
                            site.ImageUrl = site.ImageUrl.Replace("01", "06");
                            li.Text = "style='text-align:center;border-color:#7e0023;border-width: thick' ";
                        }


                    
                }
            }
            cn.Close();
        }

//        using (SqlConnection cn = new SqlConnection(sin))
//        {

//            string sql1 = "";
//            //園區
//            sql1 = @"select top 1  [SiteName]
//                                  ,[Dataday]
//                                  ,[Datatime]
//                                  ,[WS_Value]
//                                  ,[WD_Value] from [STSP].[dbo].[vBbackward] order by Dataday desc,Datatime desc ";

//            SqlCommand cmd = new SqlCommand(sql1, cn);

//            cn.Open();
//            SqlDataReader dr = cmd.ExecuteReader();
//            string[] stationid = { "平均值" };

//            while (dr.Read())
//            {
              
//                    if (dr["SiteName"].ToString() == stationid[0])
//                    {
//                        Literal wd = (Literal)Panel2.FindControl("windA" );
//                        wd.Text = "風向：" + trandferwind(dr["WD_Value"].ToString());
//                    }
                
//            }
//            cn.Close();
//        }


        //epa
        using (SqlConnection cn = new SqlConnection(sin))
        {

            string sql1 = "";
            //園區
            sql1 = @"select top 15  
                            [Station]
                           ,[AQI],[WD],[POLLUTANT]
                           ,[Date_Time] from [STSP].[dbo].[AQX] order by Date_Time desc ";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            string[] stationid = { "臺南站", "安南站", "善化站", "新營站" };

            while (dr.Read())
            {
                for (int i = 0; i < 4; i++)
                {
                    if (dr["Station"].ToString() == stationid[i])
                    {
                        Label tb = (Label)Panel2.FindControl("lv" + (i + 5));
                        Label aqi = (Label)Panel2.FindControl("AQI" + (i + 5));
                        Label item = (Label)Panel2.FindControl("item" + (i + 5));
                        Literal li = (Literal)Panel2.FindControl("Literal" + (i + 5));
                        System.Web.UI.WebControls.Image im = (System.Web.UI.WebControls.Image)Panel2.FindControl("siteimg" + (i + 5));
                        System.Web.UI.WebControls.Image bg = (System.Web.UI.WebControls.Image)Panel2.FindControl("sitebg" + (i + 5));
                        System.Web.UI.WebControls.Image site = (System.Web.UI.WebControls.Image)Panel2.FindControl("site" + (i + 5));
                        Literal wd = (Literal)Panel2.FindControl("wind" + (i + 5));


                        double AQI_Value = double.Parse(dr["AQI"].ToString());
                        aqi.Text = AQI_Value.ToString("N0");
                        item.Text = dr["POLLUTANT"].ToString();
                        //examtime.Text = dr["Date_Time"].ToString();
                        examtime2.Text = DateTime.Parse(dr["Date_Time"].ToString()).AddHours(0).ToString();
                        wd.Text = "風向：" + trandferwind(dr["wd"].ToString());


                        double val = double.Parse(dr["AQI"].ToString());
                        if (val <= 25)
                        {
                            tb.Text = "良好";
                            im.ImageUrl = "image/index/board/DashboardPic01.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "01");
                            site.ImageUrl = site.ImageUrl.Replace("01", "01");
                            li.Text = "style='text-align:center;border-color:#00e800;border-width: thick' ";
                        }
                        else if (val <= 50)
                        {
                            tb.Text = "良好";
                            im.ImageUrl = "image/index/board/DashboardPic02.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "01");
                            site.ImageUrl = site.ImageUrl.Replace("01", "01");
                            li.Text = "style='text-align:center;border-color:#00e800;border-width: thick' ";
                        }
                        else if (val <= 75)
                        {
                            tb.Text = "普通";
                            im.ImageUrl = "image/index/board/DashboardPic03.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "02");
                            site.ImageUrl = site.ImageUrl.Replace("01", "02");
                            li.Text = "style='text-align:center;border-color:#ffff00;border-width: thick' ";
                        }
                        else if (val <= 100)
                        {
                            tb.Text = "普通";
                            im.ImageUrl = "image/index/board/DashboardPic04.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "02");
                            site.ImageUrl = site.ImageUrl.Replace("01", "02");
                            li.Text = "style='text-align:center;border-color:#ffff00;border-width: thick' ";
                        }
                        else if (val <= 125)
                        {
                            tb.Attributes.Add("style", "font-size:16px");
                            tb.Text = "敏感者不健康";
                            im.ImageUrl = "image/index/board/DashboardPic05.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "03");
                            site.ImageUrl = site.ImageUrl.Replace("01", "03");
                            li.Text = "style='text-align:center;border-color:#ff7e00;border-width: thick' ";
                        }
                        else if (val <= 150)
                        {
                            tb.Attributes.Add("style", "font-size:16px");
                            tb.Text = "敏感者不健康";
                            im.ImageUrl = "image/index/board/DashboardPic06.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "03");
                            site.ImageUrl = site.ImageUrl.Replace("01", "03");
                            li.Text = "style='text-align:center;border-color:#ff7e00;border-width: thick' ";
                        }
                        else if (val <= 175)
                        {
                            tb.Text = "不健康";
                            im.ImageUrl = "image/index/board/DashboardPic07.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "04");
                            site.ImageUrl = site.ImageUrl.Replace("01", "04");
                            li.Text = "style='text-align:center;border-color:#ff0025;border-width: thick' ";
                        }
                        else if (val <= 200)
                        {
                            tb.Text = "不健康";
                            im.ImageUrl = "image/index/board/DashboardPic08.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "04");
                            site.ImageUrl = site.ImageUrl.Replace("01", "04");
                            li.Text = "style='text-align:center;border-color:#ff0025;border-width: thick' ";
                        }
                        else if (val <= 250)
                        {
                            tb.Attributes.Add("style", "font-size:16px");
                            tb.Text = "非常不健康";
                            im.ImageUrl = "image/index/board/DashboardPic10.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "05");
                            site.ImageUrl = site.ImageUrl.Replace("01", "05");
                            li.Text = "style='text-align:center;border-color:#b74fc9;border-width: thick' ";
                        }
                        else if (val <= 300)
                        {
                            tb.Attributes.Add("style", "font-size:16px");
                            tb.Text = "非常不健康";
                            im.ImageUrl = "image/index/board/DashboardPic12.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "05");
                            site.ImageUrl = site.ImageUrl.Replace("01", "05");
                            li.Text = "style='text-align:center;border-color:#b74fc9;border-width: thick' ";
                        }
                        else if (val <= 400)
                        {
                            tb.Text = "危害";
                            im.ImageUrl = "image/index/board/DashboardPic17.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "06");
                            site.ImageUrl = site.ImageUrl.Replace("01", "06");
                            li.Text = "style='text-align:center;border-color:#7e0023;border-width: thick' ";
                        }
                        else if (val <= 500)
                        {
                            tb.Text = "危害";
                            im.ImageUrl = "image/index/board/DashboardPic19.png";
                            bg.ImageUrl = bg.ImageUrl.Replace("01", "06");
                            site.ImageUrl = site.ImageUrl.Replace("01", "06");
                            li.Text = "style='text-align:center;border-color:#7e0023;border-width: thick' ";
                        }


                    }
                }
            }
            cn.Close();
        }

    }


    protected string trandferwind(string wd)
    {
        string res = "";
        double dwd = 0;
        double o = 0;
        if (double.TryParse(wd, out o))
        {
            dwd = double.Parse(wd);

            if (dwd >= 0 && dwd < 11.25)
                res = "北";
            else if (dwd >= 11.25 && dwd < 22.5)
                res = "北微東";
            else if (dwd >= 22.5 && dwd < 33.75)
                res = "北北東";
            else if (dwd >= 33.75 && dwd < 45)
                res = "東北微北";
            else if (dwd >= 45 && dwd < 56.25)
                res = "東北";
            else if (dwd >= 56.25 && dwd < 67.5)
                res = "東北微東";
            else if (dwd >= 67.5 && dwd < 78.75)
                res = "東北東";
            else if (dwd >= 78.75 && dwd < 90)
                res = "東微北";

            else if (dwd >= 90 && dwd < 101.25)
                res = "東";
            else if (dwd >= 101.25 && dwd < 112.5)
                res = "東微南";
            else if (dwd >= 112.5 && dwd < 123.75)
                res = "東南東";
            else if (dwd >= 123.75 && dwd < 135)
                res = "東南微東";
            else if (dwd >= 135 && dwd < 146.25)
                res = "東南";
            else if (dwd >= 146.25 && dwd < 157.5)
                res = "東南微南";
            else if (dwd >= 157.5 && dwd < 168.75)
                res = "南南東";
            else if (dwd >= 168.75 && dwd < 180)
                res = "南微東";


            else if (dwd >= 180 && dwd < 191.25)
                res = "南";
            else if (dwd >= 191.25 && dwd < 202.5)
                res = "南微西";
            else if (dwd >= 202.5 && dwd < 213.75)
                res = "南南西";
            else if (dwd >= 213.75 && dwd < 225)
                res = "西南微西";
            else if (dwd >= 225 && dwd < 236.25)
                res = "西南";
            else if (dwd >= 236.25 && dwd < 247.5)
                res = "西南微西";
            else if (dwd >= 247.5 && dwd < 258.75)
                res = "西南西";
            else if (dwd >= 258.75 && dwd < 270)
                res = "西微南";

            else if (dwd >= 270 && dwd < 281.25)
                res = "西";
            else if (dwd >= 281.25 && dwd < 292.5)
                res = "西微北";
            else if (dwd >= 292.5 && dwd < 303.75)
                res = "西北西";
            else if (dwd >= 303.75 && dwd < 315)
                res = "西北微西";
            else if (dwd >= 315 && dwd < 326.25)
                res = "西北";
            else if (dwd >= 326.25 && dwd < 337.5)
                res = "西北微北";
            else if (dwd >= 337.5 && dwd < 348.75)
                res = "北北西";
            else if (dwd >= 348.75 && dwd < 360)
                res = "北微西";
        }

        return res;
    }


    protected void site1_Click(object sender,ImageClickEventArgs e)
    {

        Response.Redirect("index1.aspx");
    }
}