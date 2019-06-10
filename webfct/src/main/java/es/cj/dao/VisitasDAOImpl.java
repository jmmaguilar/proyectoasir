package es.cj.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Fichas;
import es.cj.bean.Usuario;
import es.cj.bean.Visitas;

public class VisitasDAOImpl implements VisitasDAO {

	public List<Visitas> listar(Conexion c, Usuario u) {
		List<Visitas> visitas = new ArrayList<Visitas>();
		
		String sql = "Select * from visitas where idProfesor = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, u.getIdUsuario());
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				Visitas auxiliar = new Visitas(resultado.getInt("idProfesor"), 
											   resultado.getInt("idEmpresa"), 
											   resultado.getInt("idAlumno"), 
											   resultado.getString("fecha"), 
											   resultado.getString("hora_ini"), 
											   resultado.getString("hora_fin"), 
											   resultado.getInt("aceptado"), 
											   resultado.getString("tipo"),
											   resultado.getInt("realizada"));
				visitas.add(auxiliar);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return visitas;
	}

	public int borrar(Conexion c, int idAlumno, int idProfesor, int idEmpresa, String fecha) {
		int filas = 0;
		
		String sql = "delete from visitas where fecha = ? and idAlumno = ? and idProfesor = ? and idEmpresa = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setString(1, fecha);
			sentencia.setInt(2, idAlumno);
			sentencia.setInt(3, idProfesor);
			sentencia.setInt(4, idEmpresa);
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}

	public int insertar(Conexion c, Visitas visita) {
		int filas = 0;
		
		String sql = "insert into visitas values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, visita.getIdProfesor());
			sentencia.setInt(2, visita.getIdEmpresa());
			sentencia.setInt(3, visita.getIdAlumno());
			sentencia.setString(4, visita.getFecha());
			sentencia.setString(5, visita.getHora_ini());
			sentencia.setString(6, visita.getHora_fin());
			sentencia.setInt(7, visita.getAceptado());
			sentencia.setString(8, visita.getTipo());
			sentencia.setInt(9, visita.getRealizada());
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return filas;
	}

	public boolean comVisitas(Conexion c, Visitas visita) {
		boolean existe = false;
		
		String sql = "select * from visitas where idProfesor = ? and idEmpresa = ? and idAlumno = ? and fecha = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, visita.getIdProfesor());
			sentencia.setInt(2, visita.getIdEmpresa());
			sentencia.setInt(3, visita.getIdAlumno());
			sentencia.setString(4, visita.getFecha());
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

	public List<Visitas> listarPendientes(Conexion c) {
		List<Visitas> visitas = new ArrayList<Visitas>();
		
		String sql = "Select * from visitas where aceptado = 0";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				Visitas auxiliar = new Visitas(resultado.getInt("idProfesor"), 
											   resultado.getInt("idEmpresa"), 
											   resultado.getInt("idAlumno"), 
											   resultado.getString("fecha"), 
											   resultado.getString("hora_ini"), 
											   resultado.getString("hora_fin"), 
											   resultado.getInt("aceptado"), 
											   resultado.getString("tipo"),
											   resultado.getInt("realizada"));
				visitas.add(auxiliar);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return visitas;
	}

	public int cambiarEstado(Conexion c, int estado, int idAlumno, int idEmpresa, int idProfesor, String fecha) {
		int filas = 0;
		
		String sql = "update visitas set aceptado = ? where idAlumno = ? and idEmpresa = ? and idProfesor = ? and fecha = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, estado);
			sentencia.setInt(2, idAlumno);
			sentencia.setInt(3, idEmpresa);
			sentencia.setInt(4, idProfesor);
			sentencia.setString(5, fecha);
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return filas;
	}	
	public int cambiarRealizada(Conexion c, int idAlumno, int idEmpresa, int idProfesor, String fecha) {
		int filas = 0;
		
		String sql = "update visitas set realizada = 1 where idAlumno = ? and idEmpresa = ? and idProfesor = ? and fecha = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idAlumno);
			sentencia.setInt(2, idEmpresa);
			sentencia.setInt(3, idProfesor);
			sentencia.setString(4, fecha);
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return filas;
	}	

}
