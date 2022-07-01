Imports System.Data.SqlClient
Partial Class breadcrumb_station
    Inherits System.Web.UI.Page
    Dim Con As String = System.Configuration.ConfigurationManager.ConnectionStrings("DBcs").ConnectionString
    Dim Conn As New SqlConnection(Con)
    Dim station_code As String
    Dim STtype As String
    Dim dTable As String
    Dim tt As String
    Dim dFormat As String
    Dim dp_no_quest As String

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        getdata()

    End Sub

    Sub getdata()
		dim val as String = ""
        Conn.Open()
        dp_no_quest = Request("DP_NO")
        station_code = Request("ST")
            Dim station_st As String = ""
            Select Case Request("ST")
                Case "NPL-12001"
                    station_st = "ThreeBambooLake"
                Case "NPL-12002"
                    station_st = "ParkingLot2-parking"
                Case "NPL-12003"
                    station_st = "Stop8-parking"
                Case "NPL-12004"
                    station_st = "SantangLake"
                Case "NPL-12005"
                    station_st = "CentralWestRoad&SouthSectionSouthRoad"
                Case "NPL-12006"
                    station_st = "SouthSectionSouthRoad&South2ndRoad"
                Case "NPL-12007"
                    station_st = "SouthSectionSouthRoad&South3ndRoad"
                Case "NPL-12008"
                    station_st = "SilaAvenue&SouthNorthRoad"
                Case "NPL-12009"
                    station_st = "SouthNorthRoad&South6ndRoad"
                Case "NPL-12010"
                    station_st = "SouthNorthRoad&South7ndRoad"
                Case "NPL-12011"
                    station_st = "SouthNorthRoad&South9ndRoad"
                Case "NPL-12012"
                    station_st = "SouthNorthRoad&CentralEastRoad"
                Case "NPL-12013"
                    station_st = "South9ndRoad&CentralEastRoad"
                Case "NPL-12014"
                    station_st = "Stop5-parking"
                Case "NPL-12015"
                    station_st = "Stop9-parking"
                Case "NPL-12016"
                    station_st = "SilaAvenue&Dashun8Road"
                Case "NPL-12017"
                    station_st = "SectionOfEastRingRoad"
                Case "NPL-12018"
                    station_st = "Dashun7Road"
                Case "NPL-12019"
                    station_st = "YingxiLake"
                Case "NPL-12020"
                    station_st = "NNKIEH"
                Case = "Nanzi"
                    station_st = "Nanzi"
                Case = "Annan"
                    station_st = "Annan"
                Case = "Shanhua"
                    station_st = "Shanhua"
                Case = "Xinying"
                    station_st = "Xinying"
                Case = "Tainan"
                    station_st = "Tainan"
                Case = "DalinPu"
                    station_st = "DalinPu"
                Case = "Daliao"
                    station_st = "Daliao"
                Case = "Xiaogang"
                    station_st = "Xiaogang"
                Case = "Renwu"
                    station_st = "Renwu"
                Case = "Zuoying"
                    station_st = "Zuoying"
                Case = "Linyuan"
                    station_st = "Linyuan"
                Case = "Qianjin"
                    station_st = "Qianjin"
                Case = "Qianzhen"
                    station_st = "Qianzhen"
                Case = "Meinong"
                    station_st = "Meinong"
                Case = "Fuxing"
                    station_st = "Fuxing"
                Case = "Fengshan"
                    station_st = "Fengshan"
                Case = "Qiaotou"
                    station_st = "Qiaotou"
                Case = "Fengshan_Reservoir"
                    station_st = "Fengshan_Reservoir"
                Case = "Aiguoguo_school"
                    station_st = "Aiguoguo_school"
                Case = "Fwngyang_school"
                    station_st = "Fwngyang_school"
                Case = "Chenggong"
                    station_st = "Chenggong"
                Case = "Gong_13"
                    station_st = "Gong_13"
                Case = "Gong_19"
                    station_st = "Gong_19"
                Case = "Gong_29"
                    station_st = "Gong_29"
                Case = "Nankeshizhong"
                    station_st = "Nankeshizhong"
                Case = "Chengxi"
                    station_st = "Chengxi"
                Case = "Nanxi"
                    station_st = "Nanxi"
                Case = "Tainan_waste_water"
                    station_st = "Tainan_waste_water"
                Case = "Kaohsiung_waste_water"
                    station_st = "Kaohsiung_waste_water"
            End Select

            Dim SQL1, ST_Name As String
            SQL1 = "SELECT [STName_TW],STtype,[Lat],[Lng],[dTable],[Zoom]"
            SQL1 &= "FROM [STSP].[dbo].[STSP_Station]"
            SQL1 &= "where STName='" & station_st & "'"
            Dim cmd1 As New SqlCommand(SQL1, Conn)
            Dim rd1 As SqlDataReader
            rd1 = cmd1.ExecuteReader
            If rd1.Read Then
                STtype = rd1("STtype")
                dTable = rd1("dTable")
            ST_Name = rd1("STName_TW").ToString.Trim
            Dim updatetime As DateTime

                Dim sql2 As String
                sql2 = "Select Top 1 TableType,UpdateTime From STSP.dbo.STSP_StationTables "
            sql2 &= " Where STid='" & station_code & "'   And  IsGeneral=1 And UpdateTime Is Not null Order By sIndex desc "
            Dim cmd2 As New SqlCommand(sql2, Conn)
                Dim rd2 As SqlDataReader
                rd2 = cmd2.ExecuteReader
                If rd2.Read Then
                    tt = rd2("TableType")
                'updatetime = rd2("UpdateTime")
            End If


                Dim fCol As Byte = 0
                Dim sli() As String = {"success", "info", "primary", "default"}
                Dim s1 As String
                's1 &= "<ul class='list-group clear-list m-t' style='height:280px;overflow-y:auto;padding-right:15px;margin-bottom:0px;padding-bottom:10px;'>"
                Dim v As Byte = 1

                Dim sql3 As String

            If station_code.Substring(0, 3) = "NPL" Then
                    sql3 = "Select Colno,Parameter,Unit,DecimalPoint From STSP.dbo.STSP_Parameter_air Where STid='" & station_code & "' And tabletype='' Order By Colno "
                Else
                    sql3 = "Select Colno,Parameter,Unit,DecimalPoint From STSP.dbo.STSP_Parameter_air Where station='" & ST_Name & "' And tabletype='' Order By Colno "
                End If
            If ST_Name = "臺南污水廠" Then
                sql3 = "Select DISTINCT Colno,Parameter,Unit,ChartType,Decimalpoint,TableType From STSP.dbo.STSP_Parameter_water Where station='臺南污水廠'  and dp_no ='" & dp_no_quest & "' "
            ElseIf ST_Name = "高雄污水廠" Then
                sql3 = "Select Colno,Parameter,Unit,ChartType,Decimalpoint,TableType From STSP.dbo.STSP_Parameter_water Where station='高雄污水廠'  and dp_no ='" & dp_no_quest & "' "
            End If



            Dim Com3 As New SqlCommand(sql3, Conn)
                Dim RD3 As SqlDataReader = Com3.ExecuteReader()
                While RD3.Read()

                    If fCol = 0 Then : fCol = RD3("Colno") : End If

                    If v = 1 Then
                        s1 &= "<li class='list-group-item fist-item'>"
                    Else
                        s1 &= "<li class='list-group-item'>"
                    End If

                Dim SQL20 As String
                Dim pno As String = ""
                If ST_Name = "高雄污水廠" Or ST_Name = "臺南污水廠" Then
                    pno = " And DP_NO='" & dp_no_quest & "'  "
                End If
                If station_code.Substring(0, 3) = "NPL" Then
                    SQL20 = "Select Top 1 Value" & RD3("Colno") & " ,Date_Time From " & dTable & tt & " Where STid='" & station_code & "' Order By Date_Time Desc"
                Else
                    SQL20 = "Select Top 1 Value" & RD3("Colno") & " ,Date_Time From " & dTable & tt & " Where station='" & ST_Name & "' " & pno & "  Order By Date_Time Desc"
                End If
					'response.write(SQL20)
                    Dim Com20 As New SqlCommand(SQL20, Conn)
                    Dim RD20 As SqlDataReader = Com20.ExecuteReader()
                If RD20.Read() Then
                    If IsDBNull(RD20(0)) Then : val = "--" : Else : val = Math.Round(RD20(0), RD3("DecimalPoint")) : End If
                    's1 &= "<span class='pull-right' style='position:absolute; right:120px;'>" & Math.Round(RD20(0), RD3("DecimalPoint")) & "</span>"
                    s1 &= "<span class='pull-right' style='position:absolute; right:120px;'>" & val & "</span>"
                End If
                updatetime = RD20("Date_Time")
                s1 &= "<span class='pull-right'>" & RD3("Unit") & "</span>"
					RD20.Close()
                    'If IsDBNull(RD2("v" & tt)) Then : val = "-" : Else : val = Math.Round(RD2("v" & tt), RD2("DecimalPoint")) : End If
                    s1 &= "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span> " & RD3("Parameter") & "</li>"
                    v += 1
                End While
                s1 &= "</ul>"
				RD3.close()
                tParameter.Text = s1
            tTotal.Text = "共" & v - 1 & "個測項，顯示來源：" & tt & " (" & updatetime.ToString(" HH:mm:ss") & ")"

            Dim Zoom As Double
                If rd1("Lat") = 0 And rd1("Lng") = 0 Then : Zoom = 1 : Else : Zoom = rd1("Zoom") : End If

                gMap.Text = sMap(rd1("Lat"), rd1("Lng"), Zoom)


                gImg.Text = sImg()
            End If
			RD1.Close()
            Conn.Close()
            conn.dispose()

    End Sub

    Function sMap(ByVal lat As Double, ByVal lng As Double, ByVal z As Byte) As String
        Dim ReStr As String
        ReStr = "<script type='text/javascript'>"
        ReStr &= "function initMap() {"
        ReStr &= "    var mapOptions1 = {"
        ReStr &= "        zoom: " & z & ","
        ReStr &= "        center: new google.maps.LatLng(" & lat & ", " & lng & ")"
        ReStr &= "    };"
        ReStr &= "    var mapElement1 = document.getElementById('map1');"
        ReStr &= "    var map1 = new google.maps.Map(mapElement1, mapOptions1);"
        ReStr &= "    var point = new google.maps.LatLng(" & lat & ", " & lng & "); "
        ReStr &= "    var marker = new google.maps.Marker({ map : map1, position : point });"
        ReStr &= "};</script>"
        'ReStr &= "<script>google.maps.event.addDomListener(window, 'load', initMap);</script>"
        Return ReStr
    End Function

    Function sImg() As String
        Dim ReStr As String = ""
        Dim Com5 As New SqlCommand("Select Img,Note From STSP.dbo.STSP_StationImg Where STid='" & station_code & "'", Conn)
        Dim RD5 As SqlDataReader = Com5.ExecuteReader()
        If RD5.Read() Then
            ReStr &= "<a class='fancybox' href='sys_data/Station_img/" & RD5("Img") & "' title='" & RD5("Note") & "'><img alt='image' width='100%'  src='sys_data/Station_img/" & RD5("Img") & "' /></a>"
        End If
        If ReStr = "" Then
            ReStr = "<p class='text-muted'>暫無照片</p>"
        End If
		RD5.Close()
        Return ReStr
    End Function

End Class

