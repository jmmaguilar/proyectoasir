package es.cj.dao;

import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Usuario;
import es.cj.bean.Visitas;

public interface VisitasDAO {
	public List<Visitas> listar(Conexion c, Usuario u);
	public int borrar(Conexion c, int idAlumno, int idProfesor, int idEmpresa, String fecha);
	public int insertar(Conexion c, Visitas visita);
	public boolean comVisitas(Conexion c, Visitas visita);
	public List<Visitas> listarPendientes(Conexion c);
	public int cambiarEstado(Conexion c, int estado, int idAlumno, int idEmpresa, int idProfesor, String fecha);
}
