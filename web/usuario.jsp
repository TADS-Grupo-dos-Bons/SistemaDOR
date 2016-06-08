<%-- 
    Document   : cadUsuario
    Created on : 11/05/2016, 21:08:23
    Author     : allex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>DOR</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link type="text/css" rel="stylesheet" href="css/bootstrap.css">
        <link type="text/css" rel="stylesheet" href="css/tudo.css">
        <link type="text/css" rel="stylesheet" href="css/bootstrap-switch.css">
        <script src="js/jquery-2.2.1.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/bootstrap-switch.js"></script>
        <script type="text/javascript">
            function mostramodal() {
                $('#myModal2').modal('show');
            }
            function mostramodal1() {
                $('#myModal1').modal('show');
            }
            function mostramodal3() {
                $('#myModal3').modal('show');
            }


            $(document).ready(function () {
                getLista();

                $(".cadusuario").addClass('active');


                $('#myTabs a').click(function (e) {
                    e.preventDefault()
                    $(this).tab('show')
                });



            });

            //funcao que mostra os usuarios cadastrados na tela.
            function getLista() {
                $.ajax({
                    type: "post",
                    url: "ListaUsuario", //this is my servlet
                    data: "pesquisa="+"",
                    success: function (msg) {
                        $('#tbConteudoUsuario').html(msg);
                    }
                });
            }

            //Funcao que rcarrega o modal de cadastro de usuario.
            function carregacadastrarUsuario() {
                mostramodal();
                $("#nome").val('');
                $("#user").val('');
                $("#senha").val('');
                $("#invisivel").val('0');


            }
            //Faz o insert do usuario;
            function cadastrarUsuario() {
                $.ajax({
                    type: "post",
                    url: "ProcessaCadUsuario", //this is my servlet
                    data: "",
                    data: "nome=" + $("#nome").val() + "&user=" + $('#user').val() +
                            "&senha=" + $('#senha').val() + "&empresa=" + $('#empresa').val(),
                            success: function (msg) {
                                alert('Usuário cadastrado com sucesso.');
                                location.reload(true);
                            }
                });
            }

            //Funcao que joga os dados do usuario selecionado no modal.
            function carregaeditaUsuario(id) {
                $.ajax({
                    type: "post",
                    url: "EditaUsuario", //this is my servlet
                    data: "idUsuario=" + id,
                    success: function (data) {
                        var resp = data.split(",");
                        $("#invisivel2").val(resp[0]);
                        $("#nome2").val(resp[1]);
                        $("#user2").val(resp[2]);
                        $("#senha2").val(resp[3]);
                        $("#empresa2").val(resp[4]);

                        mostramodal3();

                    }
                });
            }

            function editaUsuario() {
                $.ajax({
                    type: "post",
                    url: "ProcessaEditaUsuario", //this is my servlet
                    data: "nome=" + $("#nome2").val() + "&user=" + $('#user2').val() +
                            "&senha=" + $('#senha2').val() + "&empresa=" + $("#empresa2").val() +
                            "&id=" + $("#invisivel2").val(),
                    success: function (msg) {
                        alert('Dados editados com sucesso.');
                        location.reload(true);
                    }
                });
            }

            //Funcao que trata a operação a ser feita (insert/update).
            function salvaUsuario() {
                if ($("#invisivel").val() == '0') {
                    cadastrarUsuario();
                } else {
                    editaUsuario();
                }
            }

            //Funcao que exclui o usuario

            function excluir(id) {
                $.ajax({
                    type: "post",
                    url: "ProcessaExcluiUsuario", //this is my servlet
                    data: "id=" + id,
                    success: function (msg) {
                        alert('Usuario excluido com sucesso.');
                        location.reload(true);
                    }
                });
            }

            //Função que pesquisa usuário por nome.
            function pesquisa() {
                $.ajax({
                    type: "post",
                    url: "ListaUsuario", //this is my servlet
                    data: "pesquisa=" + $('#pesquisa').val(),
                    success: function (msg) {
                        $('#tbConteudoUsuario').html(msg);
                    }
                });
         
            }


        </script>
    </head>
    <body>

        <jsp:include page="topo.jsp"/>

        <div class="container" >
            <br>
            <div class="panel panel-default conta">
                <div class="panel-heading ">
                    <h4 class="panel-title">
                        <a class="accordion-toggle " data-toggle="collapse" data-parent="#accordion"></a>
                        <button type="button" onclick="carregacadastrarUsuario()" class="btn btn-primary btn-novo">Novo</button>
                    </h4>
                </div>
                <div class="panel-body">

                    <input class="form-control" type="text" name="busca_nome" id="pesquisa" onkeyup="pesquisa();"  placeholder="Busca por Nome">
                    <br>    
                    <table class="table table-bordered table-striped" aria-describedby="dataTable1_info">
                        <thead>
                            <tr>
                                <th>
                                    Nome
                                </th>                        
                                <th>
                                    Usuario
                                <th>
                                    Opções
                                </th>
                            </tr>                 
                        </thead>

                        <tbody class="lvUsuarioTbody" role="alert" aria-live="polite" aria-relevant="all" id="tbConteudoUsuario">

                        </tbody>
                    </table>


                </div>  
            </div>  

        </div>

    </body>
</html>


<!-- Modal Novo -->

<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Novo</h4>
            </div>
            <div class="modal-body">


                <div class='row'>
                    <div class='col-md-8 col-md-offset-3'>
                        <br>
                        <div class="cel1">
                            <label for="cod_analise">Nome</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="nome" class="nome" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">Usuario</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="user" class="user" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">Senha</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="senha" class="senha" type="password" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">Empresa</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <select id="empresa" class="empresa" name="data">
                                <option value="">Selecione</option>
                                <option value="1">Banco Coban</option>
                                <option value="2">Financeira Fina</option>
                                <option value="3">Agiota Igiota</option>
                            </select>
                        </div><br>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" onclick='cadastrarUsuario();' class="btn btn-primary">Salvar</button>
                <input type="text" style="display:None;" id="invisivel">
            </div>
        </div>
    </div>
</div>

<!-- Modal Editar -->

<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Editar</h4>
            </div>
            <div class="modal-body">


                <div class='row'>
                    <div class='col-md-8 col-md-offset-3'>
                        <br>
                        <div class="cel1">
                            <label for="cod_analise">Nome</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="nome2" class="nome" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">Usuario</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="user2" class="user" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">Senha</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="senha2" class="senha" type="password" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">Empresa</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <select id="empresa2" class="empresa" name="data">
                                <option value="">Selecione</option>
                                <option value="1">Banco Coban</option>
                                <option value="2">Financeira Fina</option>
                                <option value="3">Agiota Igiota</option>
                            </select>
                        </div><br>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" onclick='editaUsuario();' class="btn btn-primary">Salvar</button>
                <input type="text" style="display:None;" id="invisivel2">
            </div>
        </div>
    </div>
</div>