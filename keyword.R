source('./analyzer2.R')

bill_txt <- analyzer('./원문/billgates.txt')
mark_txt <- analyzer('./원문/zuckerberg.txt')
steve_txt <- analyzer('./원문/stevejobs.txt')

TDM <- data.frame(Morph=vector())
TDM <- merge(TDM, data.frame(table(bill_txt)),
             by.x = "Morph", by.y="bill_txt", all=T)
colnames(TDM)[length(TDM)] <- "bill"
TDM <- merge(TDM, data.frame(table(mark_txt)),
             by.x = "Morph", by.y="mark_txt", all=T)
colnames(TDM)[length(TDM)] <- "mark"
TDM <- merge(TDM, data.frame(table(steve_txt)),
             by.x = "Morph", by.y="steve_txt", all=T)
colnames(TDM)[length(TDM)] <- "steve"
colSums(TDM[2:length(TDM)], na.rm=T)
TDM <- data.frame(row.names=TDM$Morph,
                  TDM[2:length(TDM)])
TDM[is.na(TDM)] <- 0

CONTENT <- TDM[grep("_N|_V[^BH]|_JJ|_RB", rownames(TDM)),]

CHI <- chisq.test(TDM)$residuals
CHI <- as.data.frame(CHI)

head(CHI[order(CHI$bill, decreasing=T),], 15)
head(CHI[order(CHI$mark, decreasing=T),], 15)
head(CHI[order(CHI$steve, decreasing=T),], 15)
