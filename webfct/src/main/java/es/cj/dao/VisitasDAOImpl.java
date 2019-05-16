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
											   resultado.getString("tipo"));
				visitas.add(auxiliar);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return visitas;
	}

}
