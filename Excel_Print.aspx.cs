using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Drawing;
using System.Configuration;
using System.IO;
using NPOI;
using NPOI.XSSF.UserModel;
using NPOI.HSSF.UserModel;
using System.Text.RegularExpressions;

public partial class index_Excel_Print : System.Web.UI.Page
{
    string ctsp = WebConfigurationManager.ConnectionStrings["sin"].ConnectionString;
 
    DataTable dss = new DataTable();
    List<string> dele = new List<string>();
    List<string> cname = new List<string>();
    protected void Page_Load(object sender, EventArgs e)
    {
        dss = Session["dt"] as DataTable; // get data from session.
        checknull();
        print();
    }
    protected void checknull()
    {
        for (int j = 0; j < dss.Columns.Count; j++)
        {
            cname.Add(dss.Columns[j].ColumnName);

            int cn = 0;
            for (int i = 1; i < dss.Rows.Count; i++)
            {
             
                if (dss.Rows[i][j].ToString() != "" && dss.Rows[i][j] != null)
                {

                   
                      cn = 1;
                 
                  
                }
            
            }
            
            if (cn == 0)
            {
                dele.Add(j.ToString());
               
               
            }
        }

        for (int i = 0; i < dele.Count; i++) {

            dss.Columns.Remove(cname[int.Parse(dele[i])]);
          //  dss.Columns.RemoveAt(int.Parse(dele[i]));
        }

    }
    protected void print() {
        HSSFWorkbook workbook = new HSSFWorkbook();
        MemoryStream ms = new MemoryStream();
        string title = "監測數據下載";
        try
        {
            if (Session["OutputName"] != null || Session["OutputName"].ToString()=="")
                title = Session["OutputName"].ToString();
        }
        catch { }
        // 新增試算表。 
        HSSFSheet sheet = (HSSFSheet)workbook.CreateSheet(title);
        sheet.CreateRow(0).CreateCell(0).SetCellValue(title);
        sheet.GetRow(0).CreateCell(2).SetCellValue("產生時間");
        sheet.GetRow(0).CreateCell(3).SetCellValue(DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString());
        sheet.CreateRow(1);
        for (int j = 0; j < dss.Columns.Count; j++)
        {
            sheet.GetRow(1).CreateCell(j).SetCellValue(dss.Columns[j].ColumnName.Split('_')[0]);
        }



        for (int i = 0; i < dss.Rows.Count; i++)
        {
            sheet.CreateRow(i + 2);
            for (int j = 0; j < dss.Columns.Count; j++)
            {
                string value = valuecheck(dss.Rows[i][j].ToString());
                sheet.GetRow(i + 2).CreateCell(j).SetCellValue(value);
            }
        }
        for (int k = 1; k < 1000; k++)
        {
            sheet.AutoSizeColumn((short)k);

        }
        sheet.SetColumnWidth((short)0, 6000);
        workbook.Write(ms);

        // XSSFWorkbook >> .xlsx 副檔名
        // Response.AddHeader("Content-Disposition", string.Format("attachment; filename=EmptyWorkbook.xlsx"));

        // HSSFWorkbook >> .xls 副檔名
        Response.AddHeader("Content-Disposition", string.Format("attachment; filename=" + HttpUtility.UrlEncode(DateTime.Now.ToString("yyyyMMddHHmm") + "_" + title, System.Text.Encoding.UTF8) + ".xls"));
        Response.BinaryWrite(ms.ToArray());


        workbook = null;
        // 釋放資源
        ms.Close();
        ms.Dispose();
    
    
    
    
    
    }
    protected string valuecheck(string v)
    {
        string value = "";
        double o = 0;
        if (!double.TryParse(v, out o))
        {
            value = v;
        }
        else
        {
            double dv = double.Parse(v);
            if (dv < 0)
            {
                if (dv == -999)
                    value = "N.D.";
                else if (dv == -555)
                    value = "無法採樣";
                else
                    value = "<" + Math.Abs(dv).ToString();
            }
            else
            {
                value = v;
            }




        }
        return value;

    }
}