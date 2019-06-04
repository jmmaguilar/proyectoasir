<%@page import="java.util.List"%>
<%@page import="es.cj.dao.FichasDAOImpl"%>
<%@page import="es.cj.dao.FichasDAO"%>
<%@page import="es.cj.bean.Fichas"%>
<%@page import="es.cj.bean.Conexion"%>
<%@page import="es.cj.bean.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="es">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet"	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"	crossorigin="anonymous">
<link rel="icon" href="../imagenes/icono.png">

<title>Perfil</title>
</head>
<body>

<%
		if (session.getAttribute("usuarioWeb") == null || session.isNew()) {
			response.sendRedirect("../index.jsp?mensaje=Error de sesión");
		} else {
			ServletContext sc = getServletContext();
			String usu = sc.getInitParameter("usuario");
			String pass = sc.getInitParameter("password");
			String driver = sc.getInitParameter("driver");
			String bd = sc.getInitParameter("database");
			Usuario usuario = (Usuario)session.getAttribute("usuarioWeb");

			Conexion con = new Conexion(usu, pass, driver, bd);
			
	%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">
  <img src="../imagenes/icono.png" width="35" height="35" class="d-inline-block align-top" alt="">
    <strong>IES Ciudad Jardín</strong></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse order-3" id="navbarTogglerDemo02">
    <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
      <li class="nav-item">
      <%
      if (usuario.getTipo() == 0) {
    	  %>
    	  <li>
    	  <a class="nav-link" href="principalDirectivo.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
    	  </li>
    	  <li class="nav-item">
        <a class="nav-link" href="administracionUsuarios.jsp"><strong>Administración de Usuarios</strong></a>
      </li>
      	  <%
      } else if (usuario.getTipo() == 1) {
    	  %>
    	  <li>
    	  <a class="nav-link" href="principalTutor.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
    	  </li>
    	  <li class="nav-item">
       		<a class="nav-link" href="informacionTutor.jsp"><strong>Alumnos</strong></a>
     	 </li>
     	 <li class="nav-item">
        <a class="nav-link" href="administracionUsuarios.jsp"><strong>Administración de Usuarios</strong></a>
      </li>
      	  <%
      } else {
    	  %>
    	  <li>
    	  <a class="nav-link" href="principalAlumno.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
    	  </li>
    	  <li class="nav-item">
       		<a class="nav-link" href="informacionAlumno.jsp"><strong>Tutor y Empresa</strong></a>
      	  </li>
      	  <%
      }
      %>
      <li class="nav-item">
        <a class="nav-link active" href="#"><strong>Perfil</strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-danger" href="../CerrarSesion"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a>
      </li>
    </ul>
  </div>
</nav>

<div class="container" style="margin-top: 2em;">
<%
				String error = request.getParameter("mensaje");
					if (error != null) {
			%>
			<div class="alert alert-warning alert-dismissible fade show"
				role="alert" style="text-align: center;">
				<%
					out.print(error);
				%>
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br />
			<%
				}
			%>

<form role="form" method="POST" action="../ActualizarPerfil" style="margin:0;" onsubmit="return validarAnadirSerie()">
									<div class="form-group">
										<label>Nombre</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-file-signature"></i>
												</div>
											</div>
											<input type="text" class="form-control" id="nombre" name="nombre" value="<%=usuario.getNombre() %>" required="required">
										</div>
										</div>
										<label>Apellidos</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-align-left"></i>
												</div>
											</div>
											<input type="text" class="form-control" id="apellidos" name="apellidos" value="<%=usuario.getApellidos() %>" required="required">
										</div>
										<label>Email</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-at"></i>
												</div>
											</div>
											<input type="text" class="form-control" id="email" name="email" value="<%=usuario.getEmail() %>" required="required">
										</div>
										<label>Nueva contraseña</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-key"></i>
												</div>
											</div>
											<input type="password" class="form-control" id="passwordNueva" name="passwordNueva">
										</div>
					
											<input type="hidden" id="idUsuario" name="idUsuario" value="<%=usuario.getIdUsuario() %>" class="form-control">
											<input type="hidden" id="tipo" name="tipo" value="<%=usuario.getTipo() %>" class="form-control">
											<input type="hidden" id="login" name="login" value="<%=usuario.getLogin() %>" class="form-control">

								<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalActualizar" style="margin-top: 1em; width: 100%;"><b>Actualizar</b></button>
								<!-- Modal -->
		  <div class="modal fade" id="modalActualizar" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">Introduzca su contraseña actual</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
							<label>Contraseña</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-key"></i>
												</div>
											</div>
											<input type="password" class="form-control" id="password" name="password" required="required" autofocus>
										</div>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Enviar</button>
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
						</div>
					</div>
				</div>
				</div>
							</form>

</div>
<%
		}

%>
<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="../js/jquery-3.3.1.slim.min.js"></script>
	<script src="../js/popper.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>