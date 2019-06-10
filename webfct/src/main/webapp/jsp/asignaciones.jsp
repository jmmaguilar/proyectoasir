<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="es.cj.dao.TutoresLaboralesDAOImpl"%>
<%@page import="es.cj.dao.TutoresLaboralesDAO"%>
<%@page import="es.cj.bean.TutoresLaborales"%>
<%@page import="es.cj.bean.Empresa"%>
<%@page import="es.cj.dao.UsuarioDAOImpl"%>
<%@page import="es.cj.dao.UsuarioDAO"%>
<%@page import="es.cj.dao.EmpresaDAOImpl"%>
<%@page import="es.cj.dao.EmpresaDAO"%>
<%@page import="es.cj.bean.Visitas"%>
<%@page import="java.util.List"%>
<%@page import="es.cj.dao.VisitasDAO"%>
<%@page import="es.cj.dao.VisitasDAOImpl"%>
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

.anadir {
  margin: 0 auto;
  width: 80%;
  margin-top: 1.5em;
  padding-right: 15px;
  padding-left: 15px;
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
					
			if (usuario.getTipo() == 1 || usuario.getTipo() == 0) {

			
				Conexion con = new Conexion(usu, pass, driver, bd);
				
				UsuarioDAO uDAO = new UsuarioDAOImpl();
				
				EmpresaDAO eDAO = new EmpresaDAOImpl();
				
				TutoresLaboralesDAO tDAO = new TutoresLaboralesDAOImpl();
				
				List<TutoresLaborales> t = tDAO.listarTodo(con);
				
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
    if(usuario.getTipo() == 1){
    	%>
    	<li class="nav-item">
        <a class="nav-link" href="principalTutor.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="#"><strong>Asignaciones</strong></a>
      </li>
        <li class="nav-item">
        <a class="nav-link" href="historial.jsp"><strong>Historial</strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="informacionTutor.jsp"><strong>Alumnos</strong></a>
      </li>
      <%
    } else {
    	%>
    	<li class="nav-item">
        <a class="nav-link" href="principalDirectivo.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="#"><strong>Asignaciones</strong></a>
      </li>
      <%
    }
    %>
    
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><strong>Administración</strong></a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="administracionUsuarios.jsp">Administración de Usuarios</a>
          <a class="dropdown-item" href="administracionEmpresas.jsp">Administración de Empresas</a>
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

<div class="container" style="margin-top:1em;">
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
	<a class="btn btn-dark" data-toggle="modal" data-target="#modalAnadir" style="width: 100%;color: white;"><i class="fas fa-plus"></i> <b>Nueva Visita</b></a>	
</div>

<!-- Modal -->
<div class="modal fade" id="modalAnadir" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">Nueva Visita</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../AnadirAsignacion" style="margin:0;" onsubmit="return validarAnadirSerie()">
											<div class="form-group">
											<label style="color: black;">Alumno</label>
											<div class="input-group mb-3">
										  <select class="custom-select"  name="idAlumno" required>
										    <%
										    	List<Usuario> alumnos1 = uDAO.listarXTipo(con, 2);
										    	for(Usuario alum:alumnos1) {
										    				%>
												    		<option value="<%=alum.getIdUsuario() %>"><%=alum.getNombre() %> <%=alum.getApellidos() %></option>
												    		<%
										    	}
										    	
										    %>
										  </select>
										</div>
											</div>
											<div class="form-group">
											<label style="color: black;">Profesor</label>
											<div class="input-group mb-3">
										  <select class="custom-select"  name="idProfesor" required>
										    <%
										    	List<Usuario> profesores1 = uDAO.listarXTipo(con, 1);
										    	for(Usuario prof:profesores1) {
										    				%>
												    		<option value="<%=prof.getIdUsuario() %>"><%=prof.getNombre() %> <%=prof.getApellidos() %></option>
												    		<%
										    	}
										    	
										    %>
										  </select>
										</div>
											</div>
											<div class="form-group">
											<label style="color: black;">Empresa</label>
											<div class="input-group mb-3">
										  <select class="custom-select"  name="idEmpresa" required>
										    <%
										    	List<Empresa> empresas1 = eDAO.listarTodo(con);
										    	for(Empresa emp:empresas1) {
										    				%>
												    		<option value="<%=emp.getIdEmpresa() %>"><%=emp.getNombre() %></option>
												    		<%
										    	}
										    	
										    %>
										  </select>
										</div>
											</div>	
								<button type="submit" class="btn btn-success">Enviar</button>
							
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
							</form>
						</div>
					</div>
				</div>
				</div>

<div class="container">
<div class="row">
<%
	int cont = 0;
	for (TutoresLaborales ts:t) {
		Usuario profesor = uDAO.listarXId(con, ts.getIdProfesor());
		Usuario alumno = uDAO.listarXId(con, ts.getIdAlumno());
		Empresa empresa = eDAO.listarXId(con, ts.getIdEmpresa());			
		%>
		<div class="col-sm-4" style="margin-top:1em;">
		<div class="card text-white bg-dark mb-3">
		  <div class="card-header"><b>Asignación</b></div>
		  <div class="card-body">
		    <p class="card-text"><b>Empresa</b>: <%=empresa.getNombre() %> </p>
		    <p class="card-text"><b>Alumno</b>: <%=alumno.getNombre() %> <%=alumno.getApellidos() %></p>
		    <p class="card-text"><b>Tutor</b>: <%=profesor.getNombre() %> <%=profesor.getApellidos() %></p>
		       <div class="btn-group" role="group" style="width:100%;">
			    <a class="btn btn-primary" data-toggle="modal" data-target="#modalActualizar<%=ts.getIdAlumno() %><%=ts.getIdEmpresa() %><%=ts.getIdProfesor() %>" style="width: 50%;"><i class="far fa-edit"></i> Editar</a>
			    <a class="btn btn-danger" data-toggle="modal" data-target="#modalBorrar<%=ts.getIdAlumno() %><%=ts.getIdEmpresa() %><%=ts.getIdProfesor() %>" style="width: 50%;"><i class="fas fa-trash"></i> Borrar</a>
			    </div>		   
		    		  <!-- Modal -->
		  <div class="modal fade" id="modalBorrar<%=ts.getIdAlumno() %><%=ts.getIdEmpresa() %><%=ts.getIdProfesor() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle" style="color: black;">¿Seguro que desea borrar esta asignación?</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../BorrarTutores" style="margin:0;" onsubmit="return validarAnadirSerie()">
													<input type="hidden" id="idAlumno" name="idAlumno" value="<%=ts.getIdAlumno() %>" class="form-control">
													<input type="hidden" id="idEmpresa" name="idEmpresa" value="<%=ts.getIdEmpresa() %>" class="form-control">
													<input type="hidden" id="idProfesor" name="idProfesor" value="<%=ts.getIdProfesor() %>" class="form-control">						
								<button type="submit" class="btn btn-success">Sí</button>
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
							</form>
						</div>
					</div>
				</div>
				</div>
				
				<div class="modal fade" id="modalActualizar<%=ts.getIdAlumno() %><%=ts.getIdEmpresa() %><%=ts.getIdProfesor() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle" style="color: black;">Editar asignación</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../ActualizarAsignaciones" style="margin:0;" onsubmit="return validarAnadirSerie()">
										<div class="form-group">
											<label style="color: black;">Alumno</label>
											<div class="input-group mb-3">
										  <select class="custom-select"  name="idAlumno" required>
										  <option value="<%=alumno.getIdUsuario() %>" selected><%=alumno.getNombre() %> <%=alumno.getApellidos() %></option>
										    <%
										    	List<Usuario> alumnos = uDAO.listarXTipo(con, 2);
										    	for(Usuario alum:alumnos) {
										    		if(alum.getIdUsuario() != alumno.getIdUsuario()){
										    				%>
												    		<option value="<%=alum.getIdUsuario() %>"><%=alum.getNombre() %> <%=alum.getApellidos() %></option>
												    		<%
										    		}
										    	}
										    	
										    %>
										  </select>
										</div>
											</div>
											<div class="form-group">
											<label style="color: black;">Profesor</label>
											<div class="input-group mb-3">
										  <select class="custom-select"  name="idProfesor" required>
										  <option value="<%=profesor.getIdUsuario() %>" selected><%=profesor.getNombre() %> <%=profesor.getApellidos() %></option>
										    <%
										    	List<Usuario> profesores = uDAO.listarXTipo(con, 1);
										    	for(Usuario prof:profesores) {
										    		if(prof.getIdUsuario() != profesor.getIdUsuario()){
										    				%>
												    		<option value="<%=prof.getIdUsuario() %>"><%=prof.getNombre() %> <%=prof.getApellidos() %></option>
												    		<%
										    		}
										    	}
										    	
										    %>
										  </select>
										</div>
											</div>
											<div class="form-group">
											<label style="color: black;">Empresa</label>
											<div class="input-group mb-3">
										  <select class="custom-select"  name="idEmpresa" required>
										  <option value="<%=empresa.getIdEmpresa() %>" selected><%=empresa.getNombre() %></option>
										    <%
										    	List<Empresa> empresas = eDAO.listarTodo(con);
										    	for(Empresa emp:empresas) {
										    		if(emp.getIdEmpresa() != empresa.getIdEmpresa()){
										    				%>
												    		<option value="<%=emp.getIdEmpresa() %>"><%=emp.getNombre() %></option>
												    		<%
										    		}
										    	}
										    	
										    %>
										  </select>
										</div>
											</div>
								<button type="submit" class="btn btn-success">Enviar</button>
							
								<button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
							</form>
						</div>
					</div>
				</div>
				</div>
		    
		  </div>
		</div>
		</div>
		<%

	}
%>
</div>
</div>

<%
			} else {
				response.sendRedirect("../index.jsp?mensaje=Solo accesible a tutores");
			}
			}
		%>

<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="../js/jquery-3.3.1.slim.min.js"></script>
	<script src="../js/popper.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>