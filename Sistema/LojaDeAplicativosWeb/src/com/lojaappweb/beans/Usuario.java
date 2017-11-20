package com.lojaappweb.beans;

public class Usuario {
	// Atributos da Classe
	private int idUsuario;
	private String nome, login, senha;

	// Construtores
	public Usuario(String login) {
		setLogin(login);
	}
	public Usuario(String nome, String login) {
		setNome(nome);
		setLogin(login);
		setSenha(senha);
	}
	
	// Getters e Setters
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
}
