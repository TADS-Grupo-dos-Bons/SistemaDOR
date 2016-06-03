<%-- 
    Document   : cliente
    Created on : 03/06/2016, 10:15:09
    Author     : Marco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                    data: "pesquisa=" + "",
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
                            "&senha=" + $('#senha').val(),
                            success: function (msg) {
                                alert('Conta cadastrada com sucesso.');
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
                        $("#invisivel").val(resp[0]);
                        $("#nome").val(resp[1]);
                        $("#user").val(resp[2]);
                        $("#senha").val(resp[3]);

                        mostramodal();

                    }
                });
            }

            function editaUsuario() {
                $.ajax({
                    type: "post",
                    url: "ProcessaEditaUsuario", //this is my servlet
                    data: "nome=" + $("#nome").val() + "&user=" + $('#user').val() +
                            "&senha=" + $('#senha').val() + "&id=" + $("#invisivel").val(),
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

                    <input class="form-control" type="text" name="busca_nome" id="pesquisa" onkeyup="pesquisa();"  placeholder="Busca por Nome ou CPF">
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


<!-- Modal Novo/Editar -->

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
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" onclick='salvaUsuario();' class="btn btn-primary">Salvar</button>
                <input type="text" style="display:None;" id="invisivel">
            </div>
        </div>
    </div>
</div>

</html>
