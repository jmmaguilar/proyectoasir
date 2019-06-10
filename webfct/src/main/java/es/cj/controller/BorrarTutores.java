package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.cj.bean.Conexion;
import es.cj.bean.TutoresLaborales;
import es.cj.dao.FichasDAO;
import es.cj.dao.FichasDAOImpl;
import es.cj.dao.TutoresLaboralesDAO;
import es.cj.dao.TutoresLaboralesDAOImpl;

/**
 * Servlet implementation class BorrarTutores
 */
public class BorrarTutores extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BorrarTutores() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
		int idProfesor = Integer.parseInt(request.getParameter("idProfesor"));
		int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));

		// Voy a capturar los datos del web.xml
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");

		// Crear un objeto de tipo Conexion con los datos anteriores
		Conexion con = new Conexion(usu, pass, driver, bd);

		TutoresLaboralesDAO tDAO = new TutoresLaboralesDAOImpl();
		TutoresLaborales t = new TutoresLaborales(idProfesor, idAlumno, idEmpresa);
		int filas = tDAO.borrar(con, t);
		if (filas == 1) {
			response.sendRedirect("jsp/asignaciones.jsp?mensaje=Borrado correctamente");
		} else {
			response.sendRedirect("jsp/asignaciones.jsp?mensaje=Error al borrar");

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
