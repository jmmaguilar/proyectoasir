package es.cj.dao;

import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Fichas;
import es.cj.bean.Usuario;

public interface FichasDAO {
	public List<Fichas> listar(Conexion c, Usuario u);
	public int insertar(Conexion c, Fichas fichas);
	public boolean compFicha(Conexion c, Fichas fichas);
	public int actualizar(Conexion c, Fichas fichas);
	public int borrar(Conexion c, int idAlumno, String fecha);
}
