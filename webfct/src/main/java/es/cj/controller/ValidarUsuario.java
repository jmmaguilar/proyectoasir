package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import es.cj.bean.Conexion;
import es.cj.bean.Usuario;
import es.cj.dao.UsuarioDAO;
import es.cj.dao.UsuarioDAOImpl;

/**
 * Servlet implementation class ValidarUsuario
 */
public class ValidarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidarUsuario() {
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
		String usuario = request.getParameter("usuario");
		String password = request.getParameter("password");
		
		// Datos web xml
		
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
		
		// Crear un obketo de tipo Conexion con los datos anteriores
		Conexion con = new Conexion(usu, pass, driver, bd);
				
		// LLamar al método comprobarUsuario que devuelve el usuario o null
		UsuarioDAO uDAO = new UsuarioDAOImpl();
		Usuario u = uDAO.comprobarUsuario(usuario, password, con);
		
		if (u != null) {
			// Creo la sesion
						HttpSession sesion = request.getSession();
						
						//Pongo al usuario en la sesion
						sesion.setAttribute("usuarioWeb", u);
						if (u.getTipo() == 0) {
							response.sendRedirect("jsp/principalDirectivo.jsp");

						} else if (u.getTipo() == 1) {
							response.sendRedirect("jsp/principalTutor.jsp");

						} else if (u.getTipo() == 2) {
							response.sendRedirect("jsp/principalAlumno.jsp");

						} else {
							response.sendRedirect("index.jsp");	
						}							
		} else {
			response.sendRedirect("index.jsp?mensaje=Usuario y/o Password Incorrecto");
		}
	}

}
