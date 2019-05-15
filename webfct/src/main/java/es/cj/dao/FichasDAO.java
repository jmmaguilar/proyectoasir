package es.cj.dao;

import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Fichas;
import es.cj.bean.Usuario;

public interface FichasDAO {
	List<Fichas> listar(Conexion c, Usuario u);
	int insertar(Conexion c, Fichas fichas);
	boolean compFicha(Conexion c, Fichas fichas);
	int actualizar(Conexion c, Fichas fichas);
	int borrar(Conexion c, int idAlumno, String fecha);
}
