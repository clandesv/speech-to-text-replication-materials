# Comparing Speech-to-Text Algorithms for Transcribing Voice Data from Surveys

Explore this repository for replication materials for our research paper titled "Comparing Speech-to-Text Algorithms for Transcribing Voice Data from Surveys".

## This Repository

This repository contains different instances of files which enable to replicate the results, figures and plots displayed in the research paper.

### Figures
The jupyter file "infographs-paper.ipynb" can load any wav-format file to create figures like the first three in the paper (Figure 1-3). The first visualizes the waveform of an audiofile. Figure 2 displays the waveform and time ranges (frames). The third figure creates a Mel Spectrogram.

### Plot
The barplot (Figure 4) displaying the Word-Error-Rates by ASR System as well as the average Word-Error-Rates in section "Results" is created by "code-main.R" file. The corresponding dataset in csv-format used here is called "transcript-data.csv".

### Sample Description
The sample is described in section "Data" with additional information (age, educational level and difficulty of survey). The corresponding mean and standard deviation values are calculated in "sample-description.R" by loading the csv-formatted dataset "sample-description-data.csv".

### Code for Automated Speech Recognition
The original Python (and R) code used for applying various ASR systems to our data can be found in the "code for ASR" subfolder of this repository.

---

## Abstract

With the increasing frequency of surveys being conducted via smartphones and tablets, the option of audio responses for providing open-ended responses has become more popular in research. This approach aims to improve the user experience of respondents and the quality of their answers. To circumvent the tedious task of transcribing each audio recording for analysis most previous studies have used the Google Cloud Automatic Speech Recognition (ASR) service to convert audio data to text without exploring other ASR systems. Extending previous research, we benchmark the Google Cloud ASR service with state-of-the-art ASR systems from Meta (wav2vec 2.0), Nvidia (NeMo), and OpenAI (Whisper). To do so, we use 100 randomly selected and recorded open-ended responses to popular social science survey questions. Additionally, we provide a basic, easy-to-understand introduction on how the Whisper ASR system works as well as code for implementation. By comparing Word Error Rates, we show that for our data the Google Cloud ASR service is outperformed by almost all ASR systems, highlighting the need to also consider other ASR systems.

The paper can be found on OSF: https://osf.io/preprints/socarxiv/vk6wj


---

## License
Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

