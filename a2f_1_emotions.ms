-- Emotion Control Plugin for 3ds Max
rollout EmotionControl "Emotion Control" width:300 height:500 (

    -- Scrollable Panel
    dotNetControl ScrollPanel "System.Windows.Forms.Panel" width:340 height:450

    group "Overall Strength" (
        slider OverallStrengthSlider "Overall Emotion Strength" range:[0,1,0] type:#float 
    )
    
    group "Emotion Control" (
        checkbox EnableManualEmotion "Enable Manual Emotion"
        slider AutoManualBlend "Auto vs Manual Emotion Blend" range:[0,1,0] type:#float 
    )
    
    group "Emotions" (
        slider AmazementSlider "Amazement" range:[0,1,0] type:#float 
        slider AngerSlider "Anger" range:[0,1,0] type:#float 
        slider CheekinessSlider "Cheekiness" range:[0,1,0] type:#float 
        slider DisgustSlider "Disgust" range:[0,1,0] type:#float 
        slider FearSlider "Fear" range:[0,1,0] type:#float 
        slider GriefSlider "Grief" range:[0,1,0] type:#float 
        slider JoySlider "Joy" range:[0,1,0] type:#float 
        slider OutOfBreathSlider "Out Of Breath" range:[0,1,0] type:#float 
        slider PainSlider "Pain" range:[0,1,0] type:#float 
        slider SadnessSlider "Sadness" range:[0,1,0] type:#float 
    )
    
    group "Auto-Emotion Settings" (
        slider EmotionContrastSlider "Emotion Contrast" range:[0,1,0] type:#float 
        slider EmotionSmoothingSlider "Emotion Smoothing" range:[0,1,0] type:#float 
        spinner MaxEmotionsSpinner "Max Emotions" range:[1,6,1] type:#integer 
    )
    
    group "Live Transition" (
        slider LiveTransitionSlider "Live Transition Time" range:[0.1,2,0.1] type:#float 
    )

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

    -- Initialize Panel
    on create do
    (
        ScrollPanel.AutoScroll = true
        ScrollPanel.Dock = ScrollPanel.Dock.Fill
    )
)
