# Preenchimento de tabelas para avaliação da CAPES

## Instruções

Os códigos aqui apresentados utilizam dos dados extraidos da platafroma Sucupira e constroem as tabelas solicitadas da avaliação CAPES. Para o funcionamento correto, seguir os seguintes passos:

1. Baixar este repositorio como .zip e descompactar o arquivo.
2. Dentro da pasta Sucupira (criada ao descompactar o .zip), abrir o arquivo `Sucupira.Rproj` (precisará ter instalado, além do própsio `R` o `Rstudio`).
3. Dentro da pasta `arquivos` , utilizar as sub-pastas `issn` e `lista2` e colocar dentro delas os arquivos baixados da plataforma sucupira (salvar cada arquivo com nome referente ao ano, sempre mantendo a extensão xlsx).
    *  Na pasta `issn`
    *  Na pasta `lista2`
4. Rodar o arquivo `main.R`, ele instalará algumas dependências (pacotes) caso eles não estejam intalados no computador
5. Ao terminar, dois arquivos serão gerados: `tabela2.2-dicente.csv` e `tabela2.2-egresso.csv`


**Observação:** repare que on objeto `anos` (linha 5 do `main.R`), devera escrever, em formato texto, os anos para os quais deseja que seja montada a tabela.
