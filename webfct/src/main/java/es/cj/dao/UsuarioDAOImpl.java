package es.cj.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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




}
