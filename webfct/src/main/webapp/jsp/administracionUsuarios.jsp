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
				
				UsuarioDAO uDAO = new UsuarioDAOImpl();
				List<Usuario> usuarios = uDAO.listarTodo(con);
			
			

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
      	  <%
      } else if (usuario.getTipo() == 1) {
    	  %>
    	  <li class="nav-item">
        <a class="nav-link" href="principalTutor.jsp"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
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
      
      <li class="nav-item active">
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
    <th>Usuario</th>
    <th>Nombre y Apellidos</th>
    <th>Tipo</th>
    <th>Editar / Borrar</th>
  </tr>
  <%
  	for (Usuario u:usuarios) {
  	%>
  	  <tr>
  		<td><%=u.getLogin() %></td>
  		<td><%=u.getNombre() %> <%=u.getApellidos() %></td>
  		<td>
  		<%
  			if (u.getTipo() == 0) {
  				%>
  					Directivo
  				<%
  				
  			} else if (u.getTipo() == 1) {
  				%>
					Profesor
				<%
  			} else {
  				%>
					Alumno
				<%
  			}
  		%>
  		</td>
  		<td>
  			<button type="button" data-toggle="modal" data-target="#modalEditar" class="btn btn-primary" style="margin:0.25em 0em 0.25em 0em;"> <i class="far fa-edit"> </i></button>
  			<button type="button" data-toggle="modal" data-target="#modalBorrar" class="btn btn-danger" style="margin:0.25em 0em 0.25em 0em;"> <i class="fas fa-trash"> </i></button>
  		</td>
  	  </tr>
  	<%
  	}
  %>
  
		  

</table>
<button type="button" class="btn btn-success" style="margin-top: 1em; width: 100%;"></button>
<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAnadir" style="margin-top: 1em; width: 100%;"><b>Añadir nuevo día</b></button>

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