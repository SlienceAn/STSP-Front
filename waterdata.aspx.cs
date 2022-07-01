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

public partial class index_waterdata : System.Web.UI.Page
{
    string sin = WebConfigurationManager.ConnectionStrings["DBcs"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["c"].ToString() == "1")
            chart1();
        if (Request.QueryString["c"].ToString() == "2")
            chart2();
        if (Request.QueryString["c"].ToString() == "3")
            chart3();
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
                         
                      FROM [TainanD01] where DP_NO='D01' order by  [Date_Time] desc";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {

                //                [
                //  {"title":"SS","subtitle":"ppm","ranges":[150,225,300],"measures":[220,270],"markers":[200]},
                //  {"title":"COD","subtitle":"ppm","ranges":[20,25,30],"measures":[21,23],"markers":[20]},
                //  {"title":"PH","subtitle":"","ranges":[350,500,600],"measures":[100,320],"markers":[400]},
                //  {"title":"水溫","subtitle":"%","ranges":[1400,2000,2500],"measures":[1000,1650],"markers":[2000]}

                //]

                tsvstring.AppendLine("");
                tsvstring.AppendLine(" [");
                tsvstring.AppendLine("{\"title\":\"SS\",\"subtitle\":\"ppm\",\"ranges\":[4,5,25],\"measures\":[" + dr["懸浮固體度"].ToString() + ",20],\"markers\":[20]},");
                tsvstring.AppendLine("{\"title\":\"COD\",\"subtitle\":\"ppm\",\"ranges\":[20,25,100],\"measures\":[" + dr["化學需氧量"].ToString() + ",80],\"markers\":[80]},");
                tsvstring.AppendLine("{\"title\":\"PH\",\"subtitle\":\"\",\"ranges\":[6,7,14],\"measures\":[" + dr["氫離子濃度"].ToString() + ",9],\"markers\":[9]},");
                tsvstring.AppendLine("{\"title\":\"水溫\",\"subtitle\":\"℃\",\"ranges\":[20,30,80],\"measures\":[" + dr["水溫"].ToString() + ",38],\"markers\":[38]}");

                tsvstring.AppendLine(" ]");


                strContent = tsvstring.ToString();
                //宣告字串變數。(要存取的檔案所在位置)
                string strFilePath = "data.txt";
                //將要存取檔案所在位置由虛擬路徑指定為實體路徑。
                strFilePath = Server.MapPath(strFilePath);
                //將字串變數文字內容寫入文字檔案。
                StreamWriterTextFile_Fn(strContent, strFilePath);
                //將文字檔案的內容輸出在畫面上。
                Response.Write(StreamReadTextFile_Fn(strFilePath));

                Response.Redirect("data.txt");
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

                //                [
                //  {"title":"SS","subtitle":"ppm","ranges":[150,225,300],"measures":[220,270],"markers":[200]},
                //  {"title":"COD","subtitle":"ppm","ranges":[20,25,30],"measures":[21,23],"markers":[20]},
                //  {"title":"PH","subtitle":"","ranges":[350,500,600],"measures":[100,320],"markers":[400]},
                //  {"title":"水溫","subtitle":"%","ranges":[1400,2000,2500],"measures":[1000,1650],"markers":[2000]}

                //]

                tsvstring.AppendLine("");
                tsvstring.AppendLine(" [");
                tsvstring.AppendLine("{\"title\":\"SS\",\"subtitle\":\"ppm\",\"ranges\":[4,5,25],\"measures\":[" + dr["懸浮固體度"].ToString() + ",20],\"markers\":[20]},");
                tsvstring.AppendLine("{\"title\":\"COD\",\"subtitle\":\"ppm\",\"ranges\":[20,25,100],\"measures\":[" + dr["化學需氧量"].ToString() + ",80],\"markers\":[80]},");
                tsvstring.AppendLine("{\"title\":\"PH\",\"subtitle\":\"\",\"ranges\":[6,7,14],\"measures\":[" + dr["氫離子濃度"].ToString() + ",9],\"markers\":[9]},");
                tsvstring.AppendLine("{\"title\":\"水溫\",\"subtitle\":\"℃\",\"ranges\":[20,30,80],\"measures\":[" + dr["水溫"].ToString() + ",38],\"markers\":[38]}");

                tsvstring.AppendLine(" ]");


                strContent = tsvstring.ToString();
                //宣告字串變數。(要存取的檔案所在位置)
                string strFilePath = "data.txt";
                //將要存取檔案所在位置由虛擬路徑指定為實體路徑。
                strFilePath = Server.MapPath(strFilePath);
                //將字串變數文字內容寫入文字檔案。
                StreamWriterTextFile_Fn(strContent, strFilePath);
                //將文字檔案的內容輸出在畫面上。
                Response.Write(StreamReadTextFile_Fn(strFilePath));

                Response.Redirect("data.txt");
            }
            cn.Close();
        }

    }
    protected void chart3()
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
                       
                      FROM [KaohsiungD01] where DP_NO='D01' order by  [Date_Time] desc ";

            SqlCommand cmd = new SqlCommand(sql1, cn);

            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {

                //                [
                //  {"title":"SS","subtitle":"ppm","ranges":[150,225,300],"measures":[220,270],"markers":[200]},
                //  {"title":"COD","subtitle":"ppm","ranges":[20,25,30],"measures":[21,23],"markers":[20]},
                //  {"title":"PH","subtitle":"","ranges":[350,500,600],"measures":[100,320],"markers":[400]},
                //  {"title":"水溫","subtitle":"%","ranges":[1400,2000,2500],"measures":[1000,1650],"markers":[2000]}

                //]

                tsvstring.AppendLine("");
                tsvstring.AppendLine(" [");
                tsvstring.AppendLine("{\"title\":\"SS\",\"subtitle\":\"ppm\",\"ranges\":[4,5,30],\"measures\":[" + dr["懸浮固體度"].ToString() + ",25],\"markers\":[25]},");
                tsvstring.AppendLine("{\"title\":\"COD\",\"subtitle\":\"ppm\",\"ranges\":[20,25,100],\"measures\":[" + dr["化學需氧量"].ToString() + ",80],\"markers\":[80]},");
                tsvstring.AppendLine("{\"title\":\"PH\",\"subtitle\":\"\",\"ranges\":[6,7,14],\"measures\":[" + dr["氫離子濃度"].ToString() + ",9],\"markers\":[9]},");
                tsvstring.AppendLine("{\"title\":\"水溫\",\"subtitle\":\"℃\",\"ranges\":[20,30,80],\"measures\":[" + dr["水溫"].ToString() + ",38],\"markers\":[38]}");

                tsvstring.AppendLine(" ]");


                strContent = tsvstring.ToString();
                //宣告字串變數。(要存取的檔案所在位置)
                string strFilePath = "data.txt";
                //將要存取檔案所在位置由虛擬路徑指定為實體路徑。
                strFilePath = Server.MapPath(strFilePath);
                //將字串變數文字內容寫入文字檔案。
                StreamWriterTextFile_Fn(strContent, strFilePath);
                //將文字檔案的內容輸出在畫面上。
                Response.Write(StreamReadTextFile_Fn(strFilePath));

                Response.Redirect("data.txt");
            }
            cn.Close();
        }

    }
    //寫入文字檔案功能函式。
    public void StreamWriterTextFile_Fn(string strContent_Val, string strFilePath_Val)
    {
        //建立物件案例。(取得文字檔案寫入案例)
        StreamWriter objStreamWriter = new StreamWriter(strFilePath_Val);
        //將字串內容寫入緩衝區。
        objStreamWriter.Write(strContent_Val);
        //釋放使用中的資源。
        objStreamWriter.Close();
        objStreamWriter.Dispose();
    }

    //讀取文字檔案功能函式。
    public string StreamReadTextFile_Fn(string strFilePath_Val)
    {
        //當要存取的檔案存在時。
        if (File.Exists(strFilePath_Val) == true)
        {
            //建立物件案例。(取得文字檔案讀取案例)
            StreamReader objStreamReader = new StreamReader(strFilePath_Val, Encoding.UTF8);
            //將字串內容從頭到尾讀取至緩衝區。
            string strText = objStreamReader.ReadToEnd();
            //釋放使用中的資源。
            objStreamReader.Close();
            objStreamReader.Dispose();
            //傳回結果。
            return strText;
        }
        else
        {
            //傳回結果。
            return null;
        }
    }
}