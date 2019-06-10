package es.cj.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.cj.bean.Conexion;
import es.cj.bean.Empresa;
import es.cj.bean.Fichas;
import es.cj.dao.EmpresaDAO;
import es.cj.dao.EmpresaDAOImpl;
import es.cj.dao.FichasDAO;
import es.cj.dao.FichasDAOImpl;

/**
 * Servlet implementation class AnadirEmpresa
 */
public class AnadirEmpresa extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnadirEmpresa() {
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
		String nombre = request.getParameter("nombre");
		String direccion = request.getParameter("direccion");
		int cp = Integer.parseInt(request.getParameter("cp"));

		Empresa empresa = new Empresa(nombre, direccion, cp);
		
		EmpresaDAO eDAO = new EmpresaDAOImpl();
		
		// Conexion con la base de datos
		ServletContext sc = getServletContext();
		String usu = sc.getInitParameter("usuario");
		String pass = sc.getInitParameter("password");
		String driver = sc.getInitParameter("driver");
		String bd = sc.getInitParameter("database");
		Conexion con = new Conexion(usu, pass, driver, bd);
		if (!eDAO.compEmpresa(con, empresa)) {
			int filas = eDAO.insertar(con, empresa);
			if (filas == 1) {
				// Correcto
				response.sendRedirect("jsp/administracionEmpresas.jsp?mensaje=Añadido correctamente");
			} else {
				// incorrecto
				response.sendRedirect("jsp/administracionEmpresas.jsp?mensaje=Error al añadir");
			}
		} else {
			response.sendRedirect("jsp/administracionEmpresas.jsp?mensaje=Empresa ya registrada");
		}
			
		
	}

}
