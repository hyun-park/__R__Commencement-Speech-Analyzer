source('./analyzer2.R')

bill_txt <- './원문/billgates.txt'
mark_txt <- './원문/zuckerberg.txt'
steve_txt <- './원문/stevejobs.txt'

ana_txt <- steve_txt

original_txt <- scan(file=ana_txt, what="char", sep=" ", quote=NULL, encoding="UTF-8")
original_txt <- tolower(original_txt)
original_txt <- gsub("[[:punct:]]", "", original_txt)
head(original_txt)

tri.gram <- paste(original_txt[1:(length(original_txt)-2)],
                 original_txt[2:(length(original_txt)-1)],
                 original_txt[3:(length(original_txt))], sep=" ")
tri.gram.Freq <- data.frame(sort(table(tri.gram), decreasing=T))
tri.gram.Freq <- data.frame(Freq=tri.gram.Freq$Freq, row.names=tri.gram.Freq$tri.gram)

bi.gram <- paste(original_txt[1:(length(original_txt)-1)],
                  original_txt[2:(length(original_txt))], sep=" ")
bi.gram.Freq <- data.frame(sort(table(bi.gram), decreasing=T))
bi.gram.Freq <- data.frame(Freq=bi.gram.Freq$Freq, row.names=bi.gram.Freq$bi.gram)

head(tri.gram.Freq, decreasing=T, 8)
head(bi.gram.Freq, decreasing=T, 17)
