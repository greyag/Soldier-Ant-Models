globals [
  cavity-visual-size
  ]

patches-own [ 
  cavity?         ;;true on cavities, false elsewhere
  cavity-number   ;;number (1-16), all patches in a cavity have the same number
  home?           ;;true on home cavity
  number-of-guards;;number, tells number of guards on cavity that patch belongs to
  ;; types of cavities, large/small relates to volume, wide/narrow relates to entrance size
  large?          ;;true when cavity large, false when small
  narrow?         ;;true when cavity narrow, false when wide
  ]

turtles-own [
  guard?          ;;true when guarding, false when exploring
  ]

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
  set cavity-visual-size 2
  let grid-coords create-grid-coords
  ask patches
  [
    setup-cavity-locations grid-coords
    setup-cavity-types
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
  if distancexy (first ?) (last ?) < cavity-visual-size
    [set cavity-number ((position ? possible-coordinate-list) + 1)]
  ]
  set pcolor (scale-color red cavity-number 0 16)
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
  set num-ants 10
  set-default-shape turtles "bug"
  ;;print start-place
  ;;type [pxcor] of start-place
  crt num-ants
  [
    set size 3
    set color orange ;; color when exploring
    set guard? false
    let start-place one-of (patches with [home? = TRUE])
    setxy ([pxcor] of start-place) ([pycor] of start-place)
  ]
end
  
