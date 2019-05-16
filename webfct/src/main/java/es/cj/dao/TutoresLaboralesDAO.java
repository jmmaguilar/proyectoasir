package es.cj.dao;

import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.TutoresLaborales;

public interface TutoresLaboralesDAO {
	public List<TutoresLaborales> listarTodo(Conexion c);
	public List<TutoresLaborales> listarXEmpresa(Conexion c, int idEmpresa);
	public List<TutoresLaborales> listarXTutor(Conexion c, int idTutor);
	public TutoresLaborales listarXAlumno(Conexion c, int idAlumno);
}
