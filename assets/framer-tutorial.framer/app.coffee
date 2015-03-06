# We store some variables to use later on.
screenWidth = Framer.Device.screen.width
screenHeight = Framer.Device.screen.height
startPosition = 0

# This imports all the layers for "framer-tutorial-beta" into framerTutorialBetaLayers1
sketch = Framer.Importer.load "imported/framer-tutorial-beta"

logo = sketch.logoIcon

# ----------------------------------------------------
# Animation Demo
# This animation will play continuously
# ----------------------------------------------------
#
# logo.animate
#     properties:
#         rotation: 360
#     curve: "linear"
#     repeat: 99
#     time: 1


# ----------------------------------------------------
# States Demo
# * Note that there is an implicit first state called 'default' * 
# ----------------------------------------------------
#
# logo.states.add
# 	pressed: {scale:0.9, rotationZ:45}
# 
# logo.states.animationOptions =
# 	curve: "spring(500,15,0)"
# 	
# logo.on Events.Click, ->
# 	logo.states.next()


# ----------------------------------------------------
# Events Demo
# * Transition between states on touch events *
# ----------------------------------------------------
#
# logo.on Events.TouchStart, ->
# 	logo.states.switch("pressed")
#     
# logo.on Events.TouchEnd, ->
# 	logo.states.switch("default")












# ----------------------------------------------------
# New Layer Demo
# * Create a new container layer with width equal to that of our 4 artboards *
# ----------------------------------------------------
#
# screenContainer = new Layer 
# 	width: screenWidth * 4
# 	height: screenHeight
# 	backgroundColor: "transparent"


# ----------------------------------------------------
# Draggable Demo
# * Enable draggability on the x-dimension only *
# ----------------------------------------------------
#
# screenContainer.draggable.enabled = true
# screenContainer.draggable.speedY = 0


# ----------------------------------------------------
# Artboard Demo
# * Only the first artboard is visible by default. Here we'll manually show the others *
# ----------------------------------------------------
# 
# sketch.artboardB.visible = true
# sketch.artboardC.visible = true
# sketch.artboardD.visible = true


# ----------------------------------------------------
# Positioning Demo
# * Artboards automatically import at (0,0). here we'll push them offscreen *
# ----------------------------------------------------
#
# sketch.contentA.x = 0
# sketch.artboardB.x = screenWidth
# sketch.artboardC.x = screenWidth * 2
# sketch.artboardD.x = screenWidth * 3


# ----------------------------------------------------
# Hierarchy Demo
# * Layers can have superLayer and subLayers. Properties of parents transfer to children *
# ----------------------------------------------------
#
# screens = [sketch.contentA, sketch.artboardB, sketch.artboardC, sketch.artboardD]
# 
# for screen in screens
# 	screen.superLayer = screenContainer 
	

# ----------------------------------------------------
# Multiple States Demo
# * We'll now add 4 states, one for each horizontal position of the walkthrough *
# ----------------------------------------------------
#
# screenContainer.states.add 
# 	screen1: {x:0}
# 	screen2: {x:-screenWidth}
# 	screen3: {x:-screenWidth*2}
# 	screen4: {x:-screenWidth*3}
#
# screenContainer.states.animationOptions = curve: "spring(200,20,0)"


# ----------------------------------------------------
# Dragging Logic
# * The last bit is logic to switch states back / forward depending on our drag *
# ----------------------------------------------------
#
# screenContainer.on Events.DragStart, -> startPosition = this.x
#
# screenContainer.on Events.DragEnd, ->
# 	distance = startPosition - this.x
# 	startState = this.states.state
# 	
# 	# Do nothing if we haven't dragged far enough
# 	if Math.abs(distance) < (screenWidth/4) then this.states.switch "screen1"
# 	# Switch if we have dragged far enough
# 	else 
# 		# Move on to the right
# 		if distance > 0 and startState isnt "screen4" then this.states.next()
# 		# Move back to the left.
# 		else if distance < 0 and startState isnt "screen1" then this.states.previous()
# 		# Or stay here
# 		else this.states.switch startState 

# ----------------------------------------------------
# Next Steps!
# * Try blurring our dimming our background when we leave the first screen *
# ----------------------------------------------------
#
# screenContainer.on Events.StateDidSwitch, ->
# 	if screenContainer.states.state isnt "screen1"
#		print "dim the background"
# 	else
#		print "undim the background"
# 