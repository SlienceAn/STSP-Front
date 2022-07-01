<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Data_Site.aspx.cs" Inherits="sin_Data_Site" Debug="True" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="js/ol_v3.8.2.js"></script>
    <link rel="Stylesheet" type="text/css" href="css/ol_v3.8.2.css" />
    <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap_3.3.5.min.js"></script>


    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

    <script>
        $(function () {
            $("#site").attr("class", "slip");
        });
    </script>
    <style>
        .ol-popup {
            position: absolute;
            background-color: white;
            -webkit-filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
            filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #cccccc;
            bottom: 12px;
            left: -50px;
            width: 200px;
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
            top: 2px;
            right: 8px;
        }

            .ol-popup-closer:after {
                content: "✖";
            }

        .areadrp {
            width: 80px;
        }

        .typedrp {
            width: auto;
        }

        .timedrp {
            width: 75px;
            margin-right: 5px;
        }

        .sideByside {
            display: inline-block;
            margin-bottom: 5px;
        }

        .seasonMap {
            width: 68%;
        }

        #map {
            height: 538px;
        }

        #map1, #map2, #map3 {
            height: 150px;
        }

        #map, #map1, #map2, #map3 {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        hr {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        @media (max-width: 991px) {
            .seasonMap {
                width: 100%;
            }

            #map,#map1, #map2, #map3 {
                height: 500px;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script type="text/javascript">

        var defaultIconUrl = "../Login_Style/Icon_Station.png";
        var makersA = new Array();
        //季
        var markers = [
        <asp:Repeater ID="rptMarkers"  runat="server"> 
         <ItemTemplate>
             {
                 "name" :'<%# Eval("siteName") %>',
                 "lon":'<%# Eval("gis_x") %>', 
                 "lat":'<%# Eval("gis_y") %>' 
             }
         </ItemTemplate>
         <SeparatorTemplate>
            ,
        </SeparatorTemplate>
        </asp:Repeater>
        ];
       
        //第一個月
        var markers1 = [
        <asp:Repeater ID="rptMarkers1"  runat="server"> 
         <ItemTemplate>
             {
                 "name" :'<%# Eval("siteName") %>',
                 "lon":'<%# Eval("gis_x") %>', 
                 "lat":'<%# Eval("gis_y") %>' 
             }
         </ItemTemplate>
         <SeparatorTemplate>
            ,
        </SeparatorTemplate>
        </asp:Repeater>
        ];

        //第二個月
        var markers2 = [
        <asp:Repeater ID="rptMarkers2"  runat="server"> 
         <ItemTemplate>
             {
                 "name" :'<%# Eval("siteName") %>',
                 "lon":'<%# Eval("gis_x") %>', 
                 "lat":'<%# Eval("gis_y") %>' 
             }
         </ItemTemplate>
         <SeparatorTemplate>
            ,
        </SeparatorTemplate>
        </asp:Repeater>
        ];

        //第三個月
        var markers3 = [
        <asp:Repeater ID="rptMarkers3"  runat="server"> 
         <ItemTemplate>
             {
                 "name" :'<%# Eval("siteName") %>',
                 "lon":'<%# Eval("gis_x") %>', 
                 "lat":'<%# Eval("gis_y") %>' 
             }
         </ItemTemplate>
         <SeparatorTemplate>
            ,
        </SeparatorTemplate>
        </asp:Repeater>
        ];
        //    --------------------------------------------------------------------------------------------
        //window.onload = function () {map();}
        window.onload = function () {initMap();init();}
        function map() {
            var mapOptions = {
             
                center: new google.maps.LatLng(parseFloat(markers[0].lat), parseFloat(markers[0].lon)),
             
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var infoWindow = new google.maps.InfoWindow({content:'<div id=\"mydiv\">YourContent</div>'});

            var map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);
                                  
            for (i = 0; i < markers.length; i++) {
                
                var data = markers[i]
                var myLatlng = new google.maps.LatLng(parseFloat(data.lat),parseFloat(data.lon));
           
                var marker = new google.maps.Marker({
                    position: myLatlng,
                    map: map,
                    icon: "../Login_Style/Icon_Station.png",
                    title: data.name
                });
                (function (marker, data) {
                    google.maps.event.addListener(marker, "click", function (e) {
                        infoWindow.setContent("<div style='width:150px; height:150px'>"+'測點名稱：'+data.name+'</div>');//+data.Lat+data.Lon
                         
                        infoWindow.open(map, marker);
                    });
                })(marker, data);
            }         
         
         
        }





        //OpenLayer========================================================
        function init() {
            if(markers.length>0){
                LocationPoints();
            }
            if(markers1.length>0){
                LocationPoints1();
            }
            if(markers2.length>0){
                LocationPoints2();
            }
            if(markers3.length>0){
                LocationPoints3();
            }
        }
        //初始化OL3 map物件
        function initMap() {
            var projection = ol.proj.get('EPSG:3857');
            var projectionExtent = projection.getExtent();
            var size = ol.extent.getWidth(projectionExtent) / 256;
            var resolutions = new Array(20);


            var matrixIds = new Array(20);
            for (var z = 0; z < 20; z++) {
                // generate resolutions and matrixIds arrays for this WMTS
                resolutions[z] = size / Math.pow(2, z);
                matrixIds[z] = z;
            }

            //南科管理局座標 
            var cLon="120.28194666";
            var cLat="23.09805929";
            var centerLon=cLon;
            var centerLat=cLat;
            var centerLon1=cLon;
            var centerLat1=cLat;
            var centerLon2=cLon;
            var centerLat2=cLat;
            var centerLon3=cLon;
            var centerLat3=cLat;
            //地圖中心座標 20181214 統一中心點
             if(markers.length>0){
                 centerLon=markers[0].lon;
                 centerLat=markers[0].lat;
             }
             if(markers1.length>0){
                 centerLon1=markers1[0].lon;
                 centerLat1=markers1[0].lat;
             }
             if(markers2.length>0){
                 centerLon2=markers2[0].lon;
                 centerLat2=markers2[0].lat;
             }
             if(markers3.length>0){
                 centerLon3=markers3[0].lon;
                 centerLat3=markers3[0].lat;
             }
            //園區圖層
            var vector = new ol.layer.Vector({
                source: new ol.source.Vector({
                    url: 'KML/STSPArea.kml',
                    format: new ol.format.KML()
                }), 
                style: new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 255, 0.2'
                    })
                })
            });

            var rasterLayer = new ol.layer.Tile({
                source: new ol.source.OSM({
                    url: 'http://mt{0-3}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                })
            });
            //季地圖=========================
            gMap = new ol.Map({
                layers: [
                new ol.layer.Tile({
                    source: new ol.source.OSM()
                    
                }), rasterLayer
                /*new ol.layer.Tile({
                  title: '通用版電子地圖',
                    opacity: 1,
                    visible: true,
                    visibleinTOC: false,
                    source: new ol.source.WMTS({
                        url: 'http://maps.nlsc.gov.tw/S_Maps/wmts',
                        layer: 'EMAP',
                        matrixSet: 'EPSG:3857',
                        format: 'image/png',
                        projection: projection,
                        tileGrid: new ol.tilegrid.WMTS({
                            origin: ol.extent.getTopLeft(projectionExtent),
                            resolutions: resolutions,
                            matrixIds: matrixIds
                        }),
                        style: 'null',
                        wrapX: true
                    })
                })*/
                ,vector
                ],                   
                controls: ol.control.defaults({
                    attributionOptions: /** @type {olx.control.AttributionOptions} */({
                        collapsible: true
                    })
                }),
                view: new ol.View({
                    center: ol.proj.transform([parseFloat(centerLon),parseFloat(centerLat)], 'EPSG:4326', 'EPSG:3857'),
                    zoom: 13,
                    minZoom: 7
                })
            });
            //}
            gMap.setTarget(document.getElementById("map"));
            var content = document.getElementById('popup-content');
            var closer = document.getElementById('popup-closer');
            var element = document.getElementById('popup')
            var popup = new ol.Overlay({
                element: element,
                positioning: 'bottom-center',
                stopEvent: false,

                autoPan: true
            });
            gMap.addOverlay(popup);

            //             display popup on click
            gMap.on('click', function (evt) {
                var feature = gMap.forEachFeatureAtPixel(evt.pixel,
                    function (feature, layer) {
                        return feature;

                    });
               
                if (feature && feature.get('showTab')==1) {
                    popup.setPosition(evt.coordinate);
                    content.innerHTML = feature.get('name') + "<br>" + feature.get('lat') + "<br>" + feature.get('lan') + "<br>";
                    $(content).popover('show');
                }
                else {
                    $(content).popover('destroy');
                }
            });

            closer.onclick = function () {
                popup.setPosition(undefined);
                closer.blur();
                return false;
            };
            //             change mouse cursor when over marker
            gMap.on('pointermove', function (e) {
                if (e.dragging) {
                    $(element).popover('destroy');
                    return;
                }
                var pixel = gMap.getEventPixel(e.originalEvent);
                var hit = gMap.hasFeatureAtPixel(pixel);
            });
            // zoomcentral(markers,gMap);
            //第一個月=========================
            gMap1 = new ol.Map({
                layers: [
                  new ol.layer.Tile({
                      source: new ol.source.OSM()
                  }), rasterLayer
                /*new ol.layer.Tile({
                  title: '通用版電子地圖',
                    opacity: 1,
                    visible: true,
                    visibleinTOC: false,
                    source: new ol.source.WMTS({
                        url: 'http://maps.nlsc.gov.tw/S_Maps/wmts',
                        layer: 'EMAP',
                        matrixSet: 'EPSG:3857',
                        format: 'image/png',
                        projection: projection,
                        tileGrid: new ol.tilegrid.WMTS({
                            origin: ol.extent.getTopLeft(projectionExtent),
                            resolutions: resolutions,
                            matrixIds: matrixIds
                        }),
                        style: 'null',
                        wrapX: true
                    })
                })*/
                ,vector
                ],                   
                controls: ol.control.defaults({
                    attributionOptions: /** @type {olx.control.AttributionOptions} */({
                        collapsible: true
                    })
                }),
                view: new ol.View({
                    center: ol.proj.transform([parseFloat(centerLon1),parseFloat(centerLat1)], 'EPSG:4326', 'EPSG:3857'),
                    zoom: 11,
                    minZoom: 6
                })
            });
            //}
            gMap1.setTarget(document.getElementById("map1"));
            var content1 = document.getElementById('popup-content1');
            var closer1 = document.getElementById('popup-closer1');
            var element1 = document.getElementById('popup1')
            var popup1 = new ol.Overlay({
                element: element1,
                positioning: 'bottom-center',
                stopEvent: false,

                autoPan: true
            });
            gMap1.addOverlay(popup1);

            //             display popup on click
            gMap1.on('click', function (evt) {
                var feature1 = gMap1.forEachFeatureAtPixel(evt.pixel,
                    function (feature1, layer) {
                        return feature1;

                    });
               
                if (feature1 && feature1.get('showTab')==1) {
                    popup1.setPosition(evt.coordinate);
                    content1.innerHTML = feature1.get('name') + "<br>" + feature1.get('lat') + "<br>" + feature1.get('lan') + "<br>";
                    $(content1).popover('show');
                }
                else {
                    $(content1).popover('destroy');
                }
            });

            closer1.onclick = function () {
                popup1.setPosition(undefined);
                closer1.blur();
                return false;
            };
            //             change mouse cursor when over marker
            //gMap1.on('pointermove', function (e) {
            //    if (e.dragging) {
            //        $(element1).popover('destroy');
            //        return;
            //    }
            //    var pixel1 = gMap1.getEventPixel(e.originalEvent);
            //    var hit1 = gMap1.hasFeatureAtPixel(pixel1);
            //});
            //  zoomcentral(markers1,gMap1);
            //第二個月=========================
            gMap2 = new ol.Map({
                layers: [
                 new ol.layer.Tile({
                     source: new ol.source.OSM()
                 }), rasterLayer
                /*new ol.layer.Tile({
                  title: '通用版電子地圖',
                    opacity: 1,
                    visible: true,
                    visibleinTOC: false,
                    source: new ol.source.WMTS({
                        url: 'http://maps.nlsc.gov.tw/S_Maps/wmts',
                        layer: 'EMAP',
                        matrixSet: 'EPSG:3857',
                        format: 'image/png',
                        projection: projection,
                        tileGrid: new ol.tilegrid.WMTS({
                            origin: ol.extent.getTopLeft(projectionExtent),
                            resolutions: resolutions,
                            matrixIds: matrixIds
                        }),
                        style: 'null',
                        wrapX: true
                    })
                })*/
                ,vector
                ],                   
                controls: ol.control.defaults({
                    attributionOptions: /** @type {olx.control.AttributionOptions} */({
                        collapsible: true
                    })
                }),
                view: new ol.View({
                    center: ol.proj.transform([parseFloat(centerLon2),parseFloat(centerLat2)], 'EPSG:4326', 'EPSG:3857'),
                    zoom: 11,
                    minZoom: 6
                })
            });
            //}
            gMap2.setTarget(document.getElementById("map2"));
            var content2 = document.getElementById('popup-content2');
            var closer2 = document.getElementById('popup-closer2');
            var element2 = document.getElementById('popup2')
            var popup2 = new ol.Overlay({
                element: element2,
                positioning: 'bottom-center',
                stopEvent: false,

                autoPan: true
            });
            gMap2.addOverlay(popup2);

            //             display popup on click
            gMap2.on('click', function (evt) {
                var feature2 = gMap2.forEachFeatureAtPixel(evt.pixel,
                    function (feature2, layer) {
                        return feature2;

                    });
               
                if (feature2 && feature2.get('showTab')==1) {
                    popup2.setPosition(evt.coordinate);
                    content2.innerHTML = feature2.get('name') + "<br>" + feature2.get('lat') + "<br>" + feature2.get('lan') + "<br>";
                    $(content2).popover('show');
                }
                else {
                    $(content2).popover('destroy');
                }
            });

            closer2.onclick = function () {
                popup2.setPosition(undefined);
                closer2.blur();
                return false;
            };
            //             change mouse cursor when over marker
            gMap2.on('pointermove', function (e) {
                if (e.dragging) {
                    $(element2).popover('destroy');
                    return;
                }
                var pixel2 = gMap2.getEventPixel(e.originalEvent);
                var hit2 = gMap2.hasFeatureAtPixel(pixel2);
            });
            //    zoomcentral(markers2,gMap2);
            //第三個月=========================
            gMap3 = new ol.Map({
                layers: [
                 new ol.layer.Tile({
                     source: new ol.source.OSM()
                 }), rasterLayer
                /*new ol.layer.Tile({
                  title: '通用版電子地圖',
                    opacity: 1,
                    visible: true,
                    visibleinTOC: false,
                    source: new ol.source.WMTS({
                        url: 'http://maps.nlsc.gov.tw/S_Maps/wmts',
                        layer: 'EMAP',
                        matrixSet: 'EPSG:3857',
                        format: 'image/png',
                        projection: projection,
                        tileGrid: new ol.tilegrid.WMTS({
                            origin: ol.extent.getTopLeft(projectionExtent),
                            resolutions: resolutions,
                            matrixIds: matrixIds
                        }),
                        style: 'null',
                        wrapX: true
                    })
                })*/
                ,vector
                ],                   
                controls: ol.control.defaults({
                    attributionOptions: /** @type {olx.control.AttributionOptions} */({
                        collapsible: true
                    })
                }),
                view: new ol.View({
                    center: ol.proj.transform([parseFloat(centerLon3),parseFloat(centerLat3)], 'EPSG:4326', 'EPSG:3857'),
                    zoom: 11,
                    minZoom: 6
                })
            });
            //}
            gMap3.setTarget(document.getElementById("map3"));
            var content3 = document.getElementById('popup-content3');
            var closer3 = document.getElementById('popup-closer3');
            var element3 = document.getElementById('popup3')
            var popup3 = new ol.Overlay({
                element: element3,
                positioning: 'bottom-center',
                stopEvent: false,

                autoPan: true
            });
            gMap3.addOverlay(popup3);

            //             display popup on click
            gMap3.on('click', function (evt) {
                var feature3 = gMap3.forEachFeatureAtPixel(evt.pixel,
                    function (feature3, layer) {
                        return feature3;

                    });
               
                if (feature3 && feature3.get('showTab')==1) {
                    popup3.setPosition(evt.coordinate);
                    content3.innerHTML = feature3.get('name') + "<br>" + feature3.get('lat') + "<br>" + feature3.get('lan') + "<br>";
                    $(content3).popover('show');
                }
                else {
                    $(content3).popover('destroy');
                }
            });

            closer3.onclick = function () {
                popup3.setPosition(undefined);
                closer3.blur();
                return false;
            };
            //             change mouse cursor when over marker
            gMap3.on('pointermove', function (e) {
                if (e.dragging) {
                    $(element3).popover('destroy');
                    return;
                }
                var pixel3 = gMap3.getEventPixel(e.originalEvent);
                var hit3 = gMap3.hasFeatureAtPixel(pixel3);
            });
            //     zoomcentral(markers3,gMap3);
        }//initMap()

        //季
        function LocationPoints(){
            //alert(CenterX);
            //alert(CenterY);
            //alert(Scale);
            //alert(markers.length);
            //gMap.clearOverlays();
            var CenterX = markers[0].lon;//經度
            var CenterY = markers[0].lat;//緯度
            makersA = new Array();
            for(i=0;i<markers.length;i++)
            {
                var data = markers[i];
                if(data.lon!="")
                {
                    //創造新的點
                    
                    //寫入tab的資料
                    name ="<font>測點名稱："+data.name+"</font>";
                    lan = "<font>經度："+data.lon+"</font>";
                    lat = "<font>緯度："+data.lat+"</font>";

                    var test = ol.proj.transform([parseFloat(data.lon), parseFloat(data.lat)], 'EPSG:4326', 'EPSG:3857');
                    //alert(test);
                    var point = new ol.Feature({
                        geometry: new ol.geom.Point(test),
                        name: name,
                        lan: lan,
                        lat:lat,
                        showTab:1
                    });

                    LdefIcon = new ol.style.Style({
                        image:  new ol.style.Circle({
                            radius: 5,
                            fill: new ol.style.Fill({color: 'rgba(255, 0, 0, 1)'}),
                            stroke: new ol.style.Stroke({color: 'rgba(255, 0, 0, 0.4)', width: 6})
                        }),
                        text: new ol.style.Text({
                            text: data.name
                            ,fill: new ol.style.Fill({
                                color: [0, 0, 0]
                            })
                            ,scale:1
                            ,offsetX:30
                            ,offsetY:15
                        })
                    });
            
                    point.setStyle(LdefIcon);
            
                    makersA[i] = point;
                }//if(LlonArr[i]!="")
            }//for(i=0;i<LlonArr.length;i++)
            var vectorSource = new ol.source.Vector({
                features: makersA
            });

            vectorLayer = new ol.layer.Vector({
                source: vectorSource
            });
         
            gMap.addLayer(vectorLayer);
            var extent = vectorLayer.getSource().getExtent();
            //  gMap.getView().fit(extent, gMap.getSize());          
            isEventOK="OK";
        }
        //第一個月
        function LocationPoints1(){
            //alert(CenterX);
            //alert(CenterY);
            //alert(Scale);
            //alert(markers.length);
            //gMap.clearOverlays();
            var CenterX = markers1[0].lon;//經度
            var CenterY = markers1[0].lat;//緯度
            makersA = new Array();
            for(i=0;i<markers1.length;i++)
            {
                var data = markers1[i];
                if(data.lon!="")
                {
                    //創造新的點
                    
                    //寫入tab的資料
                    name ="<font>測點名稱："+data.name+"</font>";
                    lan = "<font>經度："+data.lon+"</font>";
                    lat = "<font>緯度："+data.lat+"</font>";

                    var test = ol.proj.transform([parseFloat(data.lon), parseFloat(data.lat)], 'EPSG:4326', 'EPSG:3857');
                    //alert(test);
                    var point = new ol.Feature({
                        geometry: new ol.geom.Point(test),
                        name: name,
                        lan: lan,
                        lat:lat,
                        showTab:1
                    });

                    LdefIcon = new ol.style.Style({
                        image:  new ol.style.Circle({
                            radius: 5,
                            fill: new ol.style.Fill({color: 'rgba(255, 0, 0, 1)'}),
                            stroke: new ol.style.Stroke({color: 'rgba(255, 0, 0, 0.4)', width: 6})
                        }),
                        text: new ol.style.Text({
                            text: data.name
                            ,fill: new ol.style.Fill({
                                color: [0, 0, 0]
                            })
                            ,scale:1
                            ,offsetX:30
                            ,offsetY:15
                        })
                    });
            
                    point.setStyle(LdefIcon);
                    makersA[i] = point;
                }//if(LlonArr[i]!="")
            }//for(i=0;i<LlonArr.length;i++)
            var vectorSource = new ol.source.Vector({
                features: makersA
            });

            vectorLayer = new ol.layer.Vector({
                source: vectorSource
            });
           
            gMap1.addLayer(vectorLayer);
            var extent = vectorLayer.getSource().getExtent();
            //  gMap1.getView().fit(extent, gMap1.getSize());                     
            isEventOK="OK";
        }

        //第二個月
        function LocationPoints2(){
            //alert(CenterX);
            //alert(CenterY);
            //alert(Scale);
            //alert(markers.length);
            //gMap.clearOverlays();
            var CenterX = markers2[0].lon;//經度
            var CenterY = markers2[0].lat;//緯度
            makersA = new Array();
            for(i=0;i<markers2.length;i++)
            {
                var data = markers2[i];
                if(data.lon!="")
                {
                    //創造新的點
                    
                    //寫入tab的資料
                    name ="<font>測點名稱："+data.name+"</font>";
                    lan = "<font>經度："+data.lon+"</font>";
                    lat = "<font>緯度："+data.lat+"</font>";

                    var test = ol.proj.transform([parseFloat(data.lon), parseFloat(data.lat)], 'EPSG:4326', 'EPSG:3857');
                    //alert(test);
                    var point = new ol.Feature({
                        geometry: new ol.geom.Point(test),
                        name: name,
                        lan: lan,
                        lat:lat,
                        showTab:1
                    });

                    LdefIcon = new ol.style.Style({
                        image:  new ol.style.Circle({
                            radius: 5,
                            fill: new ol.style.Fill({color: 'rgba(255, 0, 0, 1)'}),
                            stroke: new ol.style.Stroke({color: 'rgba(255, 0, 0, 0.4)', width: 6})
                        }),
                        text: new ol.style.Text({
                            text: data.name
                            ,fill: new ol.style.Fill({
                                color: [0, 0, 0]
                            })
                            ,scale:1
                            ,offsetX:30
                            ,offsetY:15
                        })
                    });
            
                    point.setStyle(LdefIcon);
                    makersA[i] = point;
                }//if(LlonArr[i]!="")
            }//for(i=0;i<LlonArr.length;i++)
            var vectorSource = new ol.source.Vector({
                features: makersA
            });

            vectorLayer = new ol.layer.Vector({
                source: vectorSource
            });
           
            gMap2.addLayer(vectorLayer);
            var extent = vectorLayer.getSource().getExtent();
            //  gMap2.getView().fit(extent, gMap2.getSize());               
            isEventOK="OK";
        }

        //第三個月
        function LocationPoints3(){
            //alert(CenterX);
            //alert(CenterY);
            //alert(Scale);
            //alert(markers.length);
            //gMap.clearOverlays();
            var CenterX = markers3[0].lon;//經度
            var CenterY = markers3[0].lat;//緯度
            makersA = new Array();
            for(i=0;i<markers3.length;i++)
            {
                var data = markers3[i];
                if(data.lon!="")
                {
                    //創造新的點
                    
                    //寫入tab的資料
                    name ="<font>測點名稱："+data.name+"</font>";
                    lan = "<font>經度："+data.lon+"</font>";
                    lat = "<font>緯度："+data.lat+"</font>";

                    var test = ol.proj.transform([parseFloat(data.lon), parseFloat(data.lat)], 'EPSG:4326', 'EPSG:3857');
                    //alert(test);
                    var point = new ol.Feature({
                        geometry: new ol.geom.Point(test),
                        name: name,
                        lan: lan,
                        lat:lat,
                        showTab:1
                    });

                    LdefIcon = new ol.style.Style({
                        image:  new ol.style.Circle({
                            radius: 5,
                            fill: new ol.style.Fill({color: 'rgba(255, 0, 0, 1)'}),
                            stroke: new ol.style.Stroke({color: 'rgba(255, 0, 0, 0.4)', width: 6})
                        }),
                        text: new ol.style.Text({
                            text: data.name
                            ,fill: new ol.style.Fill({
                                color: [0, 0, 0]
                            })
                            ,scale:1
                             ,offsetX:30
                            ,offsetY:15
                        })
                    });
            
                    point.setStyle(LdefIcon);
                    makersA[i] = point;
                }//if(LlonArr[i]!="")
            }//for(i=0;i<LlonArr.length;i++)
            var vectorSource = new ol.source.Vector({
                features: makersA
            });

            vectorLayer = new ol.layer.Vector({
                source: vectorSource
            });
           
            gMap3.addLayer(vectorLayer);
            var extent = vectorLayer.getSource().getExtent();
            //     gMap3.getView().fit(extent, gMap3.getSize());                       
            isEventOK="OK";
        }
        function zoomcentral(mark,maptarge){
           

            var extent=ol.proj.transform([120.617759,24.208274], 'EPSG:4326', 'EPSG:3857'); 
            maptarge.getView().setCenter(extent);
            maptarge.getView().setZoom(13);
              
           

        }
        //========================================================




          
    </script>
    <ol class="breadcrumb">
        <!--現在位置導覽列-->
        <li class="breadcrumb-item"><a href="index5.aspx">首頁</a></li>
        <li class="breadcrumb-item active"><a href="#">測站分布</a></li>
    </ol>
    <div class="content-inside">
        <div class="Subtxt">
            <div class="subTitle">
                <h3>測站分布</h3>
            </div>
        </div>
        <!--Subtxt-->
        <div class="softwareText">
            <div class="col-md-12">
                <div class="form-group row">
                    <div class="sideByside">
                        <span class="sideByside">園區：</span><asp:DropDownList ID="area" runat="server" DataSourceID="SqlDataSource2" DataTextField="area_name" DataValueField="area_id" OnDataBound="area_DataBound" CssClass="form-control areadrp sideByside" AutoPostBack="True" OnSelectedIndexChanged="area_SelectedIndexChanged"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand=" SELECT [area_id], [area_name] FROM [C_Detect_Area]"></asp:SqlDataSource>
                    </div>
                    <div class="sideByside">
                        <span class="sideByside">類別：</span><asp:DropDownList ID="eid" runat="server" DataSourceID="SqlDataSource3" DataTextField="class_name" DataValueField="class_id" OnDataBound="eid_DataBound" CssClass="form-control typedrp sideByside"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sin %>" SelectCommand="  SELECT [class_id], [class_name] FROM [C_Detect_Class] where  class_id!=14 and class_id!=15"></asp:SqlDataSource>
                    </div>
                    <div class="sideByside" style="padding-right: 10px;">
                        <span class="sideByside">採樣日期：</span><asp:DropDownList ID="year" runat="server" CssClass="form-control timedrp sideByside">
                            <asp:ListItem>103</asp:ListItem>
                            <asp:ListItem>104</asp:ListItem>
                            <asp:ListItem>105</asp:ListItem>
                            <asp:ListItem>106</asp:ListItem>
                            <asp:ListItem >107</asp:ListItem>
                             <asp:ListItem Selected="True">108</asp:ListItem>
                        </asp:DropDownList>年
         <asp:DropDownList ID="season" runat="server" CssClass="form-control timedrp sideByside">
             <asp:ListItem>1</asp:ListItem>
             <asp:ListItem>2</asp:ListItem>
             <asp:ListItem>3</asp:ListItem>
             <asp:ListItem>4</asp:ListItem>
         </asp:DropDownList>季
                    </div>
                    <div style="display: inline-block; text-align: right;">
                        <asp:Button ID="search" runat="server" Text="查詢" OnClick="search_Click" class="btn btn-warning" />
                    </div>
                    <hr />
                </div>
            </div>
        </div>

        <asp:HiddenField ID="a" runat="server" />
        <asp:HiddenField ID="emi" runat="server" />
        <asp:HiddenField ID="item" runat="server" />
        <asp:HiddenField ID="cr" runat="server" />
        <asp:HiddenField ID="co" runat="server" />
        <asp:HiddenField ID="q" runat="server" />
        <%--                        </ContentTemplate>
    </asp:UpdatePanel>--%>
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-8">
                    <asp:Label ID="Label1" runat="server" Text="第一季"></asp:Label><div id="map" style="width: 100%;"></div>
                    <%-- height: 500px--%>
                </div>
                <div class="col-md-4">
                    <div>
                        <asp:Label ID="Label2" runat="server" Text="1月"></asp:Label>
                        <div id="map1" style="width: 100%;"></div>
                        <%-- height: 150px--%>
                    </div>
                    <div>
                        <asp:Label ID="Label3" runat="server" Text="2月"></asp:Label>
                        <div id="map2" style="width: 100%;"></div>
                        <%-- height: 150px--%>
                    </div>
                    <div>
                        <asp:Label ID="Label4" runat="server" Text="3月"></asp:Label>
                        <div id="map3" style="width: 100%;"></div>
                        <%-- height: 150px--%>
                    </div>
                </div>
            </div>
        </div>
        <%--<asp:Panel ID="Panel1" runat="server" Visible="false">
            <table style="width: 100%;">
                <tr>
                    <td rowspan="3" class="seasonMap" style="width: 68%">
                        <asp:Label ID="Label1" runat="server" Text="第一季"></asp:Label><div id="map" style="width: 100%; height: 500px"></div>
                    </td>
                    <td rowspan="3" class="" style="width: 2%"></td>
                    <td style="width: 30%">
                        <asp:Label ID="Label2" runat="server" Text="1月"></asp:Label><div id="map1" style="width: 100%; height: 150px"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="2月"></asp:Label><div id="map2" style="width: 100%; height: 150px"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="3月"></asp:Label><div id="map3" style="width: 100%; height: 150px"></div>
                    </td>
                </tr>
            </table>
        </asp:Panel>--%>
        <div id="popup" class="ol-popup">
            <a href="#" id="popup-closer" class="ol-popup-closer"></a>
            <div id="popup-content"></div>
        </div>

        <div id="popup1" class="ol-popup">
            <a href="#" id="popup-closer1" class="ol-popup-closer"></a>
            <div id="popup-content1"></div>
        </div>

        <div id="popup2" class="ol-popup">
            <a href="#" id="popup-closer2" class="ol-popup-closer"></a>
            <div id="popup-content2"></div>
        </div>

        <div id="popup3" class="ol-popup">
            <a href="#" id="popup-closer3" class="ol-popup-closer"></a>
            <div id="popup-content3"></div>
        </div>

        <%--<div id="map" style="width: 727px; height: 523px; position: absolute; top: 25px; left: 2px;"></div>--%>
        <div id="dvMap" style="width: 800px; height: 0px"></div>

    </div>
</asp:Content>

