Imports System.Data.SqlClient
Imports System.Web.Configuration
Partial Class AQI_Detail
    Inherits System.Web.UI.Page
    Dim Con As String = WebConfigurationManager.ConnectionStrings("DBcs").ConnectionString
    Dim Conn As New SqlConnection(Con)
    Dim station_code As String = ""

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        conn.open()
        getdata()
        getEPAdata()
        conn.Close()
        conn.dispose()
    End Sub

    Private Sub getdata()
        Dim pDate as String = Now.AddHours(-1).ToString("yyyy/MM/dd HH:00:00")
        'Dim pDate as String = Now.ToString("yyyy/MM/dd HH:00:00")
		dim val as String = ""
        'station_code = "Tainan_waste_water"
           dim sql1 as string = "select top 4  [Station_ID],[Station] ,[AQI_Item] ,[AQI_Value],[Date_Time] from AQI_Log_Report  Where Date_Time <= '" & pdate & "' order by Date_Time desc, Station_ID ASC "

            Dim cmd as SqlCommand = new SqlCommand(sql1, Conn)
            Dim RD1 as SqlDataReader = cmd.ExecuteReader()

            Dim station_st As String = ""
            While RD1.Read()
                if RD1("Station_ID") = "B01" Then exit While
                station_st = RD1("Station")
                Dim updatetime As DateTime = RD1("Date_Time").AddHours(1)
                examtime.Text = updatetime.ToString("yyyy/MM/dd  HH:mm")
                Dim fCol As Byte = 0
                Dim sli() As String = {"success", "info", "primary", "default"}
                Dim s1 As String=""
                s1 &= "<ul class='list-group clear-list m-t' style='height:280px;overflow-y:auto;padding-right:5px;margin-bottom:0px;padding-bottom:5px;'>"
                Dim v As Byte = 1
                if RD1("Station_ID") = "A01" or RD1("Station_ID") = "A04"  or RD1("Station_ID") = "A02"  or RD1("Station_ID") = "A03" then
                    s1 &= "<li class='list-group-item fist-item'>"
                    If IsDBNull(RD1("AQI_Value")) Then : val = "--" : Else : val = RD1("AQI_Value").ToString() : End If                       
                    s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & val & "</span>" 
                    s1 &= "<span class='pull-right'>" & "</span>" 
                    s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span> " & "AQI" & "</li>" 
                    v=v+1
                end if    
                    Dim sql3 As String = "Select Colno,Parameter,Unit,DecimalPoint From STSP.dbo.STSP_Parameter_air Where station='" & station_st & "' Order By Colno "
                    cmd.commandtext = sql3
                    Dim Cmd1 as New SqlCommand(sql3,conn)
                    Dim RD3 As SqlDataReader = Cmd1.ExecuteReader()

                    While RD3.Read()

                        fCol = RD3("Colno")+1
                        s1 &= "<li class='list-group-item'>"
                        Dim selectPar As String = ""
                        Select Case RD3("Parameter")
                            Case "細懸浮微粒"
                                selectPar = " convert(decimal(9,0), Value" & RD3("Colno") & ")"
                            Case Else
                                selectPar = " Value" & RD3("Colno")
                        End Select
                        Dim SQL20 As String
                        SQL20 = "Select Top 1 " & selectPar & " From STSP_S502T60 Where station='" & station_st & "' AND  Date_Time= '" & updatetime.AddHours(-1).ToString("yyyy/MM/dd HH:00:00") & "'  Order By Date_Time Desc"
                        'response.write(SQL20)
                        Dim Cmd2 as New Sqlcommand(SQL20,conn)
                        Dim RD20 As SqlDataReader = Cmd2.ExecuteReader()
                        If RD20.Read() Then
                            If IsDBNull(RD20(0)) Then : val = "--" : Else : val = Math.Round(RD20(0), RD3("DecimalPoint")) : End If
                            's1 &= "<span class='pull-right' style='position:absolute; right:120px;'>" & Math.Round(RD20(0), RD3("DecimalPoint")) & "</span>"
                            s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & val & "</span>"
                        Else
                            s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & "數據處理中.." & "</span>"
                        End If
                        s1 &= "<span class='pull-right'>" & RD3("Unit") & "</span>"
                        RD20.Close()
                        'If IsDBNull(RD2("v" & tt)) Then : val = "-" : Else : val = Math.Round(RD2("v" & tt), RD2("DecimalPoint")) : End If
                        s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span> " & RD3("Parameter") & "</li>"
                        v += 1
                    End While
                    s1 &= "</ul>"
                    RD3.close()
                Select case RD1("Station_ID")
                    case "A01"
                        StationA01.text = RD1("Station") & "監測結果"
                        tParameterA01.Text = s1
                        tTotalA01.Text = "共" & v - 1 & "個測項，顯示來源：" & "60分鐘值" & " (發佈時間:" & updatetime.ToString(" HH:mm:ss") & ")"   
                    case "A02"
                        StationA02.text = RD1("Station") & "監測結果" 
                        tParameterA02.Text = s1
                        tTotalA02.Text = "共" & v - 1 & "個測項，顯示來源：" & "60分鐘值" & " (發佈時間:" & updatetime.ToString(" HH:mm:ss") & ")"                           
                    case "A03"
                        StationA03.text = RD1("Station") & "監測結果"
                        tParameterA03.Text = s1
                        tTotalA03.Text = "共" & v - 1 & "個測項，顯示來源：" & "60分鐘值" & " (發佈時間:" & updatetime.ToString(" HH:mm:ss") & ")"                            
                    case "A04"
                        StationA04.text = RD1("Station") & "監測結果"
                        tParameterA04.Text = s1
                        tTotalA04.Text = "共" & v - 1 & "個測項，顯示來源：" & "60分鐘值" & " (發佈時間:" & updatetime.ToString(" HH:mm:ss") & ")"                                                                                        
                end select
            End While
			RD1.Close()
    End Sub

    Private Sub getEPAdata()
		dim val as String = ""
        'dim pDate as String = Now.Addhours(-1).ToString("yyyy/MM/dd HH:00:00")
        dim pDate as String = Now.ToString("yyyy/MM/dd HH:00:00")
        Dim sql1 As String = "select top 4 [Date_Time],[Station],convert(decimal(9,0),[AQI]) AQI,convert(decimal(9,0),[PM10]) PM10,convert(decimal(9,0),[PM10_AVG]),convert(decimal(9,0),[PM2.5]) 'PM2.5' ,convert(decimal(9,0),[PM2.5_AVG]),convert(decimal(9,1),[O3]) O3,convert(decimal(9,1),[O3_8]),[CO],convert(decimal(9,1),[SO2]) SO2 ,convert(decimal(9,1),[NO2]) NO2,[WD],[WS]" &
                            " from AQX Where Station IN ('臺南站','安南站','善化站','新營站') AND Date_Time <= '" & pDate & "' order by Date_Time desc"

        Dim cmd as SqlCommand = new SqlCommand(sql1, Conn)
            Dim RD1 as SqlDataReader = cmd.ExecuteReader()

            Dim station_st As String = ""
            While RD1.Read()
                station_st = RD1("Station")
                Dim updatetime As DateTime = RD1("Date_Time")
                examtime2.Text = updatetime.ToString("yyyy/MM/dd  HH:mm")
                Dim fCol As Byte = 0
                Dim sli() As String = {"success", "info", "primary", "default"}
                Dim s1 As String=""
                s1 &= "<ul class='list-group clear-list m-t' style='height:280px;overflow-y:auto;padding-right:5px;margin-bottom:0px;padding-bottom:5px;'>"
                Dim v As Byte = 1
                s1 &= "<li class='list-group-item fist-item'>"
                If IsDBNull(RD1("AQI")) Then : val = "--" : Else : val = RD1("AQI").ToString() : End If                       
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & val & "</span>" 
                s1 &= "<span class='pull-right'>" & "</span>" 
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span> " & "AQI" & "</li>" 
                v += 1
                s1 &= "<li class='list-group-item'>"
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & IIF(IsDBNull(RD1("PM10")),"---",RD1("PM10").ToString()) & "</span>"
                s1 &= "<span class='pull-right'>μg/m3</span>"            
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span>懸浮微粒</li>"
                v += 1
                s1 &= "<li class='list-group-item'>"
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & IIF(IsDBNull(RD1("PM2.5")),"---",RD1("PM2.5").ToString()) & "</span>"
                s1 &= "<span class='pull-right'>μg/m3</span>"            
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span>細懸浮微粒</li>"        
                v += 1
                s1 &= "<li class='list-group-item'>"
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & IIF(IsDBNull(RD1("O3")),"---",RD1("O3").ToString()) & "</span>"
                s1 &= "<span class='pull-right'>ppb</span>"            
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span>臭氧</li>"
                v += 1
                s1 &= "<li class='list-group-item'>"
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & IIF(IsDBNull(RD1("CO")),"---",RD1("CO").ToString()) & "</span>"
                s1 &= "<span class='pull-right'>ppm</span>"            
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span>一氧化碳</li>"  
                v += 1
                s1 &= "<li class='list-group-item'>"
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & IIF(IsDBNull(RD1("SO2")),"---",RD1("SO2").ToString()) & "</span>"
                s1 &= "<span class='pull-right'>ppb</span>"            
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span>二氧化硫</li>"  
                v += 1
                s1 &= "<li class='list-group-item'>"
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & IIF(IsDBNull(RD1("NO2")),"---",RD1("NO2").ToString()) & "</span>"
                s1 &= "<span class='pull-right'>ppb</span>"            
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span>氮氧化物</li>"
                v += 1
                s1 &= "<li class='list-group-item'>"
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & IIF(IsDBNull(RD1("WD")),"---",RD1("WD").ToString()) & "</span>"
                s1 &= "<span class='pull-right'>deg</span>"            
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span>小時風向</li>"     
                v += 1
                s1 &= "<li class='list-group-item'>"
                s1 &= "<span class='pull-right' style='position:absolute; right:65px;'>" & IIF(IsDBNull(RD1("WS")),"---",RD1("WS").ToString()) & "</span>"
                s1 &= "<span class='pull-right'>m/s</span>"            
                s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span>小時風速</li>"                                                                                                                                                     
                    ' Dim sql3 As String = "Select Colno,Parameter,Unit,DecimalPoint From STSP.dbo.STSP_Parameter_air Where station='" & station_st & "' Order By Colno "
                    ' 'cmd.commandtext = sql3
                    ' Dim Cmd1 as New SqlCommand(sql3,conn)
                    ' Dim RD3 As SqlDataReader = Cmd1.ExecuteReader()
                    ' v=2
                    ' While RD3.Read()
                    '     fCol = RD3("Colno")+1
                    '     s1 &= "<li class='list-group-item'>"

                    '     Dim SQL20 As String
                    '     SQL20 = "Select Top 1 Value" & RD3("Colno") & " From STSP_S503T60 Where station='" & station_st & "' AND  Date_Time= '" & updatetime.ToString("yyyy/MM/dd HH:00:00") & "'  Order By Date_Time Desc"
                    '    'response.write(SQL20)
                    '     Dim Cmd2 as New SqlCommand(SQL20,conn)
                    '     Dim RD20 As SqlDataReader = Cmd2.ExecuteReader()
                    '     If RD20.Read() Then
                    '         If IsDBNull(RD20(0)) Then : val = "--" : Else : val = Math.Round(RD20(0), RD3("DecimalPoint")) : End If
                    '         's1 &= "<span class='pull-right' style='position:absolute; right:120px;'>" & Math.Round(RD20(0), RD3("DecimalPoint")) & "</span>"
                    '         s1 &= "<span class='pull-right' style='position:absolute; right:85px;'>" & val & "</span>"
                    '     Else
                    '         s1 &= "<span class='pull-right' style='position:absolute; right:85px;'>" & "計算中.." & "</span>"
                    '     End If
                    '     s1 &= "<span class='pull-right'>" & RD3("Unit") & "</span>"
                    '     RD20.Close()
                    '     'If IsDBNull(RD2("v" & tt)) Then : val = "-" : Else : val = Math.Round(RD2("v" & tt), RD2("DecimalPoint")) : End If
                    '     s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span> " & RD3("Parameter") & "</li>"
                    '     v += 1
                    ' End While
                    ' s1 &= "</ul>"
                    ' RD3.close()
                Select case station_st
                    case "臺南站"
                        Station1.text = station_st & "監測結果"
                        tParameter1.Text = s1
                        tTotal1.Text = "共" & v - 1 & "個測項，顯示來源：" & "60分鐘值" & " (發佈時間:" & updatetime.ToString(" HH:mm:ss") & ")"   
                    case "安南站"
                        Station2.text = RD1("Station") & "監測結果" 
                        tParameter2.Text = s1
                        tTotal2.Text = "共" & v - 1 & "個測項，顯示來源：" & "60分鐘值" & " (發佈時間:" & updatetime.ToString(" HH:mm:ss") & ")"                           
                    case "善化站"
                        Station3.text = RD1("Station") & "監測結果"
                        tParameter3.Text = s1
                        tTotal3.Text = "共" & v - 1 & "個測項，顯示來源：" & "60分鐘值" & " (發佈時間:" & updatetime.ToString(" HH:mm:ss") & ")"                            
                    case "新營站"
                        Station4.text = RD1("Station") & "監測結果"
                        tParameter4.Text = s1
                        tTotal4.Text = "共" & v - 1 & "個測項，顯示來源：" & "60分鐘值" & " (發佈時間:" & updatetime.ToString(" HH:mm:ss") & ")"                                                                                        
                end select
            End While
			RD1.Close()
    End Sub
	
End Class

