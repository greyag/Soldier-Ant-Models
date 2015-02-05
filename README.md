# Soldier-Ant-Models

This repository will hold the code for my MCB Thesis Project.

The format of the files in this repository will mostly be netlogo models, named Model-#.nlogo, and text files that describe the model using the ODD protocol, named ODD-Protocol-Model-#.txt. To understand the purpose and functionality of the model, I recommend reading the protocol first before jumping into the code.

BACKGROUND:
Colonies of ants in the Cephalotes genus live in cavities that were originally made by beetles in trees. A colony lives in many cavities at once. They also have a type of worker ant called a "soldier ant." The soldier ants defend these cavities using their large, tough, sheild-like heads. 

At the beginning of spring, the colony awakes from its hibernation. While it hibernated, the colony lived compactly in a small number of cavities. During the spring/summer, the colony wants to control as much cavity space as possible, as cavities are used to store brood (ant eggs/larvae/babies) and store food, so the total volume of cavities that a colony holds is directly related to the colony's fitness. The cavities need to be defended because other species (often other ants) on the same tree also want to have a set of quality cavities, and because the brood and food stored in the cavity are valuable resources. 

When the colony wakes up, the soldier ants want to quickly find a set of cavities that they are able to defend and that will maximize the colony fitness. Large cavities increase colony fitness more than small cavities, because they are able to store more stuff. Soldier ants are also able to defend cavities with small entrances using fewer ants and with higher defensive success than they are able to defend cavities with large entrances. Thus, (we think) the best cavities for ants to choose are those with large volumes and small entrances. 

Soldier ants are able to complete this task to near optimal levels, despite having limited information and no top-down commands. The purpose of this project is to try and understand how they do that.

The implications of this research include any sort of problem where a finite resource needs to be distributed without using top-down commands. 
