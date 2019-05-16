package es.cj.dao;

import java.util.List;

import es.cj.bean.Conexion;
import es.cj.bean.Empresa;

public interface EmpresaDAO  {
	public Empresa listarXId(Conexion c, int idEmpresa);
	public List<Empresa> listarTodo(Conexion c);
}
