# Sound
Written for HP Omen laptop and Linux Mint 18  

[Remove clicking noise](#remove_sound_clicking)  
[How to use JACK with pulseaudio](#jack_with_pulseaudio)  
[Set up midi keyboard and sampler](#midi_keyboard_with_sampler)  

## Remove sound clicking
I had it from the very start or may be after power management adjustments.  

Add to `/etc/modprobe.d/alsa-base.conf`  
```
options snd-hda-intel power_save=10
```

For some reason I have this script that should be executed with sudo  
```
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x67
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x3000
```
But these days it's all fine without it

## JACK with PulseAudio
Problem arised when I switched to JACK as main audio server. JACK and PulseAudio both use ALSA on low-level and they block each other.  
[Recipe source on askubuntu](https://askubuntu.com/questions/572120/how-to-use-jack-and-pulseaudio-alsa-at-the-same-time-on-the-same-audio-device)  

Install JACK and module to route PulseAudio to JACK  
```
apt install jack jackd2 libjack-jackd2-dev pulseaudio-utils pulseaudio-module-jack
```

Configure qjackctl `setup->options`  
[script](./jackctl_after_start.sh) after startup
```
pactl load-module module-jack-sink
pactl load-module module-jack-source
pacmd set-default-sink jack_out
```
[script](./jackctl_before_stop.sh) before shutdown
```
pactl unload-module module-jack-sink
pactl unload-module module-jack-source
```
![](./images/qjackctl-setup-options.png)  

This way when you start jack server in qjackctl, pulseaudio will use it (but in player you have to pause/play).  
And when you stop jack, pulseaudio will fall back to direct use of sound card instantly.  

When playing audio, for example in Firefox, one should see  

![](./images/qjackctl-audio-connections.png)

And last, to control volume use `alsamixer`

## MIDI keyboard with sampler
Set MIDI driver `seq` in qjackctl parameters  

![](./images/qjackctl-parameters.png)  

Enable ALSA sequencer  

![](./images/qjackctl-misc-settings.png)

Compile [LinuxSampler](https://linuxsampler.org) with JACK, for that you'll need  
```
apt install libjack-jackd2-dev
```  

Start JACK audio output channel in JSampler (LinuxSampler GUI)  

![](./images/jsampler.png)  

Connect MIDI keyboard to LinuxSampler port and LinuxSampler to system like this  

![](./images/qjackctl-midi-patchbay.png)

You can save configuration in JSampler as script and execute it directly in LinuxSampler.  
Check [here](./linuxsampler)
