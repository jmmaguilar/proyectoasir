package es.cj.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.TutoresLaborales;
import es.cj.bean.Usuario;

public class TutoresLaboralesDAOImpl implements TutoresLaboralesDAO {

	public List<TutoresLaborales> listarTodo(Conexion c) {
		List<TutoresLaborales> lista = new ArrayList<TutoresLaborales>();
		
		String sql = "select * from tutores_laborales";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				TutoresLaborales auxiliar = new TutoresLaborales(resultado.getInt("idProfesor"), 
																 resultado.getInt("idAlumno"), 
																 resultado.getInt("idEmpresa"));
				lista.add(auxiliar);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lista;
	}

	public List<TutoresLaborales> listarXEmpresa(Conexion c, int idEmpresa) {
		List<TutoresLaborales> lista = new ArrayList<TutoresLaborales>();
		
		String sql = "select * from tutores_laborales where idEmpresa = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idEmpresa);
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				TutoresLaborales auxiliar = new TutoresLaborales(resultado.getInt("idProfesor"), 
																 resultado.getInt("idAlumno"), 
																 resultado.getInt("idEmpresa"));
				lista.add(auxiliar);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lista;
	}

	public List<TutoresLaborales> listarXTutor(Conexion c, int idTutor) {
		List<TutoresLaborales> lista = new ArrayList<TutoresLaborales>();
		
		String sql = "select * from tutores_laborales where idProfesor = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idTutor);
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				TutoresLaborales auxiliar = new TutoresLaborales(resultado.getInt("idProfesor"), 
																 resultado.getInt("idAlumno"), 
																 resultado.getInt("idEmpresa"));
				lista.add(auxiliar);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lista;
	}

	public TutoresLaborales listarXAlumno(Conexion c, int idAlumno) {
		TutoresLaborales usuario = new TutoresLaborales();
		
		String sql = "select * from tutores_laborales where idAlumno = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idAlumno);
			ResultSet resultado = sentencia.executeQuery();
			if (resultado.next()) {
				usuario = new TutoresLaborales(resultado.getInt("idProfesor"), 
											   resultado.getInt("idAlumno"), 
							   				   resultado.getInt("idEmpresa"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return usuario;
	}

	public int insertar(Conexion c, TutoresLaborales t) {
		int filas = 0;
		
		String sql = "insert into tutores_laborales values (?, ?, ?)";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, t.getIdProfesor());
			sentencia.setInt(2, t.getIdAlumno());
			sentencia.setInt(3, t.getIdEmpresa());
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}

	public int borrar(Conexion c, TutoresLaborales t) {
		int filas = 0;
		
		String sql = "delete from tutores_laborales where idProfesor = ? and idAlumno = ? and idEmpresa = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, t.getIdProfesor());
			sentencia.setInt(2, t.getIdAlumno());
			sentencia.setInt(3, t.getIdEmpresa());
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}

	public int actualizar(Conexion c, TutoresLaborales t) {
		int filas = 0;
		
		String sql = "update tutores_laborales set idProfesor = ?, idEmpresa = ? where idAlumno = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, t.getIdProfesor());
			sentencia.setInt(2, t.getIdEmpresa());
			sentencia.setInt(3, t.getIdAlumno());
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}

	public boolean compExiste(Conexion c, TutoresLaborales t) {
		boolean comp = false;
		
		String sql = "select * from tutores_laborales where idProfesor = ? and idAlumno = ? and idEmpresa = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, t.getIdProfesor());
			sentencia.setInt(2, t.getIdAlumno());
			sentencia.setInt(3, t.getIdEmpresa());
			ResultSet resultado = sentencia.executeQuery();
			if (resultado.next()) {
				comp = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return comp;
	}

}
