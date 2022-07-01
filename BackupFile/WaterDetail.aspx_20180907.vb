Imports System.Data.SqlClient
Imports System.Web.Configuration
Partial Class WaterDetail
    Inherits System.Web.UI.Page
    Dim Con As String = WebConfigurationManager.ConnectionStrings("DBcs").ConnectionString
    Dim Conn As New SqlConnection(Con)
    Dim station_code As String
    Dim STtype As String
    Dim dTable As String
    Dim tt As String
    Dim dFormat As String

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        getdata()

    End Sub

    Sub getdata()
		dim val as String = ""
        Conn.Open()
        station_code = Request("ST")
        get_water_data()
        Conn.Close()
        Conn.dispose()
        Exit Sub
    End Sub
	
    Sub get_water_data()

        Dim Tainan1_stids() As String = {"D01", "D02"}
        Dim Tainan2_stids() as String = { "T01", "T02", "T03"}

        Dim ST_Name As String
        Dim v As Byte = 1 
        dim s1 as string = ""
        'start for 臺南汙水廠
        station_code = "Tainan_waste_water" 
   
            Dim UpdateTime As DateTime
            For i = 0 To Tainan1_stids.Length - 1

                Dim fCol As Byte = 0
                s1 = "<ul id=""u1"" class='list-group clear-list m-t' style='height:250px;overflow-y:auto;padding-right:15px;margin-bottom:0px;padding-bottom:10px;'>"
                Dim stid As String
                'stid = Request("ST")
                Dim station_st = "Tainan_waste_water"

                ST_Name = "臺南污水廠"
                Dim SQL1 As String
                SQL1 = "SELECT [STName_TW],STtype,[Lat],[Lng],[dTable],[Zoom]"
                SQL1 &= "FROM [STSP].[dbo].[STSP_Station]"
                SQL1 &= "where STName='" & station_st & "'"
                Dim Com1 As New SqlCommand(SQL1, Conn)
                Dim RD1 As SqlDataReader = Com1.ExecuteReader()
 
                If RD1.Read() Then

                    STtype = RD1("STtype")
                    dTable = RD1("dTable")


                    Dim Com11 As New SqlCommand("Select Top 1 TableType,UpdateTime FROM [STSP].[dbo].[STSP_StationTables] Where stid='" & station_st & "'  And IsGeneral=1 And UpdateTime Is Not null Order By sIndex ", Conn)
                    Dim RD11 As SqlDataReader = Com11.ExecuteReader()
                    If RD11.Read() Then
                        tt = RD11("TableType")
                        UpdateTime = RD11("UpdateTime")

                    End If
					RD11.close()

                    Dim sli() As String = {"success", "info", "primary", "default"}

                    
                    Dim Com2 As New SqlCommand("Select Colno,Parameter,Unit,DecimalPoint From STSP.dbo.STSP_Parameter_water Where station='" & ST_Name & "' and dp_no='" & Tainan1_stids(i) & "' AND Colno <> '6' Order By Colno ", Conn)
                    Dim RD2 As SqlDataReader = Com2.ExecuteReader()
                    v = 1
                    While RD2.Read()

                        If fCol = 0 Then : fCol = RD2("Colno") : End If

                        If v = 1 Then
                            s1 += " <li  id=""li1"" Class='list-group-item fist-item' >"

                        Else
                            s1 += " <li  id=""li1"" Class='list-group-item'  >"
                        End If

                        s1 += "<span class='pull-right'>" & RD2("Unit") & "</span>"

                        Dim SQL20 As String = "Select Top 1 Value" & RD2("Colno") & " From " & dTable & tt & " Where station='" & ST_Name & "' and dp_no='" & Tainan1_stids(i) & "' Order By Date_Time Desc "
                        Dim Com20 As New SqlCommand(SQL20, Conn)
                        Dim RD20 As SqlDataReader = Com20.ExecuteReader()
                        If RD20.Read() Then
                            s1 += "<span class='pull-right' style='position:absolute; right:150px;' style=''>" & Tainan1_stids(i) & "</span>"
                            s1 += "<span class='pull-right' style='position:absolute; right:85px;'>" & Math.Round(RD20(0), RD2("DecimalPoint")) & "</span>"
                        End If
                        'If IsDBNull(RD2("v" & tt)) Then : val = "-" : Else : val = Math.Round(RD2("v" & tt), RD2("DecimalPoint")) : End If
						RD20.close()
                        s1 += "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span> " & RD2("Parameter") & "</li>"

                        v += 1
                    End While
					RD2.Close()

                End If
                select case Tainan1_stids(i)
                    case "D01"
                        stationD01.Text = "D01 出水口監測結果"
                        tTotalD01.Text = "共" & v - 1 & "個測項，顯示來源：" & tt & " (" & UpdateTime.ToString(dFormat & " HH:mm:ss") & ")"
                        tParameterD01.Text = s1
                    case "D02"
                        stationD02.Text = "D02 出水口監測結果"
                        tTotalD02.Text = "共" & v - 1 & "個測項，顯示來源：" & tt & " (" & UpdateTime.ToString(dFormat & " HH:mm:ss") & ")"
                        tParameterD02.Text = s1
                end select 
                s1 &= "</ul>"
            Next
            examtime.Text = UpdateTime.ToString("yyyy/MM/dd  HH:mm")
        ' 以下處理高雄汙水廠資料
        s1 = ""
        v  = 1
        Dim Kao_stids() As String = {"D01", "T01"}
            For i = 0 To Kao_stids.Length - 1


                Dim stid As String
                stid = "Kaohsiung_waste_water"
                Dim station_st = stid

                    ST_Name = "高雄污水廠"


                Dim SQL1 As String
                SQL1 = "SELECT [STName_TW],STtype,[Lat],[Lng],[dTable],[Zoom]"
                SQL1 &= "FROM [STSP].[dbo].[STSP_Station]"
                SQL1 &= "where STName='" & station_st & "'"
                Dim Com1 As New SqlCommand(SQL1, Conn)
                Dim RD1 As SqlDataReader = Com1.ExecuteReader()

                If RD1.Read() Then

                    STtype = RD1("STtype")
                    dTable = RD1("dTable")

                    Dim Com11 As New SqlCommand("Select Top 1 TableType,UpdateTime FROM [STSP].[dbo].[STSP_StationTables] Where stid='" & station_st & "'  And IsGeneral=1 And UpdateTime Is Not null Order By sIndex ", Conn)
                    Dim RD11 As SqlDataReader = Com11.ExecuteReader()
                    If RD11.Read() Then
                        tt = RD11("TableType")
                        UpdateTime = RD11("UpdateTime")

                    End If
					RD11.Close()
                    'dim fCol as byte=0
                    Dim sli() As String = {"success", "info", "primary", "default"}

                    Dim Com2 As New SqlCommand("Select Colno,Parameter,Unit,DecimalPoint From STSP.dbo.STSP_Parameter_water Where station='" & ST_Name & "' and dp_no='" & Kao_stids(i) & "' AND Colno <>'6' Order By Colno ", Conn)
                    Dim RD2 As SqlDataReader = Com2.ExecuteReader()
                    While RD2.Read()

                        'If fCol = 0 Then : fCol = RD2("Colno") : End If

                        If v = 1 Then
                            s1 += " <li  id=""li1"" Class='list-group-item fist-item' >"

                        Else
                            s1 += " <li  id=""li1"" Class='list-group-item'  >"
                        End If

                        s1 += "<span class='pull-right'>" & RD2("Unit") & "</span>"

                        Dim SQL20 As String
                        SQL20 = "Select Top 1 Value" & RD2("Colno") & " From " & dTable & tt & " Where station='" & ST_Name & "' and dp_no='" & Kao_stids(i) & "' Order By Date_Time Desc "
                        Dim Com20 As New SqlCommand(SQL20, Conn)
                        Dim RD20 As SqlDataReader = Com20.ExecuteReader()
                        If RD20.Read() Then
                            s1 += "<span class='pull-right' style='position:absolute; right:150px;' style=''>" & Kao_stids(i) & "</span>"
                            s1 += "<span class='pull-right' style='position:absolute; right:85px;'>" & Math.Round(RD20(0), RD2("DecimalPoint")) & "</span>"
                        End If
                        'If IsDBNull(RD2("v" & tt)) Then : val = "-" : Else : val = Math.Round(RD2("v" & tt), RD2("DecimalPoint")) : End If
						RD20.Close()
                        s1 += "<span class='label label-" & sli((v - 1) Mod sli.Length) & "'>" & v & "</span> " & RD2("Parameter") & "</li>"

                        v += 1
                    End While
					RD2.Close()

                End If

            Next
            Station1.Text = "高雄污水廠 D01出水口& T01進水口"
            tTotal1.Text = "共" & v - 1 & "個測項，顯示來源：" & tt & " (" & UpdateTime.ToString(dFormat & " HH:mm:ss") & ")"
            tParameter1.Text = s1                    
            s1 &= "</ul>"
            examtime2.Text = UpdateTime.ToString("yyyy/MM/dd  HH:mm")

    End Sub
End Class

