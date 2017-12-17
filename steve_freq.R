source('./analyzer2.R')
source('./makewc.R', encoding='utf-8')

steve_txt <- analyzer('./원문/stevejobs.txt')
head(steve_txt)

grep("_VV$", steve_txt, value=T)
grep("_V[^V]", steve_txt, value=T)
grep("_V[^BH]", steve_txt, value=T)
# 필요한 품사만 grep
#filtered_tagged <- grep("_nn|_nnp|_nnps|_vb|_vbd|_vbg|_vbn|_vbp|_vbz|_md|_jj|_jjr|_jjs|_prp|_prp$|_rb|_rbr|_rbs", words_tagged, value=T)
filtered_tagged <- grep("_N|_V[^BH]|_JJ|_RB", steve_txt, value=T)
#filtered_tagged <- grep("_NP", words_tagged, value=T)

tag_table<- sort(table(filtered_tagged), decreasing = T)
head(tag_table)
Freq.tag <- data.frame(tag_table)
Freq.tag <- data.frame(row.names = Freq.tag$filtered_tagged, Freq=Freq.tag$Freq)
head(Freq.tag, 30)

makeWordcloud(Freq.tag)
