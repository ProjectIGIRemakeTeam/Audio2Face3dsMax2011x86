fn modelHasFaceBones model = (
    -- Check if model has a Skin modifier
    local skinMod = undefined
    for mod in model.modifiers do (
        if classof mod == Skin do (
            skinMod = mod
            exit
        )
    )
    
    if skinMod == undefined then (
        print "No Skin modifier found!"
        return false
    )
    
    -- Get list of bones influencing the mesh
    local boneCount = skinOps.getNumberBones skinMod
    if boneCount == 0 then (
        print "No bones found in Skin modifier!"
        return false
    )
    
    -- Check if at least one face-related bone exists
    local faceBones = #("jaw", "eye", "brow", "mouth", "cheek", "lip", "nose", "tongue")
    local hasFaceBones = false
    
    for i = 1 to boneCount do (
        local boneName = skinOps.getBoneName skinMod i 0
        for faceBone in faceBones do (
            if findString boneName faceBone != undefined do (
                print ("Face bone detected: " + boneName)
                hasFaceBones = true
                exit
            )
        )
    )
    
    return hasFaceBones
)

-- Example Usage: Run after loading a model
on LoadModel pressed do
(
    local filePath = getOpenFileName caption:"Select Face Model (PSK/FBX)" types:"Model Files (*.fbx;*.psk)|*.fbx;*.psk"
    if filePath != undefined do
    (
        faceModel = importFile filePath #noPrompt
        LoadedModel.text = "Loaded: " + filenameFromPath filePath
        print ("Model Loaded: " + filePath)

        -- Check if face bones exist
        if modelHasFaceBones faceModel then
            print "✅ Face bones detected!"
        else
            messageBox "⚠ Warning: No face bones detected!" title:"Error"
    )
)
