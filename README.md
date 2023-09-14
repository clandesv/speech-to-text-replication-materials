# From Voice to Words: Speech-to-Text Algorithms for Open-Ended Survey Data

Explore this repository for replication materials for our research paper titled "From Voice to Words: Speech-to-Text Algorithms for Open-Ended Survey Data"



---

## Abstract

With the increasing frequency of surveys being conducted via smartphones and tablets, the option of audio responses for providing free text responses has become more popular in research. This approach aims to improve the user experience of respondents and the quality of their answers. To circumvent the tedious task of transcribing each audio recording for analysis most previous studies have used the Google Cloud ASR service to convert audio data to text without exploring other ASR systems. Often, their rationale for use was based on a single study that may not always have been relevant to their research subject. Extending previous research, we benchmark the Google Cloud ASR service with state-of-the-art ASR systems from Meta (wav2vec 2.0), Nvidia (NeMo), and OpenAI (Whisper). To do so, we use 100 randomly selected and recorded open-ended responses from respondents, which include various self-reported responses from popular social survey programs. Additionally, we provide a basic, easy-to-understand introduction on how the Whisper ASR system works as well as code for implementation in Python. By comparing Word Error Rates, we show that the Google Cloud ASR service is outperformed by almost all ASR systems, highlighting the need to also consider other systems to obtain more accurate transcripts on which the underlying research is based on.


The paper can be found here: https://docs.google.com/document/d/1bSGFUSpyonmQNd_QB3ybvHdL06Xz0K4ydXloTMVhPnI


---

## License
Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

