package es.cj.bean;

import java.io.Serializable;

public class Visitas implements Serializable {
	private int idProfesor;
	private int idEmpresa;
	private int idAlumno;
	private String fecha;
	private String hora_ini;
	private String hora_fin;
	private int aceptado;
	private String tipo;
	
	public Visitas() {
		// TODO Auto-generated constructor stub
	}

	public Visitas(int idProfesor, int idEmpresa, int idAlumno, String fecha, String hora_ini, String hora_fin,
			int aceptado, String tipo) {
		super();
		this.idProfesor = idProfesor;
		this.idEmpresa = idEmpresa;
		this.idAlumno = idAlumno;
		this.fecha = fecha;
		this.hora_ini = hora_ini;
		this.hora_fin = hora_fin;
		this.aceptado = aceptado;
		this.tipo = tipo;
	}

	public int getIdProfesor() {
		return idProfesor;
	}

	public void setIdProfesor(int idProfesor) {
		this.idProfesor = idProfesor;
	}

	public int getIdEmpresa() {
		return idEmpresa;
	}

	public void setIdEmpresa(int idEmpresa) {
		this.idEmpresa = idEmpresa;
	}

	public int getIdAlumno() {
		return idAlumno;
	}

	public void setIdAlumno(int idAlumno) {
		this.idAlumno = idAlumno;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getHora_ini() {
		return hora_ini;
	}

	public void setHora_ini(String hora_ini) {
		this.hora_ini = hora_ini;
	}

	public String getHora_fin() {
		return hora_fin;
	}

	public void setHora_fin(String hora_fin) {
		this.hora_fin = hora_fin;
	}

	public int getAceptado() {
		return aceptado;
	}

	public void setAceptado(int aceptado) {
		this.aceptado = aceptado;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return "Visitas [idProfesor=" + idProfesor + ", idEmpresa=" + idEmpresa + ", idAlumno=" + idAlumno + ", fecha="
				+ fecha + ", hora_ini=" + hora_ini + ", hora_fin=" + hora_fin + ", aceptado=" + aceptado + ", tipo="
				+ tipo + "]";
	}
	
		
}
