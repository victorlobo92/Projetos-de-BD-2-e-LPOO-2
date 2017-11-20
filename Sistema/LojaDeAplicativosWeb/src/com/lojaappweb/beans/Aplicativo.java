package com.lojaappweb.beans;

public class Aplicativo {
	// Atributos da Classe
	private int idAplicativo;
	private int idDesenvolvedor;
	private String desenvolvedor;
	private int idCategoria;
	private String categoria;
	private String nome;
	private String descricao;
	private int qtdDownloads;
	private String dataHora;
	
	// Construtores
	public Aplicativo(){}
	public Aplicativo(String nome, int qtdDownloads){
		setNome(nome);
		setDescricao(descricao);
		setQtdDownloads(qtdDownloads);
		setDataHora(dataHora);
	}
	public Aplicativo(int idDesenvolvedor, int idCategoria, String nome, String descricao){
		setIdDesenvolvedor(idDesenvolvedor);
		setIdCategoria(idCategoria);
		setNome(nome);
		setDescricao(descricao);
	}
	
	// Getters e Setters
	public int getIdAplicativo() {
		return idAplicativo;
	}
	public void setIdAplicativo(int idAplicativo) {
		this.idAplicativo = idAplicativo;
	}
	public int getIdDesenvolvedor() {
		return idDesenvolvedor;
	}
	public void setIdDesenvolvedor(int idDesenvolvedor) {
		this.idDesenvolvedor = idDesenvolvedor;
	}
	public String getDesenvolvedor() {
		return desenvolvedor;
	}
	public void setDesenvolvedor(String desenvolvedor) {
		this.desenvolvedor = desenvolvedor;
	}
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
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public int getQtdDownloads() {
		return qtdDownloads;
	}
	public void setQtdDownloads(int qtdDownloads) {
		this.qtdDownloads = qtdDownloads;
	}
	public String getDataHora() {
		return dataHora;
	}
	public void setDataHora(String dataHora) {
		this.dataHora = dataHora;
	}
}
