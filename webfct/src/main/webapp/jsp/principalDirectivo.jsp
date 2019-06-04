<%@page import="es.cj.bean.Empresa"%>
<%@page import="es.cj.dao.EmpresaDAOImpl"%>
<%@page import="es.cj.dao.UsuarioDAOImpl"%>
<%@page import="es.cj.dao.EmpresaDAO"%>
<%@page import="es.cj.dao.UsuarioDAO"%>
<%@page import="es.cj.bean.Conexion"%>
<%@page import="java.util.List"%>
<%@page import="es.cj.dao.VisitasDAOImpl"%>
<%@page import="es.cj.dao.VisitasDAO"%>
<%@page import="es.cj.bean.Visitas"%>
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
.container {
  position: absolute;
  left: 10%;
  width: 80%;
  margin-top: 1.5em;
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
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
				
			if (usuario.getTipo() != 0) {
				response.sendRedirect("../index.jsp?mensaje=Solo accesible a dirección");
			} else {
				Conexion con = new Conexion(usu, pass, driver, bd);
				
				UsuarioDAO uDAO = new UsuarioDAOImpl();
				
				EmpresaDAO eDAO = new EmpresaDAOImpl();
				
				VisitasDAO vDAO = new VisitasDAOImpl();
				List<Visitas> visitas = vDAO.listarPendientes(con);
				
			
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
        <a class="nav-link" href="#"><strong>Inicio<span class="sr-only">(current)</span></strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="administracionUsuarios.jsp"><strong>Administración de Usuarios</strong></a>
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

<div class="container">
<div class="row" style="margin: 0 auto;">
<%
	int cont = 0;
	for (Visitas v:visitas) {
		Usuario profesor = uDAO.listarXId(con, v.getIdProfesor());
		Usuario alumno = uDAO.listarXId(con, v.getIdAlumno());
		Empresa empresa = eDAO.listarXId(con, v.getIdEmpresa());
		%>
		<div class="card text-white bg-dark mb-3" style="width: 32.6%;">
		  <div class="card-header"><b><%=profesor.getNombre() %> <%=profesor.getApellidos() %></b></div>
		  <div class="card-body">
		    <h5 class="card-title">Datos de la visita</h5>
		    <p class="card-text"><b>Empresa</b>: <%=empresa.getNombre() %></p>
		    <p class="card-text"><b>Alumno</b>: <%=alumno.getNombre() %> <%=alumno.getApellidos() %></p>
		    <p class="card-text"><b>Fecha</b>: <%=v.getFecha() %></p>
		    <p class="card-text"><b>Hora de Inicio</b>: <%=v.getHora_ini() %></p>
		    <p class="card-text"><b>Hora de Finalización</b>: <%=v.getHora_fin() %></p>
		    <p class="card-text"><b>Tipo</b>: <%=v.getTipo() %></p>
		    <%
		    	if(v.getAceptado() == 0){
		    		%>
		    		<p class="card-text" style="color: #1E90FF"><i class="fas fa-ellipsis-h"></i> <b>Pendiente</b></p>
		    		<%
		    	} else if (v.getAceptado() == 1) {
		    		%>
		    		<p class="card-text" style="color: red"><i class="fas fa-ban"></i> <b>Denegado</b></p>
		    		<%
				} else {
					%>
		    		<p class="card-text" style="color: green"><i class="fas fa-check"></i> <b>Aceptado</b></p>
		    		<%
				}
		    %>
			<div class="" style="width:100%;" role="group">		    
		    <button type="button" style="width:49%;" class="btn btn-success" onclick="location.href='../AceptDenyVisita?aceptado=2&idAlumno=<%=v.getIdAlumno() %>&idEmpresa=<%=v.getIdEmpresa() %>&idProfesor=<%=v.getIdProfesor() %>&fecha=<%=v.getFecha() %>'"><i class="fas fa-check"></i> Aceptar</button>
		    <button type="button" style="width:49%;" class="btn btn-danger" onclick="location.href='../AceptDenyVisita?aceptado=1&idAlumno=<%=v.getIdAlumno() %>&idEmpresa=<%=v.getIdEmpresa() %>&idProfesor=<%=v.getIdProfesor() %>&fecha=<%=v.getFecha() %>'"><i class="fas fa-ban"></i> Denegar</button>
		    
		    </div>
	    
		    		  </div>
		    		  </div>
		<%
			if (cont == 2){
				cont = 0;
			} else  {
				%>
				<div style="width: 1.1%"></div>
				<%
			}
		%>
	
		<%
		cont = cont + 1;
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