# Sound
On HP Omen laptop in Linux Mint 18
[Remove sound clicking noise](#remove_sound_clicking)
[How to use JACK with pulseaudio](#jack_with_pulseaudio)
[Set up midi keyboard and sampler](#midi_keyboard_with_sampler)

### Remove sound clicking
Add to `/etc/modprobe.d/alsa-base.conf`
```
options snd-hda-intel power_save=10
```

### JACK with pulseaudio
[source](https://askubuntu.com/questions/572120/how-to-use-jack-and-pulseaudio-alsa-at-the-same-time-on-the-same-audio-device)  

Install JACK and module to route pulseaudio to JACK  
```
apt install jack jackd2 libjack-jackd2-dev pulseaudio-utils pulseaudio-module-jack
```

enable D-bus in qjackctl
![](./qjackctl-misc-settings.png)

add to /etc/pulse/default.pa  
```
load-module module-jack-sink
load-module module-jack-source
```

restart pulseaudio
```
pulseaudio -k
pulseaudio -D
```

When playing audio, for example Firefox, one should see
![](./qjackctl-audio-connections.png)

### MIDI keyboard with sampler
Compile [LinuxSampler](https://linuxsampler.org) with JACK, you'll need `libjack-jackd2-dev` for that  

Start JACK audio output channel in JSampler (LinuxSampler GUI)
![](./jsampler.png)  

Connect MIDI keyboard to LinuxSampler port and LinuxSampler to system like this
![](./qjackctl-midi-patchbay.png)
