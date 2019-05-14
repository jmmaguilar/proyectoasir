package es.cj.bean;

import java.io.Serializable;

public class Fichas implements Serializable{
	private int id_alumno;
	private String fecha;
	private String horas;
	private String descripcion;
	private String observaciones;
	
	public Fichas() {
		// TODO Auto-generated constructor stub
	}
	
	public Fichas(int id_alumno, String fecha, String horas, String descripcion, String observaciones) {
		super();
		this.id_alumno = id_alumno;
		this.fecha = fecha;
		this.horas = horas;
		this.descripcion = descripcion;
		this.observaciones = observaciones;
	}

	public int getId_alumno() {
		return id_alumno;
	}
	public void setId_alumno(int id_alumno) {
		this.id_alumno = id_alumno;
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
		return "Fichas [id_alumno=" + id_alumno + ", fecha=" + fecha + ", horas=" + horas + ", descripcion="
				+ descripcion + ", observaciones=" + observaciones + "]";
	}
	
	
	
}
