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



### Prepare Data ----
# 1. Import human generated transcripts from (Gdrive) ----
# 2. Import machine generated transcripts (local) ----
# 3. Merge human and machine generated transcripts

# 1. ----
# note: update local copy of this file when we made changes on gdrive!!
#human_transcripts <- readxl::read_excel("./human-transcripts-agreementCoder1+2+3.xlsx")

# 2. ----
# machine_transcripts <-
#   read.csv("../2022_work-life-politics/main study/Paper Text-Audio/Submission 1 (SRM)/data/data_long.csv") %>%
#   filter(condition == "audio") %>%
#   select(
#     c(
#       "ID_participant_long",
#       "transcript_wav2vec_base",
#       "transcript_wav2vec_large",
#       "transcript_google",
#       "transcript_whisper",
#       "transcript_whisper_medium",
#       "transcript_nvidia_xxlarge"
#     )
#   )


# 3. ----
#transcripts_human_machine <- merge(human_transcripts[,c(1,14)], machine_transcripts, by="ID_participant_long", all.x=TRUE)

# remove row 45 since transcriber could not infer what was said in the audio file
# transcripts_human_machine <- transcripts_human_machine %>%
#   filter(ID_participant_long != "life_satisfaction_5e7146ee69a3f1061774803b")

#write_csv(transcripts_human_machine, "../2022_work-life-politics/main study/Paper Text-Audio/Submission 1 (SRM)/data/transcripts/transcript-data.csv")
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



# visualize differences in transcriptions
diffChr(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_wav2vec_base_harm)
diffChr(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_wav2vec_large_harm)
diffChr(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_google_harm)
diffChr(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_whisper_medium_harm)
diffChr(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_whisper_large_harm)
diffChr(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, transcripts_human_machine$transcript_nvidia_xxlarge_harm)




# raw comparison of whisper medium & whisper large
#diffChr(transcripts_human_machine$transcript_whisper_medium, transcripts_human_machine$transcript_whisper_large)

# calculate WER (word error rate)
reference_corpus = corpus(transcripts_human_machine$transcript_coder1_coder2_coder3_harm, remove = is.na(transcripts_human_machine$transcript_coder1_coder2_coder3_harm))

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
  geom_text(label = paste0(Avg_Wer$Avg_WER*100, "%"), vjust = -1) +
  scale_y_continuous(labels=scales::percent, limits = c(0, 0.25), breaks = c(0, 0.025, 0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25)) +
  ylab("Average WER") +
  xlab("ASR systems") + 
  theme_minimal() +
  theme(legend.position = "none") 



#setwd("../2022_work-life-politics/main study/Paper Text-Audio/Submission 1 (SRM)/data/transcripts")
# 
# write.xlsx(Avg_Wer, file = "WER_of_transcripts.xlsx",
#            sheetName = "Comparison Avg. WER", append = FALSE)
# 
# write.xlsx(Wer_wav2vec_base, file = "WER_of_transcripts.xlsx",
#            sheetName = "Manually vs. Wav2vec (base-960h)", append = TRUE)
# 
# write.xlsx(Wer_wav2vec_large, file = "WER_of_transcripts.xlsx",
#            sheetName = "Manually vs. Wav2vec (large-960h-lv60-self)", append = TRUE)
# 
# write.xlsx(Wer_Google, file = "WER_of_transcripts.xlsx",
#            sheetName = "Manually vs. Google", append = TRUE)
# 
# write.xlsx(Wer_Whisper_medium, file = "WER_of_transcripts.xlsx",
#            sheetName = "Manually vs. Whisper (medium)", append = TRUE)
# 
# write.xlsx(Wer_Whisper_large, file = "WER_of_transcripts.xlsx",
#            sheetName = "Manually vs. Whisper (large)", append = TRUE)
# 
# write.xlsx(Wer_Nvidia_xxlarge, file = "WER_of_transcripts.xlsx",
#            sheetName = "Manually vs. Nvidia NeMo (xxlarge)", append = TRUE)