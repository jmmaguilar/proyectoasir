package es.cj.dao;

import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Usuario;

public interface UsuarioDAO {
	
	public Usuario comprobarUsuario(String login, String password, Conexion c);
	public boolean existeLogin(String login, Conexion c);
	public boolean existeEmail(String email, Conexion c);
	public int insertar(Usuario usuario, Conexion con);
	public Usuario listarXId(Conexion c, int idUsuario);
	public List<Usuario> listarXTipo(Conexion c, int tipo);
}
