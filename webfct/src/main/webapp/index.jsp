<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

<title>Libros</title>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<h1>Web Libros</h1>
		</div>
		<div class="row justify-content-center">
			<%
				String error = request.getParameter("mensaje");
				if (error != null) {
			%>
			<div class="alert alert-warning alert-dismissible fade show"
				role="alert">
				<%
					out.print(error);
				%>
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<%
				}
			%>
		</div>
		<div class="row justify-content-center">
			<form role="form" method="POST" action="ValidarUsuario">
				<div class="form-group">
					<label for="usuario">Usuario</label> <input type="text"
						class="form-control" id="usuario" name="usuario"
						aria-describedby="usuarioHelp" autofocus required="required">
				</div>
				<div class="form-group">
					<label for="password">Password</label> <input type="password"
						class="form-control" id="password" name="password"
						required="required">
				</div>
				<button type="submit" class="btn btn-primary"><i class="fas fa-share-square"></i> Enviar</button>
				<button type="button" class="btn btn-secondary" onclick="location.href='jsp/registrar.jsp'"><i class="fas fa-user-plus"></i> Registrar</button>
			</form>

		</div>
	</div>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="js/jquery-3.3.1.slim.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>