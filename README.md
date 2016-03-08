# Soldier-Ant-Models

This repository will hold the code for my MCB Thesis Project.

The format of the files in this repository will mostly be netlogo models, named SAD-Model-#.nlogo, and text files that describe the model using the ODD protocol, named ODD-Protocol-Model-#.txt. To understand the purpose and functionality of the model, I recommend reading the protocol first before jumping into the code.

BACKGROUND:
Colonies of ants in the Cephalotes genus live in cavities that were originally made by beetles in trees. A colony lives in many cavities at once. They also have a type of worker ant called a "soldier ant." The soldier ants defend these cavities using their large, tough, sheild-like heads. 

At the beginning of spring, the colony awakes from its hibernation. While it hibernated, the colony lived compactly in a small number of cavities. During the spring/summer, the colony wants to control as much cavity space as possible, as cavities are used to store brood (ant eggs/larvae/babies) and store food, so the total volume of cavities that a colony holds is directly related to the colony's fitness. The cavities need to be defended because other species (often other ants) on the same tree also want to have a set of quality cavities, and because the brood and food stored in the cavity are valuable resources. 

When the colony wakes up, the soldier ants want to quickly find a set of cavities that they are able to defend and that will maximize the colony fitness. Large cavities increase colony fitness more than small cavities, because they are able to store more stuff. Soldier ants are also able to defend cavities with small entrances using fewer ants and with higher defensive success than they are able to defend cavities with large entrances. Thus, (we think) the best cavities for ants to choose are those with large volumes and small entrances. 

Soldier ants are able to complete this task to near optimal levels, despite having limited information and no top-down commands. The purpose of this project is to try and understand how they do that.

The implications of this research include any sort of problem where a finite resource needs to be distributed without using top-down commands. 

THINGS OF NOTE IN THIS REPOSITORY:
All things of importance are in the folder Thesis. Blip blows along the way are in the folder Other. Many of the graphs used in my thesis are in the folder Graphs. 

SAD-Model-4.nlogo is the final version of the model, and the version that was used to do all of the testing.
SAD-Model4-all.Rmd is the R markdown file that was used to find the best set of rules.
Model4.Rmd is the R markdown file that was used to create bar-plots of how ants distribute themselves among 4 cavities. These plots are analogous to the ones Donaldson-Matasci used in her paper to show optimal ant distribution.
notEnoughTest.Rmd is the R markdown file that was used to analyze how changing not-enough affected the fitness of the colony. It created graphs about ant distribution and fitness


Data:
SAD-Model4-8.csv is the massive set of runs that was used to find the best set of rules.
SAD-Model4-11.csv is the set of runs that used the optimal parameters (low threat) to find how the ants behaved when choosing between wide and narrow entranced cavities (all large).
SAD-Model4-12.csv is the set of runs that used the optimal parameters (low threat) to find how the ants behaved when choosing between large and small volume cavities (all narrow entrance).
SAD-Model4-14.csv is the set of runs that used the optimal parameters with not-enough = 0.9.
Sad-Model4-15.csv is the set of runs that used the optimal parameters with not-enough = 0.1. 