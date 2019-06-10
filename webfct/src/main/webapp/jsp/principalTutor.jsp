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
      <li class="nav-item active">
        <a class="nav-link" href="#"><strong>Inicio <span class="sr-only">(current)</span></strong></a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="historial.jsp"><strong>Historial</strong></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="informacionTutor.jsp"><strong>Alumnos</strong></a>
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

								<form role="form" method="POST" action="../AnadirVisita" style="margin:0;" onsubmit="return validarAnadirSerie()">
									<div class="form-group">
										<label>Empresa</label>
										<div class="input-group mb-3">
										  <select class="custom-select" name="idEmpresa" required>
										  <option selected>Empresas...</option>
										    <%
										    	List<Empresa> empresasL = eDAO.listarTodo(con);
										    	for(Empresa emp:empresasL) {
										    		List<TutoresLaborales> tutores = tDAO.listarXTutor(con, usuario.getIdUsuario());
										    		for(TutoresLaborales tut:tutores) {
										    			if(emp.getIdEmpresa() == tut.getIdEmpresa()){
										    				%>
												    		<option value="<%=emp.getIdEmpresa() %>"><%=emp.getNombre() %></option>
												    		<%
											    		}
										    		
										    	}
										    	}
										    %>
										  </select>
										</div>
										</div>
										<span id="spempresa" style="color: red"></span>
										<div class="form-group">
											<label >Alumno</label>
											<div class="input-group mb-3">
										  <select class="custom-select"  name="idAlumno" required>
										  <option selected>Alumnos...</option>
										    <%
										    	List<Usuario> alumnos = uDAO.listarXTipo(con, 2);
										    	for(Usuario alum:alumnos) {
										    		TutoresLaborales tutalumnos = tDAO.listarXAlumno(con, alum.getIdUsuario());
										    			if(usuario.getIdUsuario() == tutalumnos.getIdProfesor()){
										    				%>
												    		<option value="<%=alum.getIdUsuario() %>"><%=alum.getNombre() %> <%=alum.getApellidos() %></option>
												    		<%
											    		}
										    	}
										    	
										    %>
										  </select>
										</div>
											</div>
											<span id="spalumno" style="color: red"></span>
											<div class="form-group">
												<label>Fecha</label>
												<div class="input-group mb-2 mr-sm-2">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<i class="far fa-calendar-alt"></i>
														</div>
													</div>
													<input type="text" class="form-control" id="fecha" name="fecha" placeholder="YYYY-MM-DD" required 
													pattern="(?:19|20)[0-9]{2}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))" 
													title="Enter a date in this format YYYY-MM-DD"/>
												</div>
												</div>
												<div>
													<span id="spfecha" style="color: red"></span>
												</div>
												<div class="form-group">
												<label>Hora de Inicio</label>
												<div class="input-group mb-2 mr-sm-2">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<i class="far fa-hourglass"></i>
														</div>
													</div>
													<input type="time" class="form-control" id="horaini" name="horaini" required="required">
												</div>
												</div>
												<div>
													<span id="sphoraini" style="color: red"></span>
												</div>	
												<div class="form-group">
												<label>Hora de Finalización</label>
												<div class="input-group mb-2 mr-sm-2">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<i class="far fa-hourglass"></i>
														</div>
													</div>
													<input type="time" class="form-control" id="horafin" name="horafin" required="required">
												</div>
												</div>
												<div>
													<span id="sphorafin" style="color: red"></span>
												</div>
												<div class="form-group">
												<label>Tipo</label>
												<div class="input-group mb-2 mr-sm-2">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<i class="fas fa-align-left"></i>
														</div>
													</div>
													<select class="custom-select"  name="tipo" required>
										  				<option value="Seguimiento" selected>Seguimiento</option>
										  				<option value="Entrega de documentación">Entrega de documentación</option>
										  			</select>
												</div>
												</div>
												<div>
													<span id="sptipo" style="color: red"></span>
												</div>
													<input type="hidden" id="idProfesor" name="idProfesor" value="<%=usuario.getIdUsuario() %>" class="form-control">
																
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
	for (Visitas v:visitas) {
		Usuario profesor = uDAO.listarXId(con, v.getIdProfesor());
		Usuario alumno = uDAO.listarXId(con, v.getIdAlumno());
		Empresa empresa = eDAO.listarXId(con, v.getIdEmpresa());
		if(v.getRealizada() == 0){
			
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
		    		<p class="card-text" style="color: green"><i class="fas fa-check"></i> <b>Aceptado</b>
		    		
		    		</p>
		    		<%
				}
		    boolean comp = false;
		    /* Date f = new Date();
		    int AnyoHoy = f.getYear();
		    int MesHoy = f.getMonth();
		    int DiaHoy = f.getDay(); */
		    
		    Calendar fecha = new GregorianCalendar();
		    int AnyoHoy = fecha.get(Calendar.YEAR);
		    int MesHoy = fecha.get(Calendar.MONTH);
		    int DiaHoy = fecha.get(Calendar.DAY_OF_MONTH);
		    
		    int AnyoFecha = Integer.parseInt(v.getFecha().substring(0, 4));
		    int MesFecha = Integer.parseInt(v.getFecha().substring(5, 7));
		    int DiaFecha = Integer.parseInt(v.getFecha().substring(8, 10));
		    		
		    if (AnyoFecha < AnyoHoy){
		        
		    }
		    else{
		        if (AnyoFecha == AnyoHoy && MesFecha < MesHoy){
		            comp = true;			
		        }
		        else{
		            if (AnyoFecha == AnyoHoy && MesFecha == MesHoy && DiaFecha < DiaHoy){
		                comp = true;
		            }
		            else{
		                if (AnyoFecha == AnyoHoy && MesFecha == MesHoy && DiaFecha == DiaHoy){
		                     
		                }
		                else{
		                    
		                }
		            }
		        }
		    }
		    
		    if(v.getAceptado() == 2 && comp){
		    	%>
			    
			    
			    <div class="btn-group" role="group" style="width:100%;">
			    <a class="btn btn-success" onclick="location.href='../CambiarRealizada?idAlumno=<%=v.getIdAlumno()%>&idEmpresa=<%=v.getIdEmpresa()%>&fecha=<%=v.getFecha()%>&idProfesor=<%=v.getIdProfesor()%>'" style="width: 50%;"><i class="fas fa-check"></i> Realizada</a>
			    <a class="btn btn-danger" data-toggle="modal" data-target="#modalBorrar<%=v.getFecha() %><%=v.getIdAlumno() %><%=v.getIdEmpresa() %><%=v.getIdProfesor() %>" style="width: 50%;"><i class="fas fa-trash"></i> Borrar Visita</a>
			    </div>
			    <%	
		    } else {
		    	 %> 
				    <a class="btn btn-danger" data-toggle="modal" data-target="#modalBorrar<%=v.getFecha() %><%=v.getIdAlumno() %><%=v.getIdEmpresa() %><%=v.getIdProfesor() %>" style="width: 100%;"><i class="fas fa-trash"></i> Borrar Visita</a>
				 <%
		    }
		    %>
		   
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