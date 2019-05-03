package es.cj.bean;

import java.io.Serializable;

public class Usuario implements Serializable{
	private int idUsuario;
	private String login;
	private String nombre;
	private String apellidos;
	private String password;
	private String email;
	private int tipo;
	
	public Usuario() {
		// TODO Auto-generated constructor stub
	}

	public Usuario(int idUsuario, String login, String nombre, String apellidos, String password, String email, int tipo) {
		super();
		this.idUsuario = idUsuario;
		this.setLogin(login);
		this.nombre = nombre;
		this.apellidos = apellidos;
		this.password = password;
		this.email = email;
		this.tipo = tipo;
	}
	
	public Usuario(String login, String nombre, String apellidos, String password, String email, int tipo) {
		super();
		this.setLogin(login);
		this.nombre = nombre;
		this.apellidos = apellidos;
		this.password = password;
		this.email = email;
		this.tipo = tipo;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellidos() {
		return apellidos;
	}

	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return "Usuario [idUsuario=" + idUsuario + ", login=" + login + ", nombre=" + nombre + ", apellidos="
				+ apellidos + ", password=" + password + ", email=" + email + ", tipo=" + tipo + "]";
	}

	
	
}
