fn importBlendshapesFromCSV csvFile modelName = (
    -- Open the CSV file for reading
    local file = openFile csvFile
    if file == undefined then (
        format "Error: Could not open file %\n" csvFile
        return
    )
    
    -- Read the header line (assuming format: Frame, BlendshapeName, Value)
    local header = readLine file
    
    -- Get reference to the model
    local model = getNodeByName modelName
    if model == undefined then (
        format "Error: Model % not found in the scene\n" modelName
        close file
        return
    )

    -- Read and process each line in the CSV file
    while not eof file do (
        local line = readLine file
        local values = filterString line ","
        
        if values.count == 3 then (
            local frame = values[1] as integer
            local blendshapeName = values[2] 
            local value = values[3] as float
            
            -- Find the corresponding blendshape channel in the model
            local blendshapeController = model.modifiers[#Morpher]
            if blendshapeController != undefined then (
                local channelIndex = blendshapeController.getChannelIndex blendshapeName
                
                -- Apply keyframe to the blendshape if found
                if channelIndex != -1 then (
                    at time frame blendshapeController.setWeight channelIndex value
                ) else (
                    format "Warning: Blendshape % not found on model %\n" blendshapeName modelName
                )
            ) else (
                format "Error: No Morpher modifier found on model %\n" modelName
            )
        )
    )
    
    -- Close the file
    close file
    format "Blendshape animation imported successfully from %\n" csvFile
)

-- Example usage:
-- importBlendshapesFromCSV "C:\\path\\to\\animation.csv" "CharacterModel"
