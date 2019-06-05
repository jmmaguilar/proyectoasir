package es.cj.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Usuario;

public class UsuarioDAOImpl implements UsuarioDAO {
	
	private String passBD = "P4sS_4_d4t4B4s3-!";

	public Usuario comprobarUsuario(String login, String password, Conexion c) {
		Usuario u = null;
		
		String query = "Select * from usuarios where login = ? and password = AES_ENCRYPT(?, ?)";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(query);
			sentencia.setString(1, login);
			sentencia.setString(2, password);
			sentencia.setString(3, passBD);
			// Ejecutamos la consulta
			ResultSet resultado = sentencia.executeQuery();
			if (resultado.next()) {
				u = new Usuario(resultado.getInt("idUsuario"), 
						resultado.getString("login"), 
						resultado.getString("nombre"),
						resultado.getString("apellidos"), 
						resultado.getString("password"), 
						resultado.getString("email"),
						resultado.getInt("tipo"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return u;
	}

	public boolean existeLogin(String login, Conexion c) {
		boolean existe = false;

		String sql = "Select * from usuarios where login = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setString(1, login);
			ResultSet resultado = sentencia.executeQuery();
			if (resultado.next()) {
				existe = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return existe;
	}

	public boolean existeEmail(String email, Conexion c) {
		boolean existe = false;

		String sql = "Select * from usuarios where email = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setString(1, email);
			ResultSet resultado = sentencia.executeQuery();
			if (resultado.next()) {
				existe = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return existe;
	}

	public int insertar(Usuario usuario, Conexion con) {
		int filas = 0;

		String sql = "insert into usuarios values (null, ?, ?, ?, ?, AES_ENCRYPT(?, ?), ?)";
		try {
			PreparedStatement sentencia = con.getConector().prepareStatement(sql);
			sentencia.setString(1, usuario.getNombre());
			sentencia.setString(2, usuario.getApellidos());
			sentencia.setString(3, usuario.getEmail());
			sentencia.setInt(4, usuario.getTipo());
			sentencia.setString(5, usuario.getPassword());
			sentencia.setString(6, passBD);
			sentencia.setString(7, usuario.getLogin());
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return filas;
	}

	public Usuario listarXId(Conexion c, int idUsuario) {
		Usuario usuario = new Usuario();
		
		String sql = "select * from usuarios where idUsuario = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idUsuario);
			ResultSet resultado = sentencia.executeQuery();
			if (resultado.next()) {
				usuario = new Usuario(resultado.getInt("idUsuario"),
						  resultado.getString("login"), 
						  resultado.getString("nombre"), 
						  resultado.getString("apellidos"), 
						  resultado.getString("password"), 
						  resultado.getString("email"), 
						  resultado.getInt("tipo"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return usuario;
	}

	public List<Usuario> listarXTipo(Conexion c, int tipo) {
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		String sql = "select * from usuarios where tipo = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, tipo);
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				Usuario auxiliar = new Usuario(resultado.getInt("idUsuario"),
						resultado.getString("login"), 
						  resultado.getString("nombre"), 
						  resultado.getString("apellidos"), 
						  resultado.getString("password"), 
						  resultado.getString("email"), 
						  resultado.getInt("tipo"));
				usuarios.add(auxiliar);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return usuarios;	}

	public int actualizarUsuario(Conexion c, Usuario usu) {
		int filas = 0;
		
		if (usu.getPassword() == null || usu.getPassword() == "") {
			String sql = "update usuarios set nombre = ?, apellidos = ?, email = ?, login = ?, tipo = ? where idUsuario = ?";
			try {
				PreparedStatement sentencia = c.getConector().prepareStatement(sql);
				sentencia.setString(1, usu.getNombre());
				sentencia.setString(2, usu.getApellidos());
				sentencia.setString(3, usu.getEmail());
				sentencia.setString(4, usu.getLogin());
				sentencia.setInt(5, usu.getTipo());
				sentencia.setInt(6, usu.getIdUsuario());
				filas = sentencia.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			String sql = "update usuarios set nombre = ?, apellidos = ?, email = ?, login = ?, password = AES_ENCRYPT(?, ?), tipo = ? where idUsuario = ?";
			try {
				PreparedStatement sentencia = c.getConector().prepareStatement(sql);
				sentencia.setString(1, usu.getNombre());
				sentencia.setString(2, usu.getApellidos());
				sentencia.setString(3, usu.getEmail());
				sentencia.setString(4, usu.getLogin());
				sentencia.setString(5, usu.getPassword());
				sentencia.setString(6, passBD);
				sentencia.setInt(7, usu.getTipo());
				sentencia.setInt(8, usu.getIdUsuario());
				filas = sentencia.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return filas;
	}

	public List<Usuario> listarTodo(Conexion c) {
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		String sql = "select * from usuarios";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				Usuario auxiliar = new Usuario(resultado.getInt("idUsuario"),
						resultado.getString("login"), 
						  resultado.getString("nombre"), 
						  resultado.getString("apellidos"), 
						  resultado.getString("password"), 
						  resultado.getString("email"), 
						  resultado.getInt("tipo"));
				usuarios.add(auxiliar);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return usuarios;
	}

	public int borrar(Conexion c, int idUsuario) {
		int filas = 0;
		
		String sql = "delete from usuarios where idUsuario = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idUsuario);
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}




}
