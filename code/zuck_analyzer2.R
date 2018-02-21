library(wordcloud)
original_txt <- scan(file="./원문/zuckerberg.txt", what="char", sep=" ", quote=NULL, encoding="UTF-8")
original_txt <- unlist(strsplit(original_txt, '\n'))
all_paste <- paste(gsub("\n", "", original_txt), collapse = " ")

library(koRpus)
set.kRp.env(TT.cmd = "C:/TreeTagger/bin/tag-english.bat", lang="en")
tagged = taggedText(treetag(all_paste, format="obj", treetagger="manual", TT.options=list(path="C:/TreeTagger", preset="en")))
nrow(tagged)

words_tagged <- vector()
# detail 품사 tagger
for (i in 1:nrow(tagged)) {
  if (tagged[i, ]$lemma == "<unknown>") {
    add_word <- paste(tagged[i, ]$token, tagged[i, ]$tag, sep="_")
    words_tagged <- c(words_tagged, add_word)
  } else {
    add_word <- paste(tagged[i, ]$lemma, tagged[i, ]$tag, sep="_")
    words_tagged <- c(words_tagged, add_word)
  }
}
head(words_tagged)

# 필요한 품사만 grep
filtered_tagged <- grep("_nn|_nnp|_nnps|_vb|_vbd|_vbg|_vbn|_vbp|_vbz|_md|_jj|_jjr|_jjs|_prp|_prp$|_rb|_rbr|_rbs", words_tagged, value=T)
filtered_tagged <- grep("_NN|_NNP|_NNPS", words_tagged, value=T)
filtered_tagged <- grep("_NP", words_tagged, value=T)
head(filtered_tagged)
head(sort(table(filtered_tagged), decreasing=T), 30)

tag_table<- sort(table(filtered_tagged), decreasing = T)
head(tag_table)
Freq.tag <- data.frame(tag_table)
Freq.tag <- data.frame(row.names = Freq.tag$filtered_tagged, Freq=Freq.tag$Freq)
head(Freq.tag, 30)

windowsFonts(font1 = windowsFont("궁서체"),
             font2 = windowsFont("Georgia"))

wordcloud(rownames(Freq.tag), Freq.tag$Freq,
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

