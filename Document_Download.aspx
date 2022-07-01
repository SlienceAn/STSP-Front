<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Document_Download.aspx.cs" Inherits="Document_Download" %>

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

          .table-bordered > tbody > tr > th {
              text-align: center;
          }

          .table-bordered > tbody > tr > th, .table-bordered > tbody > tr > td {
              vertical-align: middle;
          }

              .table-bordered > tbody > tr > th:nth-child(2), .table-bordered > tbody > tr > td:nth-child(2) {
                  width: 75px;
                  text-align: center;
              }

          .areaBtn {
              display: inline-block;
          }

          label[for="inputEmail3"] {
              display: inline-block;
          }

          .resultsBox {
              margin-bottom: 20px;
              width: 90%;
          }
          @media (min-width: 768px) {
              .col-sm-1 {
                  width: 10%;
              }
          }
          @media (max-width: 991px) {
          }
      </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
 
   
       	<ol class="breadcrumb"><!--現在位置導覽列-->
              <li><a href="index5.aspx">首頁</a></li>
              <li><a href="Document_Download.aspx">環評文件下載</a></li>
              <a href="index1.aspx" class="btn btn-success pull-right">回上一頁</a>
            </ol>
                <div class="content-inside">
                <div class="Subtxt">
                    <div class="subTitle">
                        <h3>環評文件下載</h3>
                    </div>
                </div><!--Subtxt-->
	
         <div class="resultsBox">
             <label for="inputEmail3" class="col-sm-1 col-form-label">園區</label><%----%>
       
          <div class="areaBtn" >


         <asp:Panel runat="server" ID="PL1" class="" ></asp:Panel><%--btnBox--%>
          </div> 
                    </div> 


             
          
           <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                width="90%" cellpadding="0" 
                DataSourceID="SqlDataSource1" 
                DataKeyNames="ED_id"   CssClass="table table-bordered table-condensed"  PageSize="50">
               <EmptyDataTemplate>
                 無環評文件
              </EmptyDataTemplate>
            <HeaderStyle   BackColor="#5bc0de"   />
                     <Columns>
                         <asp:TemplateField HeaderText="ED_id" InsertVisible="False" 
                             SortExpression="ED_id" Visible="False">
                             <ItemTemplate>
                                 <asp:Label ID="Label1" runat="server" Text='<%# Bind("ED_id") %>'></asp:Label>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:Label ID="Label1" runat="server" Text='<%# Eval("ED_id") %>'></asp:Label>
                             </EditItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="主題" SortExpression="title">
                             <ItemTemplate>
                                 <asp:Label ID="Label2" runat="server" Text='<%# Bind("title") %>'></asp:Label>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("title") %>'></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Font-Size="14px" />
                             <ItemStyle Font-Size="14px" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="摘要" SortExpression="summary" Visible="False">
                             <ItemTemplate>
                                 <asp:Label ID="Label3" runat="server" Text='<%# Bind("summary") %>'></asp:Label>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("summary") %>'></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Font-Size="14px" />
                             <ItemStyle Font-Size="14px" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="圖片" SortExpression="image_filepath" Visible="False">
                             <ItemTemplate>
                            
                                 <asp:Image ID="image_filepath" runat="server" ImageUrl='<%# Bind("image_filepath") %>' Height="100" Width="100" />
                             </ItemTemplate>
                         <HeaderStyle Font-Size="14px" />
                          
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="圖片說明" SortExpression="image_note" Visible="False">
                             <ItemTemplate>
                                 <asp:Label ID="Label5" runat="server" Text='<%# Bind("image_note") %>'></asp:Label>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("image_note") %>'></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Font-Size="14px" />
                             <ItemStyle Font-Size="14px" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="環評文件" 
                             SortExpression="document_filepath">
                             <ItemTemplate>
                                <%-- <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click" CommandName='<%# Bind("document_filepath") %>'>下載</asp:LinkButton>--%>
                              <%--  <asp:HyperLink ID="document_filepath" runat="server" NavigateUrl='<%# "../BackEnd/fundot/"+ Eval("document_filepath") %>'>下載</asp:HyperLink>--%>
                                 <asp:HyperLink ID="document_filepath" runat="server" NavigateUrl='<%# "../BackEnd/fundot/Document/"+ Eval("title") + ".pdf" %>'>下載</asp:HyperLink>
                             </ItemTemplate>
                         <HeaderStyle Font-Size="14px" />
                             <ItemStyle Font-Size="14px" />
                         </asp:TemplateField>
                         
                     </Columns>
                 </asp:GridView>


           
                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:sin %>" 
                     SelectCommand="SELECT [ED_id], [title], [summary], [image_filepath], [image_note], [document_filepath] FROM [EnvironmentDocument] WHERE ([dele] = 0) "
                     >

                  
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
     
</asp:Content>

