<%@page import="es.cj.dao.EmpresaDAO"%>
<%@page import="es.cj.dao.EmpresaDAOImpl"%>
<%@page import="es.cj.bean.Empresa"%>
<%@page import="es.cj.dao.UsuarioDAOImpl"%>
<%@page import="es.cj.dao.UsuarioDAO"%>
<%@page import="java.util.List"%>
<%@page import="es.cj.dao.FichasDAOImpl"%>
<%@page import="es.cj.dao.FichasDAO"%>
<%@page import="es.cj.bean.Fichas"%>
<%@page import="es.cj.bean.Conexion"%>
<%@page import="es.cj.bean.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet"	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"	crossorigin="anonymous">
<link rel="icon" href="../imagenes/icono.png">

<style>
#customers {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  border-radius: 0.5em;
  overflow: hidden;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: center;
  background-color: #343a40;
  color: white;
}

#customers td {
  text-align: center;
}
</style>

<title>Administración</title>
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
			
			if (usuario.getTipo() == 0 || usuario.getTipo() == 1) {
				Conexion con = new Conexion(usu, pass, driver, bd);
				
				EmpresaDAO eDAO = new EmpresaDAOImpl();
				List<Empresa> empresas = eDAO.listarTodo(con);
	

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
    <%
          if (usuario.getTipo() == 0) {
    	  %>
    	  <li class="nav-item">
        <a class="nav-link" href="principalDirectivo.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="asignaciones.jsp"><strong>Asignaciones</strong></a>
      </li>
      	  <%
      } else if (usuario.getTipo() == 1) {
    	  %>
    	<li class="nav-item">
       		<a class="nav-link" href="principalTutor.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
      	</li>
      	<li class="nav-item">
        <a class="nav-link" href="asignaciones.jsp"><strong>Asignaciones</strong></a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="historial.jsp"><strong>Historial</strong></a>
      </li>
      	  <%
      }
      	if (usuario.getTipo() == 1) {
      		%>
      		<li class="nav-item">
            <a class="nav-link" href="informacionTutor.jsp"><strong>Alumnos</strong></a>
          </li>
          <%
      	}
      %>
      
            <li class="nav-item dropdown active">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><strong>Administración</strong></a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="administracionUsuarios.jsp">Administración de Usuarios</a>
          <a class="dropdown-item active" href="#">Administración de Empresas</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="perfil.jsp"><strong>Perfil</strong></a>
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
			
<table id="customers">
  <tr>
    <th>Nombre</th>
    <th>Dirección</th>
    <th>Código Postal</th>
    <th>Editar / Borrar</th>
  </tr>
  <%
  	for (Empresa e:empresas) {
  	%>
  	  <tr>
  		<td><%=e.getNombre() %></td>
  		<td><%=e.getDireccion() %></td>
  		<td><%=e.getCp() %></td>
  		<td>
  			<button type="button" data-toggle="modal" data-target="#modalEditar<%=e.getIdEmpresa() %>" class="btn btn-primary" style="margin:0.25em 0em 0.25em 0em;"> <i class="far fa-edit"> </i></button>
  			<button type="button" data-toggle="modal" data-target="#modalBorrar<%=e.getIdEmpresa() %>" class="btn btn-danger" style="margin:0.25em 0em 0.25em 0em;"> <i class="fas fa-trash"> </i></button>
  		</td>
  	  </tr>
  	  		  <div class="modal fade" id="modalBorrar<%=e.getIdEmpresa() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">¿Seguro que desea la empresa <b><%=e.getNombre() %></b>?</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../BorrarEmpresa" style="margin:0;" onsubmit="return validarAnadirSerie()">
									<input type="hidden" id="idEmpresa" name="idEmpresa" value="<%=e.getIdEmpresa() %>" class="form-control">					
									<input type="hidden" id="login" name="login" value="<%=usuario.getLogin() %>" class="form-control">					
								<button type="button" data-toggle="modal" data-target="#modalBorrarPass<%=e.getIdEmpresa() %>" class="btn btn-success">Sí</button>
					<!-- MODAL -->
					<div class="modal fade" id="modalBorrarPass<%=e.getIdEmpresa() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">Introduzca su contraseña</h5>
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
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
							</form>
						</div>
					</div>
				</div>
				</div>
		  
<div class="modal fade" id="modalEditar<%=e.getIdEmpresa() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">Modificar usuario</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../ActualizarEmpresa" style="margin:0;" onsubmit="return validarAnadirSerie()">
									<div class="form-group">
										<label>Nombre</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-align-left"></i>
												</div>
											</div>
											<input type="text" class="form-control" id="nombre" name="nombre" value="<%=e.getNombre() %>" required="required">
										</div>
										</div>
										<span id="splogin" style="color: red"></span>
										<div class="form-group">
											<label >Direccion</label>
											<div class="input-group mb-2 mr-sm-2">
												<div class="input-group-prepend">
													<div class="input-group-text">
														<i class="fas fa-file-signature"></i>
													</div>
												</div>
												<input type="text" class="form-control" id="direccion" name="direccion" value="<%=e.getDireccion() %>" required="required">
											</div>
											</div>
											<span id="spnombre" style="color: red"></span>
											<div class="form-group">
												<label>Código Postal</label>
												<div class="input-group mb-2 mr-sm-2">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<i class="fas fa-align-left"></i>
														</div>
													</div>
													<input type="text" id="cp" name="cp" value="<%=e.getCp() %>" class="form-control">
												</div>
												</div>
												<div class="form-group">
										    </div>
										    </div>
													<input type="hidden" id="idEmpresa" name="idEmpresa" value="<%=e.getIdEmpresa() %>" class="form-control">
										 			<input type="hidden" id="login" name="login" value="<%=usuario.getLogin() %>" class="form-control">
								<div class="modal-footer">								
								<button type="button" data-toggle="modal" data-target="#modalEditarPass<%=e.getIdEmpresa() %>" class="btn btn-success">Sí</button>
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
								</div>
					<!-- MODAL -->
					<div class="modal fade" id="modalEditarPass<%=e.getIdEmpresa() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">Introduzca su contraseña</h5>
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
					</div>
				</div>
  	<%
  	}
  %>
  
		  

</table>
<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAnadir" style="margin-top: 1em; width: 100%;"><b>Añadir nueva empresa</b></button>

<!-- Modal -->
<div class="modal fade" id="modalAnadir" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">Añadir Nuevo Día</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../AnadirEmpresa" style="margin:0;" onsubmit="return validarAnadirSerie()">
									<label>Nombre</label>
									<div class="input-group mb-2 mr-sm-2">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="far fa-calendar-alt"></i>
											</div>
										</div>
										<input type="text" class="form-control" id="nombre" name="nombre" required="required">
									</div>
									<span id="spfecha" style="color: red"></span>
									<div class="form-group">
										<label>Direccion</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-align-left"></i>
												</div>
											</div>
											<input type="text" class="form-control" id="direccion" name="direccion" required="required">
										</div>
										</div>
										<span id="spdescripcion" style="color: red"></span>
										<div class="form-group">
											<label >Código Postal</label>
											<div class="input-group mb-2 mr-sm-2">
												<div class="input-group-prepend">
													<div class="input-group-text">
														<i class="far fa-hourglass"></i>
													</div>
												</div>
												<input type="number" min="00000" max="99999"class="form-control" id="cp" name="cp" required="required">
											</div>
											</div>
																	
								<button type="submit" class="btn btn-success">Enviar</button>
							
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
							</form>
						</div>
					</div>
				</div>
				</div>

<%
			} else {
				response.sendRedirect("../index.jsp?mensaje=Solo accesible al profesorado");
			}
			}
		%>
</div>
<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="../js/jquery-3.3.1.slim.min.js"></script>
	<script src="../js/popper.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>