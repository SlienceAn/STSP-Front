<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Report_Download.aspx.cs" Inherits="Report_Download" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <link href="css/CTSP_Login_Page.css" rel="stylesheet" type="text/css" />
    <link href="css/CTSP_Login_Style.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .dividstyle {
                z-index: 5;
                position: absolute;
                top: 25%;
                left: 35%;
                border: 1px solid #C0C0C0;
                border-bottom-color: #666;
                border-right-color: #666;
                background-color: #FFF;
                padding: 5px;
                text-align: center;
            }

            .resultsBox {
                margin-bottom: 20px;
                width: 90%;
            }

            label[for="inputEmail3"] {
                display: inline-block;
            }

            .areaBtn {
                display: inline-block;
            }

            .drpAtr {
                display: inline-block;
                width: 100px;
            }

            .pageTool {
                padding: 10px 0px 10px 0px;
                width: 90%;
                text-align: right;
            }

            .table {
                margin-bottom: 10px;
            }

            .table-bordered > tbody > tr > th {
                text-align: center;
            }

            .table-bordered > tbody > tr > th, .table-bordered > tbody > tr > td {
                vertical-align: middle;
            }

                .table-bordered > tbody > tr > td:nth-child(1), .table-bordered > tbody > tr > td:nth-child(4) {
                    text-align: center;
                }

            .drpPage {
                display: inline-block;
            }

            @media (max-width: 991px) {
                .pageTool {
                    width: 95%;
                }

                .drpPage {
                    display: inline-block;
                    margin-bottom: 10px;
                }

                .resultsBox {
                    width: 100%;
                }

                    .resultsBox:nth-child(2) {
                        border-bottom: 3px dashed #CCC;
                        padding-bottom: 10px;
                    }
            }

            @media (min-width: 768px) {
                .col-sm-1 {
                    width: 10%;
                }

                .pageBr {
                    display: inline-block;
                }
            }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
      <%--<div class="content container">--%>
       	<ol class="breadcrumb"><!--現在位置導覽列-->
              <li><a href="index5.aspx">首頁</a></li>
              <li><a href="Report_Download.aspx">簡報資料</a></li>
              <a href="index1.aspx" class="btn btn-success pull-right">回上一頁</a>
            </ol>

		<div class="content-inside">
              <div class="Subtxt">
                    <div class="subTitle">
                        <h3>簡報資料</h3>
                    </div>
                </div><!--Subtxt-->
         <div class=""><%--softwareText--%>
        <div class="resultsBox"><%--form-group row--%>
           <label for="inputEmail3" class="col-sm-1 col-form-label">園區</label>
     
         <asp:Panel runat="server" ID="PL1" class="areaBtn"></asp:Panel><%--col-sm-9--%>
              </div>
               <div class="resultsBox"><%--form-group row--%>
             <label for="inputEmail3" class="col-sm-1 col-form-label">年度</label>
               <div class="drpAtr"><%--col-sm-9--%>
             <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control"
              DataSourceID="SqlDataSource2" DataTextField="time" DataValueField="time">

          </asp:DropDownList>
          <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
              ConnectionString="<%$ ConnectionStrings:sin %>" 
              SelectCommand="SELECT DISTINCT  DATEPART(year,[time] )  as  [time] FROM [Report]  ">
          </asp:SqlDataSource>
                       </div>
        </div>
       
          </div>
                 <div id="up" runat="server"  role="toolbar" aria-label="Toolbar with button groups" class="pageTool" style=""><%--padding: 10px 0px 10px 90px;--%>
                   
               <div class="pageBr">
             
                  第  <asp:Label ID="lblPageIndex" runat="server" Text="0" ></asp:Label>  頁    
             
                 總計 <asp:Label ID="lblDataCount" runat="server" Text="0" ></asp:Label> 筆    
                跳至
              
                
                  <asp:DropDownList ID="ddlPageIndex" runat="server" AutoPostBack="True"   style="width: auto"  CssClass="drpPage"
                    onselectedindexchanged="ddlPageIndex_SelectedIndexChanged" >
                </asp:DropDownList>
                頁
                   </div>
                     <div class="pageBr">
               <asp:LinkButton ID="lkbPagePrev" runat="server" onclick="lkbPagePrev_Click">上一頁</asp:LinkButton>
                <asp:LinkButton ID="lkbPageNext" runat="server" onclick="lkbPageNext_Click">下一頁</asp:LinkButton>
               每頁顯示
                
                <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="True"    CssClass="drpPage"
                      style="width: auto" onselectedindexchanged="ddlPageSize_SelectedIndexChanged">
                    
                    <asp:ListItem >10</asp:ListItem>
                    <asp:ListItem Selected="True" >50</asp:ListItem>
                    <asp:ListItem>100</asp:ListItem>
                </asp:DropDownList>
                 筆
                </div>
                 
            </div>
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCreated="GridView1_RowCreated"   OnSorting="GridView1_Sorting" ondatabound="GridView1_DataBound"  OnPageIndexChanging="GridView1_PageIndexChanging" 
        DataKeyNames="report_id" DataSourceID="SqlDataSource1" width="90%" cellpadding="0" 
                 CssClass="table table-bordered table-condensed" AllowSorting="True" AllowPaging="True" PageSize="50">
              <%--   <AlternatingRowStyle CssClass="Table-Sec"></AlternatingRowStyle>--%>
              <EmptyDataTemplate>
                  無監測摘要
              </EmptyDataTemplate>
              <HeaderStyle   BackColor="#5bc0de" ForeColor="#FFFFFF"   />
    <Columns>
    <asp:BoundField DataField="time" HeaderText="時間"  SortExpression="time" >
        <HeaderStyle Font-Size="14px" />
        <ItemStyle Font-Size="14px" Width="90px" />
        </asp:BoundField>
        <asp:BoundField DataField="title" HeaderText="名稱" SortExpression="title" >
        <HeaderStyle Font-Size="14px" />
        <ItemStyle Font-Size="14px" />
        </asp:BoundField>
        <asp:BoundField DataField="abstract" HeaderText="摘要" SortExpression="abstract" >
        <HeaderStyle Font-Size="14px" />
        <ItemStyle Font-Size="14px" />
        </asp:BoundField>
        <asp:TemplateField HeaderText="下載"  >

          <ItemTemplate>
       <asp:LinkButton ID="filepath" runat="server" onclick="LinkButton1_Click" CommandName='<%# Eval("filepath") %>'>下載</asp:LinkButton>
        <%--  <asp:HyperLink ID="filepath" runat="server" NavigateUrl='<%# "../BackEnd/fundot/"+Eval("filepath") %>'>下載</asp:HyperLink>--%>
          </ItemTemplate>
          <HeaderStyle Font-Size="14px" />
          <ItemStyle Font-Size="14px" Width="40px" />     
          </asp:TemplateField>
        
    </Columns>
</asp:GridView>
<div id="down" runat="server"  aria-label="Toolbar with button groups"  class="pageTool" style="border-color: #C0C0C0; "><%--padding: 10px 0px 10px 90px;--%>
                   
              <div class="pageBr">
                 第  <asp:Label ID="lblPageIndex2" runat="server" Text="0" ></asp:Label>  頁    
             
               總計 <asp:Label ID="lblDataCount2" runat="server" Text="0" ></asp:Label> 筆   
                 跳至
              
                
                  <asp:DropDownList ID="ddlPageIndex2" runat="server" AutoPostBack="True"   style="width: auto"  CssClass="drpPage"
                    onselectedindexchanged="ddlPageIndex_SelectedIndexChanged" >
                </asp:DropDownList>
               頁 
                  </div>
                <div class="pageBr">
                <asp:LinkButton ID="lkbPagePrev2" runat="server" onclick="lkbPagePrev_Click">上一頁</asp:LinkButton>
                <asp:LinkButton ID="lkbPageNext2" runat="server" onclick="lkbPageNext_Click">下一頁</asp:LinkButton>
                每頁顯示
                
                <asp:DropDownList ID="ddlPageSize2" runat="server" AutoPostBack="True" onselectedindexchanged="ddlPageSize_SelectedIndexChanged"  style="width: auto"  CssClass="drpPage">
                    <asp:ListItem >10</asp:ListItem>
                    <asp:ListItem Selected="True">50</asp:ListItem>
                    <asp:ListItem>100</asp:ListItem>
                </asp:DropDownList>
                筆
                 </div>
              
            </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:sin %>" 
        SelectCommand="SELECT DISTINCT [report_id], [title],[abstract], CONVERT(VARCHAR(10), [time], 121) as [time],'../'+[filepath] as filepath,[sort] FROM [Report] where dele=0">
    </asp:SqlDataSource>
   
     <!--下載監測的聲明-->
          <asp:Panel ID="confirm" runat="server" class="dividstyle" Visible="False">
         
  
     <table width="588" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td><img src="image/1_01.gif" alt=""/>
            </td>
        </tr>
        
        <tr>
            <td style="background-image:url('image/1_02.gif'); background-position:center; background-repeat:repeat-y;">
                  <div style="font-size: 8px; padding-left: 20px;" align="left">為提升為民服務品質，請填寫下列問卷，俾利未來功能強化時改進方向。</div>
            <table style=" width: 100%;" >
              <tr  style="font-size: 8px">
         <td style="background-image:url('image/1_02.gif'); background-position:center; background-repeat:repeat-y; width:80px; padding-left: 20px;"  align="left">
         您的身份：
         </td>
            <td  align="left">
          <asp:RadioButtonList ID="youridertify" runat="server" RepeatDirection="Horizontal"  style="margin: 0px">
              <asp:ListItem>民眾</asp:ListItem>
              <asp:ListItem>學生</asp:ListItem>
              <asp:ListItem>教師</asp:ListItem>
              <asp:ListItem>廠商</asp:ListItem>
              <asp:ListItem>環保團體</asp:ListItem>
              <asp:ListItem>政府機關</asp:ListItem>
          </asp:RadioButtonList>
            </td>
           
        </tr>
         </table>
          <table style="width: 100%;" >
         <tr  style="font-size: 8px">
         <td style="background-image:url('image/1_02.gif'); background-position:center; background-repeat:repeat-y; ; padding-left: 20px;" 
                 align="left">
         下載目的：
         </td>
        
     
          <td   align="left">
         <asp:RadioButtonList ID="downloadpurpose" runat="server" RepeatDirection="Horizontal"  style="margin: 0px">
              <asp:ListItem>學術應用</asp:ListItem>
              <asp:ListItem>資料參考</asp:ListItem>
              <asp:ListItem>路過下載</asp:ListItem>
              <asp:ListItem>其他</asp:ListItem>
          </asp:RadioButtonList>
          </td>
           <td  align="left" style="width: 40%">
           <asp:TextBox ID="downloadpurpose_o" runat="server" Width="100px"></asp:TextBox>
           </td>
        </tr>
                
        </table>
            
            
                <img src="image/1_04.gif" alt=""/>
            </td>
        </tr>
        <tr>
    
        <%--float:left;--%>
            <td style="background-image:url('image/1_03.gif'); background-position:bottom;padding: 15px;" align="center" colspan="2" style="width:100%">
            <asp:ImageButton ID="Download" runat="server" 
                    ImageUrl="image/agree.jpg" 
                    onclick="Download_Click"  OnClientClick='document.getElementById("ContentPlaceHolder1_confirm").style.display = "none";' />
                     <asp:ImageButton ID="disagree" runat="server" 
                    ImageUrl="image/disagree.jpg" 
                    onclick="disagree_Click"  />
           </td>
        </tr>
    </table>
   
       </asp:Panel>
         </div>
          <%--</div>--%>
</asp:Content>

