package es.cj.dao;

import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.PreparedStatement;

import es.cj.bean.Conexion;
import es.cj.bean.Fichas;
import es.cj.bean.Usuario;

public class FichasDAOImpl implements FichasDAO {

	public List<Fichas> listar(Conexion c, Usuario u) {
		List<Fichas> fichas = new ArrayList<Fichas>();
		
		String sql = "Select * from fichas where idAlumno = ?";
		PreparedStatement sentencia = c.getConector().prepareStatement(sql);
		
		return fichas;
	}

}
