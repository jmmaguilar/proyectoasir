package es.cj.bean;

import java.io.Serializable;

public class Empresa implements Serializable {
	private int idEmpresa;
	private String nombre;
	private String direccion;
	private int cp;
	
	public Empresa() {
		// TODO Auto-generated constructor stub
	}

	public Empresa(int idEmpresa, String nombre, String direccion, int cp) {
		super();
		this.idEmpresa = idEmpresa;
		this.nombre = nombre;
		this.direccion = direccion;
		this.cp = cp;
	}

	public int getIdEmpresa() {
		return idEmpresa;
	}

	public void setIdEmpresa(int idEmpresa) {
		this.idEmpresa = idEmpresa;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public int getCp() {
		return cp;
	}

	public void setCp(int cp) {
		this.cp = cp;
	}

	@Override
	public String toString() {
		return "Empresa [idEmpresa=" + idEmpresa + ", nombre=" + nombre + ", direccion=" + direccion + ", cp=" + cp
				+ "]";
	}
	
	
}
