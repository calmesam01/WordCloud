#Install the following packages in RStudio.
install.packages("Rfacebook")
install.packages("tm")
install.packages("RCurl")
install.packages("wordcloud")

#Load these packages.
library(Rfacebook)
library(RCurl)
library(tm)
library(wordcloud)

#Fill the token here('XXXX') that you get from https://developers.facebook.com/tools/explorer.
token = 'XXXX'

#Now, save 100 posts from Hillary Clinton's page into modi_page variable.
clinton_page = getPage("hillaryclinton",token,n = 100)

#Get the the first post.
clinton_post = getPost(post = clinton_page$id[1],n = 100, token)

#Get the replies to the comments.
clinton_message = (clinton_post$comments)$message

#Create the corpous after passing docs into VectorSource().
docs = Corpus(VectorSource(clinton_message))

#Do the preproccesing with tm package.
docs = tm_map(docs, removePunctuation)
docs = tm_map(docs, removeNumbers)
docs = tm_map(docs, tolower)
docs = tm_map(docs, stripWhitespace)
docs = tm_map(docs, removeWords,stopwords("en"))

#At last, with wordcloud function, create one.
wordcloud(docs, max.words = 100, random.order = FALSE)
