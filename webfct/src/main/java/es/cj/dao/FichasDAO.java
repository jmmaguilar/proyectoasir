package es.cj.dao;

import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Fichas;
import es.cj.bean.Usuario;

public interface FichasDAO {
	List<Fichas> listar(Conexion c, Usuario u);
}
