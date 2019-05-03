package es.cj.dao;

import es.cj.bean.Conexion;
import es.cj.bean.Usuario;

public interface UsuarioDAO {
	
	public Usuario comprobarUsuario(String login, String password, Conexion c);
	public boolean existeLogin(String login, Conexion c);
	public boolean existeEmail(String email, Conexion c);
	public int insertar(Usuario usuario, Conexion con);
}
