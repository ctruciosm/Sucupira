################################################################################
###                   Tabelas Avalicação CAPES                               ###
################################################################################
options(encoding="utf-8")
anos <- c("2017","2018","2019","2020","2021","2022","2023")

## Pacotes
### Se os pacotes necessários não estão instalados, serão instalados
if (!require("dplyr")) install.packages("dplyr")
if (!require("readr")) install.packages("readr")
if (!require("readxl")) install.packages("readxl")
if (!require("stringr")) install.packages("stringr")

### Carregando os pacptes
library(dplyr)
library(readr)
library(readxl)
library(stringr)

## Importando
arquivos_issn <- list.files(path = './arquivos/issn', pattern = '.xlsx', full.names = T)
arquivos_lista2 <- list.files(path = './arquivos/lista2', pattern = '.xlsx', full.names = T)

if (length(arquivos_issn) != length(arquivos_lista2)) {
  print("O número de arquivos em ambas as pastas deve ser o mesmo, verifique.")
} 
  
  
## Merge
all <- merged.all <- NULL
ids.discente <- ids.egresso <- NULL
all.discente <- all.egresso  <- NULL

for (i in anos) {
  
  issn <- read_excel(arquivos_issn[str_detect(arquivos_issn, pattern = i)]) |> 
    select("Ano da Produção", "ID da Produção", "Nome da Produção", "Produção vinculada a TCC concluído", "Subtipo de Produção", "ISSN", "Título", "Estrato", "Nome do Autor Principal",	"Categoria do Autor Principal") |> 
    setNames(c("ano", "id", "nome", "tipo", "issn", "nome.journal", "qualis", "autor.principal", "categoria"))
  lista2 <- read_excel(arquivos_lista2[str_detect(arquivos_lista2, pattern = i)]) |> 
    select("Ano da Produção", "ID da Produção", "Nome da Produção", "Subtipo de Produção", "Nome do Autor", "Categoria do Autor") |> 
    setNames(c("ano", "id", "nome", "tipo", "nome.autor", "categoria"))

  merged <- merge(lista2, issn, by = "id")
  merged.all <- rbind(merged.all, merged) 
  
  ids.discente <- c(ids.discente, merged$id[which(merged$categoria.x == "Discente")]) 
  merged.discente <- subset(merged, id %in% ids.discente)
  all.discente <- rbind(all.discente, merged.discente)
  
  ids.egresso <- c(ids.egresso,merged$id[which(merged$categoria.x=="Egresso")]) 
  merged.egresso <- subset(merged,id %in% ids.egresso)
  all.egresso <- rbind(all.egresso, merged.egresso)

  
}

unique_id_discente <-  unique(all.discente$id)
unique_id_egresso <-  unique(all.egresso$id)

final_file_discente <- NULL
final_file_egresso <- NULL


for (j in unique_id_discente){
  outros <- NULL
  discentes <- NULL
  sub <- data.frame(subset(all.discente, id == j))
  for (k in 1:dim(sub)[1]){
    if (sub$categoria.x[k] == "Discente") {
      discentes <- paste0(discentes, sub$nome.autor[k],";")
    } else {
      outros <- paste0(outros, sub$nome.autor[k],";")
    } 
  }
  discentes <- substring(discentes, 1, nchar(discentes) - 1)
  outros <- substring(outros, 1, nchar(outros) - 1)
  final_file_discente <- rbind(final_file_discente, cbind(sub$ano.x, sub$tipo.x, sub$issn, sub$nome.x,
    ifelse(length(discentes) == 0," ", discentes),
    ifelse(length(outros) == 0," ", outros)))  
}

for (j in unique_id_egresso){
  outros <- NULL
  egressos <- NULL
  sub <- data.frame(subset(all.egresso, id == j))
  for (k in 1:dim(sub)[1]){
    if (sub$categoria.x[k] == "Egresso") {
      egressos <- paste0(egressos, sub$nome.autor[k],";")
    } else {
      outros <- paste0(outros, sub$nome.autor[k],";")
    } 
  }
  egressos <- substring(egressos, 1, nchar(egressos)-1)
  outros <- substring(outros, 1, nchar(outros) - 1)
  final_file_egresso <- rbind(final_file_egresso, cbind(sub$ano.x, sub$tipo.x, sub$issn, sub$nome.x,
    ifelse(length(egressos) == 0," ", egressos),
    ifelse(length(outros) == 0," ", outros)))  
}

## Exportar tabelas 
colnames(final_file_discente) <- c("ano","tipo","issn","titulo","autor.discente","autor.outros")
write_delim(data.frame(final_file_discente), "tabela2.2-discente.csv", delim = "*",na = " ",append = F)


colnames(final_file_egresso) <- c("ano","tipo","issn","titulo","autor.egresso","autor.outros")
write_delim(data.frame(final_file_egresso), "tabela2.2-egressos.csv", delim = "*",na = " ",append = F)
