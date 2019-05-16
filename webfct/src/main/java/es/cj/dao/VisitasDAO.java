package es.cj.dao;

import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Usuario;
import es.cj.bean.Visitas;

public interface VisitasDAO {
	public List<Visitas> listar(Conexion c, Usuario u);
}
