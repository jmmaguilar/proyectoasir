<!doctype html>
<html lang="es">
<head>

<!------ Include the above in your HEAD tag ---------->
<!-- Required meta tags -->
<meta charset="ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">


<title>Libros</title>
</head>
<body background="imagenes/fondo.jpg" style="background-repeat: no-repeat; background-attachment: fixed;">

<div class="container white" style="background-color: white;vertical-align: middle;border-radius: 5px;margin-top:15%;margin-bottom:15%;padding: 50px 20px 50px 20px;">
			<%
				String error = request.getParameter("mensaje");
				if (error != null) {
			%>
			<div class="alert alert-warning alert-dismissible fade show" role="alert">
				<% out.print(error); %>
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br />
			<% } %>
		<div class="row justify-content"  style="margin: 10px 10px 10px 10px;">
			
			 <img src="imagenes/icono.png" style="margin: 0 0 0 15%;width: 10em; weight: 1em;">
			 
			<form role="form" method="POST" action="ValidarUsuario" style="margin: 0 0 0 15%;">
			<h1>Acceder</h1> <hr/>
				<label>Usuario</label>
 		 		<div class="input-group mb-2 mr-sm-2">
  	  				<div class="input-group-prepend">
   	   				<div class="input-group-text"><i class="fas fa-user"></i></div>
   	 			</div>
  	 			<input type="text" class="form-control" id="usuario" name="usuario" aria-describedby="usuarioHelp" autofocus required="required">
 	 		</div>
				<div class="form-group">
					<label for="password">Contraseña</label>
					<div class="input-group mb-2 mr-sm-2">
  	  					<div class="input-group-prepend">
   	   					<div class="input-group-text"><i class="fas fa-key"></i></div>
   	 				</div>
					 <input type="password" class="form-control" id="password" name="password" required="required">
				</div>
				<button type="submit" class="btn btn-success"><i class="fas fa-sign-in-alt"></i> Enviar</button>
				<button type="button" class="btn btn-dark" onclick="location.href='jsp/registro.jsp'"><i class="fas fa-user-plus"> </i> Registrar</button>
			</form>
			


	</div>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="js/jquery-3.3.1.slim.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>