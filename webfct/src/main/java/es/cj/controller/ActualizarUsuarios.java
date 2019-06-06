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
 * Servlet implementation class ActualizarUsuarios
 */
public class ActualizarUsuarios extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActualizarUsuarios() {
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
		String nombre = request.getParameter("nombre");
		String apellidos = request.getParameter("apellidos");
		String email = request.getParameter("email");
		String passwordNueva = request.getParameter("passwordNueva");
		int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
		int tipo = Integer.parseInt(request.getParameter("tipo"));
		
		String password = request.getParameter("password");
		String loginAdmin = request.getParameter("loginAdmin");
		int idAdmin = Integer.parseInt(request.getParameter("idAdmin"));
		
		
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
		Conexion con = new Conexion(usu, pass, driver, bd);
		
		Usuario usuario = new Usuario(idUsuario, login, nombre, apellidos, passwordNueva, email, tipo);
		UsuarioDAO uDAO = new UsuarioDAOImpl();
		
		Usuario usuarioComp = uDAO.comprobarUsuario(loginAdmin, password, con);
		if (usuarioComp != null) {
			int filas = uDAO.actualizarUsuario(con, usuario);
			if (filas == 1) {
				HttpSession session = request.getSession();
				
				session.removeAttribute("usuarioWeb");
				session.invalidate();
				
				HttpSession sesion = request.getSession();
				
				Usuario u = uDAO.listarXId(con, idAdmin);
				
				//Pongo al usuario en la sesion
				sesion.setAttribute("usuarioWeb", u);		
				response.sendRedirect("jsp/administracionUsuarios.jsp?mensaje=Actualizado correctamente");
			} else {
				response.sendRedirect("jsp/administracionUsuarios.jsp?mensaje=Error al actualizar");

			}
		} else {
			response.sendRedirect("jsp/administracionUsuarios.jsp?mensaje=Contraseña incorrecta");

		}
		
	}

}
