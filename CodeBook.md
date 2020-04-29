---
title: "Code Book Peer Graded Project"
author: "Millfield19"
date: "Apr, 29, 2019"
---


#Code Book
#Introduction
This is the Code Book for the peer graded assignemnt of the courserea course "Getting and cleaing data". For the project the data was provided with a link in the link description. The requirements that this code should do was in the project description as well.

##Input
The all the input was stored in the "data" folder. If this is not existing the code will create one. If the .zip file which contains the data was not present the code will download it. If the .zip file is unzipt the code will unzip it.

As input was used x_train.txt, x_test.txt, y_train.txt, y_test.txt, subject_train.txt and subject_test.txt which contained the data.

The file features.txt contains the names for the file before mentioned. While the first row subject is the the last row the activity. The activity is a coded with numbers the key to those numbers is saved in activity_labels.


##Processing

First all data will be read in and a file with all data is created. After that the big data file is labeled. The means and the standart deviations are extracted from the file. The number code for the activities is match with the readable activity. A tidy datafile is created and saved in the project environment. More on the Output section.

##Output

Th code produces a .txt file called tidydata. The first collumn contains the subject that produced the data. The collums 2-67 contains the features averages and standart deviation. The last row contains the corresbonding activity. 