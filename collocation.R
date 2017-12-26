source('./analyzer2.R')

bill_txt <- analyzer('./원문/billgates.txt')
mark_txt <- analyzer('./원문/zuckerberg.txt')
steve_txt <- analyzer('./원문/stevejobs.txt')

ana_txt <- bill_txt

search <- "people_NNS"
index <- which(ana_txt==search)
span <- vector()
for (i in index) {
  span <- c(span, (i-6):(i+6))
}  
span <- span[span>0&span<=length(ana_txt)]
cooccurrence <- ana_txt[span]

Freq.span <- sort(table(cooccurrence), decreasing=T)
Freq.all <- sort(table(ana_txt), decreasing = T)
Freq.co <- data.frame(W1=vector(), W2=vector(), W1W2=vector(), N=vector())
n <- 1
for (i in (2:length(Freq.span))) {
  Freq.co[n,] <- c(Freq.span[1],
                   Freq.all[names(Freq.all)==names(Freq.span)[i]],
                   Freq.span[i], length(ana_txt))
  rownames(Freq.co)[n] <- names(Freq.span)[i]
  n <- n+1
}
collocates <- data.frame(Freq.co,
                         t.score =(Freq.co$W1W2 - ((Freq.co$W1*Freq.co$W2)/Freq.co$N))/
                           sqrt(Freq.co$W1W2),
                         MI = log2((Freq.co$W1W2*Freq.co$N)/
                                     (Freq.co$W1*Freq.co$W2)))

collocates <- collocates[grep("_N|_V[^BH]|_JJ|_RB", rownames(collocates)),]
t.score.sort <- collocates[order(collocates$t.score, decreasing=T), ]
MI.sort <- collocates[order(collocates$MI, decreasing=T), ]
MI.sort <- MI.sort[MI.sort$W1W2>2,]
head(t.score.sort, 10)
head(MI.sort, 10)
