Imports System.Data.SqlClient
Partial Class breadcrumb_chart
    Inherits System.Web.UI.Page
    Dim Con As String = System.Configuration.ConfigurationManager.ConnectionStrings("DBcs").ConnectionString
    Dim Conn As New SqlConnection(Con)
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim d As String = Request("d1")
        date_timepicker_start.Text = d
        Dim d2Str() As String = Request("d2").Split(",")
        date_timepicker_end.Text = d2Str(0)
        Conn.Open()
        ChartCreate()
        ChartParameter()
        getdrop()
        Conn.Close()
        D_ChartType.SelectedValue = Request("c")
    End Sub
    Sub ChartCreate()
        Dim dp_no_quest As String = Request("DP_NO")
        Dim STid As String = Request("ST")
        Dim sDate As DateTime = Request("d1")
        Dim d2Str() As String = Request("d2").Split(",")
        Dim eDate As DateTime = d2Str(0).Trim
        Dim tt As String = Request("tt")
        Dim ct As Byte = Request("c")
        Dim col() As String = Request("col").Split(",")
        Dim line() As String = Request("line").Split(",")
        Dim sql As String
        'Dim color() As String = Request("color").Split(",")
        Dim dTable As String
        Dim jq, EachValueStr As String
        If STid.Substring(0, 3) <> "NPL" Then
            sql = "Select dTable From STSP.dbo.STSP_Station Where  STName='" & STid & "'"
        Else
            sql = "Select dTable From STSP.dbo.STSP_Station Where  STid='" & STid & "'"
        End If

        Dim Com0 As New SqlCommand(sql, Conn)
        Dim RD0 As SqlDataReader = Com0.ExecuteReader()
        If RD0.Read() Then
            dTable = RD0("dTable") & tt
        End If


        Dim yAxisStr As String
        For c As Byte = 0 To col.Length - 1
            Dim sql1 As String
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
                    Case "Aiguoguo_school"
                        STid = "愛國國小站"
                    Case "Fengshan_Reservoir"
                        STid = "鳳山水庫站"
                    Case "Fwngyang_school"
                        STid = "鳳陽國小站"
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
                    sql1 = "Select Colno,Parameter,Unit,ChartType,Decimalpoint,TableType From STSP.dbo.STSP_Parameter_water Where station='" & STid & "'And Colno='" & col(c) & "' and dp_no='" & dp_no_quest & "'   and Parameter<>'導電度' "
                ElseIf STid = "高雄污水廠" Then
                    sql1 = "Select Colno,Parameter,Unit,ChartType,Decimalpoint,TableType From STSP.dbo.STSP_Parameter_water Where station='" & STid & "'And Colno='" & col(c) & "' and dp_no='" & dp_no_quest & "'   and Parameter<>'導電度' "
                Else
                    sql1 = "Select Colno,Parameter,Unit,ChartType,Decimalpoint,TableType From STSP.dbo.STSP_Parameter_air Where station='" & STid & "'And Colno='" & col(c) & "' And TableType='' "
                End If
            Else
                sql1 = "Select Colno,Parameter,Unit,Decimalpoint From STSP.dbo.STSP_Parameter_air Where STid='" & STid & "' And Colno='" & col(c) & "' And TableType='' Order By Colno "
            End If
            Dim Com2 As New SqlCommand(sql1, Conn)
            Dim RD2 As SqlDataReader = Com2.ExecuteReader()
            If RD2.Read() Then


                Dim par As String = RD2("Parameter")
                Dim unit As String = RD2("Unit")
                Dim dp As Byte = RD2("DecimalPoint")


                If ct = 0 Then
                ElseIf ct = 1 Then
                    yAxisStr &= "{"
                    yAxisStr &= "    labels: { format: '{value}' },"
                    yAxisStr &= "    title: { text: '" & RD2("Parameter") & " " & RD2("Unit") & "' } "
                    yAxisStr &= "},"
                ElseIf ct = 2 Then
                    yAxisStr &= "{"
                    yAxisStr &= "   title : { text: '" & RD2("Parameter") & "' }, "
                    yAxisStr &= "   height : '" & 100 / col.Length & "%', top:'" & (100 / col.Length) * c & "%', lineWidth: 2 , offset: 0, x: -3, opposite: false, gridLineWidth:0,"
                    yAxisStr &= "   labels: { formatter: function() { return ''} } "
                    yAxisStr &= "},"
                End If


                Dim SerialStr As String = ""
                Dim SqlStr As String = ""
                Dim pno As String = ""
                If STid = "高雄污水廠" Or STid = "臺南污水廠" Then
                    pno = " And DP_NO='" & dp_no_quest & "'   And  Status" & col(c) & "='10'  "
                End If
                If STid.Substring(0, 3) <> "NPL" Then
                    SqlStr = "Select Convert(VARCHAR,Date_Time,120) AS Date_Time,Value" & col(c) & ",Status" & col(c) & " From " & dTable
                    SqlStr &= " Where  station='" & STid & "' And "
                    SqlStr &= "Date_Time >='" & sDate.ToString("yyyy/MM/dd HH:mm") & "' And Date_Time<='" & eDate.ToString("yyyy/MM/dd HH:mm") & "' " & pno & " Order By Date_Time"
                Else
                    SqlStr = "Select Convert(VARCHAR,Date_Time,120) AS Date_Time,Value" & col(c) & ",Status" & col(c) & " From " & dTable
                    SqlStr &= " Where  STid='" & STid & "' And "
                    SqlStr &= "Date_Time >='" & sDate.ToString("yyyy/MM/dd HH:mm") & "' And Date_Time<='" & eDate.ToString("yyyy/MM/dd HH:mm") & "' Order By Date_Time"
                End If
                Dim comm3 As New SqlCommand(SqlStr, Conn)
                Dim RD3 As SqlDataReader = comm3.ExecuteReader()
                Dim yy, mm, dd, hh, mn, ss As Short

                While RD3.Read()
                    '2012-11-06 08:33:00 {x:Date.UTC(1988,5,5),y:13},

                    Dim DT As DateTime = RD3("Date_Time")
                    Dim Val As String

                    If IsDBNull(RD3.Item(1)) = True Then   'value null
                        Val = "null"
                    Else   'value not null
                        If RD3.Item(1) = -9999 Then   'value -9999
                            Val = "null"
                        Else   'value not -9999
                            If IsDBNull(RD3.Item(2)) = True Then   'flag null
                                Val = Math.Round(RD3.Item(1), dp)
                            Else   'flag not null
                                If RD3.Item(2) = "p" Or
                                   RD3.Item(2) = "c" Or
                                   RD3.Item(2) = "d" Or
                                   RD3.Item(2) = "b" Or
                                   RD3.Item(2) = "m" Or
                                   RD3.Item(2) = "l" Or
                                   RD3.Item(2) = "r" Or
                                   RD3.Item(2) = "1" Or
                                   RD3.Item(2) = "2" Or
                                   RD3.Item(2) = "4" Or
                                   RD3.Item(2) = "8" Or
                                   RD3.Item(2) = "16" Or
                                   RD3.Item(2) = "31" Or
                                   RD3.Item(2) = "31        " Or
                                   RD3.Item(2) = "2         " Or
                                   Math.Round(RD3.Item(1), dp) < 0 Then
                                    Val = "null"
                                Else
                                    Val = Math.Round(RD3.Item(1), dp)
                                End If
                            End If
                        End If
                    End If
                    If STid = "高雄污水廠" Or STid = "臺南污水廠" Then
                        If Math.Round(RD3.Item(1), dp) > 10000 Then
                            Val = "null"
                        End If
                    Else
                        If Math.Round(RD3.Item(1), dp) >= 500 Then
                            Val = "null"
                        End If
                    End If

                    yy = DT.Year
                    mm = DT.Month - 1
                    dd = DT.Day
                    hh = DT.Hour
                    mn = DT.Minute
                    ss = DT.Second
                    SerialStr &= "{ "
                    SerialStr &= "  x:Date.UTC(" & yy & "," & mm & "," & dd & "," & hh & "," & mn & "," & ss & "),"
                    SerialStr &= "  y:" & Val
                    'SerialStr &= "  ,marker: { enabled: true, symbol:'url(https://www.highcharts.com/samples/graphics/sun.png)' }"
                    SerialStr &= "},"

                    'marker: {  symbol: 'url(https://www.highcharts.com/samples/graphics/sun.png)' }
                End While



                If SerialStr.Length > 0 Then
                    SerialStr = SerialStr.Remove(SerialStr.Length - 1, 1)
                End If
                Dim dot As String = ""
                Select Case par.Trim
                    Case "懸浮微粒", "細懸浮微粒"
                        dot = ", valueDecimals: 0"
                    Case "一氧化碳", "總碳氫化合物", "風速", "小時風速值"
                        dot = ", valueDecimals: 2"
                    Case "二氧化硫", "氮氧化物", "臭氧", "一氧化氮", "二氧化氮", "風向", "雨量", "溫度", "濕度", "小時風向", "相對濕度"
                        dot = ", valueDecimals: 1"
                End Select
                If STid = "高雄污水廠" Or STid = "臺南污水廠" Then
                    dot = ", valueDecimals: 1"
                End If
                EachValueStr &= vbNewLine
                EachValueStr &= "    seriesOptions[" & c & "]=" & vbNewLine
                EachValueStr &= "           {" & vbNewLine
                EachValueStr &= "           name: '" & par & " " & unit & "'," & vbNewLine
                If line(c) = "circle" Or line(c) = "square" Or line(c) = "diamond" Or line(c) = "triangle" Or line(c) = "triangle-down" Then
                    EachValueStr &= "       tooltip: { useHTML: true, pointFormat:'{point.y}', valueSuffix: ' " & unit & "' " & dot & "} ," & vbNewLine
                    EachValueStr &= "       type: 'scatter' ," & vbNewLine
                    EachValueStr &= "       marker: { enabled: true, symbol:'" & line(c) & "' }," & vbNewLine
                Else
                    If line(c) = "lineM" Or line(c) = "splineM" Then
                        EachValueStr &= "   marker: { enabled: true, radius:4 }," & vbNewLine
                        EachValueStr &= "   type: '" & line(c).Replace("M", "") & "' ," & vbNewLine
                    Else
                        EachValueStr &= "   type: '" & line(c) & "' ," & vbNewLine
                    End If
                    EachValueStr &= "       tooltip: { valueSuffix: ' " & unit & "'" & dot & " } ," & vbNewLine
                End If
                'EachValueStr &= "           color: '#" & color(c) & "' ," & vbNewLine
                EachValueStr &= "           data: [" & SerialStr & " ]" & vbNewLine
                If ct <> 0 Then : EachValueStr &= " ,yAxis: " & c : End If
                EachValueStr &= "           };" & vbNewLine

            End If
        Next






        'Start JQuery Code-----------------------------------------------------------------------------------------
        jq = "    $(function () {" & vbNewLine
        jq &= "        var seriesOptions=[] ;" & vbNewLine
        jq &= EachValueStr
        jq &= "        window.chart = new Highcharts.StockChart" & vbNewLine
        jq &= "        ({" & vbNewLine
        jq &= "        chart: { renderTo: 'container', zoomType: 'x' }," & vbNewLine
        jq &= "        scrollbar: { enabled: false }, navigator: { enabled: false },"
        jq &= "        credits: { enabled: false }," & vbNewLine
        jq &= "        xAxis: { type: 'datetime' }," & vbNewLine
        If ct <> 0 Then
            jq &= "    yAxis: [ " & yAxisStr.Remove(yAxisStr.Length - 1, 1) & "], "
        End If
        jq &= "        legend: { enabled: true , verticalAlign:'top'}," & vbNewLine
        jq &= "        exporting: { sourceWidth: 1200, sourceHeight: 800 },"
        jq &= "        plotOptions: { series:{ turboThreshold : 50000 } },"
        jq &= "        rangeSelector: { enabled: false }," & vbNewLine
        jq &= "	        series: seriesOptions " & vbNewLine
        jq &= "    }); " & vbNewLine
        jq &= "    }); " & vbNewLine

        Dim ReStr As String
        ReStr = "<script type='text/javascript'>" & vbNewLine
        ReStr &= jq & vbNewLine
        ReStr &= "</script>" & vbNewLine

        Dim height_ As Short
        If ct = 2 Then
            height_ = col.Length * 100 + 100
        Else
            height_ = 500
        End If
        ReStr &= "<div id='container' style='width:100%; min-height:500px; height: " & height_ & "px; '></div>"

        ChartSetting.Text = ReStr
    End Sub

    Sub ChartParameter()
        Dim stid As String = Request("ST")
        Dim s As String
        Dim jq As String = ""
        Dim style As String = ""
        Dim col() As String = Request("col").Split(",")
        Dim line() As String = Request("line").Split(",")
        'Dim color() As String = Request("color").Split(",")
        Dim alines(,) As String = {
                                    {"spline", "曲線"},
                                    {"splineM", "曲線(點)"},
                                    {"line", "折線"},
                                    {"lineM", "折線(點)"},
                                    {"circle", "點(圓圈)"},
                                    {"square", "點(方形)"},
                                    {"diamond", "點(菱形)"},
                                    {"triangle", "點(正三角)"},
                                    {"triangle-down", "點(倒三角)"},
                                    {"column", "柱狀"},
                                    {"area", "折線區域"},
                                    {"areaspline", "曲線區域"}
                                 }


        s = "<a data-toggle='modal' class='btn btn-success' href='#modal-form' style='margin-left:7px;'><i class='fa fa-gear fa-spin'></i>測項</a>"
        s &= "  <div id='modal-form' class='modal fade' aria-hidden='true'>"
        s &= "      <div class='modal-dialog'>"
        s &= "          <div class='modal-content'>"
        s &= "              <div class='modal-body'>"
		's &= "    <label style='width:100%;margin-left:20px;' onclick=""SelectAll('cAll')""> "
        's &= "     		<input type='checkbox' class='checkbox i-checks' id='cAll' name='cAll' checked >  <button type='button' class='btn btn-warning'>全選</button></label>"

        's &= "<div class='row'><div class='checkbox i-checks' style='margin-left:30px;'><label style='width:100px;margin-left:50px;'  id='vAll' name='vAll' onclick=""SelectAll('cAll')""> "
        's &= "<div class='row'><div class='checkbox i-checks' style='margin-left:30px;'><label style='width:100px;margin-left:50px;'  onclick=""SelectAll('cAll')""> "
        's &= "  <input type='checkbox' id='cAll' name='cAll'> <i></i> 全選</label>"
        s &= "<div class='row'><div class='checkbox i-checks' style='margin-left:30px;'><label style='width:100px;margin-left:50px;'  onclick=""SelectAll('cAll')""> "
        s &= "  <input type='checkbox' id='cAll' name='cAll'>  <button type='button' class='btn btn-warning'>全選</button></label>"
        s &= "  </div>"
        s &= "</div>"
        Dim dp_no_quest As String = Request("DP_NO")
        Dim n As Byte = 0
        Dim SqlStr As String
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
                    stid = "臺南站"
                Case "Aiguoguo_school"
                    stid = "愛國國小站"
                Case "Fengshan_Reservoir"
                    stid = "鳳山水庫站"
                Case "Fwngyang_school"
                    stid = "鳳陽國小站"
                Case "Gong_13"
                    stid = "公13測站"
                Case "Gong_19"
                    stid = "公19測站"
                Case "Gong_29"
                    stid = "公29測站"
                Case "Nankeshizhong"
                    stid = "南科實中測站"
                Case "Chengxi"
                    stid = "城西站"
                Case "Nanxi"
                    stid = "楠西站"
                Case "Tainan_waste_water"
                    stid = "臺南污水廠"
                Case "Kaohsiung_waste_water"
                    stid = "高雄污水廠"
            End Select

            If stid = "臺南污水廠" Then
                SqlStr = "Select Colno,Parameter,Unit,ChartType,TableType From STSP.dbo.STSP_Parameter_water Where station='" & stid & "' and dp_no='" & dp_no_quest & "'    and Parameter<>'導電度' "
            ElseIf stid = "高雄污水廠" Then
                SqlStr = "Select Colno,Parameter,Unit,ChartType,TableType From STSP.dbo.STSP_Parameter_water Where station='" & stid & "'  and dp_no='" & dp_no_quest & "'   and Parameter<>'導電度' "
            Else
                SqlStr = "Select Colno,Parameter,Unit,ChartType,TableType From STSP.dbo.STSP_Parameter_air Where station='" & stid & "' And TableType='' And dChart=1 "
            End If
        Else
            SqlStr = "Select Colno,Parameter,Unit,ChartType From STSP.dbo.STSP_Parameter_air Where STid='" & Request("ST") & "' And TableType='' And dChart=1 "
        End If
        Dim Com As New SqlCommand(SqlStr, Conn)
        Dim RD As SqlDataReader = Com.ExecuteReader()
        While RD.Read()

            Dim t As Boolean = False
            Dim chk As String = ""
            Dim dColor As String = "DDDDDD"
            Dim dLine As String = RD("ChartType")
            For i As Byte = 0 To col.Length - 1
                If col(i) = RD("Colno") Then
                    t = True
                    chk = " checked "
                    'dColor = color(i)
                    dLine = line(i)
                    Exit For
                End If
            Next

            If n Mod 2 = 0 Then : s &= "<div class='row'>" : End If
            s &= "<div class='row row1'><div class='checkbox i-checks'><label style='width:100px; margin-top: 5px;float:left;margin-left:120px;width:130px'> "
            s &= "  <input type='checkbox' id='V" & n & "' name='V" & n & "' Value='" & RD("Colno") & "' " & chk & "> <i></i> " & RD("Parameter") & "</label>"
            s &= "  <select class='form-control fc' id='LT" & n & "'  style='margin-right:7px;width:130px;'>"
            For l As Byte = 0 To (alines.Length / 2) - 1
                s &= "<option value='" & alines(l, 0) & "' "
                If alines(l, 0) = dLine Then
                    s &= " selected "
                End If
                s &= ">" & alines(l, 1) & "</option>"
            Next
            s &= "  </select>"
            's &= "  <input type='text' id='picker" & n & "' class='form-control fc' value='" & dColor & "'></input>"
            s &= "  </div>"
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

    End Sub
    Sub getdrop()


        Dim Com2 As New SqlCommand("Select TableType From STSP.dbo.STSP_StationTables Where STid='" & Request("ST") & "' And IsGeneral=1  Order By sIndex", Conn)
        Dim RD2 As SqlDataReader = Com2.ExecuteReader()
        While RD2.Read()
            If RD2("TableType") <> "T01" Then
                Dim li As New ListItem
                Select Case RD2("TableType")
                    Case "T05"
                        li.Text = "五分鐘值"
                    Case "T60"
                        li.Text = "小時值"
                End Select
                ' li.Text = RD2("TableType")
                li.Value = RD2("TableType")
                TableTime.Items.Add(li)
            End If
        End While


    End Sub
End Class
