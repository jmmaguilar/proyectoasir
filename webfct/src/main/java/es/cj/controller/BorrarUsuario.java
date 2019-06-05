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
import es.cj.dao.FichasDAO;
import es.cj.dao.FichasDAOImpl;
import es.cj.dao.UsuarioDAO;
import es.cj.dao.UsuarioDAOImpl;

/**
 * Servlet implementation class BorrarUsuario
 */
public class BorrarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BorrarUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
		String password = request.getParameter("password");
		String login = request.getParameter("login");
		// Voy a capturar los datos del web.xml
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
		
		// Crear un objeto de tipo Conexion con los datos anteriores
		Conexion con = new Conexion(usu, pass, driver, bd);

		UsuarioDAO uDAO = new UsuarioDAOImpl();
		
		Usuario usuarioComp = uDAO.comprobarUsuario(login, password, con);
		if (usuarioComp != null) {
			int filas = uDAO.borrar(con, idUsuario);
			if (filas == 1) {
				response.sendRedirect("jsp/administracionUsuarios.jsp?mensaje=Borrado correctamente");
			} else {
				response.sendRedirect("jsp/administracionUsuarios.jsp?mensaje=Error al borrar");

			}
		} else {
			response.sendRedirect("jsp/administracionUsuarios.jsp?mensaje=Contraseña incorrecta");

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
