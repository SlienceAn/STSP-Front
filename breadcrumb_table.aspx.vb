Imports System.Data.SqlClient
'Imports Trirand.Web.UI.WebControls
Imports System.Web.UI.WebControls.GridView
Partial Class breadcrumb_table
    Inherits System.Web.UI.Page
    Dim Con As String = System.Configuration.ConfigurationManager.ConnectionStrings("DBcs").ConnectionString
    Dim Conn As New SqlConnection(Con)

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim d As String = Request("d1")
        date_timepicker_start.Text = d
        Dim dd As String = Request("d2")
        date_timepicker_end.Text = dd
        getdrop()
        GridDataCreate()
        GridParameter()
    End Sub
    Sub GridDataCreate()

        Conn.Open()
        Dim dp_no_quest As String = Request("DP_NO")
        Dim SQL_ As String
        Dim Tainan_stids() As String = {"D01", "D02", "T01", "T02", "T03"}
        Dim Kao_stids() As String = {"D01", "T01"}
        Dim STid As String = Request("ST")
        Dim sDate As String = Request("d1")
        Dim eDate As String = Request("d2")
        Dim tt As String = Request("tt")
        Dim col() As String = Request("col").Split(",")
        Dim Flag As Char = Request("f")
        Dim dTable, sql0 As String
        If STid.Substring(0, 3) <> "NPL" Then
            sql0 = "Select dTable From STSP.dbo.STSP_Station Where STName='" & STid & "'"
        Else
            sql0 = "Select dTable From STSP.dbo.STSP_Station Where STid='" & STid & "'"
        End If
        Dim Com0 As New SqlCommand(sql0, Conn)
        Dim RD0 As SqlDataReader = Com0.ExecuteReader()
        If RD0.Read() Then
            dTable = RD0("dTable") & tt
        End If
        Conn.Close()

        Dim dt As New Trirand.Web.UI.WebControls.JQGridColumn
        dt.PrimaryKey = True
        dt.HeaderText = "DateTime"
        dt.FixedWidth = True
        dt.Width = 140
        dt.DataField = "Date_Time"
        dt.Frozen = False
        dt.DataFormatString = "{0:yyyy/MM/dd HH:mm}"
        JQGrid2.Columns.Add(dt)

            Conn.Open()
            Dim SelectValue As String
            For c As Byte = 0 To col.Length - 1

                Dim sql2 As String = ""
                If STid.Substring(0, 3) <> "NPL" Then
                    Select Case STid
                        Case "DalinPu"
                            STid = "大林蒲站"
                        Case "Daliao"
                            STid = "大寮站"
                        Case "Xiaogang"
                            STid = "小港站"
                        Case "Renwu"
                            STid = "仁武站"
                        Case "Zuoying"
                            STid = "左營站"
                        Case "Chenggong"
                            STid = "成功站"
                        Case "Linyuan"
                            STid = "林園站"
                        Case "Qianjin"
                            STid = "前金站"
                        Case "Qianzhen"
                            STid = "前鎮站"
                        Case "Meinong"
                            STid = "美濃站"
                        Case "Fuxing"
                            STid = "復興站"
                        Case "Nanzi"
                            STid = "楠梓站"
                        Case "Fengshan"
                            STid = "鳳山站"
                        Case "Qiaotou"
                            STid = "橋頭站"
                        Case "Annan"
                            STid = "安南站"
                        Case "Shanhua"
                            STid = "善化站"
                        Case "Xinying"
                            STid = "新營站"
                        Case "Tainan"
                            STid = "臺南站"
                        Case "Fengshan_Reservoir"
                            STid = "鳳山水庫站"
                        Case "Fwngyang_school"
                            STid = "鳳陽國小站"
                        Case "Chenggong"
                            STid = "成功站"
                        Case "Aiguoguo_school"
                            STid = "愛國國小站"
                        Case "Gong_13"
                            STid = "公13測站"
                        Case "Gong_19"
                            STid = "公19測站"
                        Case "Gong_29"
                            STid = "公29測站"
                        Case "Nankeshizhong"
                            STid = "南科實中測站"
                        Case "Chengxi"
                            STid = "城西站"
                        Case "Nanxi"
                            STid = "楠西站"
                        Case "Tainan_waste_water"
                            STid = "臺南污水廠"
                        Case "Kaohsuing_wastr_water"
                            STid = "高雄污水廠"
                    End Select
                    sql2 = "Select Colno,Parameter,Unit,Width,Decimalpoint From STSP.dbo.STSP_Parameter_air Where station='" & STid & "' And Colno='" & col(c) & "' And TableType='' Order By Colno "
                Else
                    sql2 = "Select Colno,Parameter,Unit,Width,Decimalpoint From STSP.dbo.STSP_Parameter_air Where STid='" & STid & "' And Colno='" & col(c) & "' And TableType='' Order By Colno "
                End If

                Dim Com2 As New SqlCommand(sql2, Conn)
                Dim RD2 As SqlDataReader = Com2.ExecuteReader()
                If RD2.Read() Then
                    SelectValue &= ",Round(Value" & col(c) & "," & RD2("Decimalpoint") & ") As Value" & col(c)
                    SelectValue &= ",Status" & col(c)
                    Dim colv, colf As New Trirand.Web.UI.WebControls.JQGridColumn
                    colv.HeaderText = RD2("Parameter") & " " & RD2("Unit")
                    colv.FixedWidth = True
                    colv.Width = RD2("Width")
                    colv.DataField = "Value" & RD2("Colno")
                    colv.TextAlign = TextAlign.Right
                    Dim dfs As String
                    If RD2("Decimalpoint") > 0 Then
                        dfs = "."
                        For d As Byte = 1 To RD2("Decimalpoint") : dfs &= "0" : Next
                    End If
                    colv.DataFormatString = "{0:0" & dfs & "}"
                    JQGrid2.Columns.Add(colv)
                    If Flag = "1"c Then
                        colf.HeaderText = "F" '& Data_HeaderText(i)
                        colf.FixedWidth = True
                        colf.Width = 20
                        colf.DataField = "Status" & RD2("Colno")
                        colf.TextAlign = TextAlign.Center
                        JQGrid2.Columns.Add(colf)
                    End If
                End If
            Next

            Conn.Close()

            If STid.Substring(0, 3) <> "NPL" Then
                Select Case STid
                    Case "DalinPu"
                        STid = "大林蒲站"
                    Case "Daliao"
                        STid = "大寮站"
                    Case "Xiaogang"
                        STid = "小港站"
                    Case "Renwu"
                        STid = "仁武站"
                    Case "Zuoying"
                        STid = "左營站"
                    Case "Chenggong"
                        STid = "成功站"
                    Case "Linyuan"
                        STid = "林園站"
                    Case "Qianjin"
                        STid = "前金站"
                    Case "Qianzhen"
                        STid = "前鎮站"
                    Case "Meinong"
                        STid = "美濃站"
                    Case "Fuxing"
                        STid = "復興站"
                    Case "Nanzi"
                        STid = "楠梓站"
                    Case "Fengshan"
                        STid = "鳳山站"
                    Case "Qiaotou"
                        STid = "橋頭站"
                    Case "Annan"
                        STid = "安南站"
                    Case "Shanhua"
                        STid = "善化站"
                    Case "Xinying"
                        STid = "新營站"
                    Case "Tainan"
                        STid = "臺南站"
                    Case "Fengshan_Reservoir"
                        STid = "鳳山水庫站"
                    Case "Fwngyang_school"
                        STid = "鳳陽國小站"
                    Case "Chenggong"
                        STid = "成功站"
                    Case "Aiguoguo_school"
                        STid = "愛國國小站"
                    Case "Gong_13"
                        STid = "公13測站"
                    Case "Gong_19"
                        STid = "公19測站"
                    Case "Gong_29"
                        STid = "公29測站"
                    Case "Nankeshizhong"
                        STid = "南科實中測站"
                    Case "Chengxi"
                        STid = "城西站"
                    Case "Nanxi"
                        STid = "楠西站"
                    Case "Tainan_waste_water"
                        STid = "臺南污水廠"
                    Case "Kaohsuing_wastr_water"
                        STid = "高雄污水廠"

                End Select


                If sDate <> "" And eDate <> "" Then
                    SQL_ = "Select Date_Time" & SelectValue & " From " & dTable & " Where "
                    SQL_ &= "station='" & STid & "' And "
                    SQL_ &= "Date_Time>='" & sDate & "' And "
                    SQL_ &= "Date_Time<='" & eDate & "' "
                    SQL_ &= "Order By Date_Time"
                End If
            Else

                If sDate <> "" And eDate <> "" Then
                    SQL_ = "Select Date_Time" & SelectValue & " From " & dTable & " Where "
                    SQL_ &= "STid='" & STid & "' And "
                    SQL_ &= "Date_Time>='" & sDate & "' And "
                    SQL_ &= "Date_Time<='" & eDate & "' "
                    SQL_ &= "Order By Date_Time"
                End If
            End If


        SqlDataSource1.SelectCommand = SQL_
        JQGrid2.DataSourceID = "SqlDataSource1"
        JQGrid2.DataBind()

    End Sub
    Protected Sub Export_xls_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Export_xls.Click
        Dim gridState As JQGridState = TryCast(Session("gridFilterPageState"), JQGridState)
        JQGrid2.ExportSettings.ExportDataRange = ExportDataRange.All
        JQGrid2.ExportToExcel(Request("ST") & "-" & Request("tt") & "-" & Request("d1") & "-" & Request("d2") & ".xls")
    End Sub

    Protected Sub Export_csv_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Export_csv.Click
        Dim gridState As JQGridState = TryCast(Session("gridFilterPageState"), JQGridState)
        JQGrid2.ExportSettings.ExportDataRange = ExportDataRange.All
        JQGrid2.ExportToExcel(Request("ST") & "-" & Request("tt") & "-" & Request("d1") & "-" & Request("d2") & ".csv")
    End Sub

    Sub GridParameter()
        Conn.Open()
        Dim s As String
        Dim col() As String = Request("col").Split(",")

        s = "<a data-toggle='modal' class='btn btn-success' href='#modal-form' style='margin-left:7px;'><i class='fa fa-gear fa-spin'></i></a>"
        s &= "  <div id='modal-form' class='modal fade' aria-hidden='true'>"
        s &= "      <div class='modal-dialog'>"
        s &= "          <div class='modal-content' style='width:200px;'>"
        s &= "          <div class='modal-header'>"
        s &= "              <h5 class='modal-title' id='myModalLabel'><span class='label label-success'>測項選擇</span></h5>"
        s &= "              <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>"
        s &= "           </div>"       
        s &= "              <div class='modal-body'>"
        s &= "  <div class='row'>"
        's &= "    <div class='checkbox i-checks'><label style='width:100%;margin-left:20px;'> "
        s &= "    <div class='checkbox i-checks'> "
		's &= "    <label style='width:100%;margin-left:20px;' id='cAll' name='cAll' onclick=""SelectAll('cAll')""> "
		s &= "    <label style='width:100%;margin-left:20px;' onclick=""SelectAll('cAll')""> "
        s &= "     		<input type='checkbox' class='checkbox i-checks' id='cAll' name='cAll' checked >  <button type='button' class='btn btn-warning'>全選</button></label>"
        s &= "    </div>"
        s &= "  </div>"

        Dim n As Byte = 0
        Dim SqlStr As String
        Dim sql2 As String = ""
        Dim STid As String = Request("ST")
        If STid.Substring(0, 3) <> "NPL" Then
            Select Case STid
                Case "DalinPu"
                    STid = "大林蒲站"
                Case "Daliao"
                    STid = "大寮站"
                Case "Xiaogang"
                    STid = "小港站"
                Case "Renwu"
                    STid = "仁武站"
                Case "Zuoying"
                    STid = "左營站"
                Case "Chenggong"
                    STid = "成功站"
                Case "Linyuan"
                    STid = "林園站"
                Case "Qianjin"
                    STid = "前金站"
                Case "Qianzhen"
                    STid = "前鎮站"
                Case "Meinong"
                    STid = "美濃站"
                Case "Fuxing"
                    STid = "復興站"
                Case "Nanzi"
                    STid = "楠梓站"
                Case "Fengshan"
                    STid = "鳳山站"
                Case "Qiaotou"
                    STid = "橋頭站"
                Case "Annan"
                    STid = "安南站"
                Case "Shanhua"
                    STid = "善化站"
                Case "Xinying"
                    STid = "新營站"
                Case "Tainan"
                    STid = "臺南站"
                Case "Fengshan_Reservoir"
                    STid = "鳳山水庫站"
                Case "Fwngyang_school"
                    STid = "鳳陽國小站"
                Case "Chenggong"
                    STid = "成功站"
                Case "Aiguoguo_school"
                    STid = "愛國國小站"
                Case "Gong_13"
                    STid = "公13測站"
                Case "Gong_19"
                    STid = "公19測站"
                Case "Gong_29"
                    STid = "公29測站"
                Case "Nankeshizhong"
                    STid = "南科實中測站"
                Case "Chengxi"
                    STid = "城西站"
                Case "Nanxi"
                    STid = "楠西站"
                Case "Tainan_waste_water"
                    STid = "臺南污水廠"
                Case "Kaohsiung_waste_water"
                    STid = "高雄污水廠"

            End Select
            If STid = "臺南污水廠" Then
                SqlStr = "Select Colno,Parameter,Unit,ChartType,TableType From STSP.dbo.STSP_Parameter_water Where station='" & STid & "' and dp_no='D01'"
            ElseIf STid = "高雄污水廠" Then
                SqlStr = "Select Colno,Parameter,Unit,ChartType,TableType From STSP.dbo.STSP_Parameter_water Where station='" & STid & "' and dp_no='D01'"
            Else
                SqlStr = "Select Colno,Parameter,Unit,ChartType,TableType From STSP.dbo.STSP_Parameter_air Where station='" & STid & "' And TableType='' "
            End If
        Else
                SqlStr = "Select Colno,Parameter,Unit,ChartType,TableType From STSP.dbo.STSP_Parameter_air Where STid='" & STid & "' And TableType='' "
        End If
        'SqlStr = " Select Colno,Parameter,Unit,ChartType,TableType From STSP.dbo.STSP_Parameter_air Where STid='" & Request("ST") & "' And TableType='' "
        Dim Com As New SqlCommand(SqlStr, Conn)
        Dim RD As SqlDataReader = Com.ExecuteReader()
        While RD.Read()
            If n Mod 2 = 0 Then : s &= "<div class='row'>" : End If
            's &= "<div class='row row1'><div class='checkbox i-checks'><label style='width:120px; margin-top: 5px; margin-left:50px;'> "
			s &= "<div class='row row1'><label style='width:130px; margin-top: 5px; margin-left:50px;'> "
            s &= "  <input type='checkbox' class='checkbox i-checks' id='V" & n & "' name='V" & n & "' Value='" & RD("Colno") & "'"
            For i As Byte = 0 To col.Length - 1
                If col(i) = RD("Colno") Then
                    s &= "checked"
                    Exit For
                End If
            Next
            s &= " > <i></i> " & RD("Parameter") & "</label>"
            's &= "  </div>"
            s &= "</div>"
            If n Mod 2 = 1 Then : s &= "</div>" : End If
            n += 1
        End While
        If n Mod 2 = 1 Then : s &= "</div>" : End If

        s &= "              </div>"
         s &= "              <div class='modal-footer'>"                                            
        s &= "                  <button type='button' class='btn btn-primary btn-small' data-dismiss='modal' >確定</button>"
        s &= "               </div>"       
        s &= "          </div>"
        s &= "      </div>"
        s &= "  </div>"

        Custom.Text = s
        Conn.Close()
    End Sub

    Sub getdrop()
        Dim STid As String = Request("ST")
        Dim sql As String = "Select TableType From STSP.dbo.STSP_StationTables Where STid='" & Request("ST") & "' And IsGeneral=1  Order By sIndex"
        'Dim kao_sql As String = "select distinct DP_NO from STSP_Parameter_water where station='高雄污水廠'"
        'Dim Tainan_sql As String = "select distinct DP_NO from STSP_Parameter_water where station='臺南污水廠'"
        Conn.Open()
        'If STid = "Tainan_waste_water" Then
        '    Dim Com2 As New SqlCommand(Tainan_sql, Conn)
        '    Dim RD2 As SqlDataReader = Com2.ExecuteReader()
        '    While RD2.Read()
        '        Dim li As New ListItem
        '        li.Text = RD2("DP_NO")
        '        li.Value = RD2("DP_NO")
        '        TableTime.Items.Add(li)
        '    End While
        'ElseIf STid = "Kaohsuing_wastr_water" Then
        '    Dim Com2 As New SqlCommand(kao_sql, Conn)
        '    Dim RD2 As SqlDataReader = Com2.ExecuteReader()
        '    While RD2.Read()
        '        Dim li As New ListItem
        '        li.Text = RD2("DP_NO")
        '        li.Value = RD2("DP_NO")
        '        TableTime.Items.Add(li)
        '    End While
        'Else
        Dim Com2 As New SqlCommand(sql, Conn)
            Dim RD2 As SqlDataReader = Com2.ExecuteReader()
            While RD2.Read()
                Dim li As New ListItem
                li.Text = RD2("TableType")
                li.Value = RD2("TableType")
                TableTime.Items.Add(li)
            End While
        'End If


        Conn.Close()
    End Sub
End Class
