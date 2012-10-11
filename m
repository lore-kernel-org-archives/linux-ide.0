From: Paul Natsuo Kishimoto <mail@paul.kishimoto.name>
Subject: eSATA failure with JMicron JMB321 - "PMP product ID mismatch"
Date: Wed, 10 Oct 2012 20:33:44 -0400
Message-ID: <1349915624.28674.2.camel@khaeru-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:35341 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933227Ab2JKAe0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2012 20:34:26 -0400
Received: from homiemail-a83.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 62B0663E
	for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2012 17:34:26 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: 1062647@bugs.launchpad.net

[1.] One line summary of the problem:=20
eSATA failure with JMicron JMB321 - "PMP product ID mismatch"

[2.] Full description of the problem/report:
I purchased a Sans Digital MS4UM+B:
http://www.sansdigital.com/mobilestor/ms4umplusb.html

This is a 4-bay eSATA/USB3.0 JBOD enclosure which uses a JMicron JMB321=
 chip. I
am testing it with a single drive, attached to this system (Dell Optipl=
ex 980
small form factor, Intel Q57 Express chipset) using the rear eSATA port=
=2E

Expected:
The drive is available (as /dev/sdX?).

Observed:
After booting with the enclosure powered on and connected via eSATA, th=
e drive
is not available. Looking in dmesg (full dmesg pasted at the end of thi=
s bug
report in section X), I see:

[    5.594993] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.595510] ata5.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 15 ports=
, feat 0x5/0xf
[    5.595995] ahci 0000:00:1f.2: FBS is enabled
[    5.596450] ata5.15: PMP product ID mismatch
[   13.920014] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
[   13.920355] ata5.15: Port Multiplier vendor mismatch '0x197b' !=3D '=
0x0'
[   13.920360] ata5.15: PMP revalidation failed (errno=3D-19)
[   13.920367] ata5.15: limiting SATA link speed to 1.5 Gbps
[   22.244909] ata5.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310=
)
[   22.245287] ata5.15: Port Multiplier vendor mismatch '0x197b' !=3D '=
0x0'
[   22.245292] ata5.15: PMP revalidation failed (errno=3D-19)
[   30.569866] ata5.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310=
)
[   30.570356] ata5.15: Port Multiplier vendor mismatch '0x197b' !=3D '=
0x0'
[   30.570361] ata5.15: PMP revalidation failed (errno=3D-19)
[   30.570368] ata5.15: failed to recover PMP after 5 tries, giving up
[   30.570373] ata5.15: Port Multiplier detaching
[   30.570379] ahci 0000:00:1f.2: FBS is disabled
[   30.570386] ata5.00: disabled

=E2=80=A6this sequence of messages is repeated if I:
- Power off and on the enclosure.
- Disconnect and reconnect the eSATA cable.
- Install the Ubuntu package 'scsitools' and run, in a terminal,
  'sudo rescan-scsi-bus'.

This bug was reported downstream as: https://bugs.launchpad.net/ubuntu/=
+bug/1062647

[3.] Keywords (i.e., modules, networking, kernel):
libata, sata, esata, port multiplier, pmp

[4.] Kernel version (from /proc/version):=20
$ cat /proc/version
Linux version 3.6.0-030600-generic (apw@gomeisa) (gcc version 4.6.3 (Ub=
untu/Linaro 4.6.3-1ubuntu5) ) #201209302035 SMP Mon Oct 1 00:36:01 UTC =
2012

[5.] Output of Oops.. message
N/A

[6.] A small shell script or example program which triggers the problem=
 (if possible)=20
N/A

[7.] Environment=20
$ lsb_release -rd
Description:    Ubuntu quantal (development branch)
Release:        12.10

[7.1.] Software (add the output of the ver_linux script here)
$ /usr/src/linux-headers-3.6.0-030600-generic/scripts/ver_linux=20
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux khaeru-desktop 3.6.0-030600-generic #201209302035 SMP Mon Oct 1 0=
0:36:01 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux
=20
Gnu C                  4.7
Gnu make               3.81
binutils               2.22.90.20120924
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42.5
pcmciautils            018
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.3
Sh-utils               8.13
wireless-tools         30
Modules Loaded         joydev hidp nfsv4 btusb bnep rfcomm nfsd binfmt_=
misc nfs_acl auth_rpcgss dm_crypt arc4 snd_hda_codec_realtek rt2800pci =
rt2800lib crc_ccitt rt2x00pci snd_hda_intel rt2x00lib snd_hda_codec kvm=
_intel kvm uvcvideo snd_usb_audio mac80211 dell_wmi videobuf2_core psmo=
use snd_hwdep gpio_ich snd_pcm snd_usbmidi_lib videodev ath3k ppdev dcd=
bas sparse_keymap snd_seq_midi videobuf2_vmalloc bluetooth cfg80211 mic=
rocode snd_seq_midi_event serio_raw snd_seq videobuf2_memops snd_rawmid=
i coretemp snd_timer snd_seq_device eeprom_93cx6 i7core_edac nfs edac_c=
ore fscache snd lpc_ich lockd soundcore snd_page_alloc sunrpc mei mac_h=
id parport_pc lp parport hid_generic radeon usbhid hid ttm e1000e drm_k=
ms_helper drm i2c_algo_bit wmi

[7.2.] Processor information (from /proc/cpuinfo):=20
$ cat /proc/cpuinfo=20
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1197.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16=
 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi flex=
priority ept vpid
bogomips	: 5851.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1197.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16=
 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi flex=
priority ept vpid
bogomips	: 5851.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1197.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16=
 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi flex=
priority ept vpid
bogomips	: 5851.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1197.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16=
 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi flex=
priority ept vpid
bogomips	: 5851.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1197.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16=
 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi flex=
priority ept vpid
bogomips	: 5851.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1197.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16=
 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi flex=
priority ept vpid
bogomips	: 5851.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1197.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16=
 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi flex=
priority ept vpid
bogomips	: 5851.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 30
model name	: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz
stepping	: 5
microcode	: 0x4
cpu MHz		: 1197.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rd=
tscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nons=
top_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16=
 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi flex=
priority ept vpid
bogomips	: 5851.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):=20
$ cat /proc/modules=20
joydev 17693 0 - Live 0x0000000000000000
hidp 22562 1 - Live 0x0000000000000000
nfsv4 141076 1 - Live 0x0000000000000000
btusb 18291 0 - Live 0x0000000000000000
bnep 18315 2 - Live 0x0000000000000000
rfcomm 47922 12 - Live 0x0000000000000000
nfsd 263175 2 - Live 0x0000000000000000
binfmt_misc 17540 1 - Live 0x0000000000000000
nfs_acl 12883 1 nfsd, Live 0x0000000000000000
auth_rpcgss 41008 2 nfsv4,nfsd, Live 0x0000000000000000
dm_crypt 23120 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
snd_hda_codec_realtek 79668 1 - Live 0x0000000000000000
rt2800pci 18750 0 - Live 0x0000000000000000
rt2800lib 63557 1 rt2800pci, Live 0x0000000000000000
crc_ccitt 12667 1 rt2800lib, Live 0x0000000000000000
rt2x00pci 14578 1 rt2800pci, Live 0x0000000000000000
snd_hda_intel 34147 3 - Live 0x0000000000000000
rt2x00lib 55527 3 rt2800pci,rt2800lib,rt2x00pci, Live 0x000000000000000=
0
snd_hda_codec 135374 2 snd_hda_codec_realtek,snd_hda_intel, Live 0x0000=
000000000000
kvm_intel 137895 0 - Live 0x0000000000000000
kvm 437435 1 kvm_intel, Live 0x0000000000000000
uvcvideo 82212 0 - Live 0x0000000000000000
snd_usb_audio 132126 1 - Live 0x0000000000000000
mac80211 564631 3 rt2800lib,rt2x00pci,rt2x00lib, Live 0x000000000000000=
0
dell_wmi 12681 0 - Live 0x0000000000000000
videobuf2_core 36094 1 uvcvideo, Live 0x0000000000000000
psmouse 92362 0 - Live 0x0000000000000000
snd_hwdep 13668 2 snd_hda_codec,snd_usb_audio, Live 0x0000000000000000
gpio_ich 13383 0 - Live 0x0000000000000000
snd_pcm 97661 3 snd_hda_intel,snd_hda_codec,snd_usb_audio, Live 0x00000=
00000000000
snd_usbmidi_lib 25396 1 snd_usb_audio, Live 0x0000000000000000
videodev 120715 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
ath3k 12968 0 - Live 0x0000000000000000
ppdev 17113 0 - Live 0x0000000000000000
dcdbas 14490 0 - Live 0x0000000000000000
sparse_keymap 13890 1 dell_wmi, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
videobuf2_vmalloc 12860 1 uvcvideo, Live 0x0000000000000000
bluetooth 218412 28 hidp,btusb,bnep,rfcomm,ath3k, Live 0x00000000000000=
00
cfg80211 212917 2 rt2x00lib,mac80211, Live 0x0000000000000000
microcode 23040 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 13215 0 - Live 0x0000000000000000
snd_seq 61897 2 snd_seq_midi,snd_seq_midi_event, Live 0x000000000000000=
0
videobuf2_memops 13368 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_rawmidi 30749 2 snd_usbmidi_lib,snd_seq_midi, Live 0x00000000000000=
00
coretemp 13554 0 - Live 0x0000000000000000
snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_seq,snd_rawmidi, Live 0x0000000=
000000000
eeprom_93cx6 13302 1 rt2800pci, Live 0x0000000000000000
i7core_edac 24610 0 - Live 0x0000000000000000
nfs 164575 2 nfsv4, Live 0x0000000000000000
edac_core 62802 2 i7core_edac, Live 0x0000000000000000
fscache 61534 1 nfs, Live 0x0000000000000000
snd 79391 19 snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_usb_=
audio,snd_hwdep,snd_pcm,snd_usbmidi_lib,snd_seq,snd_rawmidi,snd_timer,s=
nd_seq_device, Live 0x0000000000000000
lpc_ich 17144 0 - Live 0x0000000000000000
lockd 77396 2 nfsd,nfs, Live 0x0000000000000000
soundcore 15091 1 snd, Live 0x0000000000000000
snd_page_alloc 18572 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
sunrpc 236326 13 nfsv4,nfsd,nfs_acl,auth_rpcgss,nfs,lockd, Live 0x00000=
00000000000
mei 41409 0 - Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
parport_pc 32866 1 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 46562 3 ppdev,parport_pc,lp, Live 0x0000000000000000
hid_generic 12493 0 - Live 0x0000000000000000
radeon 917652 2 - Live 0x0000000000000000
usbhid 47307 0 - Live 0x0000000000000000
hid 100579 3 hidp,hid_generic,usbhid, Live 0x0000000000000000
ttm 88492 1 radeon, Live 0x0000000000000000
e1000e 198575 0 - Live 0x0000000000000000
drm_kms_helper 46931 1 radeon, Live 0x0000000000000000
drm 277074 4 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
wmi 19256 1 dell_wmi, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iom=
em)=20
$ cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0064-0064 : keyboard
  0070-007f : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0378-037a : parport0
  03f8-03ff : serial
  0778-077a : parport0
  0800-085f : pnp 00:01
    0800-0803 : ACPI PM1a_EVT_BLK
    0804-0805 : ACPI PM1a_CNT_BLK
    0808-080b : ACPI PM_TMR
    0810-0815 : ACPI CPU throttle
    0820-082f : ACPI GPE0_BLK
    0830-0833 : iTCO_wdt
    0850-0850 : ACPI PM2_CNT_BLK
  0860-08ff : pnp 00:01
    0860-087f : iTCO_wdt
    0880-08ff : gpio_ich
      0880-08ff : gpio_ich
  0c00-0c7f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1fff : PCI Bus 0000:02
  2000-2fff : PCI Bus 0000:03
  d000-dfff : PCI Bus 0000:01
    dc00-dcff : 0000:01:00.0
  ec98-ec9f : 0000:00:16.3
    ec98-ec9f : serial
  ecc0-ecdf : 0000:00:19.0
  ece0-ecff : 0000:00:1f.3
  fe00-fe07 : 0000:00:1f.2
    fe00-fe07 : ahci
  fe10-fe13 : 0000:00:1f.2
    fe10-fe13 : ahci
  fe20-fe27 : 0000:00:1f.2
    fe20-fe27 : ahci
  fe30-fe33 : 0000:00:1f.2
    fe30-fe33 : ahci
  fe80-fe87 : 0000:00:16.2
    fe80-fe87 : ata_generic
  fe90-fe93 : 0000:00:16.2
    fe90-fe93 : ata_generic
  fea0-fea7 : 0000:00:16.2
    fea0-fea7 : ata_generic
  feb0-feb3 : 0000:00:16.2
    feb0-feb3 : ata_generic
  fec0-fedf : 0000:00:1f.2
    fec0-fedf : ahci
  fef0-feff : 0000:00:16.2
    fef0-feff : ata_generic
$ cat /proc/iomem
00000000-0000ffff : reserved
00010000-0009e3ff : System RAM
0009e400-0009ffff : RAM buffer
000a0000-000bffff : PCI Bus 0000:00
000c0000-000effff : PCI Bus 0000:00
  000c0000-000cf7ff : Video ROM
000f0000-000fffff : PCI Bus 0000:00
  000f0000-000fffff : reserved
    000f0000-000fffff : System ROM
00100000-db6cfbff : System RAM
  01000000-016aa86a : Kernel code
  016aa86b-01ce017f : Kernel data
  01dd6000-01f2ffff : Kernel bss
db6cfc00-db723bff : ACPI Non-volatile Storage
db723c00-db725bff : ACPI Tables
db725c00-f7ffffff : reserved
  db800000-f7ffffff : PCI Bus 0000:00
    dc000000-dc1fffff : PCI Bus 0000:02
    dc200000-dc3fffff : PCI Bus 0000:02
    dc400000-dc5fffff : PCI Bus 0000:03
    dc600000-dc7fffff : PCI Bus 0000:03
    e0000000-efffffff : PCI Bus 0000:01
      e0000000-efffffff : 0000:01:00.0
    f7c00000-f7cfffff : PCI Bus 0000:04
      f7cf0000-f7cfffff : 0000:04:00.0
        f7cf0000-f7cfffff : 0000:04:00.0
    f7d00000-f7efffff : PCI Bus 0000:01
      f7df0000-f7dfffff : 0000:01:00.0
      f7e00000-f7e1ffff : 0000:01:00.0
    f7fdb000-f7fdbfff : 0000:00:16.3
    f7fdc000-f7fdcfff : 0000:00:19.0
      f7fdc000-f7fdcfff : e1000e
    f7fdd000-f7fdd3ff : 0000:00:1a.0
      f7fdd000-f7fdd3ff : ehci_hcd
    f7fde000-f7fde3ff : 0000:00:1d.0
      f7fde000-f7fde3ff : ehci_hcd
    f7fdf000-f7fdf0ff : 0000:00:1f.3
    f7fe0000-f7ffffff : 0000:00:19.0
      f7fe0000-f7ffffff : e1000e
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f8000000-fbffffff : reserved
fec00000-fed003ff : reserved
  fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
fed20000-fed9ffff : reserved
  fed20000-fed9ffff : PCI Bus 0000:00
feda6000-feda6fff : PCI Bus 0000:00
  feda6000-feda600f : 0000:00:16.0
    feda6000-feda600f : mei
feda7000-feda7fff : PCI Bus 0000:00
fedab410-fedab414 : iTCO_wdt
fee00000-feefffff : reserved
  fee00000-fee00fff : Local APIC
ff870000-ff8707ff : PCI Bus 0000:00
  ff870000-ff8707ff : 0000:00:1f.2
    ff870000-ff8707ff : ahci
ff87c000-ff87ffff : PCI Bus 0000:00
  ff87c000-ff87ffff : 0000:00:1b.0
    ff87c000-ff87ffff : ICH HD audio
ffb00000-ffffffff : reserved
100000000-11fffffff : System RAM

[7.5.] PCI information ('lspci -vvv' as root)=20
$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Core Processor DMI (rev 11)
	Subsystem: Dell OptiPlex 980
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] #00 [0000]

00:03.0 PCI bridge: Intel Corporation Core Processor PCI Express Root P=
ort 1 (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f7d00000-f7efffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Dell OptiPlex 980
	Capabilities: [60] MSI: Enable- Count=3D1/2 Maskable+ 64bit-
		Address: 00000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x16, ASPM L0s, Latency L0 <512ns,=
 L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive+ BWMg=
mt+ ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 75.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Select=
able De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [150 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ Egress=
Ctrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- Egress=
Ctrl- DirectTrans-
	Capabilities: [160 v0] Vendor Specific Information: ID=3D0002 Rev=3D0 =
Len=3D00c <?>
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:08.0 System peripheral: Intel Corporation Core Processor System Mana=
gement Registers (rev 11)
	Subsystem: Device 0028:00da
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI =
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM L0s, Latency L0 unlimi=
ted, L1 unlimited
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Sele=
ctable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v0] Vendor Specific Information: ID=3D0000 Rev=3D0 =
Len=3D000 <?>

00:08.1 System peripheral: Intel Corporation Core Processor Semaphore a=
nd Scratchpad Registers (rev 11)
	Subsystem: Device 0028:00da
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI =
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM L0s, Latency L0 unlimi=
ted, L1 unlimited
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Sele=
ctable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v0] Vendor Specific Information: ID=3D0000 Rev=3D0 =
Len=3D000 <?>

00:08.2 System peripheral: Intel Corporation Core Processor System Cont=
rol and Status Registers (rev 11)
	Subsystem: Device 0028:00da
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI =
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM L0s, Latency L0 unlimi=
ted, L1 unlimited
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Sele=
ctable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v0] Vendor Specific Information: ID=3D0000 Rev=3D0 =
Len=3D000 <?>

00:10.0 System peripheral: Intel Corporation Core Processor QPI Link (r=
ev 11)
	Subsystem: Device 0028:00da
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-

00:10.1 System peripheral: Intel Corporation Core Processor QPI Routing=
 and Protocol Registers (rev 11)
	Subsystem: Device 0028:00da
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-

00:16.0 Communication controller: Intel Corporation 5 Series/3400 Serie=
s Chipset HECI Controller (rev 06)
	Subsystem: Dell Device 02da
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at feda6000 (64-bit, non-prefetchable) [size=3D16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4152
	Kernel driver in use: mei
	Kernel modules: mei

00:16.2 IDE interface: Intel Corporation 5 Series/3400 Series Chipset P=
T IDER Controller (rev 06) (prog-if 85 [Master SecO PriO])
	Subsystem: Dell Device 02da
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at fe80 [size=3D8]
	Region 1: I/O ports at fe90 [size=3D4]
	Region 2: I/O ports at fea0 [size=3D8]
	Region 3: I/O ports at feb0 [size=3D4]
	Region 4: I/O ports at fef0 [size=3D16]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: ata_generic

00:16.3 Serial controller: Intel Corporation 5 Series/3400 Series Chips=
et KT Controller (rev 06) (prog-if 02 [16550])
	Subsystem: Dell Device 02da
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at ec98 [size=3D8]
	Region 1: Memory at f7fdb000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation 82578DM Gigabit Network =
Connection (rev 05)
	Subsystem: Dell OptiPlex 980
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at f7fe0000 (32-bit, non-prefetchable) [size=3D128K]
	Region 1: Memory at f7fdc000 (32-bit, non-prefetchable) [size=3D4K]
	Region 2: I/O ports at ecc0 [size=3D32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 4182
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e
	Kernel modules: e1000e

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset =
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
	Subsystem: Dell OptiPlex 980
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f7fdd000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci_hcd

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset Hi=
gh Definition Audio (rev 05)
	Subsystem: Dell OptiPlex 980
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at ff87c000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4162
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI =
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <6=
4ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWM=
gmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D04
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=3D0f ComponentID=3D00 EltType=3DConfig
		Link0:	Desc:	TargetPort=3D00 TargetComponent=3D00 AssocRCRB- LinkType=
=3DMemMapped LinkValid+
			Addr:	00000000feda8000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI =
Express Root Port 1 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: dc000000-dc1fffff
	Prefetchable memory behind bridge: 00000000dc200000-00000000dc3fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <256ns=
, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Sele=
ctable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Dell OptiPlex 980
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.4 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI =
Express Root Port 5 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: dc400000-dc5fffff
	Prefetchable memory behind bridge: 00000000dc600000-00000000dc7fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <256ns=
, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Sele=
ctable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Dell OptiPlex 980
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset =
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
	Subsystem: Dell OptiPlex 980
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f7fde000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci_hcd

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5) (prog-i=
f 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f7c00000-f7cfffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Dell OptiPlex 980

00:1f.0 ISA bridge: Intel Corporation 5 Series Chipset LPC Interface Co=
ntroller (rev 05)
	Subsystem: Dell OptiPlex 980
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D10 <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset=
 6 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
	Subsystem: Dell OptiPlex 980
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 45
	Region 0: I/O ports at fe00 [size=3D8]
	Region 1: I/O ports at fe10 [size=3D4]
	Region 2: I/O ports at fe20 [size=3D8]
	Region 3: I/O ports at fe30 [size=3D4]
	Region 4: I/O ports at fec0 [size=3D32]
	Region 5: Memory at ff870000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee8800c  Data: 41d1
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus Con=
troller (rev 05)
	Subsystem: Dell OptiPlex 980
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at f7fdf000 (64-bit, non-prefetchable) [size=3D256]
	Region 4: I/O ports at ece0 [size=3D32]
	Kernel modules: i2c-i801

01:00.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI=
 RV710 [Radeon HD 4550] (prog-if 00 [VGA controller])
	Subsystem: Dell Device 0002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 47
	Region 0: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
	Region 2: Memory at f7df0000 (64-bit, non-prefetchable) [size=3D64K]
	Region 4: I/O ports at dc00 [size=3D256]
	Expansion ROM at f7e00000 [disabled] [size=3D128K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlim=
ited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0 <64n=
s, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMg=
mt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Select=
able De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- C=
omplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000feeff00c  Data: 4142
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 =
Len=3D010 <?>
	Kernel driver in use: radeon
	Kernel modules: radeon

04:00.0 Network controller: Ralink corp. RT2800 802.11n PCI
	Subsystem: Linksys Device 0067
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f7cf0000 (32-bit, non-prefetchable) [size=3D64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: rt2800pci
	Kernel modules: rt2800pci

3f:00.0 Host bridge: Intel Corporation Core Processor QuickPath Archite=
cture Generic Non-Core Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:00.1 Host bridge: Intel Corporation Core Processor QuickPath Archite=
cture System Address Decoder (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 0=
4)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Kernel driver in use: i7core_edac
	Kernel modules: i7core_edac

3f:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0 (r=
ev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:03.0 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:03.1 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Target Address Decoder (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:03.4 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Test Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:04.0 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Channel 0 Control Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:04.1 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Channel 0 Address Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:04.2 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Channel 0 Rank Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:04.3 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Channel 0 Thermal Control Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:05.0 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Channel 1 Control Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:05.1 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Channel 1 Address Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:05.2 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Channel 1 Rank Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

3f:05.3 Host bridge: Intel Corporation Core Processor Integrated Memory=
 Controller Channel 1 Thermal Control Registers (rev 04)
	Subsystem: Intel Corporation Device 8086
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

[7.6.] SCSI information (from /proc/scsi/scsi)=20
$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Mushkin MKNSSDCL Rev: 343A
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TSSTcorp Model: DVD+-RW TS-L633C Rev: DW50
  Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem (please =
look in /proc and include all information that you think to be relevant=
):=20
$ ls /proc
1
10
1018
1030
1049
1052
1055
10680
1079
1080
1097
1099
11
1106
1131
1136
1139
1140
1141
1142
1143
1144
1145
1146
1147
1148
1149
1150
1151
1152
1153
1154
1155
1156
1157
1158
1159
1160
1161
1162
1163
1164
1165
1166
1167
1168
1169
117
1170
1171
1172
1173
1174
1175
1176
1177
1178
1179
118
1180
1181
1182
1183
1184
1185
1186
1187
1188
1189
119
1190
1191
1192
1193
1194
1195
1196
1197
1198
1199
12
120
1200
1201
1202
1203
1204
1205
1206
1207
1208
1209
1210
1211
1212
1213
1218
1219
1220
1224
1225
13
1392
14
1409
1420
1428
1437
1438
1440
1455
1458
1459
1461
1469
1472
1484
1492
1493
15
1502
16
1697
17
1702
1705
1723
1796
18
1801
1802
1804
1810
1816
1820
1824
1834
1837
1854
19
1901
1912
1918
1923
1929
1931
1960
1987
1991
2
20
2047
2062
2081
2093
2095
2103
2111
2117
2128
22
2221
2240
2241
2245
23
24
25
26
2614
266
27
28
29
2989
3
30
3037
32
33
3329
3330
34
35
365
366
367
37
38
39
4
40
41
42
43
44
45
459
46
461
47
48
49
5
50
51
5135
52
53
54
55
57
58
59
593
60
602
61
64
65
66
667
67
68
69
690
7
70
701
702
711
722
79
8
809
82
83
832
84
8439
85
851
86
862
8620
87
878
882
9
905
915
9151
92
924
93
94
95
97
989
acpi
asound
buddyinfo
bus
cgroups
cmdline
consoles
cpuinfo
crypto
devices
diskstats
dma
dri
driver
execdomains
fb
filesystems
fs
interrupts
iomem
ioports
irq
kallsyms
kcore
key-users
kmsg
kpagecount
kpageflags
latency_stats
loadavg
locks
mdstat
meminfo
misc
modules
mounts
mtrr
net
pagetypeinfo
partitions
sched_debug
schedstat
scsi
self
slabinfo
softirqs
stat
swaps
sys
sysrq-trigger
sysvipc
timer_list
timer_stats
tty
uptime
version
vmallocinfo
vmstat
zoneinfo

[X.] Other notes, patches, fixes, workarounds:
$ dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.6.0-030600-generic (apw@gomeisa) (gcc ve=
rsion 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201209302035 SMP Mon Oct =
1 00:36:01 UTC 2012
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-3.6.0-030600-ge=
neric root=3DUUID=3Dc78e3709-82ba-4e14-b214-a74ef951c14a ro quiet splas=
h vt.handoff=3D7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e3ff] u=
sable
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000db6cfbff] u=
sable
[    0.000000] BIOS-e820: [mem 0x00000000db6cfc00-0x00000000db723bff] A=
CPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000db723c00-0x00000000db725bff] A=
CPI data
[    0.000000] BIOS-e820: [mem 0x00000000db725c00-0x00000000dbffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fed003ff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed9ffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000011fffffff] u=
sable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Dell Inc. OptiPlex 980                 /0C522T, BIO=
S A05 11/03/2010
[    0.000000] e820: update [mem 0x00000000-0x0000ffff] usable =3D=3D> =
reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x120000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D3FFF write-protect
[    0.000000]   D4000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0DF800000 mask FFF800000 uncachable
[    0.000000]   1 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x70106=
00070106
[    0.000000] e820: last_pfn =3D 0xdb6cf max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fe710-0x000fe71f] mapped=
 at [ffff8800000fe710]
[    0.000000] initial memory mapped: [mem 0x00000000-0x1fffffff]
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size =
24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0xdb6cefff]
[    0.000000]  [mem 0x00000000-0xdb5fffff] page 2M
[    0.000000]  [mem 0xdb600000-0xdb6cefff] page 4k
[    0.000000] kernel direct mapping tables up to 0xdb6cefff @ [mem 0x1=
f91f000-0x1fffffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x11fffffff]
[    0.000000]  [mem 0x100000000-0x11fffffff] page 2M
[    0.000000] kernel direct mapping tables up to 0x11fffffff @ [mem 0x=
db6c9000-0xdb6cefff]
[    0.000000] RAMDISK: [mem 0x357d8000-0x36be3fff]
[    0.000000] ACPI: RSDP 00000000000fec00 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000000fc7e7 00074 (v01 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: FACP 00000000000fc8d7 000F4 (v03 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: DSDT 00000000ffdc86d0 047BC (v01   DELL    dt_ex 0=
0001000 INTL 20050624)
[    0.000000] ACPI: FACS 00000000db6cfc00 00040
[    0.000000] ACPI: SSDT 00000000ffdccfad 000AC (v01   DELL    st_ex 0=
0001000 INTL 20050624)
[    0.000000] ACPI: APIC 00000000000fc9cb 00092 (v01 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: BOOT 00000000000fca5d 00028 (v01 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: ASF! 00000000000fca85 00096 (v32 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: MCFG 00000000000fcb1b 0003E (v01 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: HPET 00000000000fcb59 00038 (v01 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: TCPA 00000000000fcdb5 00032 (v01 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: ____ 00000000000fcde7 00030 (v01 DELL    B11K    0=
0000015 ASL  00000061)
[    0.000000] ACPI: SSDT 00000000db725c00 0297C (v01  INTEL PPM RCM  8=
0000001 INTL 20061109)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000011ffff=
fff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x11fffffff]
[    0.000000]   NODE_DATA [mem 0x11fffc000-0x11fffffff]
[    0.000000]  [ffffea0000000000-ffffea00047fffff] PMD -> [ffff88011b6=
00000-ffff88011f5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x11fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00010000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xdb6cefff]
[    0.000000]   node   0: [mem 0x100000000-0x11fffffff]
[    0.000000] On node 0 totalpages: 1029725
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 6 pages reserved
[    0.000000]   DMA zone: 3912 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 16320 pages used for memmap
[    0.000000]   DMA32 zone: 878351 pages, LIFO batch:31
[    0.000000]   Normal zone: 2048 pages used for memmap
[    0.000000]   Normal zone: 129024 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GS=
I 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 0000000=
0000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000=
000100000
[    0.000000] PM: Registered nosave memory: 00000000db6cf000 - 0000000=
0db6d0000
[    0.000000] PM: Registered nosave memory: 00000000db6d0000 - 0000000=
0db723000
[    0.000000] PM: Registered nosave memory: 00000000db723000 - 0000000=
0db724000
[    0.000000] PM: Registered nosave memory: 00000000db724000 - 0000000=
0db725000
[    0.000000] PM: Registered nosave memory: 00000000db725000 - 0000000=
0db726000
[    0.000000] PM: Registered nosave memory: 00000000db726000 - 0000000=
0dc000000
[    0.000000] PM: Registered nosave memory: 00000000dc000000 - 0000000=
0f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 0000000=
0fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 0000000=
0fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 0000000=
0fed00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 0000000=
0fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 0000000=
0feda0000
[    0.000000] PM: Registered nosave memory: 00000000feda0000 - 0000000=
0fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 0000000=
0fef00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 0000000=
0ffb00000
[    0.000000] PM: Registered nosave memory: 00000000ffb00000 - 0000000=
100000000
[    0.000000] e820: [mem 0xdc000000-0xf7ffffff] available for PCI devi=
ces
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids=
:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88011fc00000 s84608 r=
8192 d21888 u262144
[    0.000000] pcpu-alloc: s84608 r8192 d21888 u262144 alloc=3D1*209715=
2
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  =
Total pages: 1011287
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.6.0-03=
0600-generic root=3DUUID=3Dc78e3709-82ba-4e14-b214-a74ef951c14a ro quie=
t splash vt.handoff=3D7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bai=
ling!
[    0.000000] Memory: 3950024k/4718592k available (6826k kernel code, =
599692k absent, 168876k reserved, 6358k data, 948k init)
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D8, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_ids=3D=
8.
[    0.000000] NR_IRQS:16640 nr_irqs:744 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 2925.999 MHz processor
[    0.000001] Calibrating delay loop (skipped), value calculated using=
 timer frequency.. 5851.99 BogoMIPS (lpj=3D11703996)
[    0.000004] pid_max: default: 32768 minimum: 301
[    0.000018] Security Framework initialized
[    0.000027] AppArmor: AppArmor initialized
[    0.000253] Dentry cache hash table entries: 524288 (order: 10, 4194=
304 bytes)
[    0.000883] Inode-cache hash table entries: 262144 (order: 9, 209715=
2 bytes)
[    0.001160] Mount-cache hash table entries: 256
[    0.001309] Initializing cgroup subsys cpuacct
[    0.001310] Initializing cgroup subsys devices
[    0.001311] Initializing cgroup subsys freezer
[    0.001312] Initializing cgroup subsys blkio
[    0.001313] Initializing cgroup subsys perf_event
[    0.001329] CPU: Physical Processor ID: 0
[    0.001330] CPU: Processor Core ID: 0
[    0.001334] mce: CPU supports 9 MCE banks
[    0.001341] CPU0: Thermal monitoring enabled (TM1)
[    0.001346] process: using mwait in idle threads
[    0.001349] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.001349] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[    0.001349] tlb_flushall_shift is 0x6
[    0.002927] ACPI: Core revision 20120711
[    0.132877] ftrace: allocating 27795 entries in 109 pages
[    0.143763] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
[    0.183337] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         870  @ 2=
=2E93GHz stepping 05
[    0.288856] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem eve=
nts, Intel PMU driver.
[    0.288860] perf_event_intel: CPU erratum AAJ80 worked around
[    0.288861] perf_event_intel: CPUID marked event: 'bus cycles' unava=
ilable
[    0.288862] ... version:                3
[    0.288862] ... bit width:              48
[    0.288863] ... generic registers:      4
[    0.288864] ... value mask:             0000ffffffffffff
[    0.288865] ... max period:             000000007fffffff
[    0.288865] ... fixed-purpose events:   3
[    0.288866] ... event mask:             000000070000000f
[    0.289026] NMI watchdog: enabled on all CPUs, permanently consumes =
one hw-PMU counter.
[    0.289105] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6=
 #7 OK
[    0.381366] Brought up 8 CPUs
[    0.381369] smpboot: Total of 8 processors activated (46815.98 BogoM=
IPS)
[    0.387090] devtmpfs: initialized
[    0.387889] EVM: security.selinux
[    0.387890] EVM: security.SMACK64
[    0.387891] EVM: security.capability
[    0.387922] PM: Registering ACPI NVS region [mem 0xdb6cfc00-0xdb723b=
ff] (344064 bytes)
[    0.388491] dummy:=20
[    0.388518] RTC time:  0:02:09, date: 10/11/12
[    0.388546] NET: Registered protocol family 16
[    0.388667] ACPI FADT declares the system doesn't support PCIe ASPM,=
 so disable it
[    0.388668] ACPI: bus type pci registered
[    0.388711] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf800=
0000-0xfbffffff] (base 0xf8000000)
[    0.388713] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in=
 E820
[    0.391680] PCI: Using configuration type 1 for base access
[    0.391685] dmi type 0xB1 record - unknown flag
[    0.392353] bio: create slab <bio-0> at 0
[    0.392411] ACPI: Added _OSI(Module Device)
[    0.392412] ACPI: Added _OSI(Processor Device)
[    0.392413] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.392414] ACPI: Added _OSI(Processor Aggregator Device)
[    0.392934] ACPI: EC: Look up EC in DSDT
[    0.427976] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.429740] ACPI BIOS Bug: Warning: Incorrect checksum in table [TCP=
A] - 0x00, should be 0x7E (20120711/tbutils-324)
[    0.430497] ACPI: Interpreter enabled
[    0.430499] ACPI: (supports S0 S1 S3 S4 S5)
[    0.430511] ACPI: Using IOAPIC for interrupt routing
[    0.477230] ACPI: No dock devices found.
[    0.477233] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
[    0.482864] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.494149] pci_root PNP0A03:00: [Firmware Info]: MMCONFIG for domai=
n 0000 [bus 00-3f] only partially covers this bridge
[    0.494181] PCI host bridge to bus 0000:00
[    0.494183] pci_bus 0000:00: busn_res: [bus 00-ff] is inserted under=
 domain [bus 00-ff]
[    0.494185] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.494186] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.494188] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.494189] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000=
bffff]
[    0.494190] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000=
effff]
[    0.494192] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000=
fffff]
[    0.494193] pci_bus 0000:00: root bus resource [mem 0xdb800000-0xf7f=
fffff]
[    0.494194] pci_bus 0000:00: root bus resource [mem 0xff87c000-0xff8=
7ffff]
[    0.494196] pci_bus 0000:00: root bus resource [mem 0xff870000-0xff8=
707ff]
[    0.494197] pci_bus 0000:00: root bus resource [mem 0xfed20000-0xfed=
9ffff]
[    0.494198] pci_bus 0000:00: root bus resource [mem 0xfeda6000-0xfed=
a6fff]
[    0.494199] pci_bus 0000:00: root bus resource [mem 0xfeda7000-0xfed=
a7fff]
[    0.494207] pci 0000:00:00.0: [8086:d131] type 00 class 0x060000
[    0.494251] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    0.494293] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.494310] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    0.494358] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    0.494405] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    0.494457] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    0.494493] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    0.494546] pci 0000:00:16.0: [8086:3b64] type 00 class 0x078000
[    0.494572] pci 0000:00:16.0: reg 10: [mem 0xfeda6000-0xfeda600f 64b=
it]
[    0.494660] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.494682] pci 0000:00:16.2: [8086:3b66] type 00 class 0x010185
[    0.494698] pci 0000:00:16.2: reg 10: [io  0xfe80-0xfe87]
[    0.494706] pci 0000:00:16.2: reg 14: [io  0xfe90-0xfe93]
[    0.494714] pci 0000:00:16.2: reg 18: [io  0xfea0-0xfea7]
[    0.494723] pci 0000:00:16.2: reg 1c: [io  0xfeb0-0xfeb3]
[    0.494733] pci 0000:00:16.2: reg 20: [io  0xfef0-0xfeff]
[    0.494804] pci 0000:00:16.3: [8086:3b67] type 00 class 0x070002
[    0.494821] pci 0000:00:16.3: reg 10: [io  0xec98-0xec9f]
[    0.494831] pci 0000:00:16.3: reg 14: [mem 0xf7fdb000-0xf7fdbfff]
[    0.494927] pci 0000:00:19.0: [8086:10ef] type 00 class 0x020000
[    0.494943] pci 0000:00:19.0: reg 10: [mem 0xf7fe0000-0xf7ffffff]
[    0.494950] pci 0000:00:19.0: reg 14: [mem 0xf7fdc000-0xf7fdcfff]
[    0.494957] pci 0000:00:19.0: reg 18: [io  0xecc0-0xecdf]
[    0.495015] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.495037] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    0.495055] pci 0000:00:1a.0: reg 10: [mem 0xf7fdd000-0xf7fdd3ff]
[    0.495137] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.495159] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.495172] pci 0000:00:1b.0: reg 10: [mem 0xff87c000-0xff87ffff 64b=
it]
[    0.495230] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.495248] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.495309] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.495331] pci 0000:00:1c.4: [8086:3b4a] type 01 class 0x060400
[    0.495391] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.495417] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    0.495435] pci 0000:00:1d.0: reg 10: [mem 0xf7fde000-0xf7fde3ff]
[    0.495515] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.495534] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.495589] pci 0000:00:1f.0: [8086:3b0a] type 00 class 0x060100
[    0.495700] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.495716] pci 0000:00:1f.2: reg 10: [io  0xfe00-0xfe07]
[    0.495722] pci 0000:00:1f.2: reg 14: [io  0xfe10-0xfe13]
[    0.495729] pci 0000:00:1f.2: reg 18: [io  0xfe20-0xfe27]
[    0.495735] pci 0000:00:1f.2: reg 1c: [io  0xfe30-0xfe33]
[    0.495742] pci 0000:00:1f.2: reg 20: [io  0xfec0-0xfedf]
[    0.495748] pci 0000:00:1f.2: reg 24: [mem 0xff870000-0xff8707ff]
[    0.495787] pci 0000:00:1f.2: PME# supported from D3hot
[    0.495801] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.495814] pci 0000:00:1f.3: reg 10: [mem 0xf7fdf000-0xf7fdf0ff 64b=
it]
[    0.495832] pci 0000:00:1f.3: reg 20: [io  0xece0-0xecff]
[    0.495878] pci_bus 0000:01: busn_res: [bus 01] is inserted under [b=
us 00-ff]
[    0.495887] pci 0000:01:00.0: [1002:9540] type 00 class 0x030000
[    0.495899] pci 0000:01:00.0: reg 10: [mem 0xe0000000-0xefffffff 64b=
it pref]
[    0.495908] pci 0000:01:00.0: reg 18: [mem 0xf7df0000-0xf7dfffff 64b=
it]
[    0.495914] pci 0000:01:00.0: reg 20: [io  0xdc00-0xdcff]
[    0.495924] pci 0000:01:00.0: reg 30: [mem 0xf7e00000-0xf7e1ffff pre=
f]
[    0.495951] pci 0000:01:00.0: supports D1 D2
[    0.504095] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.504101] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    0.504107] pci 0000:00:03.0:   bridge window [mem 0xf7d00000-0xf7ef=
ffff]
[    0.504114] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefff=
ffff 64bit pref]
[    0.504164] pci_bus 0000:02: busn_res: [bus 02] is inserted under [b=
us 00-ff]
[    0.504170] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.504218] pci_bus 0000:03: busn_res: [bus 03] is inserted under [b=
us 00-ff]
[    0.504220] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.504244] pci_bus 0000:04: busn_res: [bus 04] is inserted under [b=
us 00-ff]
[    0.504253] pci 0000:04:00.0: [1814:0601] type 00 class 0x028000
[    0.504269] pci 0000:04:00.0: reg 10: [mem 0xf7cf0000-0xf7cfffff]
[    0.504373] pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive de=
code)
[    0.504378] pci 0000:00:1e.0:   bridge window [mem 0xf7c00000-0xf7cf=
ffff]
[    0.504382] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (s=
ubtractive decode)
[    0.504383] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (s=
ubtractive decode)
[    0.504385] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000b=
ffff] (subtractive decode)
[    0.504386] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000e=
ffff] (subtractive decode)
[    0.504387] pci 0000:00:1e.0:   bridge window [mem 0x000f0000-0x000f=
ffff] (subtractive decode)
[    0.504389] pci 0000:00:1e.0:   bridge window [mem 0xdb800000-0xf7ff=
ffff] (subtractive decode)
[    0.504390] pci 0000:00:1e.0:   bridge window [mem 0xff87c000-0xff87=
ffff] (subtractive decode)
[    0.504391] pci 0000:00:1e.0:   bridge window [mem 0xff870000-0xff87=
07ff] (subtractive decode)
[    0.504392] pci 0000:00:1e.0:   bridge window [mem 0xfed20000-0xfed9=
ffff] (subtractive decode)
[    0.504394] pci 0000:00:1e.0:   bridge window [mem 0xfeda6000-0xfeda=
6fff] (subtractive decode)
[    0.504395] pci 0000:00:1e.0:   bridge window [mem 0xfeda7000-0xfeda=
7fff] (subtractive decode)
[    0.504410] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.504905] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
[    0.505213] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
[    0.505564] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5._PRT]
[    0.505795]  pci0000:00: ACPI _OSC support notification failed, disa=
bling PCIe ASPM
[    0.505797]  pci0000:00: Unable to request _OSC control (_OSC suppor=
t mask: 0x08)
[    0.988283] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11=
 12 15)
[    0.989032] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11=
 12 15)
[    0.989779] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11=
 12 15)
[    0.990530] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 =
12 15) *0, disabled.
[    0.991274] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 =
12 15) *0, disabled.
[    0.992027] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11=
 12 15)
[    0.992774] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 =
12 15) *0, disabled.
[    0.993526] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11=
 12 15)
[    0.993764] vgaarb: device added: PCI:0000:01:00.0,decodes=3Dio+mem,=
owns=3Dio+mem,locks=3Dnone
[    0.993766] vgaarb: loaded
[    0.993766] vgaarb: bridge control possible 0000:01:00.0
[    0.993869] SCSI subsystem initialized
[    0.993871] ACPI: bus type scsi registered
[    0.993891] libata version 3.00 loaded.
[    0.993908] ACPI: bus type usb registered
[    0.993920] usbcore: registered new interface driver usbfs
[    0.993927] usbcore: registered new interface driver hub
[    0.993939] usbcore: registered new device driver usb
[    0.993981] PCI: Using ACPI for IRQ routing
[    0.995245] PCI: Discovered peer bus 3f
[    0.995246] PCI: root bus 3f: using default resources
[    0.995247] PCI: Probing PCI hardware (bus 3f)
[    0.995263] PCI host bridge to bus 0000:3f
[    0.995265] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.995266] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfff=
ffffff]
[    0.995268] pci_bus 0000:3f: No busn resource found for root bus, wi=
ll use [bus 3f-ff]
[    0.995270] pci_bus 0000:3f: busn_res: [bus 3f-ff] is inserted under=
 domain [bus 00-ff]
[    0.995274] pci 0000:3f:00.0: [8086:2c51] type 00 class 0x060000
[    0.995288] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    0.995303] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    0.995316] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    0.995331] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    0.995343] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    0.995357] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    0.995371] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    0.995385] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    0.995398] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    0.995411] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    0.995425] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    0.995438] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    0.995451] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    0.995464] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    0.995485] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to=
 3f
[    0.995670] PCI: pci_cache_line_size set to 64 bytes
[    0.995734] Expanded resource reserved due to conflict with PCI Bus =
0000:00
[    0.995736] e820: reserve RAM buffer [mem 0x0009e400-0x0009ffff]
[    0.995737] e820: reserve RAM buffer [mem 0xdb6cfc00-0xdbffffff]
[    0.995794] NetLabel: Initializing
[    0.995795] NetLabel:  domain hash size =3D 128
[    0.995796] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.995803] NetLabel:  unlabeled traffic allowed by default
[    0.995856] HPET: 8 timers in total, 5 timers will be used for per-c=
pu timer
[    0.995862] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 40, 41, 42, 43, 44=
, 0
[    0.995866] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.998906] hpet: hpet2 irq 40 for MSI
[    1.000303] hpet: hpet3 irq 41 for MSI
[    1.001520] hpet: hpet4 irq 42 for MSI
[    1.002731] hpet: hpet5 irq 43 for MSI
[    1.003956] hpet: hpet6 irq 44 for MSI
[    1.007614] Switching to clocksource hpet
[    1.011765] AppArmor: AppArmor Filesystem Enabled
[    1.011780] pnp: PnP ACPI init
[    1.011789] ACPI: bus type pnp registered
[    1.017460] pnp 00:00: [bus 00-ff]
[    1.017462] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.017464] pnp 00:00: [io  0x0000-0x0cf7 window]
[    1.017465] pnp 00:00: [io  0x0d00-0xffff window]
[    1.017467] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.017468] pnp 00:00: [mem 0x000c0000-0x000effff window]
[    1.017469] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    1.017470] pnp 00:00: [mem 0xdb800000-0xf7ffffff window]
[    1.017472] pnp 00:00: [mem 0xff87c000-0xff87ffff window]
[    1.017473] pnp 00:00: [mem 0xff870000-0xff8707ff window]
[    1.017474] pnp 00:00: [mem 0xfed20000-0xfed9ffff window]
[    1.017476] pnp 00:00: [mem 0xfeda6000-0xfeda6fff window]
[    1.017477] pnp 00:00: [mem 0xfeda7000-0xfeda7fff window]
[    1.017505] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (activ=
e)
[    1.019869] pnp 00:01: [io  0x0060]
[    1.019870] pnp 00:01: [io  0x0064]
[    1.019872] pnp 00:01: [io  0x0062-0x0063]
[    1.019873] pnp 00:01: [io  0x0065-0x006f]
[    1.019874] pnp 00:01: [io  0x00e0-0x00ef]
[    1.019875] pnp 00:01: [io  0x0800-0x085f]
[    1.019876] pnp 00:01: [io  0x0c00-0x0c7f]
[    1.019878] pnp 00:01: [io  0x0860-0x08ff]
[    1.019911] system 00:01: [io  0x0800-0x085f] has been reserved
[    1.019913] system 00:01: [io  0x0c00-0x0c7f] has been reserved
[    1.019914] system 00:01: [io  0x0860-0x08ff] has been reserved
[    1.019916] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (ac=
tive)
[    1.020190] pnp 00:02: [io  0x0080-0x009f]
[    1.020192] pnp 00:02: [io  0x0000-0x001f]
[    1.020193] pnp 00:02: [io  0x00c0-0x00df]
[    1.020194] pnp 00:02: [dma 4]
[    1.020208] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (activ=
e)
[    1.020412] pnp 00:03: [io  0x00f0-0x00ff]
[    1.020418] pnp 00:03: [irq 13]
[    1.020435] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (activ=
e)
[    1.020627] pnp 00:04: [io  0x0061]
[    1.020641] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (activ=
e)
[    1.020845] pnp 00:05: [io  0x0070-0x007f]
[    1.020849] pnp 00:05: [irq 8]
[    1.020865] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (activ=
e)
[    1.027552] pnp 00:06: [io  0x0378-0x037f]
[    1.027553] pnp 00:06: [io  0x0778-0x077f]
[    1.027558] pnp 00:06: [irq 7]
[    1.027559] pnp 00:06: [dma 0 disabled]
[    1.027609] pnp 00:06: Plug and Play ACPI device, IDs PNP0401 (activ=
e)
[    1.031790] pnp 00:07: [io  0x03f8-0x03ff]
[    1.031795] pnp 00:07: [irq 4]
[    1.032203] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (activ=
e)
[    1.041588] pnp 00:08: [mem 0xfed00000-0xfed003ff]
[    1.041611] pnp 00:08: Plug and Play ACPI device, IDs PNP0103 (activ=
e)
[    1.041615] pnp: PnP ACPI: found 9 devices
[    1.041615] ACPI: ACPI bus type pnp unregistered
[    1.047452] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [=
bus 02] add_size 1000
[    1.047455] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fff=
ff 64bit pref] to [bus 02] add_size 200000
[    1.047457] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fff=
ff] to [bus 02] add_size 200000
[    1.047471] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [=
bus 03] add_size 1000
[    1.047473] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fff=
ff 64bit pref] to [bus 03] add_size 200000
[    1.047474] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fff=
ff] to [bus 03] add_size 200000
[    1.047484] pci 0000:00:1c.0: res[14]=3D[mem 0x00100000-0x000fffff] =
get_res_add_size add_size 200000
[    1.047486] pci 0000:00:1c.0: res[15]=3D[mem 0x00100000-0x000fffff 6=
4bit pref] get_res_add_size add_size 200000
[    1.047487] pci 0000:00:1c.4: res[14]=3D[mem 0x00100000-0x000fffff] =
get_res_add_size add_size 200000
[    1.047488] pci 0000:00:1c.4: res[15]=3D[mem 0x00100000-0x000fffff 6=
4bit pref] get_res_add_size add_size 200000
[    1.047490] pci 0000:00:1c.0: res[13]=3D[io  0x1000-0x0fff] get_res_=
add_size add_size 1000
[    1.047491] pci 0000:00:1c.4: res[13]=3D[io  0x1000-0x0fff] get_res_=
add_size add_size 1000
[    1.047494] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdc000000-0xdc1=
fffff]
[    1.047497] pci 0000:00:1c.0: BAR 15: assigned [mem 0xdc200000-0xdc3=
fffff 64bit pref]
[    1.047498] pci 0000:00:1c.4: BAR 14: assigned [mem 0xdc400000-0xdc5=
fffff]
[    1.047500] pci 0000:00:1c.4: BAR 15: assigned [mem 0xdc600000-0xdc7=
fffff 64bit pref]
[    1.047502] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    1.047504] pci 0000:00:1c.4: BAR 13: assigned [io  0x2000-0x2fff]
[    1.047506] pci 0000:00:03.0: PCI bridge to [bus 01]
[    1.047508] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    1.047511] pci 0000:00:03.0:   bridge window [mem 0xf7d00000-0xf7ef=
ffff]
[    1.047513] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefff=
ffff 64bit pref]
[    1.047517] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    1.047519] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    1.047522] pci 0000:00:1c.0:   bridge window [mem 0xdc000000-0xdc1f=
ffff]
[    1.047525] pci 0000:00:1c.0:   bridge window [mem 0xdc200000-0xdc3f=
ffff 64bit pref]
[    1.047529] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    1.047531] pci 0000:00:1c.4:   bridge window [io  0x2000-0x2fff]
[    1.047535] pci 0000:00:1c.4:   bridge window [mem 0xdc400000-0xdc5f=
ffff]
[    1.047538] pci 0000:00:1c.4:   bridge window [mem 0xdc600000-0xdc7f=
ffff 64bit pref]
[    1.047542] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    1.047546] pci 0000:00:1e.0:   bridge window [mem 0xf7c00000-0xf7cf=
ffff]
[    1.047568] pci 0000:00:1e.0: setting latency timer to 64
[    1.047571] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.047572] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.047574] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.047575] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000effff]
[    1.047576] pci_bus 0000:00: resource 8 [mem 0x000f0000-0x000fffff]
[    1.047578] pci_bus 0000:00: resource 9 [mem 0xdb800000-0xf7ffffff]
[    1.047579] pci_bus 0000:00: resource 10 [mem 0xff87c000-0xff87ffff]
[    1.047580] pci_bus 0000:00: resource 11 [mem 0xff870000-0xff8707ff]
[    1.047581] pci_bus 0000:00: resource 12 [mem 0xfed20000-0xfed9ffff]
[    1.047583] pci_bus 0000:00: resource 13 [mem 0xfeda6000-0xfeda6fff]
[    1.047584] pci_bus 0000:00: resource 14 [mem 0xfeda7000-0xfeda7fff]
[    1.047585] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    1.047587] pci_bus 0000:01: resource 1 [mem 0xf7d00000-0xf7efffff]
[    1.047588] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xefffffff 6=
4bit pref]
[    1.047589] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    1.047590] pci_bus 0000:02: resource 1 [mem 0xdc000000-0xdc1fffff]
[    1.047592] pci_bus 0000:02: resource 2 [mem 0xdc200000-0xdc3fffff 6=
4bit pref]
[    1.047593] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    1.047594] pci_bus 0000:03: resource 1 [mem 0xdc400000-0xdc5fffff]
[    1.047596] pci_bus 0000:03: resource 2 [mem 0xdc600000-0xdc7fffff 6=
4bit pref]
[    1.047597] pci_bus 0000:04: resource 1 [mem 0xf7c00000-0xf7cfffff]
[    1.047598] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    1.047600] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    1.047601] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    1.047602] pci_bus 0000:04: resource 7 [mem 0x000c0000-0x000effff]
[    1.047604] pci_bus 0000:04: resource 8 [mem 0x000f0000-0x000fffff]
[    1.047605] pci_bus 0000:04: resource 9 [mem 0xdb800000-0xf7ffffff]
[    1.047606] pci_bus 0000:04: resource 10 [mem 0xff87c000-0xff87ffff]
[    1.047607] pci_bus 0000:04: resource 11 [mem 0xff870000-0xff8707ff]
[    1.047609] pci_bus 0000:04: resource 12 [mem 0xfed20000-0xfed9ffff]
[    1.047610] pci_bus 0000:04: resource 13 [mem 0xfeda6000-0xfeda6fff]
[    1.047611] pci_bus 0000:04: resource 14 [mem 0xfeda7000-0xfeda7fff]
[    1.047613] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    1.047614] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    1.047636] NET: Registered protocol family 2
[    1.048063] TCP established hash table entries: 524288 (order: 11, 8=
388608 bytes)
[    1.049979] TCP bind hash table entries: 65536 (order: 8, 1048576 by=
tes)
[    1.050213] TCP: Hash tables configured (established 524288 bind 655=
36)
[    1.050229] TCP: reno registered
[    1.050235] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    1.050259] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes=
)
[    1.050337] NET: Registered protocol family 1
[    1.050438] pci 0000:01:00.0: Boot video device
[    1.050458] PCI: CLS 64 bytes, default 64
[    1.050495] Trying to unpack rootfs image as initramfs...
[    1.329874] Freeing initrd memory: 20528k freed
[    1.332431] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
[    1.332436] software IO TLB [mem 0xd76c9000-0xdb6c8fff] (64MB) mappe=
d at [ffff8800d76c9000-ffff8800db6c8fff]
[    1.332472] Simple Boot Flag at 0x7a set to 0x80
[    1.332854] audit: initializing netlink socket (disabled)
[    1.332863] type=3D2000 audit(1349913730.228:1): initialized
[    1.349581] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.350705] VFS: Disk quotas dquot_6.5.2
[    1.350734] Dquot-cache hash table entries: 512 (order 0, 4096 bytes=
)
[    1.351064] fuse init (API version 7.20)
[    1.351122] msgmni has been set to 7754
[    1.351414] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 252)
[    1.351436] io scheduler noop registered
[    1.351437] io scheduler deadline registered (default)
[    1.351454] io scheduler cfq registered
[    1.351623] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.351634] pciehp: PCI Express Hot Plug Controller Driver version: =
0.4
[    1.351666] intel_idle: MWAIT substates: 0x1120
[    1.351675] intel_idle: v0.4 model 0x1E
[    1.351676] intel_idle: lapic_timer_reliable_states 0x2
[    1.351743] input: Power Button as /devices/LNXSYSTM:00/device:00/PN=
P0C0C:00/input/input0
[    1.351747] ACPI: Power Button [VBTN]
[    1.351774] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/=
input/input1
[    1.351776] ACPI: Power Button [PWRF]
[    1.351828] ACPI: Requesting acpi_cpufreq
[    1.427746] GHES: HEST is not enabled!
[    1.427793] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.448132] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.469269] 00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.489537] 0000:00:16.3: ttyS4 at I/O 0xec98 (irq =3D 17) is a 1655=
0A
[    1.489874] Linux agpgart interface v0.103
[    1.490881] brd: module loaded
[    1.491403] loop: module loaded
[    1.491467] ahci 0000:00:1f.2: version 3.0
[    1.491512] ahci 0000:00:1f.2: irq 45 for MSI/MSI-X
[    1.506242] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbp=
s 0x17 impl SATA mode
[    1.506248] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp fbs=
 pio ems sxs apst=20
[    1.506254] ahci 0000:00:1f.2: setting latency timer to 64
[    1.506262] ahci 0000:00:1f.2: port 0 is not capable of FBS
[    1.506302] ahci 0000:00:1f.2: port 1 is not capable of FBS
[    1.514193] ahci 0000:00:1f.2: port 2 is not capable of FBS
[    1.530474] scsi0 : ahci
[    1.530525] scsi1 : ahci
[    1.530569] scsi2 : ahci
[    1.530615] scsi3 : ahci
[    1.530661] scsi4 : ahci
[    1.530704] scsi5 : ahci
[    1.530727] ata1: SATA max UDMA/133 abar m2048@0xff870000 port 0xff8=
70100 irq 45
[    1.530729] ata2: SATA max UDMA/133 abar m2048@0xff870000 port 0xff8=
70180 irq 45
[    1.530731] ata3: SATA max UDMA/133 abar m2048@0xff870000 port 0xff8=
70200 irq 45
[    1.530732] ata4: DUMMY
[    1.530733] ata5: SATA max UDMA/133 abar m2048@0xff870000 port 0xff8=
70300 irq 45
[    1.530734] ata6: DUMMY
[    1.530792] pata_acpi 0000:00:16.2: setting latency timer to 64
[    1.530836] ata_generic 0000:00:16.2: setting latency timer to 64
[    1.530991] scsi6 : ata_generic
[    1.531035] scsi7 : ata_generic
[    1.531059] ata7: PATA max UDMA/100 cmd 0xfe80 ctl 0xfe90 bmdma 0xfe=
f0 irq 18
[    1.531060] ata8: PATA max UDMA/100 cmd 0xfea0 ctl 0xfeb0 bmdma 0xfe=
f8 irq 18
[    1.531221] libphy: Fixed MDIO Bus: probed
[    1.531248] tun: Universal TUN/TAP device driver, 1.6
[    1.531249] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.531282] PPP generic driver version 2.4.2
[    1.531323] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    1.531345] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.531347] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    1.531351] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned =
bus number 1
[    1.535248] ehci_hcd 0000:00:1a.0: debug port 2
[    1.535254] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supp=
orted
[    1.535265] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf7fdd000
[    1.546110] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.546141] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    1.546145] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.546148] usb usb1: Product: EHCI Host Controller
[    1.546152] usb usb1: Manufacturer: Linux 3.6.0-030600-generic ehci_=
hcd
[    1.546155] usb usb1: SerialNumber: 0000:00:1a.0
[    1.546253] hub 1-0:1.0: USB hub found
[    1.546256] hub 1-0:1.0: 3 ports detected
[    1.546304] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.546307] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    1.546310] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned =
bus number 2
[    1.550218] ehci_hcd 0000:00:1d.0: debug port 2
[    1.550223] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supp=
orted
[    1.550234] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf7fde000
[    1.562063] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.562086] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    1.562090] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.562094] usb usb2: Product: EHCI Host Controller
[    1.562097] usb usb2: Manufacturer: Linux 3.6.0-030600-generic ehci_=
hcd
[    1.562100] usb usb2: SerialNumber: 0000:00:1d.0
[    1.562194] hub 2-0:1.0: USB hub found
[    1.562197] hub 2-0:1.0: 3 ports detected
[    1.562236] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.562246] uhci_hcd: USB Universal Host Controller Interface driver
[    1.562275] usbcore: registered new interface driver libusual
[    1.562291] i8042: PNP: No PS/2 controller found. Probing ports dire=
ctly.
[    1.565049] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.565053] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.565128] mousedev: PS/2 mouse device common for all mice
[    1.565215] rtc_cmos 00:05: RTC can wake from S4
[    1.565314] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.565338] rtc0: alarms up to one day, 242 bytes nvram, hpet irqs
[    1.565379] device-mapper: uevent: version 1.0.3
[    1.565421] device-mapper: ioctl: 4.23.0-ioctl (2012-07-25) initiali=
sed: dm-devel@redhat.com
[    1.565506] cpuidle: using governor ladder
[    1.565615] cpuidle: using governor menu
[    1.565616] EFI Variables Facility v0.08 2004-May-17
[    1.565751] ashmem: initialized
[    1.565835] TCP: cubic registered
[    1.565897] NET: Registered protocol family 10
[    1.566008] NET: Registered protocol family 17
[    1.566014] Key type dns_resolver registered
[    1.566244] PM: Hibernation image not present or could not be loaded=
=2E
[    1.566251] registered taskstats version 1
[    1.568442] Key type trusted registered
[    1.570830] Key type encrypted registered
[    1.573574]   Magic number: 0:807:0
[    1.573752] rtc_cmos 00:05: setting system clock to 2012-10-11 00:02=
:10 UTC (1349913730)
[    1.575936] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.575938] EDD information not available.
[    1.849540] ata3: SATA link down (SStatus 4 SControl 300)
[    1.857475] usb 1-1: new high-speed USB device number 2 using ehci_h=
cd
[    1.989377] usb 1-1: New USB device found, idVendor=3D8087, idProduc=
t=3D0020
[    1.989383] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    1.989908] hub 1-1:1.0: USB hub found
[    1.990119] hub 1-1:1.0: 6 ports detected
[    2.020899] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.020920] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.031349] ata1.00: ATA-8: Mushkin MKNSSDCL40GB-DX, 343A13F0, max U=
DMA/133
[    2.031354] ata1.00: 78161328 sectors, multi 1: LBA48 NCQ (depth 31/=
32), AA
[    2.041325] ata1.00: configured for UDMA/133
[    2.041734] scsi 0:0:0:0: Direct-Access     ATA      Mushkin MKNSSDC=
L 343A PQ: 0 ANSI: 5
[    2.041992] sd 0:0:0:0: [sda] 78161328 512-byte logical blocks: (40.=
0 GB/37.2 GiB)
[    2.042084] sd 0:0:0:0: [sda] Write Protect is off
[    2.042089] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.042096] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.042117] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[    2.042728] ata2.00: ATAPI: TSSTcorp DVD+/-RW TS-L633C, DW50, max UD=
MA/100
[    2.042735] ata2.00: applying bridge limits
[    2.042777]  sda: sda1 sda2 < sda5 >
[    2.043637] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.063812] ata2.00: configured for UDMA/100
[    2.068969] scsi 1:0:0:0: CD-ROM            TSSTcorp DVD+-RW TS-L633=
C DW50 PQ: 0 ANSI: 5
[    2.076268] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/fo=
rm2 cdda tray
[    2.076272] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.076738] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.076884] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    2.100614] usb 2-1: new high-speed USB device number 2 using ehci_h=
cd
[    2.232700] usb 2-1: New USB device found, idVendor=3D8087, idProduc=
t=3D0020
[    2.232706] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    2.233232] hub 2-1:1.0: USB hub found
[    2.233445] hub 2-1:1.0: 8 ports detected
[    2.327976] tsc: Refined TSC clocksource calibration: 2925.999 MHz
[    2.327981] Switching to clocksource tsc
[    2.503672] usb 2-1.2: new high-speed USB device number 3 using ehci=
_hcd
[    2.628072] usb 2-1.2: New USB device found, idVendor=3D19ff, idProd=
uct=3D0102
[    2.628077] usb 2-1.2: New USB device strings: Mfr=3D2, Product=3D1,=
 SerialNumber=3D3
[    2.628081] usb 2-1.2: Product: Dynex 1.3MP Webcam
[    2.628084] usb 2-1.2: Manufacturer: Dynex
[    2.628088] usb 2-1.2: SerialNumber: 100505_A_50506
[    2.703120] usb 2-1.6: new low-speed USB device number 4 using ehci_=
hcd
[    2.800219] usb 2-1.6: New USB device found, idVendor=3D046d, idProd=
uct=3Dc408
[    2.800224] usb 2-1.6: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    2.800227] usb 2-1.6: Product: USB Trackball
[    2.800231] usb 2-1.6: Manufacturer: Logitech
[    2.870656] usb 2-1.7: new full-speed USB device number 5 using ehci=
_hcd
[    2.963023] usb 2-1.7: New USB device found, idVendor=3D0cf3, idProd=
uct=3D3000
[    2.963028] usb 2-1.7: New USB device strings: Mfr=3D0, Product=3D0,=
 SerialNumber=3D0
[    5.594993] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.595510] ata5.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 15 ports=
, feat 0x5/0xf
[    5.595995] ahci 0000:00:1f.2: FBS is enabled
[    5.596450] ata5.15: PMP product ID mismatch
[   13.920014] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
[   13.920355] ata5.15: Port Multiplier vendor mismatch '0x197b' !=3D '=
0x0'
[   13.920360] ata5.15: PMP revalidation failed (errno=3D-19)
[   13.920367] ata5.15: limiting SATA link speed to 1.5 Gbps
[   22.244909] ata5.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310=
)
[   22.245287] ata5.15: Port Multiplier vendor mismatch '0x197b' !=3D '=
0x0'
[   22.245292] ata5.15: PMP revalidation failed (errno=3D-19)
[   30.569866] ata5.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310=
)
[   30.570356] ata5.15: Port Multiplier vendor mismatch '0x197b' !=3D '=
0x0'
[   30.570361] ata5.15: PMP revalidation failed (errno=3D-19)
[   30.570368] ata5.15: failed to recover PMP after 5 tries, giving up
[   30.570373] ata5.15: Port Multiplier detaching
[   30.570379] ahci 0000:00:1f.2: FBS is disabled
[   30.570386] ata5.00: disabled
[   30.737918] Freeing unused kernel memory: 948k freed
[   30.738025] Write protecting the kernel read-only data: 12288k
[   30.741020] Freeing unused kernel memory: 1356k freed
[   30.743471] Freeing unused kernel memory: 1048k freed
[   30.762006] udevd[147]: starting version 175
[   30.772837] wmi: Mapper loaded
[   30.776387] [drm] Initialized drm 1.1.0 20060810
[   30.777428] e1000e: Intel(R) PRO/1000 Network Driver - 2.0.0-k
[   30.777429] e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
[   30.777469] e1000e 0000:00:19.0: setting latency timer to 64
[   30.777527] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec=
) set to dynamic conservative mode
[   30.777561] e1000e 0000:00:19.0: irq 46 for MSI/MSI-X
[   30.781903] [drm] radeon defaulting to kernel modesetting.
[   30.781906] [drm] radeon kernel modesetting enabled.
[   30.782524] [drm] initializing kernel modesetting (RV710 0x1002:0x95=
40 0x1028:0x0002).
[   30.782542] [drm] register mmio base: 0xF7DF0000
[   30.782543] [drm] register mmio size: 65536
[   30.782605] ATOM BIOS: 113
[   30.782624] radeon 0000:01:00.0: VRAM: 512M 0x0000000000000000 - 0x0=
00000001FFFFFFF (512M used)
[   30.782626] radeon 0000:01:00.0: GTT: 512M 0x0000000020000000 - 0x00=
0000003FFFFFFF
[   30.819039] [drm] Detected VRAM RAM=3D512M, BAR=3D256M
[   30.819042] [drm] RAM width 64bits DDR
[   30.819106] usbcore: registered new interface driver usbhid
[   30.819108] usbhid: USB HID core driver
[   30.819867] [TTM] Zone  kernel: Available graphics memory: 1986952 k=
iB
[   30.819869] [TTM] Initializing pool allocator
[   30.819873] [TTM] Initializing DMA pool allocator
[   30.819894] [drm] radeon: 512M of VRAM memory ready
[   30.819896] [drm] radeon: 512M of GTT memory ready.
[   30.819908] [drm] Supports vblank timestamp caching Rev 1 (10.10.201=
0).
[   30.819909] [drm] Driver supports precise vblank timestamp query.
[   30.819943] radeon 0000:01:00.0: irq 47 for MSI/MSI-X
[   30.819950] radeon 0000:01:00.0: radeon: using MSI.
[   30.819975] [drm] radeon: irq initialized.
[   30.819978] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   30.820841] [drm] probing gen 2 caps for device 8086:d138 =3D 2/0
[   30.820844] [drm] enabling PCIE gen 2 link speeds, disable with rade=
on.pcie_gen2=3D0
[   30.820910] [drm] Loading RV710 Microcode
[   30.837699] input: Logitech USB Trackball as /devices/pci0000:00/000=
0:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.0/input/input2
[   30.837792] hid-generic 0003:046D:C408.0001: input,hidraw0: USB HID =
v1.10 Mouse [Logitech USB Trackball] on usb-0000:00:1d.0-1.6/input0
[   30.840534] [drm] PCIE GART of 512M enabled (table at 0x000000000004=
0000).
[   30.840598] radeon 0000:01:00.0: WB enabled
[   30.840600] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr=
 0x0000000020000c00 and cpu addr 0xffff880114ca5c00
[   30.886963] [drm] ring test on 0 succeeded in 1 usecs
[   30.887145] [drm] ib test on ring 0 succeeded in 0 usecs
[   30.887495] [drm] Radeon Display Connectors
[   30.887496] [drm] Connector 0:
[   30.887497] [drm]   DP-1
[   30.887498] [drm]   HPD2
[   30.887499] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0=
x7e5c 0x7e5c
[   30.887499] [drm]   Encoders:
[   30.887500] [drm]     DFP1: INTERNAL_UNIPHY
[   30.887501] [drm] Connector 1:
[   30.887501] [drm]   DVI-I-1
[   30.887502] [drm]   HPD4
[   30.887503] [drm]   DDC: 0x7f10 0x7f10 0x7f14 0x7f14 0x7f18 0x7f18 0=
x7f1c 0x7f1c
[   30.887504] [drm]   Encoders:
[   30.887504] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   30.887505] [drm]     DFP2: INTERNAL_UNIPHY2
[   30.887523] [drm] Internal thermal controller with fan control
[   30.887543] [drm] radeon: power management initialized
[   30.953878] [drm] fb mappable at 0xE0142000
[   30.953879] [drm] vram apper at 0xE0000000
[   30.953880] [drm] size 5242880
[   30.953880] [drm] fb depth is 24
[   30.953881] [drm]    pitch is 5120
[   30.954110] fbcon: radeondrmfb (fb0) is primary device
[   31.004375] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1=
) 84:2b:2b:bd:07:11
[   31.004376] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Con=
nection
[   31.004411] e1000e 0000:00:19.0: eth0: MAC: 9, PHY: 9, PBA No: A002F=
=46-0FF
[   31.153823] Console: switching to colour frame buffer device 160x64
[   31.155891] fb0: radeondrmfb frame buffer device
[   31.155891] drm: registered panic notifier
[   31.155894] [drm] Initialized radeon 2.22.0 20080528 for 0000:01:00.=
0 on minor 0
[   31.327857] EXT4-fs (sda1): INFO: recovery required on readonly file=
system
[   31.327859] EXT4-fs (sda1): write access will be enabled during reco=
very
[   31.363369] EXT4-fs (sda1): recovery complete
[   31.363492] EXT4-fs (sda1): mounted filesystem with ordered data mod=
e. Opts: (null)
[   31.576626] Adding 1648636k swap on /dev/sda5.  Priority:-1 extents:=
1 across:1648636k SS
[   31.603062] udevd[461]: starting version 175
[   31.652365] lp: driver loaded but no devices found
[   31.665890] parport_pc 00:06: reported by Plug and Play ACPI
[   31.665951] parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [=
PCSPP,TRISTATE,COMPAT,ECP]
[   31.671616] mei 0000:00:16.0: setting latency timer to 64
[   31.671657] mei 0000:00:16.0: irq 48 for MSI/MSI-X
[   31.673193] RPC: Registered named UNIX socket transport module.
[   31.673195] RPC: Registered udp transport module.
[   31.673196] RPC: Registered tcp transport module.
[   31.673197] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[   31.680802] ACPI Warning: 0x0000000000000828-0x000000000000082f Syst=
emIO conflicts with Region \GLBC 1 (20120711/utaddress-251)
[   31.680808] ACPI Warning: 0x0000000000000828-0x000000000000082f Syst=
emIO conflicts with Region \SACT 2 (20120711/utaddress-251)
[   31.680818] ACPI Warning: 0x0000000000000828-0x000000000000082f Syst=
emIO conflicts with Region \SSTS 3 (20120711/utaddress-251)
[   31.680822] ACPI: If an ACPI driver is available for this device, yo=
u should use it instead of the native driver
[   31.680892] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   31.685097] FS-Cache: Loaded
[   31.687066] EDAC MC: Ver: 3.0.0
[   31.691880] FS-Cache: Netfs 'nfs' registered for caching
[   31.692152] EDAC MC0: Giving out device to 'i7core_edac.c' 'i7 core =
#0': DEV 0000:3f:03.0
[   31.692197] EDAC PCI0: Giving out device to module 'i7core_edac' con=
troller 'EDAC PCI controller': DEV '0000:3f:03.0' (POLLED)
[   31.692203] EDAC i7core: Driver loaded, 1 memory controller(s) found=
=2E
[   31.726296] microcode: CPU0 sig=3D0x106e5, pf=3D0x2, revision=3D0x4
[   31.727241] cfg80211: Calling CRDA to update world regulatory domain
[   31.728976] Bluetooth: Core ver 2.16
[   31.728991] NET: Registered protocol family 31
[   31.728993] Bluetooth: HCI device and connection manager initialized
[   31.728994] Bluetooth: HCI socket layer initialized
[   31.728995] Bluetooth: L2CAP socket layer initialized
[   31.729000] Bluetooth: SCO socket layer initialized
[   31.732291] dcdbas dcdbas: Dell Systems Management Base Driver (vers=
ion 5.6.0-3.2)
[   31.739240] ppdev: user-space parallel port driver
[   31.743118] Linux video capture interface: v2.00
[   31.751600] gpio_ich: GPIO from 180 to 255 on gpio_ich
[   31.753834] input: Dell WMI hotkeys as /devices/virtual/input/input3
[   31.758794] microcode: CPU1 sig=3D0x106e5, pf=3D0x2, revision=3D0x4
[   31.759743] microcode: CPU2 sig=3D0x106e5, pf=3D0x2, revision=3D0x4
[   31.760571] microcode: CPU3 sig=3D0x106e5, pf=3D0x2, revision=3D0x4
[   31.761471] microcode: CPU4 sig=3D0x106e5, pf=3D0x2, revision=3D0x4
[   31.762438] microcode: CPU5 sig=3D0x106e5, pf=3D0x2, revision=3D0x4
[   31.763470] microcode: CPU6 sig=3D0x106e5, pf=3D0x2, revision=3D0x4
[   31.763639] lp0: using parport0 (interrupt-driven).
[   31.765932] microcode: CPU7 sig=3D0x106e5, pf=3D0x2, revision=3D0x4
[   31.767511] microcode: Microcode Update Driver: v2.00 <tigran@aivazi=
an.fsnet.co.uk>, Peter Oruba
[   31.771090] cfg80211: World regulatory domain updated:
[   31.771093] cfg80211:   (start_freq - end_freq @ bandwidth), (max_an=
tenna_gain, max_eirp)
[   31.771095] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (30=
0 mBi, 2000 mBm)
[   31.771097] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz), (30=
0 mBi, 2000 mBm)
[   31.771098] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (30=
0 mBi, 2000 mBm)
[   31.771100] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (30=
0 mBi, 2000 mBm)
[   31.771101] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (30=
0 mBi, 2000 mBm)
[   31.772087] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work pr=
operly. Using workaround
[   31.778507] snd_hda_intel 0000:00:1b.0: irq 49 for MSI/MSI-X
[   31.788834] 3:3:1: cannot get freq at ep 0x84
[   31.790027] uvcvideo: Found UVC 1.00 device Dynex 1.3MP Webcam (19ff=
:0102)
[   31.790029] usbcore: registered new interface driver snd-usb-audio
[   31.797725] input: Dynex 1.3MP Webcam as /devices/pci0000:00/0000:00=
:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/input/input4
[   31.797852] usbcore: registered new interface driver uvcvideo
[   31.797854] USB Video Class driver (1.1.1)
[   31.813996] cfg80211: Updating information on frequency 2412 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.813998] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.813999] cfg80211: Updating information on frequency 2417 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814001] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814001] cfg80211: Updating information on frequency 2422 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814002] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814003] cfg80211: Updating information on frequency 2427 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814007] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814008] cfg80211: Updating information on frequency 2432 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814009] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814010] cfg80211: Updating information on frequency 2437 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814011] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814012] cfg80211: Updating information on frequency 2442 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814013] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814014] cfg80211: Updating information on frequency 2447 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814015] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814016] cfg80211: Updating information on frequency 2452 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814018] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814018] cfg80211: Updating information on frequency 2457 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814020] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814021] cfg80211: Updating information on frequency 2462 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814022] cfg80211: 2402000 KHz - 2472000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814023] cfg80211: Updating information on frequency 2467 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814024] cfg80211: 2457000 KHz - 2482000 KHz @ 20000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814025] cfg80211: Updating information on frequency 2472 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814026] cfg80211: 2457000 KHz - 2482000 KHz @ 20000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814027] cfg80211: Updating information on frequency 2484 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814028] cfg80211: 2474000 KHz - 2494000 KHz @ 20000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814029] cfg80211: Updating information on frequency 5180 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814030] cfg80211: 5170000 KHz - 5250000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814031] cfg80211: Updating information on frequency 5190 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814032] cfg80211: 5170000 KHz - 5250000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814033] cfg80211: Updating information on frequency 5200 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814034] cfg80211: 5170000 KHz - 5250000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814035] cfg80211: Updating information on frequency 5220 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814036] cfg80211: 5170000 KHz - 5250000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814052] cfg80211: Updating information on frequency 5230 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814053] cfg80211: 5170000 KHz - 5250000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814063] cfg80211: Updating information on frequency 5240 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814064] cfg80211: 5170000 KHz - 5250000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814065] cfg80211: Disabling freq 5260 MHz
[   31.814066] cfg80211: Disabling freq 5270 MHz
[   31.814066] cfg80211: Disabling freq 5280 MHz
[   31.814067] cfg80211: Disabling freq 5300 MHz
[   31.814068] cfg80211: Disabling freq 5310 MHz
[   31.814068] cfg80211: Disabling freq 5320 MHz
[   31.814069] cfg80211: Disabling freq 5500 MHz
[   31.814069] cfg80211: Disabling freq 5510 MHz
[   31.814070] cfg80211: Disabling freq 5520 MHz
[   31.814071] cfg80211: Disabling freq 5540 MHz
[   31.814071] cfg80211: Disabling freq 5550 MHz
[   31.814072] cfg80211: Disabling freq 5560 MHz
[   31.814073] cfg80211: Disabling freq 5580 MHz
[   31.814073] cfg80211: Disabling freq 5590 MHz
[   31.814074] cfg80211: Disabling freq 5600 MHz
[   31.814075] cfg80211: Disabling freq 5620 MHz
[   31.814075] cfg80211: Disabling freq 5630 MHz
[   31.814076] cfg80211: Disabling freq 5640 MHz
[   31.814077] cfg80211: Disabling freq 5660 MHz
[   31.814077] cfg80211: Disabling freq 5670 MHz
[   31.814078] cfg80211: Disabling freq 5680 MHz
[   31.814079] cfg80211: Disabling freq 5700 MHz
[   31.814079] cfg80211: Updating information on frequency 5745 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814081] cfg80211: 5735000 KHz - 5835000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814082] cfg80211: Updating information on frequency 5755 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814083] cfg80211: 5735000 KHz - 5835000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814084] cfg80211: Updating information on frequency 5765 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814085] cfg80211: 5735000 KHz - 5835000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814086] cfg80211: Updating information on frequency 5785 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814087] cfg80211: 5735000 KHz - 5835000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814088] cfg80211: Updating information on frequency 5795 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814089] cfg80211: 5735000 KHz - 5835000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814090] cfg80211: Updating information on frequency 5805 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814091] cfg80211: 5735000 KHz - 5835000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814092] cfg80211: Updating information on frequency 5825 MHz for=
 a 20 MHz width channel with regulatory rule:
[   31.814093] cfg80211: 5735000 KHz - 5835000 KHz @ 40000 KHz), (300 m=
Bi, 2000 mBm)
[   31.814094] cfg80211: Disabling freq 5835 MHz
[   31.814094] cfg80211: Disabling freq 5845 MHz
[   31.814095] cfg80211: Disabling freq 5855 MHz
[   31.814096] cfg80211: Disabling freq 5865 MHz
[   31.814096] cfg80211: Disabling freq 4920 MHz
[   31.814097] cfg80211: Disabling freq 4940 MHz
[   31.814098] cfg80211: Disabling freq 4960 MHz
[   31.814098] cfg80211: Disabling freq 4980 MHz
[   31.814099] cfg80211: Disabling freq 6040 MHz
[   31.814100] cfg80211: Disabling freq 6060 MHz
[   31.814100] cfg80211: Disabling freq 6080 MHz
[   31.825867] hda_codec: ALC269VB: SKU not ready 0x411111f0
[   31.826393] ieee80211 phy0: Selected rate control algorithm 'minstre=
l_ht'
[   31.826582] Registered led device: rt2800pci-phy0::radio
[   31.826601] Registered led device: rt2800pci-phy0::assoc
[   31.826617] Registered led device: rt2800pci-phy0::quality
[   31.830443] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00=
:1b.0/sound/card0/input5
[   31.830527] input: HDA Intel Front Mic as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input6
[   31.830623] input: HDA Intel Front Headphone as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input7
[   31.830723] input: HDA Intel Line Out as /devices/pci0000:00/0000:00=
:1b.0/sound/card0/input8
[   32.006663] usbcore: registered new interface driver ath3k
[   32.011236] EXT4-fs (sda1): re-mounted. Opts: errors=3Dremount-ro
[   32.103758] init: failsafe main process (990) killed by TERM signal
[   32.107195] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   32.120117] init: idmapd-mounting (/net/khaeru-storage) main process=
 (945) killed by TERM signal
[   32.148416] Bluetooth: RFCOMM TTY layer initialized
[   32.148421] Bluetooth: RFCOMM socket layer initialized
[   32.148422] Bluetooth: RFCOMM ver 1.11
[   32.148458] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   32.148460] Bluetooth: BNEP filters: protocol multicast
[   32.187851] usb 2-1.7: USB disconnect, device number 5
[   32.321081] e1000e 0000:00:19.0: irq 46 for MSI/MSI-X
[   32.424694] e1000e 0000:00:19.0: irq 46 for MSI/MSI-X
[   32.424797] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   32.556645] type=3D1400 audit(1349913761.566:2): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/sbin/dhclient" pid=3D1123 comm=3D"=
apparmor_parser"
[   32.556755] type=3D1400 audit(1349913761.566:3): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/NetworkManager/nm-dhcp-cli=
ent.action" pid=3D1123 comm=3D"apparmor_parser"
[   32.556834] type=3D1400 audit(1349913761.566:4): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/connman/scripts/dhclient-s=
cript" pid=3D1123 comm=3D"apparmor_parser"
[   32.593247] type=3D1400 audit(1349913761.602:5): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/x86_64-linux-gnu/lightdm-r=
emote-session-freerdp/freerdp-session-wrapper" pid=3D1121 comm=3D"appar=
mor_parser"
[   32.593355] type=3D1400 audit(1349913761.602:6): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/x86_64-linux-gnu/lightdm-r=
emote-session-freerdp/freerdp-session-wrapper//chromium_browser" pid=3D=
1121 comm=3D"apparmor_parser"
[   32.636625] type=3D1400 audit(1349913761.646:7): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/lightdm/lightdm/lightdm-gu=
est-session-wrapper" pid=3D1120 comm=3D"apparmor_parser"
[   32.636760] type=3D1400 audit(1349913761.646:8): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/lightdm/lightdm/lightdm-gu=
est-session-wrapper//chromium_browser" pid=3D1120 comm=3D"apparmor_pars=
er"
[   32.681143] type=3D1400 audit(1349913761.690:9): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/sbin/tcpdump" pid=3D1134 comm=3D=
"apparmor_parser"
[   32.693048] type=3D1400 audit(1349913761.702:10): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/lib/x86_64-linux-gnu/lightdm-=
remote-session-uccsconfigure/uccsconfigure-session-wrapper" pid=3D1122 =
comm=3D"apparmor_parser"
[   32.693192] type=3D1400 audit(1349913761.702:11): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/lib/x86_64-linux-gnu/lightdm-=
remote-session-uccsconfigure/uccsconfigure-session-wrapper//chromium_br=
owser" pid=3D1122 comm=3D"apparmor_parser"
[   33.406160] usb 2-1.7: new full-speed USB device number 6 using ehci=
_hcd
[   33.498770] usb 2-1.7: New USB device found, idVendor=3D0cf3, idProd=
uct=3D3005
[   33.498773] usb 2-1.7: New USB device strings: Mfr=3D0, Product=3D0,=
 SerialNumber=3D0
[   33.502576] usbcore: registered new interface driver btusb
[   35.325845] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow =
Control: Rx
[   35.325877] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   36.565661] NFS: Registering the id_resolver key type
[   36.565668] Key type id_resolver registered
[   36.565669] Key type id_legacy registered
[   37.326755] 3:3:1: cannot get freq at ep 0x84
[   37.357121] 3:3:1: cannot get freq at ep 0x84
[   43.889656] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   43.890118] hid-generic 0005:05AC:0255.0002: unknown main item tag 0=
x0
[   43.890191] input: Apple Wireless Keyboard as /devices/pci0000:00/00=
00:00:1d.0/usb2/2-1/2-1.7/2-1.7:1.0/bluetooth/hci0/hci0:21/input9
[   43.890277] hid-generic 0005:05AC:0255.0002: input,hidraw1: BLUETOOT=
H HID v0.50 Keyboard [Apple Wireless Keyboard] on 00:02:72:20:11:B4

--=20
Paul Natsuo Kishimoto

Research associate, http://globalchange.mit.edu/CECP
S.M. Technology & Policy, MIT 2012
https://paul.kishimoto.name

