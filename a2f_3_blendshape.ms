-- Define the rollout window
rollout blendshapeControl "Blendshape Control" width:300 height:800
(
    -- Scrollable Panel
    dotNetControl ScrollPanel "System.Windows.Forms.Panel" width:340 height:450

    -- Global variables
    local clampEnabled = false

    -- UI Elements
    button btnResetAll "Reset All" width:280 height:30
    checkbox chkClamp "Enable Blendshape Clamping" checked:false

    -- Function to reset all sliders
    fn resetAllSliders =
    (
        for c in blendshapeControl.controls do
        (
            if (classof c) == sliderControl then
            (
                c.value = 0
            )
        )
    )

    -- Function to clamp slider values
    fn clampSliderValue slider =
    (
        if clampEnabled then
        (
            if slider.name[1] == "sldOffset" then
            (
                slider.value = clamp slider.value -1 1
            )
            else
            (
                slider.value = clamp slider.value 0 1
            )
        )
    )

    -- Create sliders for Blendshape Multiplier
    group "Blendshape Multiplier"
    (
        slider sldEyeBlinkLeft "Eye Blink Left" range:[0,3,0] width:280 height:30
        slider sldEyeLookDownLeft "Eye Look Down Left" range:[0,3,0] width:280 height:30
        slider sldEyeLookInLeft "Eye Look In Left" range:[0,3,0] width:280 height:30
        slider sldEyeLookOutLeft "Eye Look Out Left" range:[0,3,0] width:280 height:30
        slider sldEyeLookUpLeft "Eye Look Up Left" range:[0,3,0] width:280 height:30
        slider sldEyeSquintLeft "Eye Squint Left" range:[0,3,0] width:280 height:30
        slider sldEyeWideLeft "Eye Wide Left" range:[0,3,0] width:280 height:30
        slider sldEyeBlinkRight "Eye Blink Right" range:[0,3,0] width:280 height:30
        slider sldEyeLookDownRight "Eye Look Down Right" range:[0,3,0] width:280 height:30
        slider sldEyeLookInRight "Eye Look In Right" range:[0,3,0] width:280 height:30
        slider sldEyeLookOutRight "Eye Look Out Right" range:[0,3,0] width:280 height:30
        slider sldEyeLookUpRight "Eye Look Up Right" range:[0,3,0] width:280 height:30
        slider sldEyeSquintRight "Eye Squint Right" range:[0,3,0] width:280 height:30
        slider sldEyeWideRight "Eye Wide Right" range:[0,3,0] width:280 height:30
        slider sldJawForward "Jaw Forward" range:[0,3,0] width:280 height:30
        slider sldJawLeft "Jaw Left" range:[0,3,0] width:280 height:30
        slider sldJawRight "Jaw Right" range:[0,3,0] width:280 height:30
        slider sldJawOpen "Jaw Open" range:[0,3,0] width:280 height:30
        slider sldMouthClose "Mouth Close" range:[0,3,0] width:280 height:30
        slider sldMouthFunnel "Mouth Funnel" range:[0,3,0] width:280 height:30
        slider sldMouthPucker "Mouth Pucker" range:[0,3,0] width:280 height:30
        slider sldMouthLeft "Mouth Left" range:[0,3,0] width:280 height:30
        slider sldMouthRight "Mouth Right" range:[0,3,0] width:280 height:30
        slider sldMouthSmileLeft "Mouth Smile Left" range:[0,3,0] width:280 height:30
        slider sldMouthSmileRight "Mouth Smile Right" range:[0,3,0] width:280 height:30
        slider sldMouthFrownLeft "Mouth Frown Left" range:[0,3,0] width:280 height:30
        slider sldMouthFrownRight "Mouth Frown Right" range:[0,3,0] width:280 height:30
        slider sldMouthDimpleLeft "Mouth Dimple Left" range:[0,3,0] width:280 height:30
        slider sldMouthDimpleRight "Mouth Dimple Right" range:[0,3,0] width:280 height:30
        slider sldMouthStretchLeft "Mouth Stretch Left" range:[0,3,0] width:280 height:30
        slider sldMouthStretchRight "Mouth Stretch Right" range:[0,3,0] width:280 height:30
        slider sldMouthRollLower "Mouth Roll Lower" range:[0,3,0] width:280 height:30
        slider sldMouthRollUpper "Mouth Roll Upper" range:[0,3,0] width:280 height:30
        slider sldMouthShrugLower "Mouth Shrug Lower" range:[0,3,0] width:280 height:30
        slider sldMouthShrugUpper "Mouth Shrug Upper" range:[0,3,0] width:280 height:30
        slider sldMouthPressLeft "Mouth Press Left" range:[0,3,0] width:280 height:30
        slider sldMouthPressRight "Mouth Press Right" range:[0,3,0] width:280 height:30
        slider sldMouthLowerDownLeft "Mouth Lower Down Left" range:[0,3,0] width:280 height:30
        slider sldMouthLowerDownRight "Mouth Lower Down Right" range:[0,3,0] width:280 height:30
        slider sldMouthUpperUpLeft "Mouth Upper Up Left" range:[0,3,0] width:280 height:30
        slider sldMouthUpperUpRight "Mouth Upper Up Right" range:[0,3,0] width:280 height:30
        slider sldBrowDownLeft "Brow Down Left" range:[0,3,0] width:280 height:30
        slider sldBrowDownRight "Brow Down Right" range:[0,3,0] width:280 height:30
        slider sldBrowInnerUp "Brow Inner Up" range:[0,3,0] width:280 height:30
        slider sldBrowOuterUpLeft "Brow Outer Up Left" range:[0,3,0] width:280 height:30
        slider sldBrowOuterUpRight "Brow Outer Up Right" range:[0,3,0] width:280 height:30
        slider sldCheekPuff "Cheek Puff" range:[0,3,0] width:280 height:30
        slider sldCheekSquintLeft "Cheek Squint Left" range:[0,3,0] width:280 height:30
        slider sldCheekSquintRight "Cheek Squint Right" range:[0,3,0] width:280 height:30
        slider sldNoseSneerLeft "Nose Sneer Left" range:[0,3,0] width:280 height:30
        slider sldNoseSneerRight "Nose Sneer Right" range:[0,3,0] width:280 height:30
        slider sldTongueOut "Tongue Out" range:[0,3,0] width:280 height:30
    )

    -- Create sliders for Blendshape Offset
    group "Blendshape Offset"
    (
        slider sldOffsetEyeBlinkLeft "Eye Blink Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeLookDownLeft "Eye Look Down Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeLookInLeft "Eye Look In Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeLookOutLeft "Eye Look Out Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeLookUpLeft "Eye Look Up Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeSquintLeft "Eye Squint Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeWideLeft "Eye Wide Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeBlinkRight "Eye Blink Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeLookDownRight "Eye Look Down Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeLookInRight "Eye Look In Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeLookOutRight "Eye Look Out Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeLookUpRight "Eye Look Up Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeSquintRight "Eye Squint Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetEyeWideRight "Eye Wide Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetJawForward "Jaw Forward" range:[-1,1,0] width:280 height:30
        slider sldOffsetJawLeft "Jaw Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetJawRight "Jaw Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetJawOpen "Jaw Open" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthClose "Mouth Close" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthFunnel "Mouth Funnel" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthPucker "Mouth Pucker" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthLeft "Mouth Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthRight "Mouth Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthSmileLeft "Mouth Smile Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthSmileRight "Mouth Smile Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthFrownLeft "Mouth Frown Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthFrownRight "Mouth Frown Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthDimpleLeft "Mouth Dimple Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthDimpleRight "Mouth Dimple Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthStretchLeft "Mouth Stretch Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthStretchRight "Mouth Stretch Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthRollLower "Mouth Roll Lower" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthRollUpper "Mouth Roll Upper" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthShrugLower "Mouth Shrug Lower" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthShrugUpper "Mouth Shrug Upper" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthPressLeft "Mouth Press Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthPressRight "Mouth Press Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthLowerDownLeft "Mouth Lower Down Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthLowerDownRight "Mouth Lower Down Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthUpperUpLeft "Mouth Upper Up Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetMouthUpperUpRight "Mouth Upper Up Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetBrowDownLeft "Brow Down Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetBrowDownRight "Brow Down Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetBrowInnerUp "Brow Inner Up" range:[-1,1,0] width:280 height:30
        slider sldOffsetBrowOuterUpLeft "Brow Outer Up Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetBrowOuterUpRight "Brow Outer Up Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetCheekPuff "Cheek Puff" range:[-1,1,0] width:280 height:30
        slider sldOffsetCheekSquintLeft "Cheek Squint Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetCheekSquintRight "Cheek Squint Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetNoseSneerLeft "Nose Sneer Left" range:[-1,1,0] width:280 height:30
        slider sldOffsetNoseSneerRight "Nose Sneer Right" range:[-1,1,0] width:280 height:30
        slider sldOffsetTongueOut "Tongue Out" range:[-1,1,0] width:280 height:30
    )

    -- Reset All button event
    on btnResetAll pressed do
    (
        resetAllSliders()
    )

    -- Clamping checkbox event
    on chkClamp changed state do
    (
        clampEnabled = state
    )

    -- Slider change event
    on sldEyeBlinkLeft changed val do
    (
        clampSliderValue sldEyeBlinkLeft
        -- Update blendshape value here
    )

    -- Add more slider change events for the rest of the sliders...

    -- Initialize Panel
    on create do
    (
        ScrollPanel.AutoScroll = true
        ScrollPanel.Dock = ScrollPanel.Dock.Fill
    )
)

-- Create the dialog
createDialog blendshapeControlRollout