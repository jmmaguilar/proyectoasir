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

}
