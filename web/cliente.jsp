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
        <script src="js/jquery.mask.js"></script>
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
                getListaRelatorio(4);
                
                
                $(".cpfmask").mask("999.999.999-99");
                $(".txtRg").mask("9.999.999-9");

                $(".cadcliente").addClass('active');


                $('#myTabs a').click(function (e) {
                    e.preventDefault()
                    $(this).tab('show')
                });



            });

            //funcao que mostra os clientes cadastrados na tela.
            function getLista() {
                $.ajax({
                    type: "post",
                    url: "ListaCliente", //this is my servlet
                    data: "pesquisa=" + "",
                    success: function (msg) {
                        $('#tbConteudoCliente').html(msg);
                    }
                });
            }

            //funcao que mostra o historico do cliente na tela do relatorio.
            function getListaRelatorio(id) {
                $.ajax({
                    type: "post",
                    url: "ListaRelatorio", //this is my servlet
                    data: "idCliente=" + id,
                    success: function (msg) {
                        $('#tbListaRelatorio').html(msg);
                    }
                });
            }

            //Funcao que rcarrega o modal de cadastro de cliente.
            function carregacadastrarCliente() {
                mostramodal();
                $("#nome").val('');
                $("#rg").val('');
                $("#cpf").val('');
                $("#status").val('');
                $("#invisivel").val('0');


            }
            //Faz o insert do cliente;
            function cadastrarCliente() {
                
                
                if($("#nome").val() != "" && $("#rg").val() != "" && $("#cpf").val()){
                    if(validarCPF($("#cpf").val())){
                        $.ajax({
                            type: "post",
                            url: "ProcessaCadCliente", //this is my servlet
                            data: "",
                            data: "nome=" + $("#nome").val() + "&rg=" + $("#rg").val() +
                                    "&cpf=" + $("#cpf").val() + "&empresa=" + $("#empresa").val(),
                                    success: function (msg) {
                                        alert(msg);
                                        location.reload(true);
                                    }
                        });
                    }else{
                        alert('CPF inválido.')
                    }
                }else{
                    alert("Todos os campos deve ser preenchidos");
                    
                }
            }

            //Funcao que joga os dados do cliente selecionado no modal.
            function carregaeditaCliente(id) {
                $.ajax({
                    type: "post",
                    url: "EditaCliente", //this is my servlet
                    data: "idCliente=" + id,
                    success: function (data) {
                        var resp = data.split(",");
                        $("#invisivel2").val(resp[0]);
                        $("#nome2").val(resp[1]);
                        $("#rg2").val(resp[2]);
                        $("#cpf2").val(resp[3]);

                        if ($.trim(resp[4]) === "A")
                            $("#status2").find(':radio[name=data][value="1"]').prop('checked', true);
                        else
                            $("#status2").find(':radio[name=data][value="2"]').prop('checked', true);

                        mostramodal3();

                    }
                });
            }

            //Funcao que joga os dados do cliente selecionado no modal relatorio.
            function carregaRelatorio(id) {
                $.ajax({
                    type: "post",
                    url: "Relatorio", //this is my servlet
                    data: "idCliente=" + id,
                    success: function (data) {
                        
                        alert(data);
                        
                        
//                        var resp = data.split(",");
//                        $("#invisivel3").val(resp[0]);
//                        $("#nome3").val(resp[1]);
//                        $("#rg3").val(resp[2]);
//                        $("#cpf3").val(resp[3]);
//                        $("#status3").val(resp[4]);
//
////                        mostramodal1();
//                        getListaRelatorio(id);

                    }
                });
            }

            function editaCliente() {
                
                
                if($("#nome2").val() != "" && $("#rg2").val() != "" && $("#cpf2").val()){
                    $.ajax({
                        type: "post",
                        url: "ProcessaEditaCliente", //this is my servlet
                        data: "nome=" + $("#nome2").val() + "&rg=" + $('#rg2').val() +
                                "&cpf=" + $('#cpf2').val() + "&status=" + $('input[name=data]:checked').val() +
                                "&id=" + $("#invisivel2").val(),
                        success: function (msg) {
                            alert(msg);
                            location.reload(true);
                        }
                    });
                }else{
                    alert("Todos os campos deve ser preenchidos");
                    
                }
            }

            //Funcao que trata a operação a ser feita (insert/update).
            function salvaCliente() {
                if ($("#invisivel").val() == '0') {
                    cadastrarCliente();
                } else {
                    editaCliente();
                }
            }

            //Funcao que exclui o usuario

            function excluir(id) {
                $.ajax({
                    type: "post",
                    url: "ProcessaExcluiCliente", //this is my servlet
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
                    url: "ListaCliente", //this is my servlet
                    data: "pesquisa=" + $('#pesquisa').val(),
                    success: function (msg) {
                        $('#tbConteudoCliente').html(msg);
                    }
                });

            }
            
            function validarCPF(cpf) {  
            cpf = cpf.replace(/[^\d]+/g,'');    
            if(cpf == '') return false; 
            // Elimina CPFs invalidos conhecidos    
            if (cpf.length != 11 || 
                cpf == "00000000000" || 
                cpf == "11111111111" || 
                cpf == "22222222222" || 
                cpf == "33333333333" || 
                cpf == "44444444444" || 
                cpf == "55555555555" || 
                cpf == "66666666666" || 
                cpf == "77777777777" || 
                cpf == "88888888888" || 
                cpf == "99999999999")
                    return false;       
            // Valida 1o digito 
            add = 0;    
            for (i=0; i < 9; i ++)       
                add += parseInt(cpf.charAt(i)) * (10 - i);  
                rev = 11 - (add % 11);  
                if (rev == 10 || rev == 11)     
                    rev = 0;    
                if (rev != parseInt(cpf.charAt(9)))     
                    return false;       
            // Valida 2o digito 
            add = 0;    
            for (i = 0; i < 10; i ++)        
                add += parseInt(cpf.charAt(i)) * (11 - i);  
            rev = 11 - (add % 11);  
            if (rev == 10 || rev == 11) 
                rev = 0;    
            if (rev != parseInt(cpf.charAt(10)))
                return false;       
            return true;   
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
                        <button type="button" onclick="carregacadastrarCliente()" class="btn btn-primary btn-novo">Novo</button>
                    </h4>
                </div>
                <div class="panel-body">

                    <input class="form-control" type="text" name="busca_nome" id="pesquisa" onkeyup="pesquisa();"  placeholder="Busca por nome / CPF">
                    <br>    
                    <table class="table table-bordered table-striped" aria-describedby="dataTable1_info">
                        <thead>
                            <tr>
                                <th>
                                    Nome
                                </th>                        
                                <th>
                                    RG
                                <th>
                                    CPF
                                </th>
                                <th>
                                    Status
                                </th>
                                <th>
                                    Opções
                                </th>
                            </tr>                 
                        </thead>

                        <tbody class="lvUsuarioTbody" role="alert" aria-live="polite" aria-relevant="all" id="tbConteudoCliente">

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
                            <label for="cod_analise">Nome</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <input id="nome" class="nome" type="text" name="data" />
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">RG</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="rg" class="rg txtRg" type="text" pattern="[0-9]+$" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">CPF</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="cpf" class="cpf cpfmask" type="text1" pattern="[0-9]+$" name="data"/>
                        </div><br>
                                           
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" onclick='cadastrarCliente();' class="btn btn-primary">Salvar</button>
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
                            <label for="cod_analise">Nome</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <input id="nome2" class="nome" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">RG</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="rg2" class="rg txtRg" type="text" pattern="[0-9]+$" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">CPF</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="cpf2" class="cpf cpfmask" type="text" pattern="[0-9]+$"  name="data"/>
                        </div><br>                        
                        <div id="status2" class="cel1" name="data">
                            <label for="cod_analise">Status</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label><input class="status" type="radio" value="1" name="data"> Ativo</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label><input class="status" type="radio" value="2" name="data">  Inativo</label>
                        </div><br>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" onclick='editaCliente();' class="btn btn-primary">Salvar</button>
                <input type="text" style="display:None;" id="invisivel2">
            </div>
        </div>
    </div>
</div>

</html>





