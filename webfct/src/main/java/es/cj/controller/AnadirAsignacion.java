package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.cj.bean.Conexion;
import es.cj.bean.TutoresLaborales;
import es.cj.dao.TutoresLaboralesDAO;
import es.cj.dao.TutoresLaboralesDAOImpl;

/**
 * Servlet implementation class AnadirAsignacion
 */
public class AnadirAsignacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnadirAsignacion() {
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
		int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
		int idProfesor = Integer.parseInt(request.getParameter("idProfesor"));
		int idAlumno = Integer.parseInt(request.getParameter("idAlumno"));

		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
		Conexion con = new Conexion(usu, pass, driver, bd);
		
		TutoresLaborales tutores = new TutoresLaborales(idProfesor, idAlumno, idEmpresa);
		TutoresLaboralesDAO tDAO = new TutoresLaboralesDAOImpl();
		if (!tDAO.compExiste(con, tutores)) {
			int filas = tDAO.insertar(con, tutores);
			if (filas == 1) {
				response.sendRedirect("jsp/asignaciones.jsp?mensaje=Añadido correctamente");
			} else {
				response.sendRedirect("jsp/asignaciones.jsp?mensaje=Error al añadir");

			}
		} else {
			response.sendRedirect("jsp/asignaciones.jsp?mensaje=Ya existe esa asignación");
		}
			

	}

}
