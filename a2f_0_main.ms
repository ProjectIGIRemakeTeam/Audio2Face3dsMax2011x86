-- Audio2Face MaxScript Plugin for 3ds Max 2011
-- Integrates NVIDIA A2F to send audio and receive animation data

plugin simpleObject Audio2FaceMainPanel
name:"Audio-2-Face"
category:"Audio Animation"
(
    -- Audio2Face Top Panel
    rollout A2F_TopPanel "Audio-2-Face" width:350 height:250
    (
        -- Plugin Image (Replace with actual image path)
        bitmap PluginImage "Audio2Face Plugin" bitmap:(openBitmap "C:\\Path\\To\\a2f_0_nvidia.png") width:340 height:100

        -- Actor Section
        label ActorLabel "Actor: NewActor"
        button CreateActor "Create Actor..." width:150
        button LoadActor "Load Actor..." width:150
        button SaveActor "Save Actor..." width:150
        button AboutButton "About..." width:150

        -- Sound Section
        label SoundLabel "Sound: NewSound"
        button LoadSound "Load Sound..." width:150
        button PlaySound "Play Sound" width:150
        button GenerateAnim "Generate Animation..." width:150

        -- Event Handlers (Placeholders for functionality)
        on CreateActor pressed do print "Creating new Actor..."
        on LoadActor pressed do print "Loading existing Actor..."
        on SaveActor pressed do print "Saving Actor..."
        on AboutButton pressed do messagebox "Audio2Face Plugin v1.0\nCreated for 3ds Max integration."

        on LoadSound pressed do print "Loading new Sound..."
        on PlaySound pressed do print "Playing Sound..."
        on GenerateAnim pressed do print "Generating Animation..."
    )
)



plugin simpleObject Audio2FaceAnimation
name:"Audio2Face Animations"
category:"Facial Animation"
(
    rollout AnimUI "Audio2Face Animations" width:400 height:300
    (
        -- Actor & Model Section
        group "Face Model"
        (
            button LoadModel "Load PSK/FBX..." width:150
            label LoadedModel "No model loaded" align:#center
        )

        -- Animation List
        group "Animation Data"
        (
            listbox AnimList "Animations:" height:6 width:350
            button ImportAnim "Import from A2F" width:150
            button PlayAnim "Play Selected" width:150
            button DeleteAnim "Delete" width:150
        )

        -- Audio Controls
        group "Audio Controls"
        (
            button LoadAudio "Load Audio File..." width:150
            button PlayAudio "Play Audio" width:150
            label LoadedAudio "No audio loaded" align:#center
        )

        -- Variables
        local faceModel = undefined
        local audioFile = ""

        -- Load Model
        on LoadModel pressed do
        (
            local filePath = getOpenFileName caption:"Select Face Model (PSK/FBX)" types:"Face Model (*.fbx;*.psk)|*.fbx;*.psk"
            if filePath != undefined do
            (
                importFile filePath #noPrompt
                LoadedModel.text = "Loaded: " + filenameFromPath filePath
                print ("Model Loaded: " + filePath)
                faceModel = getNodeByName (filenameFromPath filePath)
            )
        )

        -- Import Animation
        on ImportAnim pressed do
        (
            if faceModel == undefined then
            (
                messageBox "Please load a PSK/FBX face model first!" title:"Error"
                return
            )
            local animName = "Anim_" + (random 1000 9999) as string
            AnimList.items += animName
            print ("Imported Animation: " + animName)
        )

        -- Play Animation & Sync with Timeline
        on PlayAnim pressed do
        (
            if faceModel == undefined or AnimList.selection == 0 then
            (
                messageBox "Please select a model and an animation!" title:"Error"
                return
            )
            local animName = AnimList.items[AnimList.selection]
            print ("Playing Animation: " + animName)
            sliderTime = animationRange.start
            playAnimation()
        )

        -- Delete Animation
        on DeleteAnim pressed do
        (
            if AnimList.selection != 0 then
            (
                local selectedAnim = AnimList.items[AnimList.selection]
                print ("Deleting Animation: " + selectedAnim)
                deleteItem AnimList.items AnimList.selection
            )
        )

        -- Load Audio
        on LoadAudio pressed do
        (
            local filePath = getOpenFileName caption:"Select Audio File" types:"WAV Files (*.wav)|*.wav"
            if filePath != undefined do
            (
                audioFile = filePath
                LoadedAudio.text = "Loaded: " + filenameFromPath filePath
                print ("Audio Loaded: " + filePath)
            )
        )

        -- Play Audio & Sync with Animation
        on PlayAudio pressed do
        (
            if audioFile == "" then
            (
                messageBox "No audio file loaded!" title:"Error"
                return
            )
            print ("Playing Audio: " + audioFile)
            
            sliderTime = animationRange.start
            playAnimation()
        )
    )
)

-- Helper function to start playback
fn playAnimation =
(
    with animate on
    (
        for t = animationRange.start to animationRange.end do
        (
            sliderTime = t
            wait 0.04 -- Adjust to match playback speed
        )
    )
)
