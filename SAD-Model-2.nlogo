globals [
  cavity-visual-size
  cavity-1
  cavity-2
  cavity-3
  cavity-4
  cavity-5
  cavity-6
  cavity-7
  cavity-8
  cavity-9
  cavity-10
  cavity-11
  cavity-12
  cavity-13
  cavity-14
  cavity-15
  cavity-16
  
  ]

patches-own [ 
  cavity?         ;;true on cavities, false elsewhere
  cavity-number   ;;number (1-16), all patches in a cavity have the same number
  home?           ;;true on home cavity
  guarded?        ;;if cavity is guarded
  number-of-guards;;number, tells number of guards on cavity that patch belongs to
  ;; types of cavities, large/small relates to volume, wide/narrow relates to entrance size
  large?          ;;true when cavity large, false when small
  narrow?         ;;true when cavity narrow, false when wide
  ]

turtles-own [
  explore?        ;;only true when looking for a new cavity; only true on bark
  guard?          ;;true when guarding, false otherwise
  ]


;;;;;;;;;;;;;;;;;;;;;;;;
;;; Setup procedures ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

to setup
  ca
  if (large-narrow + large-wide + small-narrow + small-wide + 1) > 16
  [
    print "Too many cavities. Sum must be less than 16"
    stop
  ]
  setup-patches
  setup-turtles
  reset-ticks
end

to setup-patches
  set cavity-visual-size 1
  let grid-coords create-grid-coords
  ask patches
  [
    setup-cavity-locations grid-coords
    setup-cavity-types
    setup-cavity-sets
  ]
end

to-report create-grid-coords ;;global procedure
  let width-interval (world-width / 4)
  let height-interval (world-height / 4)
  let cav-a (list (min-pxcor + width-interval * .5) (min-pycor + height-interval * .5))
  let cav-b (list (min-pxcor + width-interval * 1.5) (min-pycor + height-interval * .5))
  let cav-c (list (min-pxcor + width-interval * 2.5) (min-pycor + height-interval * .5))
  let cav-d (list (min-pxcor + width-interval * 3.5) (min-pycor + height-interval * .5))
  let cav-e (list (min-pxcor + width-interval * .5) (min-pycor + height-interval * 1.5))
  let cav-f (list (min-pxcor + width-interval * 1.5) (min-pycor + height-interval * 1.5))
  let cav-g (list (min-pxcor + width-interval * 2.5) (min-pycor + height-interval * 1.5))
  let cav-h (list (min-pxcor + width-interval * 3.5) (min-pycor + height-interval * 1.5))
  let cav-i (list (min-pxcor + width-interval * .5) (min-pycor + height-interval * 2.5))
  let cav-j (list (min-pxcor + width-interval * 1.5) (min-pycor + height-interval * 2.5))
  let cav-k (list (min-pxcor + width-interval * 2.5) (min-pycor + height-interval * 2.5))
  let cav-l (list (min-pxcor + width-interval * 3.5) (min-pycor + height-interval * 2.5))
  let cav-m (list (min-pxcor + width-interval * .5) (min-pycor + height-interval * 3.5))
  let cav-n (list (min-pxcor + width-interval * 1.5) (min-pycor + height-interval * 3.5))
  let cav-o (list (min-pxcor + width-interval * 2.5) (min-pycor + height-interval * 3.5))
  let cav-p (list (min-pxcor + width-interval * 3.5) (min-pycor + height-interval * 3.5))
  let grid-coords (list cav-a cav-b cav-c cav-d cav-e cav-f cav-g cav-h 
    cav-i cav-j cav-k cav-l cav-m cav-n cav-o cav-p)
  set grid-coords shuffle grid-coords
  report grid-coords
end

to setup-cavity-locations [possible-coordinate-list];; patch procedure
  foreach possible-coordinate-list
  [
  if (abs(pxcor - (first ?))) < cavity-visual-size and (abs(pycor - (last ?))) < cavity-visual-size
    [set cavity-number ((position ? possible-coordinate-list) + 1)]
  ]
  ;;set pcolor (scale-color red cavity-number 0 16)
end

to setup-cavity-sets ;;patch procedure
  set cavity-1 patches with [cavity-number = 1]
  set cavity-2 patches with [cavity-number = 2]
  set cavity-3 patches with [cavity-number = 3]
  set cavity-4 patches with [cavity-number = 4]
  set cavity-5 patches with [cavity-number = 5]
  set cavity-6 patches with [cavity-number = 6]
  set cavity-7 patches with [cavity-number = 7]
  set cavity-8 patches with [cavity-number = 8]
  set cavity-9 patches with [cavity-number = 9]
  set cavity-10 patches with [cavity-number = 10]
  set cavity-11 patches with [cavity-number = 11]
  set cavity-12 patches with [cavity-number = 12]
  set cavity-13 patches with [cavity-number = 13]
  set cavity-14 patches with [cavity-number = 14]
  set cavity-15 patches with [cavity-number = 15]
  set cavity-16 patches with [cavity-number = 16]
end

to setup-cavity-types
  set cavity? FALSE
  set pcolor brown
  set home? FALSE
  set large? FALSE
  set narrow? FALSE
  
  if cavity-number <= (large-narrow + large-wide)
    [set large? TRUE]
  if cavity-number <= large-narrow
    [set narrow? TRUE]
  if ((cavity-number > large-narrow + large-wide) and 
     (cavity-number <= large-narrow + large-wide + small-narrow))
    [set narrow? TRUE]
  if cavity-number = large-narrow + large-wide + small-narrow + small-wide + 1
    [set home? TRUE]
  if (cavity-number <= large-narrow + large-wide + small-narrow + small-wide + 1)
     and cavity-number > 0
    [set cavity? TRUE]
    
  if cavity?
  [
    ifelse large?
      [ifelse narrow?
        [set pcolor black]
        [set pcolor blue]]
      [ifelse narrow?
        [set pcolor green]
        [set pcolor yellow]]
  ]
  if home?
    [set pcolor magenta]
end

to setup-turtles
  set-default-shape turtles "bug"
  ;;print start-place
  ;;type [pxcor] of start-place
  crt num-ants
  [
    set size cavity-visual-size * 2
    set color orange ;; color when exploring
    set guard? FALSE
    set explore? TRUE
    let start-place one-of (patches with [home? = TRUE])
    setxy ([pxcor] of start-place) ([pycor] of start-place)
  ]
end

;;;;;;;;;;;;;;;;;;;;;
;;; Go procedures ;;;
;;;;;;;;;;;;;;;;;;;;;

to go ;; forever button
  if ((turtles with [guard? = TRUE]) = turtles)
    [
      ;create output file
      file-open "SAD-Model2.csv"
      file-print date-and-time
      file-type "LN-percent,"
      file-type "LW-percent,"
      file-type "SN-percent,"
      file-print "SW-percent"
      file-type (word LN-percent ",")
      file-type (word LW-percent ",")
      file-type (word SN-percent ",")
      file-print (word SW-percent)
      file-type "Volume large?, "
      file-type "Entrance Size narrow?,"
      file-print "Number of Guards"
      let list-of-cavities (list cavity-1 cavity-2 cavity-3 cavity-4
        cavity-5 cavity-6 cavity-7 cavity-8
        cavity-9 cavity-10 cavity-11 cavity-12
        cavity-13 cavity-14 cavity-15 cavity-16)
      let patch-1 one-of cavity-1
      
      foreach list-of-cavities
      [
        set patch-1 one-of ?
        if [cavity?] of patch-1 = TRUE
        [
          file-type (word ([large?] of patch-1) ",")
          file-type (word ([narrow?] of patch-1) ",")
          file-print (word ([number-of-guards] of patch-1))
        ]
      ]
      file-close
      stop
    ]
  
  ask turtles
  [
    ifelse guard? = TRUE
    [ guard ]
    [ ifelse explore? = TRUE
      [ explore ]
      [ wiggle
        fd 1
        if [cavity?] of patch-here = FALSE
        [ set explore? TRUE ]
      ]
    ]
  ]
  
  ask patches
  [
    am-i-guarded
  ]
  
  tick
end

to explore ;;turtle procedure
  ifelse [cavity?] of patch-here = TRUE
  [ifelse ((patch-good-enough patch-here) = TRUE)
    [set guard? TRUE
     set color grey]
    [wiggle
     fd 1]]
  [wiggle
    fd 1]
  
end

to guard
  
end

to-report patch-good-enough [a-patch] ;; turtle procedure
  if ([large?] of a-patch = TRUE) and ([narrow?] of a-patch = TRUE)
  [
    ifelse (random-float 1 < LN-percent)
    [report TRUE]
    [report FALSE]
  ]
  if ([large?] of a-patch = TRUE) and ([narrow?] of a-patch = FALSE)
  [
    ifelse (random-float 1 < LW-percent)
    [report TRUE]
    [report FALSE]
  ]
  if ([large?] of a-patch = FALSE) and ([narrow?] of a-patch = TRUE)
  [
    ifelse (random-float 1 < SN-percent)
    [report TRUE]
    [report FALSE]
  ]
  if ([large?] of a-patch = FALSE) and ([narrow?] of a-patch = FALSE)
  [
    ifelse (random-float 1 < SW-percent)
    [report TRUE]
    [report FALSE]
  ]
end

to wiggle ;;turtle procedure
  rt random 40
  lt random 40
  if not can-move? 1 [ rt 180 ]
end

to-report my-cavity [cavityIDnumber]
  if cavityIDnumber = 1
  [report cavity-1]
  if cavityIDnumber = 2
  [report cavity-2]
  if cavityIDnumber = 3
  [report cavity-3]
  if cavityIDnumber = 4
  [report cavity-4]
  if cavityIDnumber = 5
  [report cavity-5]
  if cavityIDnumber = 6
  [report cavity-6]
  if cavityIDnumber = 7
  [report cavity-7]
  if cavityIDnumber = 8
  [report cavity-8]
  if cavityIDnumber = 9
  [report cavity-9]
  if cavityIDnumber = 10
  [report cavity-10]
  if cavityIDnumber = 11
  [report cavity-11]
  if cavityIDnumber = 12
  [report cavity-12]
  if cavityIDnumber = 13
  [report cavity-13]
  if cavityIDnumber = 14
  [report cavity-14]
  if cavityIDnumber = 15
  [report cavity-15]
  if cavityIDnumber = 16
  [report cavity-16]
end


to am-i-guarded ;;patch procedure
  if cavity? = TRUE
  [
    ;;print cavity-number
    ;;print my-cavity cavity-number
   let my-cavity-mates my-cavity cavity-number
   let turtles-on-cavity turtles-on my-cavity-mates
   let my-cavity-guards turtles-on-cavity with [guard? = TRUE]
   if any? my-cavity-guards
   [
     set guarded? TRUE
     set number-of-guards count my-cavity-guards
   ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
649
470
16
16
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
6
19
72
52
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
79
19
142
52
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
7
75
179
108
LN-percent
LN-percent
0
1
1
.01
1
NIL
HORIZONTAL

SLIDER
7
111
179
144
LW-percent
LW-percent
0
1
0.67
.01
1
NIL
HORIZONTAL

SLIDER
6
147
178
180
SN-percent
SN-percent
0
1
0.33
.01
1
NIL
HORIZONTAL

SLIDER
10
185
182
218
SW-percent
SW-percent
0
1
0
.01
1
NIL
HORIZONTAL

SLIDER
14
255
186
288
large-narrow
large-narrow
0
15
3
1
1
NIL
HORIZONTAL

SLIDER
14
293
186
326
large-wide
large-wide
0
15
3
1
1
NIL
HORIZONTAL

SLIDER
16
332
188
365
small-narrow
small-narrow
0
16
3
1
1
NIL
HORIZONTAL

SLIDER
17
372
189
405
small-wide
small-wide
0
16
3
1
1
NIL
HORIZONTAL

INPUTBOX
23
437
178
497
num-ants
200
1
0
Number

@#$#@#$#@
ODD Protocol for Soldier Ant Decisions – Model Number 2
by Greta Gadbois
February 17, 2015

##Purpose:

The purpose of this model is to explore the various ways soldier ants choose to or not to guard cavities during the process where the colony is expanding from one nest to many.

##Entities, State Variables, and Scales:

The model has two kinds of entities: soldier ants and cavities. The ants are characterized by their location and their current action, either exploring or guarding a cavity. When ants are exploring they move until they find a cavity. When they find a cavity, the ant can choose to guard the cavity, which means to stand still at the cavity. The cavities will appear in a grid formation, and each cavity can have either large or small volume and has an entrance that is either narrow or wide. They are also characterized by whether they are guarded or not, and if they are being guarded, by how many ants. In this model, all of the cavities will be appear to be the same size, despite the different volumes and entrance widths, so that each type will be found at the same rate by the ants. There is also one home cavity where all the ants are located at the beginning of the simulation. Ants will not be able to guard this cavity, as the soldier ants that I am representing in this model are only the deployed soldiers.

##Process, Overview, and Scheduling

During each time step, each ant will do one action, either guard a cavity, or explore. While the ant is guarding, it remains still located on the cavity. While an ant explores, it moves one step.  The order in which the ants execute their actions is unimportant because there are no interactions among the ants.

##Design Concepts:

The basic principle explored by this model is the emergence of an optimal or near optimal colonial defensive strategy from the simple behaviors of individual ants. This model hopes to show how ants choose to guard certain cavities to provide an optimal or near optimal set of sufficiently guarded cavities for the colony.

We will explore various decision making process for ants. In this iteration, we will use a based-on-percentages process, where the ant will decide to guard a cavity, when it finds one, and then, for each type of cavity, chooses to guard it some set percent of the time. The user will be able to change these percentages before setup. There is no learning in this model.

Sensing is important in this model. The ants will be able sense whether they have found a cavity, the size of that cavity, and the entrance size of that cavity.
This model does not include interactions between ants, including whether or not a cavity is already being guarded. Interactions may be added in later iterations.

Stochasticity is used in this model to randomize the locations of the various cavities on the grid. All cavities will be located at the intersections of a regular (and imaginary/invisible) 4x4 grid in order to be able to more easily compare the results of the model with previous ant experiments done by Powell and Dornhouse 2013. Stochasticity is also used during ant movement, while ants are exploring.

The collective of the colony is somewhat represented in this model. We show only the relevant ants in the colony, not the entire colony, with the expectation that from these ants, the colony’s defensive and reproductive fitnesses will emerge. 

We will collect information by outputting graphs at the end of the simulation that show (1) the number of ants at each defended cavity, and the (2) volume and (3) entrance width of those defended colonies. We will also be sure to keep track of the number and types of cavities that were available for expansion. With that information we will give the colony a rating of fitness, and also a rating of fitness vs. best possible fitness, as a way to compare this model to other ant decision-making models, as well as to real ants. The equation that we will use to find colony fitness and optimal colony fitness is given in Donaldson-Matasci 2014. 

##Initialization:

The location, size, and entrance width of each cavity is initialized when the model starts. The ants are initialized at the home cavity, facing a random direction.

##Input data:

The user will input the number of soldier ants, and the number of each type of empty cavity (large-narrow, large-wide, small-narrow, small-wide), where the combined number of empty cavities must not exceed 15.
The user will also input percentages (LN, LW, SN, SW), where, an ant, upon reaching a particular type of cavity, will chose to guard it the appropriate percentage of the time.

##Submodels:

Ant movement in the explore state will be random, and as done in the provided NetLogo Ant Foraging model, where at each time step the ant “wiggles” (turns right a random number of degrees less than or equal to 40, then turns left a random number of degrees less than or equal to 40) then moves forward one.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
