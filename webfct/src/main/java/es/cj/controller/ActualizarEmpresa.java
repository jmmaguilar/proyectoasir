package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import es.cj.bean.Conexion;
import es.cj.bean.Empresa;
import es.cj.bean.Usuario;
import es.cj.dao.EmpresaDAO;
import es.cj.dao.EmpresaDAOImpl;
import es.cj.dao.UsuarioDAO;
import es.cj.dao.UsuarioDAOImpl;

/**
 * Servlet implementation class ActualizarEmpresa
 */
public class ActualizarEmpresa extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActualizarEmpresa() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nombre = request.getParameter("nombre");
		String direccion = request.getParameter("direccion");
		
		int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
		int cp = Integer.parseInt(request.getParameter("cp"));
		
		String login = request.getParameter("login");
		String password = request.getParameter("password");

		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
		Conexion con = new Conexion(usu, pass, driver, bd);
		
		Empresa empresa = new Empresa(idEmpresa, nombre, direccion, cp);
		
		EmpresaDAO eDAO = new EmpresaDAOImpl();
		UsuarioDAO uDAO = new UsuarioDAOImpl();
		
		Usuario usuarioComp = uDAO.comprobarUsuario(login, password, con);
		if (usuarioComp != null) {
			int filas = eDAO.actualizarEmpresa(con, empresa);
			if (filas == 1) {				
				response.sendRedirect("jsp/administracionEmpresas.jsp?mensaje=Actualizado correctamente");
			} else {
				response.sendRedirect("jsp/administracionEmpresas.jsp?mensaje=Error al actualizar");

			}
		} else {
			response.sendRedirect("jsp/administracionEmpresas.jsp?mensaje=Contraseña incorrecta");
		}
		
	}

}
