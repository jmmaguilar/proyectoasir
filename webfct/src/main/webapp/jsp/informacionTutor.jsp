<%@page import="es.cj.dao.EmpresaDAOImpl"%>
<%@page import="es.cj.dao.EmpresaDAO"%>
<%@page import="es.cj.bean.Empresa"%>
<%@page import="es.cj.dao.UsuarioDAO"%>
<%@page import="es.cj.dao.UsuarioDAOImpl"%>
<%@page import="es.cj.bean.TutoresLaborales"%>
<%@page import="org.w3c.dom.ls.LSInput"%>
<%@page import="es.cj.dao.TutoresLaboralesDAOImpl"%>
<%@page import="es.cj.dao.TutoresLaboralesDAO"%>
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

<title>Información</title>
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
				response.sendRedirect("../index.jsp?mensaje=Solo accesible al profesorado");
			} else {
			Conexion con = new Conexion(usu, pass, driver, bd);
			
			TutoresLaboralesDAO tDAO = new TutoresLaboralesDAOImpl();
			
			UsuarioDAO uDAO = new UsuarioDAOImpl();
			EmpresaDAO eDAO = new EmpresaDAOImpl();
	
			
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
      <li class="nav-item active">
        <a class="nav-link" href="#"><strong>Alumnos</strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="perfil.jsp"><strong>Perfil</strong></a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><strong>Link2</strong></a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
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
<%
	List<TutoresLaborales> tutores = tDAO.listarXTutor(con, usuario.getIdUsuario());
%>
<div class="row">
<%
	for(TutoresLaborales t:tutores){
		Usuario alumno = uDAO.listarXId(con, t.getIdAlumno());
		Empresa empresa = eDAO.listarXId(con, t.getIdEmpresa());
%>
  <div class="col-sm-6">
<div class="card" style="margin-top:1em;">
  <div class="card-body">
    <h5 class="card-title"><b>Alumno</b></h5>
  	<ul class="list-group list-group-flush">
    	<li class="list-group-item"><%=alumno.getNombre() %> <%=alumno.getApellidos() %></li>
    	<li class="list-group-item"><%=alumno.getEmail() %></li>
  	</ul>
  	<h5 class="card-title" style="margin-top: 0.5em;"><b>Empresa</b></h5>
  	<ul class="list-group list-group-flush">
    	<li class="list-group-item"><%=empresa.getNombre() %></li>
    	<li class="list-group-item"><%=empresa.getDireccion()%></li>
  	</ul>
  </div>
</div>
</div>
<%
	}
%>

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