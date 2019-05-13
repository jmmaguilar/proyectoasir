package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.cj.bean.Conexion;
import es.cj.bean.Usuario;
import es.cj.dao.UsuarioDAO;
import es.cj.dao.UsuarioDAOImpl;

/**
 * Servlet implementation class RegistrarUsuario
 */
public class RegistrarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrarUsuario() {
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
		String login = request.getParameter("login");
		String password = request.getParameter("password");
		String nombre = request.getParameter("nombre");
		String email = request.getParameter("email");
		String apellidos = request.getParameter("apellidos");
		
		// Datos web xml
		
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
				
		// Crear un objeto de tipo Conexion con los datos anteriores
		Conexion con = new Conexion(usu, pass, driver, bd);
		
		Usuario usuario = new Usuario(login, password, nombre, apellidos, email, 2);
		
		UsuarioDAO uDAO = new UsuarioDAOImpl();
		
		if (!uDAO.existeLogin(login, con)) {
			if (!uDAO.existeEmail(email, con)) {
				int filas = uDAO.insertar(usuario, con);
				if (filas == 1) {
					// Correcto
					response.sendRedirect("registro.jsp?mensaje=Usuario registrado correctamente");
				} else {
					// incorrecto
					response.sendRedirect("registro.jsp?mensaje=Error al registrar al usuario");
				}
			} else {
				response.sendRedirect("registro.jsp?mensaje=Email ya registrado");
			}
			
		} else {
			response.sendRedirect("registro.jsp?mensaje=Login ya registrado");
		}
	}

}
