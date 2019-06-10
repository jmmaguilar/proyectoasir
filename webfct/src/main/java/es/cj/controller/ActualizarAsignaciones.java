package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import es.cj.bean.Conexion;
import es.cj.bean.TutoresLaborales;
import es.cj.bean.Usuario;
import es.cj.dao.TutoresLaboralesDAO;
import es.cj.dao.TutoresLaboralesDAOImpl;
import es.cj.dao.UsuarioDAO;
import es.cj.dao.UsuarioDAOImpl;

/**
 * Servlet implementation class ActualizarAsignaciones
 */
public class ActualizarAsignaciones extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActualizarAsignaciones() {
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

			int filas = tDAO.actualizar(con, tutores);
			if (filas == 1) {
				response.sendRedirect("jsp/asignaciones.jsp?mensaje=Actualizado correctamente");
			} else {
				response.sendRedirect("jsp/asignaciones.jsp?mensaje=Error al actualizar");

			}

	}

}
