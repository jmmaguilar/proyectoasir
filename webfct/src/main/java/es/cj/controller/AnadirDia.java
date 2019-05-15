package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.cj.bean.Conexion;
import es.cj.bean.Fichas;
import es.cj.bean.Usuario;
import es.cj.dao.FichasDAO;
import es.cj.dao.FichasDAOImpl;
import es.cj.dao.UsuarioDAO;
import es.cj.dao.UsuarioDAOImpl;

/**
 * Servlet implementation class AnadirDia
 */
public class AnadirDia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnadirDia() {
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
		String fecha = request.getParameter("fecha");
		String desc = request.getParameter("descripcion");
		String horas = request.getParameter("horas");
		String obs = request.getParameter("observaciones");
		int idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
		Fichas fichas = new Fichas();

		if (obs == null) {
			fichas = new Fichas(idAlumno, fecha, horas, desc, null);
		} else {
			fichas = new Fichas(idAlumno, fecha, horas, desc, obs);
		}
		
		FichasDAO fDAO = new FichasDAOImpl();
		
		// Conexion con la base de datos
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
		Conexion con = new Conexion(usu, pass, driver, bd);
		if (!fDAO.compFicha(con, fichas)) {
			int filas = fDAO.insertar(con, fichas);
			if (filas == 1) {
				// Correcto
				response.sendRedirect("jsp/principalAlumno.jsp?mensaje=Añadido correctamente");
			} else {
				// incorrecto
				response.sendRedirect("jsp/principalAlumno.jsp?mensaje=Error al añadir");
			}
		} else {
			response.sendRedirect("jsp/principalAlumno.jsp?mensaje=Día ya registrado");
		}
			
		
	}

}
