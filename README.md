# Preenchimento de tabelas para avaliação da CAPES

Códigos criados por Mariana Motta e Carlos Trucíos para auxiliar no preenchimento das tabelas solicitadas pela CAPES.

## Instruções

Os códigos apresentados a seguir utilizam dados extraídos da plataforma Sucupira para gerar as tabelas solicitadas na avaliação da CAPES. Para garantir o funcionamento adequado, siga os passos abaixo:


1. Faça o download deste repositório como um arquivo .zip e descompacte-o.
2. Dentro da pasta Sucupira (gerada ao descompactar o .zip), abra o arquivo `Sucupira.Rproj` (para isso, além do `R`, será necessário ter o `RStudio` instalado).
3. Na pasta `arquivos`, utilize as subpastas `issn` e `lista2` e coloque nelas os arquivos baixados da plataforma Sucupira. Certifique-se de salvar cada arquivo com o nome correspondente ao ano, mantendo sempre a extensão `.xlsx`.
    *  Na pasta `issn`
    *  Na pasta `lista2`
4. Execute o arquivo `main.R`. Ele irá instalar automaticamente as dependências necessárias (pacotes), caso ainda não estejam instalados no seu computador.
5. Após a execução, serão gerados dois arquivos: `tabela2.2-dicente.csv` e `tabela2.2-egresso.csv`.


**Observação:** repare que no objeto `anos` (linha 5 do  arquivo `main.R`), devera escrever, em formato texto, os anos para os quais deseja que sejam montadas as tabelas.
