package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.cj.bean.Conexion;
import es.cj.bean.Fichas;
import es.cj.bean.TutoresLaborales;
import es.cj.bean.Usuario;
import es.cj.bean.Visitas;
import es.cj.dao.FichasDAO;
import es.cj.dao.FichasDAOImpl;
import es.cj.dao.TutoresLaboralesDAO;
import es.cj.dao.TutoresLaboralesDAOImpl;
import es.cj.dao.UsuarioDAO;
import es.cj.dao.UsuarioDAOImpl;
import es.cj.dao.VisitasDAO;
import es.cj.dao.VisitasDAOImpl;

/**
 * Servlet implementation class AnadirVisita
 */
public class AnadirVisita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnadirVisita() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idProfesor = Integer.parseInt(request.getParameter("idProfesor"));
		int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
		int idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
		String fecha = request.getParameter("fecha");
		String horaini = request.getParameter("horaini");
		String horafin = request.getParameter("horafin");
		String tipo = request.getParameter("tipo");
		int aceptado = 0;

		TutoresLaboralesDAO tDAO = new TutoresLaboralesDAOImpl();
		
		UsuarioDAO uDAO = new UsuarioDAOImpl();
		
		VisitasDAO vDAO = new VisitasDAOImpl();
				
		// Conexion con la base de datos
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
		Conexion con = new Conexion(usu, pass, driver, bd);
		
		Visitas visita = new Visitas(idProfesor, idEmpresa, idAlumno, fecha, horaini, horafin, aceptado, tipo);
		
		TutoresLaborales alumXTutXEmp = tDAO.listarXAlumno(con, idAlumno);
		if (alumXTutXEmp.getIdEmpresa() == idEmpresa && alumXTutXEmp.getIdProfesor() == idProfesor) {
			Usuario alumno = uDAO.listarXId(con, idAlumno);
			if (alumno.getTipo() == 2) {
				if (!vDAO.comVisitas(con, visita)) {
					int filas = vDAO.insertar(con, visita);
					if (filas == 1) {
						response.sendRedirect("jsp/principalTutor.jsp?mensaje=Visita registrada correctamente");
					} else {
						response.sendRedirect("jsp/principalTutor.jsp?mensaje=Error al registar la visita");
					}
				} else {
					response.sendRedirect("jsp/principalTutor.jsp?mensaje=Visita ya registrada");
				}
			} else {
				response.sendRedirect("jsp/principalTutor.jsp?mensaje=Debe seleccionar un alumno válido");
			}
		} else {
			response.sendRedirect("jsp/principalTutor.jsp?mensaje=El alumno no está asignado a la empresa seleccionada");
		}
		
		
		
		
	}

}
