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

}
