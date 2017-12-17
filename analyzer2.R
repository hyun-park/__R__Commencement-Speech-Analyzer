library(koRpus)
set.kRp.env(TT.cmd = "C:/TreeTagger/bin/tag-english.bat", lang="en")

lemmatizer <- function (text) {
  tagged = taggedText(treetag(text, format="obj", treetagger="manual", TT.options=list(path="C:/TreeTagger", preset="en")))
  return(tagged)
}

analyzer <- function (path) {
  original_txt <- scan(file=path, what="char", sep=" ", quote=NULL, encoding="UTF-8")
  original_txt <- unlist(strsplit(original_txt, '\n'))
  all_paste <- paste(gsub("\n", "", original_txt), collapse = " ")
  tolower(all_paste)
  
  # 소문자로 변경
  #gsub("I","I★", all_paste)
  
  tagged <- lemmatizer(all_paste)
  head(tagged)
  
  # 고유 단어라 lemma가 unknown으로 뜨는건 token 값으로 벡터에 저장
  # 나머지는 lemma(원형)으로 벡터에 저장
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
  return(words_tagged)
}
