### Setup ----
library(pacman)

#devtools::install_github("jenswaeckerle/wersim")

pacman::p_load(tidyverse,
               stringr,
               textclean,
               diffobj,
               readxl,
               quanteda,
               wersim,
               xlsx,
               ggplot2)


### Import data that contains all machine generated data as well as the human generated version

transcripts_human_machine <- read.csv("./transcript-data.csv")


### Harmonization ----

# replace all ´ with ' in transcript_coder1_coder2_coder3
transcripts_human_machine$transcript_coder1_coder2_coder3  <- str_replace_all(transcripts_human_machine$transcript_coder1_coder2_coder3, "´", "'")

# remove punctuation except for apostrophes 
transcripts_human_machine$transcript_coder1_coder2_coder3_harm   <- gsub("[^[:alnum:]['-]", " ", transcripts_human_machine$transcript_coder1_coder2_coder3)
transcripts_human_machine$transcript_wav2vec_base_harm           <- gsub("[^[:alnum:]['-]", " ", transcripts_human_machine$transcript_wav2vec_base)
transcripts_human_machine$transcript_wav2vec_large_harm          <- gsub("[^[:alnum:]['-]", " ", transcripts_human_machine$transcript_wav2vec_large)
transcripts_human_machine$transcript_google_harm                 <- gsub("[^[:alnum:]['-]", " ", transcripts_human_machine$transcript_google)
transcripts_human_machine$transcript_whisper_medium_harm         <- gsub("[^[:alnum:]['-]", " ", transcripts_human_machine$transcript_whisper_medium)
transcripts_human_machine$transcript_whisper_large_harm          <- gsub("[^[:alnum:]['-]", " ", transcripts_human_machine$transcript_whisper)
transcripts_human_machine$transcript_nvidia_xxlarge_harm         <- gsub("[^[:alnum:]['-]", " ", transcripts_human_machine$transcript_nvidia_xxlarge)

# remove whitespace at the beginning or ending of a sentence, and all internal whitespaces with a single space 
transcripts_human_machine$transcript_coder1_coder2_coder3_harm   <- str_squish(transcripts_human_machine$transcript_coder1_coder2_coder3_harm)
transcripts_human_machine$transcript_wav2vec_base_harm           <- str_squish(transcripts_human_machine$transcript_wav2vec_base_harm)
transcripts_human_machine$transcript_wav2vec_large_harm          <- str_squish(transcripts_human_machine$transcript_wav2vec_large_harm)
transcripts_human_machine$transcript_google_harm                 <- str_squish(transcripts_human_machine$transcript_google_harm)
transcripts_human_machine$transcript_whisper_medium_harm         <- str_squish(transcripts_human_machine$transcript_whisper_medium_harm)
transcripts_human_machine$transcript_whisper_large_harm          <- str_squish(transcripts_human_machine$transcript_whisper_large_harm)
transcripts_human_machine$transcript_nvidia_xxlarge_harm         <- str_squish(transcripts_human_machine$transcript_nvidia_xxlarge_harm)


# convert all strings to lowercase 
transcripts_human_machine$transcript_coder1_coder2_coder3_harm   <- tolower(transcripts_human_machine$transcript_coder1_coder2_coder3_harm)
transcripts_human_machine$transcript_wav2vec_base_harm           <- tolower(transcripts_human_machine$transcript_wav2vec_base_harm)
transcripts_human_machine$transcript_wav2vec_large_harm          <- tolower(transcripts_human_machine$transcript_wav2vec_large_harm)
transcripts_human_machine$transcript_google_harm                 <- tolower(transcripts_human_machine$transcript_google_harm)
transcripts_human_machine$transcript_whisper_medium_harm         <- tolower(transcripts_human_machine$transcript_whisper_medium_harm)
transcripts_human_machine$transcript_whisper_large_harm          <- tolower(transcripts_human_machine$transcript_whisper_large_harm)
transcripts_human_machine$transcript_nvidia_xxlarge_harm         <- tolower(transcripts_human_machine$transcript_nvidia_xxlarge_harm)

# replaces numeric represented numbers with words
transcripts_human_machine$transcript_coder1_coder2_coder3_harm   <- replace_number(transcripts_human_machine$transcript_coder1_coder2_coder3_harm)
transcripts_human_machine$transcript_wav2vec_base_harm           <- replace_number(transcripts_human_machine$transcript_wav2vec_base_harm)
transcripts_human_machine$transcript_wav2vec_large_harm          <- replace_number(transcripts_human_machine$transcript_wav2vec_large_harm)
transcripts_human_machine$transcript_google_harm                 <- replace_number(transcripts_human_machine$transcript_google_harm)
transcripts_human_machine$transcript_whisper_medium_harm         <- replace_number(transcripts_human_machine$transcript_whisper_medium_harm)
transcripts_human_machine$transcript_whisper_large_harm          <- replace_number(transcripts_human_machine$transcript_whisper_large_harm)
transcripts_human_machine$transcript_nvidia_xxlarge_harm         <- replace_number(transcripts_human_machine$transcript_nvidia_xxlarge_harm)



find <- c("-"                 ,
          "\\<gonna\\>"       ,
          "\\<tryna\\>"       ,
          "\\<wanna\\>"       ,
          "\\<gotta\\>"       ,
          "\\<kinda\\>"       ,
          "\\<cuz\\>"         ,
          "'ll"               ,
          "'ve"               ,
          "'s"                ,
          "'re"               ,
          "'m"                ,
          "\\<isn't\\>"       ,
          "\\<aren't\\>"      ,
          "\\<wasn't\\>"      ,
          "\\<weren't\\>"     ,
          "\\<hasn't\\>"      ,
          "\\<haven't\\>"     ,
          "\\<hadn't\\>"      ,
          "\\<don't\\>"       ,
          "\\<doesn't\\>"     ,
          "\\<didn't\\>"      ,
          "\\<can't\\>"       ,
          "\\<couldn't\\>"    ,
          "\\<could've\\>"    ,
          "\\<wouldn't\\>"    ,
          "\\<let's\\>"       ,
          "\\<mustn't\\>"     ,
          "\\<should've\\>"   ,
          "\\<shouldn't\\>"   ,
          "\\<won't\\>"       ,
          "\\<50s\\>"         ,
          "\\<um\\>"          ,
          "\\<oh\\>"          ,
          "\\<runnin\\>"      ,
          "\\<comin\\>"       ,
          "\\<doin\\>"        ,
          "\\<goin\\>"        ,
          "\\<givin\\>"       ,
          "\\<whats\\>"       ,
          "\\<thats\\>"       ,
          "\\<uh\\>"          ,
          "\\<ah\\>"          ,
          "\\<helpin'\\>"      )


replacement <- c(" "          ,
                 "going to"   ,
                 "trying to"  ,
                 "want to"    ,
                 "got to"     ,
                 "kind of"    ,
                 "because"    ,
                 " will"      ,
                 " have"      ,
                 " is"        ,
                 " are"       ,
                 " am"        ,
                 "is not"     ,
                 "are not"    ,
                 "was not"    ,
                 "were not"   ,
                 "has not"    ,
                 "have not"   ,
                 "had not"    ,
                 "do not"     ,
                 "does not"   ,
                 "did not"    ,
                 "cannot"     ,
                 "could not"  ,
                 "could have" ,
                 "would not"  ,
                 "let us"     ,
                 "must not"   ,
                 "should have",
                 "should not" ,
                 "will not"   ,
                 "fifties"    ,
                 ""           ,
                 ""           ,
                 "running"    ,
                 "coming"     ,
                 "doing"      ,
                 "going"      ,
                 "giving"     ,
                 "what is"    ,
                 "that is"    ,
                 ""           ,
                 ""           ,
                 "helping"     )
                 
                 

for (i in 9:15){
  
  for (t in 1:length(find)){

  transcripts_human_machine[i] <- lapply(transcripts_human_machine[i], gsub, pattern = find[t], replacement = replacement[t])
  
  
  }
}


# remove multiple whitespaces 
transcripts_human_machine$transcript_coder1_coder2_coder3_harm   <- gsub("\\s+"," ", transcripts_human_machine$transcript_coder1_coder2_coder3_harm )
transcripts_human_machine$transcript_wav2vec_base_harm           <- gsub("\\s+"," ", transcripts_human_machine$transcript_wav2vec_base_harm  )
transcripts_human_machine$transcript_wav2vec_large_harm          <- gsub("\\s+"," ", transcripts_human_machine$transcript_wav2vec_large_harm )
transcripts_human_machine$transcript_google_harm                 <- gsub("\\s+"," ", transcripts_human_machine$transcript_google_harm        )
transcripts_human_machine$transcript_whisper_medium_harm         <- gsub("\\s+"," ", transcripts_human_machine$transcript_whisper_medium_harm)
transcripts_human_machine$transcript_whisper_large_harm          <- gsub("\\s+"," ", transcripts_human_machine$transcript_whisper_large_harm )
transcripts_human_machine$transcript_nvidia_xxlarge_harm         <- gsub("\\s+"," ", transcripts_human_machine$transcript_nvidia_xxlarge_harm)





### Analysis ----

# calculate WER (word error rate)
reference_corpus = corpus(transcripts_human_machine$transcript_coder1_coder2_coder3_harm)

hypothesis_corpus_wav2vec_base    = corpus(transcripts_human_machine$transcript_wav2vec_base_harm)
hypothesis_corpus_wav2vec_large   = corpus(transcripts_human_machine$transcript_wav2vec_large_harm)
hypothesis_corpus_google          = corpus(transcripts_human_machine$transcript_google_harm)
hypothesis_corpus_whisper_medium  = corpus(transcripts_human_machine$transcript_whisper_medium_harm)
hypothesis_corpus_whisper_large   = corpus(transcripts_human_machine$transcript_whisper_large_harm)
hypothesis_corpus_nvidia_xxlarge  = corpus(transcripts_human_machine$transcript_nvidia_xxlarge_harm)


# bind WERs and corresponding transcripts_human_machine into one data frame.
Wer_wav2vec_base    <- cbind(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_wav2vec_base_harm, wer(r=reference_corpus,h=hypothesis_corpus_wav2vec_base))
Wer_wav2vec_large   <- cbind(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_wav2vec_large_harm, wer(r=reference_corpus,h=hypothesis_corpus_wav2vec_large))
Wer_Google          <- cbind(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_google_harm, wer(r=reference_corpus,h=hypothesis_corpus_google))
Wer_Whisper_medium  <- cbind(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_whisper_medium_harm, wer(r=reference_corpus,h=hypothesis_corpus_whisper_medium))
Wer_Whisper_large   <- cbind(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_whisper_large_harm, wer(r=reference_corpus,h=hypothesis_corpus_whisper_large))
Wer_Nvidia_xxlarge  <- cbind(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_nvidia_xxlarge_harm, wer(r=reference_corpus,h=hypothesis_corpus_nvidia_xxlarge))

# Mean Scores
mean(Wer_wav2vec_base$wer)
#[1] 0.2114907
mean(Wer_wav2vec_large$wer)
#[1] 0.1081011
mean(Wer_Google$wer)
#[1] 0.1334105
mean(Wer_Whisper_medium$wer)
#[1] 0.05636567
mean(Wer_Whisper_large$wer)
#[1] 0.04672335
mean(Wer_Nvidia_xxlarge$wer)
#[1] 0.07178783


# construct output for comparison of all ASR models
Avg_Wer <- data.frame("Names_ASR_systems" = c("wav2vec (base-960h)", 
                                              "wav2vec (large-960h-lv60-self)",
                                              "Google",
                                              "Whisper (medium)",
                                              "Whisper (large)",
                                              "Nvidia NeMo (xxlarge)"),
                      "Avg_WER" = c(mean(Wer_wav2vec_base$wer), 
                                    mean(Wer_wav2vec_large$wer), 
                                    mean(Wer_Google$wer), 
                                    mean(Wer_Whisper_medium$wer), 
                                    mean(Wer_Whisper_large$wer),
                                    mean(Wer_Nvidia_xxlarge$wer)))


Avg_Wer <- Avg_Wer %>%
  arrange(desc(Avg_WER)) %>%
  mutate(Avg_WER = round(Avg_WER, digits = 3))


# plot WERs

Avg_Wer %>%
  mutate(Names_ASR_systems = reorder(Names_ASR_systems, -Avg_WER)) %>%
  ggplot(., aes(x = reorder(Names_ASR_systems, -Avg_WER), y = Avg_WER, fill = Names_ASR_systems)) + 
  geom_bar(stat = "identity", width = 0.5) + 
  geom_text(label = paste0(Avg_Wer$Avg_WER*100, "%"), vjust = -1, size=4, color = "black") +
  scale_y_continuous(labels=scales::percent, limits = c(0, 0.25), breaks = c(0, 0.025, 0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25)) +
  ylab("Average WER") +
  xlab("ASR systems") + 
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1)  # Rotate x-axis labels
  )

