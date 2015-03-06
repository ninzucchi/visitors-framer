# This imports all the layers for "framer-tutorial-beta" into framerTutorialBetaLayers1
sketch = Framer.Importer.load "imported/framer-tutorial-beta"

# Artboard Setup
# Only the first artboard is visible by default, so we have to manually show the others
sketch.artboardB.visible = true
#sketch.artboardC.visible = true

# Artboards automatically import at (0,0), but we want them offscreen
# This code pushes each artboard off screen to the right.
sketch.artboardB.x = sketch.artboardA.maxX
sketch.artboardC.x = sketch.artboardB.maxX

logo = sketch.logoIcon

logo.animate
    properties:
        rotation: 360
    curve: linear
    repeat: 99
    time: 1

# Define a set of states with names (the original state is 'default')
logo.states.add
	second: {y:100, scale:0.6, rotationZ:100}
	third:  {y:300, scale:1.3, blur:4}
	fourth: {y:200, scale:0.9, blur:2, rotationZ:200}

# Set the default animation options
logo.states.animationOptions =
	curve: "spring(500,12,0)"

# On a click, go to the next state
logo.on Events.Click, ->
	logo.states.next()

#
#
#
#
#
#
# We store some variables to use later on.
screenWidth = Framer.Device.screen.width
screenHeight = Framer.Device.screen.height
startPosition = 0

# We set up a container holding all of our artboards.
# Its width is set to 3x the screenWidth, because we have 3 screens to swipe between.
screenContainer = new Layer width:(screenWidth*3), height:screenHeight, backgroundColor: "transparent"

# Make it only horizontally draggable
screenContainer.draggable.enabled = true
screenContainer.draggable.speedY = 0

# Adding states for each screen and its position
screenContainer.states.add 
	screen1: {x:0}
	screen2: {x:-screenWidth}
	screen3: {x:-screenWidth*2}
	
# We're defining a nice bouncy animation curve and switch to the first screen.
screenContainer.states.animationOptions = curve: "spring(200,20,0)"
screenContainer.states.switch "screen1"

# Storing all of our artboards within an array
screens = [sketch.contentA, sketch.artboardB, sketch.artboardC]

# We're looping over our array and placing each artboard within our container
for screen in screens
	screen.superLayer = screenContainer 
	
# Grabbing the startPosition of each dragging instance
screenContainer.on Events.DragStart, -> startPosition = this.x

# When we release, we calculate our dragging distance and set the states accordingly.
screenContainer.on Events.DragEnd, ->
	distance = startPosition - this.x
	startState = this.states.state
	
	# If we haven't dragged past 1/4th of our screenWidth, stay at screen1.
	if Math.abs(distance) < (750/4) then this.states.switch startState
	else 
		# If we're dragging to the right and we're not at the last screen, go to next.
		if distance > 0 and startState isnt "screen3" then this.states.next()
		# If we're dragging to the left and we're not at the first screen, go to previous.
		else if distance < 0 and startState isnt "screen1" then this.states.previous()
		# Otherwise, stay at our current screen
		else this.states.switch startState 