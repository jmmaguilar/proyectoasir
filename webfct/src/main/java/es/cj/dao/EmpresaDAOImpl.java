package es.cj.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Empresa;

public class EmpresaDAOImpl implements EmpresaDAO {

	public Empresa listarXId(Conexion c, int idEmpresa) {
		Empresa empresa = new Empresa();
		
		String sql = "select * from empresa where idEmpresa = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idEmpresa);
			ResultSet resultado = sentencia.executeQuery();
			if (resultado.next()) {
				empresa = new Empresa(resultado.getInt("idEmpresa"), 
						  resultado.getString("nombre"), 
						  resultado.getString("direccion"), 
						  resultado.getInt("cp"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return empresa;
	}

	public List<Empresa> listarTodo(Conexion c) {
		List<Empresa> empresas = new ArrayList<Empresa>();
		
		String sql = "select * from empresa";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			ResultSet resultado = sentencia.executeQuery();
			while (resultado.next()) {
				Empresa empresa = new Empresa(resultado.getInt("idEmpresa"), 
						                      resultado.getString("nombre"), 
						                      resultado.getString("direccion"), 
						                      resultado.getInt("cp"));
				empresas.add(empresa);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return empresas;
	}

	public int borrarXId(Conexion c, int idEmpresa) {
		int filas = 0;
		String sql = "delete from empresa where idEmpresa = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setInt(1, idEmpresa);
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}

	public int insertar(Conexion c, Empresa empresa) {
		int filas = 0;
		
		String sql = "insert into empresa values (null, ?, ?, ?)";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setString(1, empresa.getNombre());
			sentencia.setString(2, empresa.getDireccion());
			sentencia.setInt(3, empresa.getCp());
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}

	public boolean compEmpresa(Conexion c, Empresa empresa) {
		boolean comp = false;
		String sql = "select * from empresa where nombre = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setString(1, empresa.getNombre());
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

	public int actualizarEmpresa(Conexion c, Empresa empresa) {
		int filas = 0;
		
		String sql = "update empresa set nombre = ?, direccion = ?, cp = ? where idEmpresa = ?";
		try {
			PreparedStatement sentencia = c.getConector().prepareStatement(sql);
			sentencia.setString(1, empresa.getNombre());
			sentencia.setString(2, empresa.getDireccion());
			sentencia.setInt(3, empresa.getCp());
			sentencia.setInt(4, empresa.getIdEmpresa());
			filas = sentencia.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return filas;
	}

}
