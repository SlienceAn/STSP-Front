<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Icon Symbolizer</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
<%--    <script src="https://cdn.polyfill.io/v2/polyfill.js?features=Array.prototype.map,modernizr:es5array|always"></script>--%>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAC46YcgD1yW9UdA3C-vARKrw_rKh7WWgA" type="text/javascript"></script>

    <script src="https://openlayers.org/en/v5.3.0/build/ol.js"></script>
     <link rel="stylesheet" href="https://openlayers.org/en/v5.3.0/css/ol.css" type="text/css">
<%--   <script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>--%>
    <script src="js/jquery-1.11.2.min.js"></script>
    <link href="css/bootstrap_3.3.5.min.css" rel="stylesheet" />
    <script src="js/bootstrap.min.js"></script>
    <script src="js/Chart.bundle.js"></script>
    <style>
        #map {
            position: relative;
        }

        .popover {
            width: 500px;
            height: 380px;
            max-width: 500px;
            max-height: 380px;
        }
        ol-popup {
          position: absolute;
          background-color: white;
          -webkit-filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
          filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
          padding: 15px;
          border-radius: 10px;
          border: 1px solid #cccccc;
          bottom: 12px;
          left: -50px;
   z-index:0;
            width:200px;
        }
        .ol-popup:after, .ol-popup:before {
          top: 100%;
          border: solid transparent;
          content: " ";
          height: 0;
          width: 0;
          position: absolute;
          pointer-events: none;
        }
        .ol-popup:after {
          border-top-color: white;
          border-width: 10px;
          left: 48px;
          margin-left: -10px;
        }
        .ol-popup:before {
          border-top-color: #cccccc;
          border-width: 11px;
          left: 48px;
          margin-left: -11px;
        }
        .ol-popup-closer {
          text-decoration: none;
          position: absolute;
          top: -350px;
          right: -230px;
          z-index:999;
        }
        .ol-popup-closer:after {
          content: "✖";
        }
    </style>
</head>
<body>
    <form runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div id="map" class="map">
            
             <div id="popup" class="ol-popup">
     <a href="#" id="popup-closer" class="ol-popup-closer" style="display:none"></a>
      <div id="popup-content"></div></div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="HiddenField1" runat="server" Value="" />
                <asp:HiddenField ID="HiddenField2" runat="server" Value="" />
                <asp:HiddenField ID="HiddenField3" runat="server" Value="" />
                <asp:HiddenField ID="HiddenField4" runat="server" Value="" />
                <asp:HiddenField ID="HiddenField5" runat="server" Value="" />

                  <asp:HiddenField ID="HiddenField6" runat="server" Value="" />
                <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" CssClass="hidden" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <script>
            window.localStorage['a'] = "1";
            var rasterLayer = new ol.layer.Tile({
                source: new ol.source.OSM({
                    url: 'http://mt{0-3}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                })
            });
            var vector = new ol.layer.Vector({
                source: new ol.source.Vector({
                    url: 'KML/STSPArea.kml',
                    format: new ol.format.KML()
                }),
                style: new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 255, 0.2)'
                    })
                })
            });
            var map = new ol.Map({
                layers: [rasterLayer, vector],
                target: document.getElementById('map'),
               
                view: new ol.View({
                    projection: 'EPSG:4326',
                    center: [120.909466, 23.719683],
                    zoom: 8
                })
                 
            });
            //園區圖層
            
            var pointvectorSource = new ol.source.Vector();
            var pointLayer = new ol.layer.Vector({
                source: pointvectorSource,
                style: new ol.style.Style({
                    image: new ol.style.Circle({
                        fill: new ol.style.Fill({
                            color: [255, 255, 255, 1]
                        }),
                        stroke: new ol.style.Stroke({
                            color: [255, 0, 0, 1],
                            width: 5
                        }),
                        radius: 5
                    }),
              
                })
            });
            map.addLayer(pointLayer);


          








            var element = document.getElementById('popup');
            var content = document.getElementById('popup-content');
            var closer = document.getElementById('popup-closer');
            closer.onclick = function () {
                popup.setPosition(undefined);
                closer.blur();
                return false;
            };
            var popup = new ol.Overlay({
                element: element,
                positioning: 'bottom-center',
               // stopEvent: false,
                autoPan: true,
                offset: [0, 0]
            });
            map.addOverlay(popup);



            //map.getView().on('propertychange', function (e) {
            //    switch (e.key) {
            //        case 'resolution':
            //            try{
                         
            //                //setTimeout("document.getElementById('Button1').click()",1000)
            //            }catch{}
            //            break;
            //    }
            //});





            // display popup on click
            map.on('click', function (evt) {
               
           

                var feature = map.forEachFeatureAtPixel(evt.pixel,
                    function (feature) {
                        return feature;
                    });
                if (feature) {

                    var x = feature.get('x');
                    var y = feature.get('y');
                 
                   


                    var coordinates = feature.getGeometry().getCoordinates();

                 

                    if (localStorage['a'] == "1") {
                        popup.setPosition(coordinates)
                        $(element).popover({
                            'placement': 'top',
                            'html': true,
                            'content': '園區：' + feature.get('area')
                                + '<br/>類別：' + feature.get('class')
                                + '<br/>測點名稱：' + feature.get('siteName')
                                + '<br/>監測項目：' + feature.get('item') 
                                + '<br/>法規標準：' + feature.get('law') + ' ' + feature.get('law_unit') 
                                + '<br/><span style="color:red">紅色圈為ND值</span>'
                                + '<br/><canvas id="chart-legend-normal" style="position: relative;"></canvas>'
                        });

                        map.getView().animate({
                            center: [x, y + 0.025],
                            duration: 0
                        });

                        document.getElementById('HiddenField4').value = feature.get('siteid');
                        document.getElementById('HiddenField5').value = feature.get('item') + feature.get('unit');

                        setTimeout("document.getElementById('Button1').click()",0)
                       // document.getElementById('Button1').click();
                        $(element).popover('show');
                        window.localStorage['a'] = "0";
                    }
                    else {
                        $(element).popover('destroy');
                        window.localStorage['a'] = "1";
                    }


                   
                } else {
                    $(element).popover('destroy');
                    window.localStorage['a'] = "1";
                   
                }
            });
            
            // change mouse cursor when over marker
            //map.on('pointermove', function (e) {
            //    if (e.dragging) {
            //        $(element).popover('destroy');
            //        return;
            //    }
            //    var pixel = map.getEventPixel(e.originalEvent);
            //    var hit = map.hasFeatureAtPixel(pixel);
            //    map.getTarget().style.cursor = hit ? 'pointer' : '';
            //});




            var color = Chart.helpers.color;
            function createConfig() {
                return {
                    type: 'line',
                    data: {
                        labels: document.getElementById('HiddenField1').value.split(','),
                        datasets: [{
                            label:'', //
                            data: stringatoint(document.getElementById('HiddenField2').value.split(',')),
                            //   backgroundColor: 'rgb(5, 55, 155,0.5)',
                            // backgroundColor: 'rgb(0, 0, 0,0.0)',
                            pointBorderColor: document.getElementById('HiddenField6').value.split(','),
                            borderColor: 'rgb(0, 0, 0)',
                            borderWidth: 1,
                            pointStyle: 'rectRot',
                            pointRadius: 5,
                            //pointBorderColor: 'rgb(0, 0, 0)'
                        }]
                    },
                    options: {
                        responsive: true,
                        legend: {
                            display: false,
                            labels: {
                               
                                usePointStyle: false
                            }
                        },
                        scales: {
                            xAxes: [{
                                display: true,
                                scaleLabel: {
                                    display: true,
                                    labelString: document.getElementById('HiddenField3').value
                                }
                            }],
                            yAxes: [{
                                display: true,
                                scaleLabel: {
                                    display: true,
                                    labelString: document.getElementById('HiddenField5').value
                                }
                            }]
                        },
                        title: {
                            display: true,
                            text: '監測結果'
                        }
                    }
                };
            }

            function stringatoint(arry) {
                var newarry = new Array();
                for (var i = 0; i < arry.length; i++) {
                    newarry[i] = parseFloat(arry[i]);
                }
                return newarry;
            }
           
            function test() {
                var ctx = document.getElementById('chart-legend-normal').getContext('2d');
                new Chart(ctx, createConfig());
            };

        </script>
    </form>
</body>
</html>
