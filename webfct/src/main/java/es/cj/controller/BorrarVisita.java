package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.cj.bean.Conexion;
import es.cj.dao.FichasDAO;
import es.cj.dao.FichasDAOImpl;
import es.cj.dao.VisitasDAO;
import es.cj.dao.VisitasDAOImpl;

/**
 * Servlet implementation class BorrarVisita
 */
public class BorrarVisita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BorrarVisita() {
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
		String fecha = request.getParameter("fecha");

		// Voy a capturar los datos del web.xml
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");

		// Crear un objeto de tipo Conexion con los datos anteriores
		Conexion con = new Conexion(usu, pass, driver, bd);

		VisitasDAO vDAO = new VisitasDAOImpl();
		
		int filas = vDAO.borrar(con, idAlumno, idProfesor, idEmpresa, fecha);
		if (filas == 1) {
			response.sendRedirect("jsp/principalTutor.jsp?mensaje=Borrado correctamente");
		} else {
			response.sendRedirect("jsp/principalTutor.jsp?mensaje=Error al borrar");

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
