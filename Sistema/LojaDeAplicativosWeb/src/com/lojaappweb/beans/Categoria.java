package com.lojaappweb.beans;

public class Categoria {
	// Atributos da Classe
	private int idCategoria;
	private String categoria;

	// Construtores
	public Categoria(){}
	public Categoria(int idCategoria, String categoria){
		setIdCategoria(idCategoria);
		setCategoria(categoria);
	}
	
	// Getters e Setters
	public int getIdCategoria() {
		return idCategoria;
	}
	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
}
