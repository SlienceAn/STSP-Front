Imports System.Data.SqlClient
Imports System.Web.Configuration
Partial Class AutoMonitor
    Inherits System.Web.UI.Page
    Dim Con As String = WebConfigurationManager.ConnectionStrings("DBcs").ConnectionString
    Dim Conn As New SqlConnection(Con)
    Dim st, dp_no As String
    Dim station As String
    Dim station_st As String = ""
    Dim PJn As String = ""
    Dim STtype As String
    Dim dTable As String
    Dim tt As String = ""
    Dim cSet As Boolean
    Dim cEdit As Boolean
    Dim DP_choice As String

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
		Dim rd As SqlDataReader
		Dim Cmd,cmd2 As New SqlCommand
        Conn.Open()
		Cmd.Connection = Conn
		cmd2.Connection = Conn
		Dim RD2 As SqlDataReader
        st = Request("ST")
        DP_choice = Request("DP_NO")
        '一般測站
        'Dim sql As String = "Select * from STSP_station where stname='" & st & "'"
        'Dim cmd As New SqlCommand(sql, Conn)
        Cmd.CommandText = "Select * from STSP_station where stname='" & st & "'"
            'Dim rd As SqlDataReader
            rd = cmd.ExecuteReader
            If rd.Read Then
                Dim HasData As Boolean = False
                Dim HasTable As Boolean = False
                Dim HasUpdate As Boolean = False
                Dim IsGeneral As Boolean = False
                Dim UpdateTime As String = ""
                Dim TableType As String = ""
                Dim T60 As Boolean = False
                Dim T1440 As Boolean = False
                Dim S8 As Boolean = False
                Dim Calib As Boolean = False

            Dim pnco As String = ""
            If DP_choice <> "" Then
                pnco = "_" & DP_choice
            End If
            StationName.Text = rd.Item("STname_TW") & pnco
            station = rd.Item("STname_TW")
                STtype = rd("STtype")
                dTable = rd("dTable")

            'Dim sql2 As String = "Select TableType, UpdateTime From STSP.dbo.STSP_StationTables Where STid='" & st & "' And IsGeneral=1 Order By sIndex"
            cmd2.CommandText = "Select TableType, UpdateTime From STSP.dbo.STSP_StationTables Where STid='" & st & "' And IsGeneral=1 Order By sIndex"
            'Dim Com2 As New SqlCommand(sql2, Conn)
            'Dim RD2 As SqlDataReader = Com2.ExecuteReader()
            RD2 = Cmd2.ExecuteReader()
                While RD2.Read()
                    HasTable = True
                    If tt = "" And IsDBNull(RD2("UpdateTime")) = False Then
                        tt = RD2("TableType")
                        HasUpdate = True
                        UpdateTime = RD2("UpdateTime")
                    End If
                    Select Case RD2("TableType")
                        Case Is = "T60" : T60 = True
                        Case Is = "T1440" : T1440 = True
                        Case Is = "S8" : S8 = True
                    End Select
                End While
				RD2.close()
            If HasTable = True And HasUpdate = True Then 'data update

                'Select Parameter
                Dim dDate1, dDate2 As String
                Dim rDate1, rDate2 As String
                Dim aCol, dCol, fCol, wCol As String
                Dim dLine As String
                Dim n As Byte   'for color

                'Dim Com3 As New SqlCommand("Select Colno,dChart,dWind,dCalib,ChartType,LoadDisplay From [STSP].[dbo].[STSP_Parameter_air] Where station='" & station & "' And TableType=''", Conn)
                'Dim RD3 As SqlDataReader = Com3.ExecuteReader()
                cmd2.CommandText = "Select Colno,dChart,dWind,dCalib,ChartType,LoadDisplay From [STSP].[dbo].[STSP_Parameter_air] Where station='" & station & "' And TableType=''"
                Select Case st
                    Case "Tainan_waste_water"
                        tt = "T60"
                        cmd2.CommandText = "Select Colno,dChart,dWind,dCalib,ChartType,LoadDisplay From [STSP].[dbo].[STSP_Parameter_water]  Where station='臺南污水廠' AND  DP_NO='" & DP_choice & "'"
                    Case "Kaohsiung_waste_water"
                        tt = "T60"
                        cmd2.CommandText = "Select Colno,dChart,dWind,dCalib,ChartType,LoadDisplay From [STSP].[dbo].[STSP_Parameter_water]  Where station='高雄污水廠' AND  DP_NO='" & DP_choice & "'"
                End Select
                RD2 = Cmd2.ExecuteReader()
                While RD2.Read()
                    If fCol = 0 Then    'first col
                        fCol = RD2("Colno")
                    End If
                    If wCol = 0 And RD2("dWind") = True Then   'first dWind col
                        wCol = RD2("Colno")
                    End If
                    If RD2("LoadDisplay") = True Then   'dChart loaddisplay col
                        dCol &= RD2("Colno") & ","
                        dLine &= RD2("ChartType") & ","
                    End If
                    aCol &= RD2("Colno") & ","  'all col
                    n += 1
                End While

                aCol = aCol.Remove(aCol.Length - 1, 1)
                If dCol = "" Then   '預防載入無欄位
                    dCol = fCol
                    dLine = "spline"
                Else
                    dCol = dCol.Remove(dCol.Length - 1, 1)
                    dLine = dLine.Remove(dLine.Length - 1, 1)
                End If

                RD2.close()
                Dim uDate As DateTime = UpdateTime
                If IsDBNull(rd("mDateEnd")) Then   'continue monitoring
                    If uDate > Today Then   'status normol
                        dDate1 = Today.ToString("yyyy/MM/dd 00:00")
                        dDate2 = Today.ToString("yyyy/MM/dd 23:59")
                        rDate1 = Today.AddDays(-15).ToString("yyyy/MM/dd 00:00")
                        rDate2 = Today.ToString("yyyy/MM/dd 23:59")
                    Else    'error
                        dDate1 = uDate.ToString("yyyy/MM/dd 00:00")
                        dDate2 = uDate.ToString("yyyy/MM/dd 23:59")
                        rDate1 = uDate.AddDays(-15).ToString("yyyy/MM/dd 00:00")
                        rDate2 = uDate.ToString("yyyy/MM/dd 23:59")
                    End If
                Else    'end  monitoring
                    Dim uDateEnd As DateTime = rd("mDateEnd")
                    dDate1 = uDateEnd.ToString("yyyy/MM/dd 00:00")
                    dDate2 = uDateEnd.ToString("yyyy/MM/dd 23:59")
                    rDate1 = uDateEnd.AddDays(-15).ToString("yyyy/MM/dd 00:00")
                    rDate2 = uDateEnd.AddDays(1).ToString("yyyy/MM/dd 00:00")
                End If
                Dim ol As String
                Dim start As DateTime = Now
                Dim start_time As String = start.AddDays(-2).ToString("yyyy/MM/dd 00:00")
                Dim end_time As String = start.ToString("yyyy/MM/dd 00:00")

                ol = "<ol Class='breadcrumb'>"
                ol &= OptionList("breadcrumb_station.aspx", "測站資料", "ST=" & st & "&d1=" & rDate1 & "&d2=" & rDate2 & "&DP_NO=" & DP_choice)
                'ol &= OptionList("breadcrumb_table.aspx", "資料表", "ST=" & st & "&d1=" & start_time & "&d2=" & end_time & "&DP_NO=" & DP_choice & "&tt=" & tt & "&f=0" & "&col=" & aCol)
                ol &= OptionList("breadcrumb_chart.aspx", "圖表", "ST=" & st & "&d1=" & start_time & "&d2=" & end_time & "&DP_NO=" & DP_choice & "&tt=" & tt & "&c=0&col=" & dCol & "&line=" & dLine)

                If cSet = True Then
                    ol &= "<li><a href='StationSet.aspx?ST=" & st & "'><i class=""fa fa-gear fa-spin""></i>設定</a></li>"
                End If

                ol &= "</ol>"
                StationOption.Text = ol
                If Request("ch") = 2 Then
                    sdata.Text = "<iframe id='ifs' style='border:none;width:100%;' src='breadcrumb_chart.aspx?ST=" & st & "&d1=" & start_time & "&d2=" & end_time & "&DP_NO=" & DP_choice & "&tt=" & tt & "&c=0&col=" & dCol & "&line=" & dLine & "'  scrolling=no></iframe>"
                Else
                    sdata.Text = "<iframe id='ifs' style='border:none;width:100%;' src='breadcrumb_station.aspx?ST=" & st & "&DP_NO=" & DP_choice & "'  scrolling=no></iframe>" 'height:950px
                End If
            Else
                sdata.Text = "目前無資料"
					End If
            End If
			rd.close()
		rd.close()
        Conn.Close()

    End Sub

    Function OptionList(ByVal url As String, ByVal title As String, ByVal vGet As String) As String
        Dim li As String
        li = "<li><a href='javascript:NewWindow(""" & url & "?" & vGet & """,""" & title & """);"
        li &= "ChangePageTitle(""" & PJn & "-" & title & """);'  class='btn btn-warning' role='button' >"
        li &= title & "</a></li>"
        Return li
    End Function
End Class
