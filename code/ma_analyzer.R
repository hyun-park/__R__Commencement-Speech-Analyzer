library(wordcloud)

zuck_txt <- scan(file="./원문/jackma.txt", what="char", sep=" ", quote=NULL, encoding="UTF-8")

zuckerberg <- scan(file="./원문/jackma.tag.txt", what="char", sep=" ", quote=NULL, encoding="UTF-8")
#_가 있어야 올바른 태거
zuckerberg <- tolower(grep("_",zuckerberg, value=T))


head(zuckerberg)
zuckerberg_fil <- grep("_nn|_nnp|_nnps|_vb|_vbd|_vbg|_vbn|_vbp|_vbz|_md|_jj|_jjr|_jjs|_prp|_prp$|_rb|_rbr|_rbs", zuckerberg, value=T)
zuckerberg_fil <- grep("_nn|_nnp|_nnps", zuckerberg, value=T)
zuc_table<- sort(table(zuckerberg_fil), decreasing = T)

Freq.zuckerberg <- data.frame(zuc_table)
Freq.zuckerberg <- data.frame(row.names = Freq.zuckerberg$zuckerberg, Freq=Freq.zuckerberg$Freq)
head(Freq.zuckerberg, 30)
Freq.zuckerberg

windowsFonts(font1 = windowsFont("궁서체"),
             font2 = windowsFont("Georgia"))

wordcloud(rownames(Freq.zuckerberg), Freq.zuckerberg$Freq,
          scale=c(3, 1.5), min.freq=2, max.words=100,
          random.order = F, rot.per = 0.4,
          colors = brewer.pal(8, "Dark2"), family="font1")

#Bi gram
grep("",zuck_txt)
nchar(zuck_txt) == 0
zuck_txt_without_blank <- zuck_txt[nchar(zuck_txt) != 0]

Bigrams <- paste(zuck_txt_without_blank[1:length(zuck_txt_without_blank)-1],zuck_txt_without_blank[2:length(zuck_txt_without_blank)], sep=" ")
Bigrams.Freq <- data.frame(sort(table(Bigrams), decreasing = T))
head(Bigrams.Freq, 20)

