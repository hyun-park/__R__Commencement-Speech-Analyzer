source('./analyzer2.R')
source('./makewc.R', encoding='utf-8')

jack_txt <- analyzer('./원문/jackma.txt')

grep("_VV$", jack_txt, value=T)
grep("_V[^V]", jack_txt, value=T)
grep("_V[^BH]", jack_txt, value=T)
# 필요한 품사만 grep
#filtered_tagged <- grep("_nn|_nnp|_nnps|_vb|_vbd|_vbg|_vbn|_vbp|_vbz|_md|_jj|_jjr|_jjs|_prp|_prp$|_rb|_rbr|_rbs", words_tagged, value=T)
filtered_tagged <- grep("_N|_V[^BH]|_JJ|_RB", jack_txt, value=T)
#filtered_tagged <- grep("_NP", words_tagged, value=T)

tag_table<- sort(table(filtered_tagged), decreasing = T)
Freq.tag <- data.frame(tag_table)
Freq.tag <- data.frame(row.names = Freq.tag$filtered_tagged, Freq=Freq.tag$Freq)

makeWordcloud(Freq.tag)
