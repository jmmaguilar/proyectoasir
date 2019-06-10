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
					
			if (usuario.getTipo() != 1) {
				response.sendRedirect("../index.jsp?mensaje=Solo accesible a tutores");
			} else {
				Conexion con = new Conexion(usu, pass, driver, bd);
				
				UsuarioDAO uDAO = new UsuarioDAOImpl();
				
				EmpresaDAO eDAO = new EmpresaDAOImpl();
				
				TutoresLaboralesDAO tDAO = new TutoresLaboralesDAOImpl();
				
				VisitasDAO vDAO = new VisitasDAOImpl();
				List<Visitas> visitas = vDAO.listar(con, usuario);
				
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
        <a class="nav-link" href="principalTutor.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="asignaciones.jsp"><strong>Asignaciones</strong></a>
      </li>
       <li class="nav-item active">
        <a class="nav-link" href="#"><strong>Historial</strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="informacionTutor.jsp"><strong>Alumnos</strong></a>
      </li>
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

<div class="container">
<div class="row">
<%
	int cont = 0;
	for (Visitas v:visitas) {
		Usuario profesor = uDAO.listarXId(con, v.getIdProfesor());
		Usuario alumno = uDAO.listarXId(con, v.getIdAlumno());
		Empresa empresa = eDAO.listarXId(con, v.getIdEmpresa());
		if(v.getRealizada() == 1){
			
		%>
		<div class="col-sm-4" style="margin-top:1em;">
		<div class="card text-white bg-dark mb-3">
		  <div class="card-header"><b><%=profesor.getNombre() %> <%=profesor.getApellidos() %></b></div>
		  <div class="card-body">
		    <h5 class="card-title">Datos de la visita</h5>
		    <p class="card-text"><b>Empresa</b>: <%=empresa.getNombre() %></p>
		    <p class="card-text"><b>Alumno</b>: <%=alumno.getNombre() %> <%=alumno.getApellidos() %></p>
		    <p class="card-text"><b>Fecha</b>: <%=v.getFecha() %></p>
		    <p class="card-text"><b>Hora de Inicio</b>: <%=v.getHora_ini() %></p>
		    <p class="card-text"><b>Hora de Finalización</b>: <%=v.getHora_fin() %></p>
		    <p class="card-text"><b>Tipo</b>: <%=v.getTipo() %></p>

				    <a class="btn btn-danger" data-toggle="modal" data-target="#modalBorrar<%=v.getFecha() %><%=v.getIdAlumno() %><%=v.getIdEmpresa() %><%=v.getIdProfesor() %>" style="width: 100%;"><i class="fas fa-trash"></i> Borrar Visita</a>
		   
		    		  <!-- Modal -->
		  <div class="modal fade" id="modalBorrar<%=v.getFecha() %><%=v.getIdAlumno() %><%=v.getIdEmpresa() %><%=v.getIdProfesor() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle" style="color: black;">¿Seguro que desea borrar esta visita?</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<form role="form" method="POST" action="../BorrarVisita" style="margin:0;" onsubmit="return validarAnadirSerie()">
													<input type="hidden" id="fecha" name="fecha" value="<%=v.getFecha() %>" class="form-control">
													<input type="hidden" id="idAlumno" name="idAlumno" value="<%=v.getIdAlumno() %>" class="form-control">
													<input type="hidden" id="idEmpresa" name="idEmpresa" value="<%=v.getIdEmpresa() %>" class="form-control">
													<input type="hidden" id="idProfesor" name="idProfesor" value="<%=v.getIdProfesor() %>" class="form-control">						
								<button type="submit" class="btn btn-success">Sí</button>
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
		} else {
			
		}
	}
%>
</div>
</div>

<%
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