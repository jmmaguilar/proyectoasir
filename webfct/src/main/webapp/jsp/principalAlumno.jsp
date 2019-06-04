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

<title>Inicio</title>
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
			
			if (usuario.getTipo() != 2) {
				response.sendRedirect("../index.jsp?mensaje=Solo accesible al alumnado");
			} else {
			Conexion con = new Conexion(usu, pass, driver, bd);
			
			FichasDAO fDAO = new FichasDAOImpl();
			List<Fichas> fichas = fDAO.listar(con, (Usuario)session.getAttribute("usuarioWeb"));

			int horas = 0;
			int minutos = 0;
			int segundos = 0;
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
      <li class="nav-item active">
        <a class="nav-link" href="#"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="informacionAlumno.jsp"><strong>Tutor y Empresa</strong></a>
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
    <th>Fecha</th>
    <th>Descripción</th>
    <th>Horas</th>
    <th>Observaciones</th>
    <th>Editar / Borrar</th>
  </tr>
<%
	for(Fichas f:fichas) {
		%>
		  <tr>
		    <td><%=f.getFecha() %></td>
		    <td><%=f.getDescripcion() %></td>
		    <td><%=f.getHoras() %>
		    <%		    	
		    	int horasAux = Integer.parseInt(f.getHoras().substring(0, 2));
		   		int minutosAux = Integer.parseInt(f.getHoras().substring(3, 5));
		   		int segundosAux = Integer.parseInt(f.getHoras().substring(6, 8));
		   		
				if (segundos + segundosAux >= 60) {
					segundos = (segundos + segundosAux) - 60;
					if (minutos + minutosAux + 1 >= 60) {
						minutos = (minutos + minutosAux + 1) - 60;
						horas = horas + horasAux + 1;
					} else {
						minutos = minutos + minutosAux + 1;
						horas = horas + horasAux;
					}
		    	} else {
		    		segundos = segundos + segundosAux;
		    		if (minutos + minutosAux >= 60) {
						minutos = (minutos + minutosAux) - 60;
						horas = horas + horasAux + 1;
					} else {
						minutos = minutos + minutosAux;
						horas = horas + horasAux;
					}
		    	}
		    %>
		    </td>
		    
		    <td>
		    <%
		    	if(f.getObservaciones() == null) {
		    		out.print(" ");
		    	} else {
		    		out.print(f.getObservaciones());
		    	}	
		    %>
		    <td><button type="button" data-toggle="modal" data-target="#modalEditar<%=f.getFecha() %>" class="btn btn-primary" style="margin:0.25em 0em 0.25em 0em;"> <i class="far fa-edit"> </i></button>
		    <button type="button" data-toggle="modal" data-target="#modalBorrar<%=f.getFecha() %>" class="btn btn-danger" style="margin:0.25em 0em 0.25em 0em;"> <i class="fas fa-trash"> </i></button>
		    </td>
		  </tr>
		  
		  <!-- Modal -->
		  <div class="modal fade" id="modalBorrar<%=f.getFecha() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">¿Seguro que desea borrar este día <%=f.getFecha() %>?</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../BorrarFicha" style="margin:0;" onsubmit="return validarAnadirSerie()">
													<input type="hidden" id="idAlumno" name="idAlumno" value="<%=f.getIdAlumno() %>" class="form-control">
													<input type="hidden" id="fecha" name="fecha" value="<%=f.getFecha() %>" class="form-control">						
								<button type="submit" class="btn btn-success">Sí</button>
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
							</form>
						</div>
					</div>
				</div>
				</div>
		  
<div class="modal fade" id="modalEditar<%=f.getFecha() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">Modificar Día <%=f.getFecha() %></h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../EditarFicha" style="margin:0;" onsubmit="return validarAnadirSerie()">
									<div class="form-group">
										<label>Descripción</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-align-left"></i>
												</div>
											</div>
											<input type="text" class="form-control" id="descripcion" name="descripcion" value="<%=f.getDescripcion() %>" required="required">
										</div>
										</div>
										<span id="spdescripcion" style="color: red"></span>
										<div class="form-group">
											<label >Horas</label>
											<div class="input-group mb-2 mr-sm-2">
												<div class="input-group-prepend">
													<div class="input-group-text">
														<i class="far fa-hourglass"></i>
													</div>
												</div>
												<input type="time" class="form-control" id="horas" name="horas" value="<%=f.getHoras() %>" required="required">
											</div>
											</div>
											<span id="sphoras" style="color: red"></span>
											<div class="form-group">
												<label>Observaciones</label>
												<div class="input-group mb-2 mr-sm-2">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<i class="fas fa-align-left"></i>
														</div>
													</div>
													<input type="text" id="observaciones" name="observaciones" value="<%if(f.getObservaciones() == null){out.print(" ");} else {out.print(f.getObservaciones());}%>" class="form-control">
												</div>
												</div>
												<div>
													<span id="spobservaciones" style="color: red"></span>
												</div>	
													<input type="hidden" id="idAlumno" name="idAlumno" value="<%=f.getIdAlumno() %>" class="form-control">
													<input type="hidden" id="fecha" name="fecha" value="<%=f.getFecha() %>" class="form-control">
																
								<button type="submit" class="btn btn-success">Enviar</button>
							
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
							</form>
						</div>
					</div>
				</div>
				</div>
		  
	  <%
	}
%>
</table>
<button type="button" class="btn btn-success" style="margin-top: 1em; width: 100%;"><b>Horas Totales: <%=horas %>:<%=minutos %>:<%=segundos %></b></button>
<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAnadir" style="margin-top: 1em; width: 100%;"><b>Añadir nuevo día</b></button>

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

								<form role="form" method="POST" action="../AnadirDia" style="margin:0;" onsubmit="return validarAnadirSerie()">
									<label>Fecha</label>
									<div class="input-group mb-2 mr-sm-2">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="far fa-calendar-alt"></i>
											</div>
										</div>
										<input type="text" class="form-control" id="fecha" name="fecha" placeholder="YYYY-MM-DD" autofocus required 
										pattern="(?:19|20)[0-9]{2}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))" 
										title="Enter a date in this format YYYY-MM-DD"/>
									</div>
									<span id="spfecha" style="color: red"></span>
									<div class="form-group">
										<label>Descripción</label>
										<div class="input-group mb-2 mr-sm-2">
											<div class="input-group-prepend">
												<div class="input-group-text">
													<i class="fas fa-align-left"></i>
												</div>
											</div>
											<input type="text" class="form-control" id="descripcion" name="descripcion" required="required">
										</div>
										</div>
										<span id="spdescripcion" style="color: red"></span>
										<div class="form-group">
											<label >Horas</label>
											<div class="input-group mb-2 mr-sm-2">
												<div class="input-group-prepend">
													<div class="input-group-text">
														<i class="far fa-hourglass"></i>
													</div>
												</div>
												<input type="time" class="form-control" id="horas" name="horas" required="required">
											</div>
											</div>
											<span id="sphoras" style="color: red"></span>
											<div class="form-group">
												<label>Observaciones</label>
												<div class="input-group mb-2 mr-sm-2">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<i class="fas fa-align-left"></i>
														</div>
													</div>
													<input type="text" id="observaciones" name="observaciones" class="form-control">
												</div>
												</div>
												<div>
													<span id="spobservaciones" style="color: red"></span>
												</div>
												<input type="hidden" id="idAlumno" name="idAlumno" value="<%=usuario.getIdUsuario()%>" class="form-control">
																	
								<button type="submit" class="btn btn-success">Enviar</button>
							
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
							</form>
						</div>
					</div>
				</div>
				</div>




<%
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