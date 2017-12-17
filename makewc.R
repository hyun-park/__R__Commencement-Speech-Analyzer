library(wordcloud)

makeWordcloud <- function(df) {
  windowsFonts(font1 = windowsFont("궁서체"),
               font2 = windowsFont("Georgia"))
  
  wordcloud(rownames(df), df$Freq,
            scale=c(3, 1.5), min.freq=2, max.words=100,
            random.order = F, rot.per = 0.4,
            colors = brewer.pal(8, "Dark2"), family="font1")
}