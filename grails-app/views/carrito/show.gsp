<%--
  Created by IntelliJ IDEA.
  User: Neill
  Date: 6/14/2015
  Time: 10:44 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Carrito</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'custom.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'carrito.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'star-rating.css')}" />

    <!-- ||||||||||||||| SCRIPTS ||||||||||||||| -->
    <g:javascript src="jquery-1.11.2.min.js" />
    <g:javascript src="bootstrap.min.js" />
    <g:javascript src="context.js" />

    <script type="text/javascript"
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAHnIu6wKpmVEuMWFKM6fO98apSBsG-tHk&libraries=places&sensor=false">
    </script>

    <g:javascript src="star-rating.js"/>

    <script type="text/javascript">
        $(document).ready(function(){
            $(".product-rate").rating({
                'size':'sm',
                showClear: false,
                starCaptions: {1: "Muy malo", 2: "Malo", 3: "Regular", 4: "Bueno", 5: "Excelente"},
                clearCaption: "Sin calificación"
            });
        });
    </script>

    <script type="text/javascript">

        function scrollToID(id, speed, before, index){
            var offSet = 50;
            var targetOffset = $(id).offset().top - offSet;
            $('html,body').animate({scrollTop:targetOffset}, speed);
        }

        var progressbar1 = 33;
        var progressbar2 = 33;
        var progressbar3 = 34;
        var map;
        var markerCurrent;
        function initialize() {
            var mapOptions = {
                center: { lat: 4.668487, lng: -74.092701},
                zoom: 12
            };
            map = new google.maps.Map(document.getElementById('map-canvas'),
                    mapOptions);

            google.maps.event.addListener(map, 'rightclick', function(e) {
                createMarker(e.latLng);
            });
        }


        function createMarker(place){
            if(markerCurrent) markerCurrent.setMap(null);
            markerCurrent = new google.maps.Marker({
                map: map,
                position: place
            });
            $('#lat').val(markerCurrent.getPosition().lat());
            $('#lng').val(markerCurrent.getPosition().lng());
        }

        google.maps.event.addDomListener(window, 'load', initialize);

        $(document).ready(function(){

            $('.buttonMap').click(function () {
                scrollToID("#containerMap", 750 ,0,0)
            });

            $('.mybutton').click(function(){
                if(markerCurrent==null){
                    alert("Seleccione Posición")
                }else{
                    scrollToID("#opciones",750,0,0)
                }
            });

            $('#valueprogress1').change(function(){
                var value = $('#valueprogress1').val();
                var toSum = progressbar1 - value;
                var prog2;
                var prog3;
                if(toSum==1 || toSum==-1){
                    prog2 = progressbar2 + toSum;
                    prog3 = progressbar3;
                }else{
                    if(toSum % 2 == 0){
                        prog2 = progressbar2 + (toSum/2);
                        prog3 = progressbar3 + (toSum/2)
                    }else{
                        prog2 = progressbar2 + (toSum-1)/2 + 1;
                        prog3 = progressbar3 + (toSum-1)/2;
                    }
                }
                progressbar2 = prog2;
                progressbar3 = prog3;
                progressbar1 = value;
                $('#progress2').css("width",prog2+"%");
                $("#valueprogress2").val(progressbar2);
                $('#progress3').css("width",prog3+"%");
                $("#valueprogress3").val(progressbar3);
                $('#progress1').css("width",value+"%");
            });

            $('#valueprogress2').change(function(){
                var value = $('#valueprogress2').val();
                var toSum = progressbar2 - value;
                var prog1;
                var prog3;
                if(toSum==1 || toSum==-1){
                    prog1 = progressbar1 + toSum;
                    prog3 = progressbar3;
                }else{
                    if(toSum % 2 == 0){
                        prog1 = progressbar1 + (toSum/2);
                        prog3 = progressbar3 + (toSum/2)
                    }else{
                        prog1 = progressbar1 + (toSum-1)/2 + 1;
                        prog3 = progressbar3 + (toSum-1)/2;
                    }
                }
                progressbar2 = value;
                progressbar3 = prog3;
                progressbar1 = prog1;
                $('#progress1').css("width",prog1+"%");
                $("#valueprogress1").val(progressbar1);
                $('#progress3').css("width",prog3+"%");
                $("#valueprogress3").val(progressbar3);
                $('#progress2').css("width",value+"%");
            });

            $('#valueprogress3').change(function(){
                var value = $('#valueprogress3').val();
                var toSum = progressbar3 - value;
                var prog1;
                var prog2;
                if(toSum==1 || toSum==-1){
                    prog2 = progressbar2 + toSum;
                    prog1 = progressbar1;
                }else{
                    if(toSum % 2 == 0){
                        prog2 = progressbar2 + (toSum/2);
                        prog1 = progressbar1 + (toSum/2)
                    }else{
                        prog2 = progressbar2 + (toSum-1)/2 + 1;
                        prog1 = progressbar1 + (toSum-1)/2;
                    }
                }
                progressbar2 = prog2;
                progressbar1 = prog1;
                progressbar3 = value;
                $('#progress2').css("width",prog2+"%");
                $("#valueprogress2").val(progressbar2);
                $('#progress1').css("width",prog1+"%");
                $("#valueprogress1").val(progressbar1);
                $('#progress3').css("width",value+"%");
            });

            $('.buttonsucess').click(function () {
                $('.resultados').html(markerCurrent.getPosition().lat() + " " + markerCurrent.getPosition().lat() + " " + $('#valueprogress1').val() + " " +$('#valueprogress2').val() + " " + $('#valueprogress3').val());
            });

        });
    </script>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top background-color">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        <!--El header contiene el boton "inicio"-->
            <g:link controller="VMarket" action="index" class="navbar-brand">
                V-Market <span class="glyphicon glyphicon-asterisk"></span>
            </g:link>

        </div>

        <div id="navbar" class="navbar-collapse collapse">

            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Categorias <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><g:link controller="product" action="Salud_y_Aseo">Salud y Aseo</g:link> </li>
                        <li><g:link controller="product" action="Licores">Licores</g:link></li>
                        <li><g:link controller="product" action="Refrigerados">Refrigerados</g:link></li>
                        <li><g:link controller="product" action="Frutas_Y_Verduras">Frutas y Verduras</g:link></li>
                        <li><g:link controller="product" action="Alimentos_Y_Bebidas">Alimentos y bebidas</g:link>></li>
                    </ul>
                </li>
            </ul>

            <sec:ifNotLoggedIn>
                <ul class="nav navbar-nav navbar-right">
                    <li><g:link controller="user" action="register"> <span class="glyphicon glyphicon-user"></span> Registrate</g:link></li>
                </ul>

                <p class="nav navbar-text navbar-right" > o </p>

                <ul class="nav navbar-nav navbar-right">
                    <li><g:link controller="login"><span class="glyphicon glyphicon-log-in"></span> Ingresa</g:link></li>
                </ul>
            </sec:ifNotLoggedIn>
            <sec:ifLoggedIn>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                            <sec:username /> <span class="glyphicon glyphicon-user"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><g:link controller="user" action="profile" id="${user.id}">Ver perfil</g:link></li>
                            <li><g:link controller="carrito" action="show" >Carrito</g:link></li>
                            <li class="divider"></li>
                            <li><g:link controller="logout">Log out <span class="glyphicon glyphicon-log-out"></span></g:link></li>
                        </ul>
                    </li>
                </ul>
            </sec:ifLoggedIn>
        </div><!--/.navbar-collapse-->
    </div>
</nav>

<div class="container">
    <div class="row" style="height: 80%">
        <div class="col-md-12">
            <div class="row" style="height: 14%; width:100%"></div>
            <div class="container">
                <div class="row" style="width:100%">
                    <div class="h_line"></div>
                    <g:each in="${session.carrito.products}" status="i" var="productInstance">
                        <div class="col-md-3">
                            <g:render template="/product/one_product" bean="${productInstance}" var="productInstance" style="width: 100%"/>
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
    </div>
    <div class="row" style="height: 20%">
        <div class="col-lg-12" style="text-align: center    ">
            <div class="btn btn-default"><div class="buttonMap">Verificar Opciones</div></div>
        </div>
    </div>
</div>
<div id="containerMap">
    <div class="titulo">Selecciona un punto de referencia    <button class="mybutton btn btn-default">Continuar</button></div>
    <div id="map-canvas"></div>
</div>
<div id="opciones">
    <div class="titulo">Criterios de Selección</div>
    <br>
    <br>
    <div class="row">
        <div class="col-md-12" style="text-align: center">
            <div class="progress" style="width: 100%">
                <div class="progress-bar progress-bar-success" role="progressbar" style="width:33%" id="progress1">
                    Distancia
                </div>
                <div class="progress-bar progress-bar-info" role="progressbar" style="width:33%" id="progress2">
                    Precio
                </div>
                <div class="progress-bar progress-bar-warning" role="progressbar" style="width:34%" id="progress3">
                    Calidad
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <g:field type="number" min="0" max="100" name="valueprogress1" value="33"/>
        </div>
        <div class="col-md-4">
            <g:field type="number" min="0" max="100" name="valueprogress2" value="33"/>
        </div>
        <div class="col-md-4">
            <g:field type="number" min="0" max="100" name="valueprogress3" value="34"/>
        </div>
    </div>
    <br>
    <br>
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4" style="text-align: center">
            <button class="buttonsucess btn btn-default">Hallar mejor opción</button>
        </div>
        <div class="col-md-4"></div>
    </div>
    <div class="resultados">


    </div>
</div>
</body>
</html>