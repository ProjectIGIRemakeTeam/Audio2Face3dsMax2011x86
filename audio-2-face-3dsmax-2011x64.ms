plugin simpleObject Audio2FaceAnimation
name:"Animations"
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

        -- Event Handlers
        local faceModel = undefined
        local audioFile = ""

        on LoadModel pressed do
        (
            local filePath = getOpenFileName caption:"Select Face Model (PSK/FBX)" types:"Face Model (*.fbx;*.psk)|*.fbx;*.psk"
            if filePath != undefined do
            (
                faceModel = importFile filePath #noPrompt
                LoadedModel.text = "Loaded: " + filenameFromPath filePath
                print ("Model Loaded: " + filePath)
            )
        )

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

        on PlayAnim pressed do
        (
            if faceModel == undefined or AnimList.selection == 0 then
            (
                messageBox "Please select a model and an animation!" title:"Error"
                return
            )
            print ("Playing Animation: " + AnimList.items[AnimList.selection])
            -- TODO: Trigger animation playback in 3ds Max timeline
        )

        on DeleteAnim pressed do
        (
            if AnimList.selection != 0 then
            (
                local selectedAnim = AnimList.items[AnimList.selection]
                print ("Deleting Animation: " + selectedAnim)
                AnimList.items = deleteItem AnimList.items AnimList.selection
            )
        )

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

        on PlayAudio pressed do
        (
            if audioFile == "" then
            (
                messageBox "No audio file loaded!" title:"Error"
                return
            )
            print ("Playing Audio: " + audioFile)
            shellLaunch "wmplayer.exe" audioFile -- Plays audio in Windows Media Player
        )
    )
)


plugin simpleObject Audio2FaceMainPanel
name:"Audio-2-Face"
category:"Audio Animation"
(
    rollout A2F_TopPanel "Audio-2-Face" width:350 height:250
    (
        -- Plugin Image (Replace with actual image path)
        bitmap PluginImage "Audio2Face Plugin" bitmap:(openBitmap "C:\\Path\\To\\PluginImage.png") width:340 height:100

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


plugin simpleObject Audio2FacePlugin
name:"Audio2Face Settings"
category:"Audio Animation"
(
    rollout A2F_Rollout "Audio2Face Control" width:350 height:500
    (
        -- Scrollable Panel
        dotNetControl ScrollPanel "System.Windows.Forms.Panel" width:340 height:450
        
        -- Emotion Strength
        slider OverallEmotion "Overall Emotion Strength" range:[0,1,0] type:#float
        
        -- Emotion Control Panel
        checkbox ManualEmotion "Enable Manual Emotion"
        slider AutoVsManual "Auto vs Manual Blend" range:[0,1,0] type:#float
        
        -- Emotion Sliders
        slider Emotion_Amazement "Amazement" range:[0,1,0] type:#float
        slider Emotion_Anger "Anger" range:[0,1,0] type:#float
        slider Emotion_Cheekiness "Cheekiness" range:[0,1,0] type:#float
        slider Emotion_Disgust "Disgust" range:[0,1,0] type:#float
        slider Emotion_Fear "Fear" range:[0,1,0] type:#float
        slider Emotion_Grief "Grief" range:[0,1,0] type:#float
        slider Emotion_Joy "Joy" range:[0,1,0] type:#float
        slider Emotion_OutOfBreath "Out of Breath" range:[0,1,0] type:#float
        slider Emotion_Pain "Pain" range:[0,1,0] type:#float
        slider Emotion_Sadness "Sadness" range:[0,1,0] type:#float
        
        -- Auto-Emotion Controls
        slider EmotionContrast "Emotion Contrast" range:[0,1,0] type:#float
        slider EmotionSmoothing "Emotion Smoothing" range:[0,1,0] type:#float
        spinner MaxEmotions "Max Active Emotions" range:[1,6,3] type:#integer
        
        -- Live Transition Time
        spinner LiveTransition "Live Transition Time (sec)" range:[0.1,2,0.5] type:#float
        
        -- Apply Emotion Values
        button ApplyButton "Apply to Audio2Face" width:150 height:30
        
        -- Event Handlers
        on ApplyButton pressed do
        (
            -- Example: Send slider values to external process or API
            print ("Applying Emotions to Audio2Face Engine")
            print ("Overall Strength: " + OverallEmotion.value as string)
            print ("Anger: " + Emotion_Anger.value as string)
            print ("Joy: " + Emotion_Joy.value as string)
            print ("Live Transition: " + LiveTransition.value as string)
        )
    )

    -- Initialize Panel
    on create do
    (
        ScrollPanel.AutoScroll = true
        ScrollPanel.Dock = ScrollPanel.Dock.Fill
    )
)

plugin simpleObject AnimationsPanel
name:"Animations"
category:"Audio Animation"
(
    rollout AnimationsUI "Animations" width:350 height:250
    (
        -- Animation Group Selection
        group "Animation Group"
        (
            dropdownlist AnimGroupList "Select Group:" items:#("Default") width:200
            button AddGroup "Add Group..." width:150
        )

        -- Animation List (Placeholder for imported animations)
        group "Available Animations"
        (
            listbox AnimList "Animations:" height:5 width:300
        )

        -- Animation Controls
        button ImportAnim "Import" width:80
        button CleanAnim "Clean" width:80
        button DeleteAnim "Delete" width:80
        button RenameAnim "Rename" width:80
        
        -- Event Handlers (Placeholder Logic)
        on AddGroup pressed do print "Adding new Animation Group..."
        on ImportAnim pressed do print "Importing animation from FBX..."
        on CleanAnim pressed do print "Cleaning animations..."
        on DeleteAnim pressed do 
        (
            if AnimList.selection != 0 then
            (
                local selectedAnim = AnimList.items[AnimList.selection]
                print ("Deleting animation: " + selectedAnim)
                AnimList.items = deleteItem AnimList.items AnimList.selection
            )
        )
        on RenameAnim pressed do print "Renaming selected animation..."
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
