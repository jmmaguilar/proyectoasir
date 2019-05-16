package es.cj.bean;

import java.io.Serializable;

public class TutoresLaborales implements Serializable {
	private int idProfesor;
	private int idAlumno;
	private int idEmpresa;
	
	public TutoresLaborales() {
		// TODO Auto-generated constructor stub
	}

	public TutoresLaborales(int idProfesor, int idAlumno, int idEmpresa) {
		super();
		this.idProfesor = idProfesor;
		this.idAlumno = idAlumno;
		this.idEmpresa = idEmpresa;
	}

	public int getIdProfesor() {
		return idProfesor;
	}

	public void setIdProfesor(int idProfesor) {
		this.idProfesor = idProfesor;
	}

	public int getIdAlumno() {
		return idAlumno;
	}

	public void setIdAlumno(int idAlumno) {
		this.idAlumno = idAlumno;
	}

	public int getIdEmpresa() {
		return idEmpresa;
	}

	public void setIdEmpresa(int idEmpresa) {
		this.idEmpresa = idEmpresa;
	}

	@Override
	public String toString() {
		return "TutoresLaborales [idProfesor=" + idProfesor + ", idAlumno=" + idAlumno + ", idEmpresa=" + idEmpresa
				+ "]";
	}
	
	
}
