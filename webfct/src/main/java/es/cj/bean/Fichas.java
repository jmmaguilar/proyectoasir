package es.cj.bean;

import java.io.Serializable;

public class Fichas implements Serializable{
	private int idAlumno;
	private String fecha;
	private String horas;
	private String descripcion;
	private String observaciones;
	
	public Fichas() {
		// TODO Auto-generated constructor stub
	}
	
	public Fichas(int idAlumno, String fecha, String horas, String descripcion, String observaciones) {
		super();
		this.idAlumno = idAlumno;
		this.fecha = fecha;
		this.horas = horas;
		this.descripcion = descripcion;
		this.observaciones = observaciones;
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
	public String getHoras() {
		return horas;
	}
	public void setHoras(String horas) {
		this.horas = horas;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}

	@Override
	public String toString() {
		return "Fichas [id_alumno=" + idAlumno + ", fecha=" + fecha + ", horas=" + horas + ", descripcion="
				+ descripcion + ", observaciones=" + observaciones + "]";
	}
	
	
	
}
