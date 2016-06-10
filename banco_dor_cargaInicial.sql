insert into empresa(nome) values('Banco Coban'), ('Financeira Fina'), ('Agiota Igiota');

insert into usuario(nome, usuario, senha, id_empresa) values ('marco', 'admin', 'senha', 1);

insert into cliente(nome, rg, cpf, st_cliente) values ('antonio', '861261', '8127662', 'A');

insert into historico(dtInicio, dtFim, id_cliente, id_usuario, id_empresa_usuario) 
values('2015-05-06','2015-06-06',1,1,1);