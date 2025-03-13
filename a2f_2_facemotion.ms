-- Define the rollout window
rollout FaceMotionControls "Face Motion Controls" width:300 height:800
(
    -- Scrollable Panel
    dotNetControl ScrollPanel "System.Windows.Forms.Panel" width:340 height:450


     -- UI Elements
    button btnResetAll "Reset All" width:280 height:30

     -- Function to reset all sliders
    fn resetAllSliders =
    (
        for c in FaceMotionControls.controls do
        (
            if (classof c) == sliderControl then
            (
                c.value = 0
            )
        )
    )

    -- Motion Strength
    spinner spn_motionStrength "Motion Strength" range:[0,2,0] type:#float
    
    -- Upper Face Strength
    spinner spn_upperFaceStrength "Upper Face Strength" range:[0,2,0] type:#float
    
    -- Lower Face Strength
    spinner spn_lowerFaceStrength "Lower Face Strength" range:[0,2,0] type:#float
    
    -- Eyelid Offset
    spinner spn_eyelidOffset "Eyelid Offset" range:[0,1,0] type:#float
    
    -- Lip Offset
    spinner spn_lipOffset "Lip Offset" range:[-0.2,0.2,0] type:#float
    
    -- Upper Face Smoothing
    spinner spn_upperFaceSmoothing "Upper Face Smoothing" range:[0,0.1,0] type:#float
    
    -- Lower Face Smoothing
    spinner spn_lowerFaceSmoothing "Lower Face Smoothing" range:[0,0.1,0] type:#float
    
    -- Face Mask Level
    spinner spn_faceMaskLevel "Face Mask Level" range:[0,1,0] type:#float
    
    -- Face Mask Softness
    spinner spn_faceMaskSoftness "Face Mask Softness" range:[0,0.5,0] type:#float
    
    -- Apply Button
    button btn_apply "Apply Settings" width:150 height:30
    
    on btn_apply pressed do
    (
        -- Example: Apply to selected face rig controller
        if selection.count > 0 then
        (
            local faceCtrl = selection[1]
            faceCtrl.modifiers[#FaceMotion].motionStrength = spn_motionStrength.value
            faceCtrl.modifiers[#FaceMotion].upperFaceStrength = spn_upperFaceStrength.value
            faceCtrl.modifiers[#FaceMotion].lowerFaceStrength = spn_lowerFaceStrength.value
            faceCtrl.modifiers[#FaceMotion].eyelidOffset = spn_eyelidOffset.value
            faceCtrl.modifiers[#FaceMotion].lipOffset = spn_lipOffset.value
            faceCtrl.modifiers[#FaceMotion].upperFaceSmoothing = spn_upperFaceSmoothing.value
            faceCtrl.modifiers[#FaceMotion].lowerFaceSmoothing = spn_lowerFaceSmoothing.value
            faceCtrl.modifiers[#FaceMotion].faceMaskLevel = spn_faceMaskLevel.value
            faceCtrl.modifiers[#FaceMotion].faceMaskSoftness = spn_faceMaskSoftness.value
            print "Face Motion Settings Applied!"
        )
        else
        (
            messageBox "No object selected! Please select a face rig controller."
        )
    )

    -- Reset All button event
    on btnResetAll pressed do
    (
        resetAllSliders()
    )

    -- Initialize Panel
    on create do
    (
        ScrollPanel.AutoScroll = true
        ScrollPanel.Dock = ScrollPanel.Dock.Fill
    )

)
createDialog FaceMotionControls width:300 height:400
