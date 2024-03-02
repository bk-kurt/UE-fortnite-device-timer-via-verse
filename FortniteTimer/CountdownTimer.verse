using {/UnrealEngine.com/Temporary/Diagnostics }
using/Verse.org/Simulation }
using/Fortnite.com/Devices } 

@editable : MainHUD hud_message_device = hud_message_device{}
@editable : StartCountdown trigger_device = trigger_device{}
@editable : StopCountdown trigger_device = trigger_device{}
@editable : CelebrationVFX: vfx_spawner_device = vfx_spawner_device{}

@editable : TimerMinutes: int = 0
@editable : TimerSeconds int = 20

var BreakLoop: logic = false

CountdownTimerTOUI<localizes> (CountdownTimerText : string) <computes> : message = "{CountdownTimerText}"

OnBegin<override>() < suspends>:void-

StartCountdown.Triggered Event. Subscribe (StartCountdownEvent)
StopCountdown.TriggeredEvent.Subscribe (StopCountdownEvent)

StartCountdownEvent (Agent : ?agent): void= 
spawn (OnCountdown Timer()}
    StopCountdownEvent(Agent : ?agent): void= 
    set BreakLoop = true
    
OnCountdownTimer()<suspends>:void=
    var Minutes int = TimerMinutes
    var Seconds int = TimerSeconds
    set BreakLoop = false
    loop:
        Sleep(1.0)  // Wait for 1 second
        if (Seconds > 0):
            set Seconds -= 1  // Decrement seconds
        else:
            if (Minutes > 0):
                set Minutes -= 1
                set Seconds = 59
            else:
                set BreakLoop = true
                OnCelebration() 
                break
        
       
        if (Seconds >= 10):
            HudMessage: string = "{Minutes}:{Seconds}" 
        else:
            HudMessage: string = "{Minutes}:0{Seconds}"
        
        MainHUD.SetText(CountdownTimerTOUI(HudMessage))
        
        if (BreakLoop?):
            break

    
    
OnCelebration(): void=
    CelebrationVFX.Enable()
    HudMessage: string = "Celebration Time!" 
    MainHUD.SetText(CountdownTimerTOUI (HudMessage))