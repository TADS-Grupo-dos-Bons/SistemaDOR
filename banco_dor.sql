/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Marco
 * Created: 03/06/2016
 */

CREATE DATABASE dor;

USE dor


CREATE TABLE empresa (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)
)

CREATE TABLE usuario
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	usuario VARCHAR(45),
	senha VARCHAR(45),
	id_empresa INT,
	FOREIGN KEY (id_empresa) REFERENCES empresa(id)
);


CREATE TABLE historico(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	dt DATE,
	st_historico VARCHAR(1),
	id_cliente INT,
	id_usuario INT,
	id_empresa_usuario INT,
	FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	FOREIGN KEY (id_usuario) REFERENCES usuario(id),
	FOREIGN KEY (id_empresa_usuario) REFERENCES usuario(id_empresa)
);


CREATE TABLE cliente(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	rg VARCHAR(20),
	cpf VARCHAR(20),
	st_cliente VARCHAR(1)
);

