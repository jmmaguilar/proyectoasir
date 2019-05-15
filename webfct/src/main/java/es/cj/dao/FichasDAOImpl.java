package es.cj.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import es.cj.bean.Conexion;
import es.cj.bean.Fichas;
import es.cj.bean.Usuario;

public class FichasDAOImpl implements FichasDAO {

	public List<Fichas> listar(Conexion c, Usuario u) {
		List<Fichas> fichas = new ArrayList<Fichas>();
		
		String sql = "Select * from fichas where idAlumno = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, u.getIdUsuario());
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				Fichas auxiliar = new Fichas(resultado.getInt("idAlumno"), 
											 resultado.getString("fecha"), 
											 resultado.getString("horas"), 
											 resultado.getString("descripcion"), 
											 resultado.getString("observaciones"));
				fichas.add(auxiliar);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fichas;
	}
	
	public int insertar(Conexion c, Fichas fichas) {
		int filas = 0;
		
		if (fichas.getObservaciones() == null) {
			String sql = "insert into fichas values (?, ?, ?, ?, null)";
			try {
				PreparedStatement sentencias = c.getConector().prepareStatement(sql);
				sentencias.setString(1, fichas.getFecha());
				sentencias.setString(2, fichas.getHoras());
				sentencias.setString(3, fichas.getDescripcion());
				sentencias.setInt(4, fichas.getIdAlumno());
				
				filas = sentencias.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			String sql = "insert into fichas values (?, ?, ?, ?, ?)";
			try {
				PreparedStatement sentencias = c.getConector().prepareStatement(sql);
				sentencias.setString(1, fichas.getFecha());
				sentencias.setString(2, fichas.getHoras());
				sentencias.setString(3, fichas.getDescripcion());
				sentencias.setInt(4, fichas.getIdAlumno());
				sentencias.setString(5, fichas.getObservaciones());
				
				filas = sentencias.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return filas;
	}

	public boolean compFicha(Conexion c, Fichas fichas) {
		boolean existe = false;
		String sql = "Select * from fichas where idAlumno = ? and fecha = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, fichas.getIdAlumno());
			sentencia.setString(2, fichas.getFecha());
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				existe = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return existe;
	}

	public int actualizar(Conexion c, Fichas fichas) {
		int filas = 0;
		String sql = "update fichas set descripcion = ?, horas = ?, observaciones = ? where fecha = ? and idAlumno = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setString(1, fichas.getDescripcion());
			sentencia.setString(2, fichas.getHoras());
			sentencia.setString(3, fichas.getObservaciones());
			sentencia.setString(4, fichas.getFecha());
			sentencia.setInt(5, fichas.getIdAlumno());
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return filas;
	}

	public int borrar(Conexion c, int idAlumno, String fecha) {
		int filas = 0;
		String sql = "delete from fichas where idAlumno = ? and fecha = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idAlumno);
			sentencia.setString(2, fecha);
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}

}
