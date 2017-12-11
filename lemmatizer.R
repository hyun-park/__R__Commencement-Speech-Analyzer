#install.packages("koRpus")
library(koRpus)
set.kRp.env(TT.cmd = "C:/TreeTagger/bin/tag-english.bat", lang="en")
tagged = taggedText(treetag("this is a sample text.", format="obj", treetagger="manual", TT.options=list(path="C:/TreeTagger", preset="en")))
paste(tagged$lemma, collapse = ' ')

# tag 링크 http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/Penn-Treebank-Tagset.pdf

# detail 품사 tagger
paste(tagged$lemma, tagged$tag, sep="_")

# 품사 tagger
paste(tagged$lemma, tagged$wclass, sep="_")
