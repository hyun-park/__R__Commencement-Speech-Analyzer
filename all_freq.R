source('./analyzer2.R')
source('./makewc.R', encoding='utf-8')

bill_txt <- analyzer('./원문/billgates.txt')
mark_txt <- analyzer('./원문/zuckerberg.txt')
steve_txt <- analyzer('./원문/stevejobs.txt')
jeff_txt <- analyzer('./원문/jeffbezos.txt')
elon_txt <- analyzer('./원문/elonmusk.txt')
jack_txt <- analyzer('./원문/jackma.txt')

head(bill_txt)
obama_txt <- analyzer('./원문/obama.txt')

obama_txt <- analyzer('./원문/obama_후보연설.txt')

length(bill_txt)
length(mark_txt)
length(steve_txt)
length(jack_txt)

grep("^always", steve_txt, value=T)


head(bill_txt)

grep("_VV$", bill_txt, value=T)
grep("_V[^V]", bill_txt, value=T)
grep("_V[^BH]", bill_txt, value=T)
# 필요한 품사만 grep
#filtered_tagged <- grep("_nn|_nnp|_nnps|_vb|_vbd|_vbg|_vbn|_vbp|_vbz|_md|_jj|_jjr|_jjs|_prp|_prp$|_rb|_rbr|_rbs", words_tagged, value=T)
filtered_tagged <- grep("_N|_V[^BH]|_JJ|_RB", mark_txt, value=T)
filtered_tagged <- grep("_VH", bill_txt, value=T)
filtered_tagged <- grep("_VB", bill_txt, value=T)
filtered_tagged <- grep("_RB", bill_txt, value=T)
filtered_tagged <- grep("_JJ", bill_txt, value=T)


#filtered_tagged <- grep("_N|_V[^BH]|_JJ", bill_txt, value=T)
#filtered_tagged <- grep("_NP", words_tagged, value=T)

tag_table<- sort(table(mark_txt), decreasing = T)
tag_table<- sort(table(filtered_tagged), decreasing = T)
Freq.tag <- data.frame(tag_table)
Freq.tag <- data.frame(row.names = Freq.tag$filtered_tagged, Freq=Freq.tag$Freq)


write.table(Freq.tag, file="markdf.csv", quote=F, sep=",", col.names=NA)
head(Freq.tag, 200)

Freq.tag

makeWordcloud(Freq.tag)
