# Text mining using (tm) package
# Step 1 - collecting data
# To develop the Naive Bayes classifier, we will use data
# adapted from the SMS Spam

# Collection at http://www.dt.fee.unicamp.br/~tiago/smsspamcollection/
getwd()
setwd("C:/Users/Naveen/Desktop/ML/Del_Naive_Bayes")

#install.packages("tm")
library(tm)

smsData <- read.csv("sms_spam.csv",stringsAsFactors = FALSE)
str(smsData)

# The type element is currently a character vector.
# Since this is a categorical variable, it
# would be better to convert it into a factor, 
# as shown in the following code:
smsData$type <- factor(smsData$type)
str(smsData)

table(smsData$type)

# Data preparation - cleaning and standardizing text
# data
# The first step in processing text data involves creating a corpus, which is a collection
# of text documents
smsDataCorpus <- VCorpus(VectorSource(smsData$text))
print(smsDataCorpus)#By printing the corpus, we see that it contains documents for each of the 5,559 SMS

#messages in the training data:
inspect(smsDataCorpus[1:2])#To receive a summary of specific messages

# To view the actual message text, the as.character() function must be applied to
# the desired messages
as.character(smsDataCorpus[[1]])

# names(smsDataCorpus)
# The lapply() command to apply
# as.character() to a subset of corpus elements is as follows
lapply(smsDataCorpus[1:2], as.character)

# As noted earlier, the corpus contains the raw text of 5,559 text messages. In order
# to perform our analysis, we need to divide these messages into individual words.
# But first, we need to clean the text, in order to standardize the words, by removing
# punctuation and other characters that clutter the result. For example, we would like
# the strings Hello!, HELLO, and hello to be counted as instances of the same word
# The tm_map() function provides a method to apply a transformation (also known
# as mapping) to a tm corpus. We will use this function to clean up our corpus using a
# series of transformations and save the result in a new object called corpus_clean.
smsData_corpus_clean <- tm_map(smsDataCorpus,
                               content_transformer(tolower))#to standardize the messages to use only lowercase
# To check whether the command worked as advertised, let's inspect the first message
# in the original corpus and compare it to the same in the transformed corpus
as.character(smsDataCorpus[[1]])

as.character(smsData_corpus_clean[[1]])

#################################################
# Let's continue our cleanup by removing numbers from the SMS messages. Although
# some numbers may provide useful information, the majority would likely be unique
# to individual senders and thus will not provide useful patterns across all messages.
# With this in mind, we'll strip all the numbers from the corpus as follows:
smsData_corpus_clean <- tm_map(smsData_corpus_clean,
                               removeNumbers)
# Our next task is to remove filler words such as to, and, but, and or from our SMS
# messages. These terms are known as stop words and are typically removed prior to
# text mining. This is due to the fact that although they appear very frequently, they do
# not provide much useful information for machine learning
# The stop words alone are not a useful transformation. What we need is a way
# to remove any words that appear in the stop words list. The solution lies in the
# removeWords() function, which is a transformation included with the tm package
smsData_corpus_clean <- tm_map(smsData_corpus_clean,
                               removeWords,stopwords())
# Since stopwords() simply returns a vector of stop words, had we chosen so, we
# could have replaced it with our own vector of words to be removed. In this way, we
# could expand or reduce the list of stop words to our liking or remove a completely
# different set of words entirely.
# Continuing with our cleanup process, we can also eliminate any punctuation from
# the text messages using the built-in removePunctuation() transformation:
smsData_corpus_clean <- tm_map(smsData_corpus_clean,
                               removePunctuation)#???The removePunctuation() transformation strips punctuation characters from the
#text blindly, which can lead to unintended consequences
# removePunctuation("hello...world")
# [1] "helloworld"
# As shown, the lack of blank space after the ellipses has caused the words hello and
# world to be joined as a single word. While this is not a substantial problem for our
# analysis, it is worth noting for the future
# To work around the default behavior of removePunctuation(),
# simply create a custom function that replaces rather than removes
# punctuation characters:
#   > replacePunctuation <- function(x) {
#     gsub("[[:punct:]]+", " ", x)
#   }
# Essentially, this uses R's gsub() function to substitute
# any punctuation characters in x with a blank space. The
# replacePunctuation() function can then be used with tm_map()
# as with other transformations
# Another common standardization for text data involves reducing words to their root
# form in a process called stemming. The stemming process takes words like learned,
# learning, and learns, and strips the suffix in order to transform them into the base
# form, learn. This allows machine learning algorithms to treat the related terms as a
# single concept rather than attempting to learn a pattern for each variant.
# The tm package provides stemming functionality via integration with the SnowballC
# package. At the time of this writing, SnowballC was not installed by default with tm.
# Do so with install.packages("SnowballC") if it is not installed already.

#install.packages("SnowballC")
library(SnowballC)
# The SnowballC package provides a wordStem() function, which for a character
# vector, returns the same vector of terms in its root form. For example, the function
# correctly stems the variants of the word learn, as described previously
objects(grep("Snowball",search()))

###################################################

# an example:
wordStem(c("learn","learned","learning","learns"))

# In order to apply the wordStem() function to an entire corpus of text documents, the
# tm package includes a stemDocument() transformation. We apply this to our corpus
# with the tm_map() function exactly as done earlier:
smsData_corpus_clean <- tm_map(smsData_corpus_clean,
                               stemDocument)
# After removing numbers, stop words, and punctuation as well as performing
# stemming, the text messages are left with the blank spaces that previously separated
# the now-missing pieces. The final step in our text cleanup process is to remove
# additional whitespace, using the built-in stripWhitespace() transformation
smsData_corpus_clean <- tm_map(smsData_corpus_clean,stripWhitespace)
as.character(smsData_corpus_clean[1:3])

# Data preparation - splitting text documents into
# words
# Now that the data are processed to our liking, the final step is to split the messages
# into individual components through a process called tokenization. A token is a
# single element of a text string; in this case, the tokens are words.
# As you might assume, the tm package provides functionality to tokenize the SMS
# message corpus. The DocumentTermMatrix() function will take a corpus and create
# a data structure called a Document Term Matrix (DTM) in which rows indicate
# documents (SMS messages) and columns indicate terms (words).
sms_dtm <- DocumentTermMatrix(smsData_corpus_clean)
# This will create an sms_dtm object that contains the tokenized corpus using
# the default settings, which apply minimal processing. The default settings
# are appropriate because we have already prepared the corpus manually.
# On the other hand, if we hadn't performed the preprocessing, we could do so
# here by providing a list of control parameter options to override the defaults.
# For example, to create a DTM directly from the raw, unprocessed SMS corpus,
# we can use the following command:
# > sms_dtm2 <- DocumentTermMatrix(sms_corpus, control = list(
# tolower = TRUE,removeNumbers = TRUE,
# stopwords = TRUE,
# removePunctuation = TRUE,
# stemming = TRUE
# ))
sms_dtm

sms_dtm2 <- DocumentTermMatrix(smsDataCorpus,
                               control = list(tolower=TRUE,
                                              removeNumbers=TRUE,
                                              stopwords=TRUE,
                                              removePunctuation=TRUE,
                                              stemming=TRUE))
sms_dtm2

# The reason for this discrepancy has to do with a minor difference in the ordering of
# the preprocessing steps. The DocumentTermMatrix() function applies its cleanup
# functions to the text strings only after they have been split apart into words. Thus,
# it uses a slightly different stop words removal function. Consequently, some words
# split differently than when they are cleaned before tokenization.
# To force the two prior document term matrices to be identical, we can
# override the default stop words function with our own that uses the
# original replacement function. Simply replace stopwords = TRUE
# with the following:
#   stopwords = function(x) { removeWords(x, stopwords()) }
# The differences between these two cases illustrate an important principle of cleaning
# text data: the order of operations matters. With this in mind, it is very important
# to think through how early steps in the process are going to affect later ones. The
# order presented here will work in many cases, but when the process is tailored more
# carefully to specific datasets and use cases, it may require rethinking. For example,
# if there are certain terms you hope to exclude from the matrix, consider whether you
# should search for them before or after stemming. Also, consider how the removal
# of punctuation-and whether the punctuation is eliminated or replaced by blank
# space-affects these steps.
# Data preparation - creating training and test
# datasets
# With our data prepared for analysis, we now need to split the data into training and
# test datasets, so that once our spam classifier is built, it can be evaluated on data it
# has not previously seen. But even though we need to keep the classifier blinded as to
# the contents of the test dataset, it is important that the split occurs after the data have
# been cleaned and processed; we need exactly the same preparation steps to occur on
# both the training and test datasets.
# We'll divide the data into two portions: 75 percent for training and 25 percent for
# testing. Since the SMS messages are sorted in a random order, we can simply take the
# first 4,169 for training and leave the remaining 1,390 for testing. Thankfully, the DTM
# object acts very much like a data frame and can be split using the standard [row,
# col] operations. As our DTM stores SMS messages as rows and words as columns,
# we must request a specific range of rows and all columns for each:
sms_dtm_train <- sms_dtm[1:4169,]
sms_dtm_test <- sms_dtm[4170:5559,]
# For convenience later on, it is also helpful to save a pair of vectors with labels for
# each of the rows in the training and testing matrices. These labels are not stored in
# the DTM, so we would need to pull them from the original sms_raw data frame:
sms_train_labels <- smsData[1:4169,]$type
sms_test_labels <- smsData[4170:5559,]$type
# To confirm that the subsets are representative of the complete set of SMS data, let's
# compare the proportion of spam in the training and test data frames:
prop.table(table(sms_train_labels))

prop.table(table(sms_test_labels))

# Both the training data and test data contain about 13 percent spam. This suggests
# that the spam messages were divided evenly between the two datasets.
# Visualizing text data - word clouds
# A word cloud is a way to visually depict the frequency at which words appear in
# text data.

#install.packages("wordcloud")
library(wordcloud)

wordcloud(smsData_corpus_clean,
          min.freq = 50,
          random.order = FALSE)
# This will create a word cloud from our prepared SMS corpus. Since we specified
# random.order = FALSE, the cloud will be arranged in a nonrandom order with higher
# frequency words placed closer to the center
# The min.freq parameter specifies the
# number of times a word must appear in the corpus before it will be displayed in the
# cloud. Since a frequency of 50 is about 1 percent of the corpus, this means that a word
# must be found in at least 1 percent of the SMS messages to be included in the cloud.
# A perhaps more interesting visualization involves comparing the clouds for SMS
# spam and ham. Since we did not construct separate corpora for spam and ham,
# this is an appropriate time to note a very helpful feature of the wordcloud()
# function. Given a vector of raw text strings, it will automatically apply common text
# preparation processes before displaying the cloud.
# Let's use R's subset() function to take a subset of the sms_raw data by the SMS
# type. First, we'll create a subset where the message type is spam:
spam <- subset(smsData,type=="spam")
ham <- subset(smsData,type=="ham")
# We now have two data frames, spam and ham, each with a text feature containing
# the raw text strings for SMSes. Creating word clouds is as simple as before. This
# time, we'll use the max.words parameter to look at the 40 most common words in
# each of the two sets. The scale parameter allows us to adjust the maximum and
# minimum font size for words in the cloud. Feel free to adjust these parameters as
# you see fit. This is illustrated in the following commands:
wordcloud(spam$text,max.words = 40,scale = c(3,0.5))

wordcloud(ham$text,max.words = 40,scale = c(3,0.5))

# Data preparation - creating indicator features for
# frequent words
# The final step in the data preparation process is to transform the sparse matrix into a
# data structure that can be used to train a Naive Bayes classifier. Currently, the sparse
# matrix includes over 6,500 features; this is a feature for every word that appears in at
# least one SMS message. It's unlikely that all of these are useful for classification. To
# reduce the number of features, we will eliminate any word that appear in less than five
# SMS messages, or in less than about 0.1 percent of the records in the training data.
# Finding frequent words requires use of the findFreqTerms() function in the
# tm package. This function takes a DTM and returns a character vector containing
# the words that appear for at least the specified number of times. For instance,
# the following command will display the words appearing at least five times in
# the sms_dtm_train matrix:
frequent_terms <- findFreqTerms(sms_dtm_train,5)
# We now need to filter our DTM to include only the terms appearing in a specified
# vector. As done earlier, we'll use the data frame style [row, col] operations to
# request specific portions of the DTM, noting that the columns are named after the
# words the DTM contains. We can take advantage of this to limit the DTM to specific
# words. Since we want all the rows, but only the columns representing the words in
# the sms_freq_words vector, our commands are
sms_dtm_freq_train <- sms_dtm_train[,frequent_terms]
sms_dtm_freq_test <- sms_dtm_test[,frequent_terms]
# The training and test datasets now include 1,136 features, which correspond to
# words appearing in at least five messages.
# The Naive Bayes classifier is typically trained on data with categorical features.
# This poses a problem, since the cells in the sparse matrix are numeric and measure
# the number of times a word appears in a message. We need to change this to a
# categorical variable that simply indicates yes or no depending on whether the
# word appears at all.
# The following defines a convert_counts() function to convert counts to
# Yes/No strings:
convert_counts <- function(x){
  x <- ifelse(x > 0,"Yes","No")
}
# The first
# line defines the function. The ifelse(x > 0, "Yes", "No") statement transforms
# the values in x, so that if the value is greater than 0, then it will be replaced by "Yes",
# otherwise it will be replaced by a "No" string. Lastly, the newly transformed x vector
# is returned.
# We now need to apply convert_counts() to each of the columns in our sparse
# matrix. You may be able to guess the R function to do exactly this. The function
# is simply called apply() and is used much like lapply() was used previously.
# The apply() function allows a function to be used on each of the rows or columns
# in a matrix. It uses a MARGIN parameter to specify either rows or columns. Here,
# we'll use MARGIN = 2, since we're interested in the columns (MARGIN = 1 is used
#                                                              for rows). The commands to convert the training and test matrices are as follows:
sms_train <- apply(sms_dtm_freq_train,MARGIN = 2,
                   convert_counts)
sms_test <- apply(sms_dtm_freq_test,MARGIN = 2,
                  convert_counts)
# The result will be two character type matrixes, each with cells indicating "Yes" or
# "No" for whether the word represented by the column appears at any point in the
# message represented by the row.
# Step 3 - training a model on the data
#The Naive Bayes implementation we will employ is in the e1071 package

library(e1071)
#To build our model on the sms_train matrix, we'll use the following command
sms_classifier <- naiveBayes(sms_train,sms_train_labels)
# The sms_classifier object now contains a naiveBayes classifier object that can be
# used to make predictions
#Step 4 - evaluating model performance
# To evaluate the SMS classifier, we need to test its predictions on unseen messages
# in the test data. Recall that the unseen message features are stored in a matrix
# named sms_test, while the class labels (spam or ham) are stored in a vector named
# sms_test_labels. The classifier that we trained has been named sms_classifier.
# We will use this classifier to generate predictions and then compare the predicted
# values to the true values.
# The predict() function is used to make the predictions. We will store these in a
# vector named sms_test_pred. We will simply supply the function with the names
# of our classifier and test dataset, as shown:
sms_test_pred <- predict(sms_classifier,sms_test)
# To compare the predictions to the true values, we'll use the CrossTable() function
# in the gmodels package, which we used previously. This time, we'll add some
# additional parameters to eliminate unnecessary cell proportions and use the dnn
# parameter (dimension names) to relabel the rows and columns, as shown in the
# following code:

#installed.packages("gmodels")
library(gmodels)
CrossTable(sms_test_pred,sms_test_labels,
           prop.chisq = FALSE,
           prop.t = FALSE,
           dnn = c("predicted","actual"))

# Looking at the table, we can see that a total of only 6 + 30 = 36 of the 1,390 SMS
# messages were incorrectly classified (2.6 percent). Among the errors were 6 out
# of 1,207 ham messages that were misidentified as spam, and 30 of the 183 spam
# messages were incorrectly labeled as ham. Considering the little effort we put
# into the project, this level of performance seems quite impressive. This case study
# exemplifies the reason why Naive Bayes is the standard for text classification;
# directly out of the box, it performs surprisingly well.
# On the other hand, the six legitimate messages that were incorrectly classified
# as spam could cause significant problems for the deployment of our filtering
# algorithm, because the filter could cause a person to miss an important text message.
# We should investigate to see whether we can slightly tweak the model to achieve
# better performance.
# Step 5 - improving model performance
# You may have noticed that we didn't set a value for the Laplace estimator while
# training our model. This allows words that appeared in zero spam or zero ham
# messages to have an indisputable say in the classification process. Just because the
# word "ringtone" only appeared in the spam messages in the training data, it does
# not mean that every message with this word should be classified as spam.
# We'll build a Naive Bayes model as done earlier, but this time set laplace = 1:
sms_classifier2 <- naiveBayes(sms_train,sms_train_labels,
                              laplace=1)
sms_test_pred2 <- predict(sms_classifier2,sms_test)
CrossTable(sms_test_pred2,sms_test_labels,
           prop.chisq = FALSE,prop.t = FALSE,
           prop.r = FALSE,
           dnn = c("Predicted","Actual"))

# Adding the Laplace estimator reduced the number of false positives (ham messages
#                                                                     erroneously classified as spam) from six to five and the number of false negatives
# from 30 to 28. Although this seems like a small change, it's substantial considering
# that the model's accuracy was already quite impressive. We'd need to be careful
# before tweaking the model too much in order to maintain the balance between being
# overly aggressive and overly passive while filtering spam. Users would prefer that a
# small number of spam messages slip through the filter than an alternative in which
# ham messages are filtered too aggressively.