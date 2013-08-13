From: Bruce Link <Bruce@1045.ca>
Subject: System fails to connect to iHOS-104 DVD drive with nvidia MCP61 chipset.
Date: Tue, 13 Aug 2013 17:36:08 -0500
Message-ID: <520AB4D8.1000208@1045.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:5208 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757741Ab3HMWqP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Aug 2013 18:46:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: 1063474@bugs.launchpad.net

On bootup, when trying to attach to a Lite-on iHOS-104 DVD drive, the 
kernel attempts to establish a connection to the CD drive at a variety 
of speeds. Ultimately it fails with a "TEST_UNIT_READY failed 
(err_mask=0x4)" message

****************************************************************
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1063474

****************************************************************
The relevant DMESG output is listed below:
watchtv@teevee:~$ dmesg|grep ata5
[    1.088342] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400 
irq 23
[    1.556031] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.564134] ata5.00: ATAPI: ATAPI   iHOS104, WL0F, max UDMA/100
[    1.580115] ata5.00: configured for UDMA/100
[    6.580029] ata5.00: qc timeout (cmd 0xa0)
[    6.580036] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
[    7.048044] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    7.072129] ata5.00: configured for UDMA/100
[   29.856040] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen
[   29.856063] ata5.00: cmd a0/01:00:00:60:00/00:00:00:00:00/a0 tag 0 
dma 96 in
[   29.856065] ata5.00: status: { DRDY }
[   29.856071] ata5: hard resetting link
[   29.856073] ata5: nv: skipping hardreset on occupied port
[   30.324070] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   30.348152] ata5.00: configured for UDMA/100
[   35.348125] ata5.00: qc timeout (cmd 0xa0)
[   35.348132] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
[   35.348139] ata5: hard resetting link
[   35.348141] ata5: nv: skipping hardreset on occupied port
[   35.816115] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   35.840125] ata5.00: configured for UDMA/100
[   36.835824] ata5: EH complete
[   67.840151] ata5: limiting SATA link speed to 1.5 Gbps
[   67.840159] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen
[   67.840178] ata5.00: cmd a0/01:00:00:80:00/00:00:00:00:00/a0 tag 0 
dma 16512 in
[   67.840181] ata5.00: status: { DRDY }
[   67.840187] ata5: hard resetting link
[   67.840188] ata5: nv: skipping hardreset on occupied port
[   68.308056] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   68.332176] ata5.00: configured for UDMA/100
[   68.343497] ata5: EH complete
[   75.808054] ata5.00: limiting speed to UDMA/66:PIO4
[   75.808061] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen
[   75.808081] ata5.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 
dma 16416 in
[   75.808084] ata5.00: status: { DRDY }
[   75.808089] ata5: hard resetting link
[   75.808091] ata5: nv: skipping hardreset on occupied port
[   76.276050] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   76.300125] ata5.00: configured for UDMA/66
[   76.307490] ata5: EH complete
[  136.868049] ata5.00: limiting speed to UDMA/33:PIO4
[  136.868058] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen
[  136.868078] ata5.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 
dma 16416 in
[  136.868081] ata5.00: status: { DRDY }
[  136.868087] ata5: hard resetting link
[  136.868089] ata5: nv: skipping hardreset on occupied port
[  137.332073] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  137.356170] ata5.00: configured for UDMA/33
[  137.866272] ata5: EH complete
watchtv@teevee:~$


****************************************************************
Keywords: device drivers, hardware

****************************************************************
watchtv@teevee:~$ cat /proc/version
Linux version 3.11.0-031100rc5-generic (apw@gomeisa) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201308112135 SMP Mon Aug 12 01:35:49 
UTC 2013
watchtv@teevee:~$

****************************************************************
watchtv@teevee:~$ lsb_release -rd
Description:    Ubuntu Saucy Salamander (development branch)
Release:        13.10
watchtv@teevee:~$

****************************************************************
watchtv@teevee:/usr/src/linux-headers-3.11.0-031100rc5/scripts$ ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux teevee 3.11.0-031100rc5-generic #201308112135 SMP Mon Aug 12 
01:35:49 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.23.52.20130727
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.8
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         bnep rfcomm bluetooth snd_hda_codec_hdmi nvidia 
hid_generic usbhid hid joydev xpad snd_hda_codec_realtek ff_memless 
snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_page_alloc 
snd_seq_midi kvm snd_seq_midi_event ppdev snd_rawmidi snd_seq 
snd_seq_device snd_timer edac_core snd k8temp serio_raw edac_mce_amd 
soundcore ohci_pci i2c_nforce2 parport_pc mac_hid lp parport sata_nv 
pata_acpi forcedeth pata_amd

****************************************************************
watchtv@teevee:/usr/src/linux-headers-3.11.0-031100rc5/scripts$ cat 
/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 5200+
stepping        : 2
microcode       : 0x83
cpu MHz         : 2700.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext 
fxsr_opt rdtscp lm 3dnowext 3dnow rep_good nopl extd_apicid pni cx16 
lahf_lm cmp_legacy svm extapic cr8_legacy 3dnowprefetch lbrv
bogomips        : 5424.74
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 5200+
stepping        : 2
microcode       : 0x83
cpu MHz         : 2700.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext 
fxsr_opt rdtscp lm 3dnowext 3dnow rep_good nopl extd_apicid pni cx16 
lahf_lm cmp_legacy svm extapic cr8_legacy 3dnowprefetch lbrv
bogomips        : 5424.74
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

watchtv@teevee:/usr/src/linux-headers-3.11.0-031100rc5/scripts$

****************************************************************
watchtv@teevee:/usr/src/linux-headers-3.11.0-031100rc5/scripts$ cat 
/proc/modules
bnep 23966 2 - Live 0x0000000000000000
rfcomm 74589 6 - Live 0x0000000000000000
bluetooth 391564 10 bnep,rfcomm, Live 0x0000000000000000
snd_hda_codec_hdmi 41688 4 - Live 0x0000000000000000
nvidia 11309674 40 - Live 0x0000000000000000 (POF)
hid_generic 12548 0 - Live 0x0000000000000000
usbhid 53329 0 - Live 0x0000000000000000
hid 105557 2 hid_generic,usbhid, Live 0x0000000000000000
joydev 17613 0 - Live 0x0000000000000000
xpad 18546 0 - Live 0x0000000000000000
snd_hda_codec_realtek 56259 1 - Live 0x0000000000000000
ff_memless 13704 1 xpad, Live 0x0000000000000000
snd_hda_intel 53038 7 - Live 0x0000000000000000
snd_hda_codec 194727 3 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live 
0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
kvm 447883 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
snd_rawmidi 30416 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
edac_core 62914 0 - Live 0x0000000000000000
snd 69657 24 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
k8temp 13064 0 - Live 0x0000000000000000
serio_raw 13413 0 - Live 0x0000000000000000
edac_mce_amd 22792 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
ohci_pci 13561 0 - Live 0x0000000000000000
i2c_nforce2 13304 0 - Live 0x0000000000000000
parport_pc 32866 1 - Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42466 3 ppdev,parport_pc,lp, Live 0x0000000000000000
sata_nv 32267 3 - Live 0x0000000000000000
pata_acpi 13038 0 - Live 0x0000000000000000
forcedeth 72212 0 - Live 0x0000000000000000
pata_amd 18225 0 - Live 0x0000000000000000
watchtv@teevee:/usr/src/linux-headers-3.11.0-031100rc5/scripts$

****************************************************************
watchtv@teevee:/usr/src/linux-headers-3.11.0-031100rc5/scripts$ cat 
/proc/ioports
0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0064-0064 : keyboard
   0070-0073 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
   0170-0177 : 0000:00:06.0
     0170-0177 : pata_amd
   01f0-01f7 : 0000:00:06.0
     01f0-01f7 : pata_amd
   0290-0294 : pnp 00:01
   0295-0296 : pnp 00:01
   0376-0376 : 0000:00:06.0
     0376-0376 : pata_amd
   0378-037a : parport0
   03c0-03df : vga+
   03f6-03f6 : 0000:00:06.0
     03f6-03f6 : pata_amd
   03f8-03ff : serial
   04d0-04d1 : pnp 00:01
   0800-087f : pnp 00:01
   0960-0967 : 0000:00:08.1
     0960-0967 : sata_nv
   0970-0977 : 0000:00:08.0
     0970-0977 : sata_nv
   09e0-09e7 : 0000:00:08.1
     09e0-09e7 : sata_nv
   09f0-09f7 : 0000:00:08.0
     09f0-09f7 : sata_nv
   0b60-0b63 : 0000:00:08.1
     0b60-0b63 : sata_nv
   0b70-0b73 : 0000:00:08.0
     0b70-0b73 : sata_nv
   0be0-0be3 : 0000:00:08.1
     0be0-0be3 : sata_nv
   0bf0-0bf3 : 0000:00:08.0
     0bf0-0bf3 : sata_nv
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   1000-1003 : ACPI PM1a_EVT_BLK
   1004-1005 : ACPI PM1a_CNT_BLK
   1008-100b : ACPI PM_TMR
   1010-1015 : ACPI CPU throttle
   101c-101c : ACPI PM2_CNT_BLK
   1020-1027 : ACPI GPE0_BLK
   1080-10ff : pnp 00:00
   1400-147f : pnp 00:00
   1480-14ff : pnp 00:00
     14a0-14af : ACPI GPE1_BLK
   1800-187f : pnp 00:00
   1880-18ff : pnp 00:00
   1c00-1c3f : 0000:00:01.1
     1c00-1c3f : nForce2_smbus
   1c40-1c7f : 0000:00:01.1
     1c40-1c7f : nForce2_smbus
   a000-afff : PCI Bus 0000:02
     ac00-ac7f : 0000:02:00.0
   b000-bfff : PCI Bus 0000:01
   c400-c40f : 0000:00:08.1
     c400-c40f : sata_nv
   d800-d80f : 0000:00:08.0
     d800-d80f : sata_nv
   ec00-ec07 : 0000:00:07.0
     ec00-ec07 : forcedeth
   f000-f00f : 0000:00:06.0
     f000-f00f : pata_amd
   fc00-fc3f : 0000:00:01.1
watchtv@teevee:/usr/src/linux-headers-3.11.0-031100rc5/scripts$

****************************************************************
watchtv@teevee:~$ cat /proc/iomem
00000000-00000fff : reserved
00001000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000dffff : PCI Bus 0000:00
   000c0000-000c7fff : Video ROM
   000d0000-000d17ff : Adapter ROM
   000d1800-000d3fff : pnp 00:0a
000f0000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-bfedffff : System RAM
   01000000-01738813 : Kernel code
   01738814-01d0e73f : Kernel data
   01e70000-01fe2fff : Kernel bss
   b4000000-b7ffffff : GART
bfee0000-bfee2fff : ACPI Non-volatile Storage
bfee3000-bfeeffff : ACPI Tables
bfef0000-bfefffff : reserved
   bfef0000-bfefffff : pnp 00:0a
bff00000-bfffffff : RAM buffer
c0000000-dfffffff : PCI Bus 0000:00
   c0000000-dfffffff : PCI Bus 0000:02
     c0000000-cfffffff : 0000:02:00.0
     d0000000-d007ffff : 0000:02:00.0
     de000000-dfffffff : 0000:02:00.0
e0000000-febfffff : reserved
   e4000000-febfffff : PCI Bus 0000:00
     fb000000-fcffffff : PCI Bus 0000:02
       fb000000-fbffffff : 0000:02:00.0
         fb000000-fbffffff : nvidia
       fcffc000-fcffffff : 0000:02:00.1
         fcffc000-fcffffff : ICH HD audio
     fde00000-fdefffff : PCI Bus 0000:01
     fdf00000-fdffffff : PCI Bus 0000:01
     fe024000-fe027fff : 0000:00:05.0
       fe024000-fe027fff : ICH HD audio
     fe02b000-fe02bfff : 0000:00:08.1
       fe02b000-fe02bfff : sata_nv
     fe02c000-fe02cfff : 0000:00:08.0
       fe02c000-fe02cfff : sata_nv
     fe02d000-fe02dfff : 0000:00:07.0
       fe02d000-fe02dfff : forcedeth
     fe02e000-fe02e0ff : 0000:00:02.1
       fe02e000-fe02e0ff : ehci_hcd
     fe02f000-fe02ffff : 0000:00:02.0
       fe02f000-fe02ffff : ohci_hcd
fec00000-ffffffff : reserved
   fec00000-fec003ff : IOAPIC 0
   fee00000-fee00fff : Local APIC
     fee00000-fee00fff : pnp 00:0a
   fefe0000-fefe01ff : pnp 00:00
   fefe1000-fefe10ff : pnp 00:00
   feff0000-feff03ff : HPET 0
   ffff0000-ffffffff : pnp 00:0a
100000000-13fffffff : System RAM
watchtv@teevee:~$

****************************************************************
watchtv@teevee:~$ sudo lspci -vvv
00:00.0 RAM memory: NVIDIA Corporation MCP61 Host Bridge (rev a1)
     Subsystem: Gigabyte Technology Co., Ltd Device 5001
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [44] HyperTransport: Slave or Primary Interface
         Command: BaseUnitID=0 UnitCnt=17 MastHost- DefDir- DUL-
         Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- 
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
         Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit 
DwFcInEn- LWO=16bit DwFcOutEn-
         Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ 
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
         Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit 
DwFcInEn- LWO=8bit DwFcOutEn-
         Revision ID: 1.03
         Link Frequency 0: 1.0GHz
         Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
         Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
         Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
         Link Frequency 1: 200MHz
         Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
         Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 
600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
         Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- 
SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
         Prefetchable memory behind bridge Upper: 00-00
         Bus Number: 00
     Capabilities: [dc] HyperTransport: MSI Mapping Enable+ Fixed-
         Mapping Address Base: 00000000fee00000

00:01.0 ISA bridge: NVIDIA Corporation MCP61 LPC Bridge (rev a2)
     Subsystem: Gigabyte Technology Co., Ltd Device 0c11
     Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

00:01.1 SMBus: NVIDIA Corporation MCP61 SMBus (rev a2)
     Subsystem: Gigabyte Technology Co., Ltd Device 0c11
     Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 5
     Region 0: I/O ports at fc00 [size=64]
     Region 4: I/O ports at 1c00 [size=64]
     Region 5: I/O ports at 1c40 [size=64]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: nForce2_smbus

00:01.2 RAM memory: NVIDIA Corporation MCP61 Memory Controller (rev a2)
     Subsystem: Gigabyte Technology Co., Ltd Device 0c11
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:02.0 USB controller: NVIDIA Corporation MCP61 USB 1.1 Controller (rev 
a3) (prog-if 10 [OHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0 (750ns min, 250ns max)
     Interrupt: pin A routed to IRQ 23
     Region 0: Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: ohci-pci

00:02.1 USB controller: NVIDIA Corporation MCP61 USB 2.0 Controller (rev 
a3) (prog-if 20 [EHCI])
     Subsystem: Gigabyte Technology Co., Ltd Device 5004
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0 (750ns min, 250ns max)
     Interrupt: pin B routed to IRQ 22
     Region 0: Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
     Capabilities: [44] Debug port: BAR=1 offset=0098
     Capabilities: [80] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
     Kernel driver in use: ehci-pci

00:04.0 PCI bridge: NVIDIA Corporation MCP61 PCI bridge (rev a1) 
(prog-if 01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
     I/O behind bridge: 0000b000-0000bfff
     Memory behind bridge: fdf00000-fdffffff
     Prefetchable memory behind bridge: fde00000-fdefffff
     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
     Capabilities: [b8] Subsystem: Gigabyte Technology Co., Ltd Device 026f
     Capabilities: [8c] HyperTransport: MSI Mapping Enable- Fixed-
         Mapping Address Base: 00000000fee00000

00:05.0 Audio device: NVIDIA Corporation MCP61 High Definition Audio 
(rev a2)
     Subsystem: Gigabyte Technology Co., Ltd Device a002
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0 (500ns min, 1250ns max)
     Interrupt: pin B routed to IRQ 22
     Region 0: Memory at fe024000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [6c] HyperTransport: MSI Mapping Enable- Fixed+
     Kernel driver in use: snd_hda_intel

00:06.0 IDE interface: NVIDIA Corporation MCP61 IDE (rev a2) (prog-if 8a 
[Master SecP PriP])
     Subsystem: Gigabyte Technology Co., Ltd Device 5002
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0 (750ns min, 250ns max)
     Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) 
[size=8]
     Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) 
[size=1]
     Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) 
[size=8]
     Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) 
[size=1]
     Region 4: I/O ports at f000 [size=16]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pata_amd

00:07.0 Bridge: NVIDIA Corporation MCP61 Ethernet (rev a2)
     Subsystem: Gigabyte Technology Co., Ltd Device e000
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0 (250ns min, 5000ns max)
     Interrupt: pin A routed to IRQ 41
     Region 0: Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
     Region 1: I/O ports at ec00 [size=8]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee0100c  Data: 41a1
         Masking: 000000fe  Pending: 00000000
     Capabilities: [6c] HyperTransport: MSI Mapping Enable- Fixed+
     Kernel driver in use: forcedeth

00:08.0 IDE interface: NVIDIA Corporation MCP61 SATA Controller (rev a2) 
(prog-if 85 [Master SecO PriO])
     Subsystem: Gigabyte Technology Co., Ltd Device b002
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0 (750ns min, 250ns max)
     Interrupt: pin A routed to IRQ 20
     Region 0: I/O ports at 09f0 [size=8]
     Region 1: I/O ports at 0bf0 [size=4]
     Region 2: I/O ports at 0970 [size=8]
     Region 3: I/O ports at 0b70 [size=4]
     Region 4: I/O ports at d800 [size=16]
     Region 5: Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [b0] MSI: Enable- Count=1/4 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [cc] HyperTransport: MSI Mapping Enable- Fixed+
     Kernel driver in use: sata_nv

00:08.1 IDE interface: NVIDIA Corporation MCP61 SATA Controller (rev a2) 
(prog-if 85 [Master SecO PriO])
     Subsystem: Gigabyte Technology Co., Ltd Device b002
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0 (750ns min, 250ns max)
     Interrupt: pin B routed to IRQ 23
     Region 0: I/O ports at 09e0 [size=8]
     Region 1: I/O ports at 0be0 [size=4]
     Region 2: I/O ports at 0960 [size=8]
     Region 3: I/O ports at 0b60 [size=4]
     Region 4: I/O ports at c400 [size=16]
     Region 5: Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [b0] MSI: Enable- Count=1/4 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [cc] HyperTransport: MSI Mapping Enable- Fixed+
     Kernel driver in use: sata_nv

00:09.0 PCI bridge: NVIDIA Corporation MCP61 PCI Express bridge (rev a2) 
(prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 4 bytes
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 0000a000-0000afff
     Memory behind bridge: fb000000-fcffffff
     Prefetchable memory behind bridge: 00000000c0000000-00000000dfffffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
     Capabilities: [48] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
         Address: 00000000fee0300c  Data: 4161
     Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
         Mapping Address Base: 00000000fee00000
     Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr+ FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <512ns, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #1, PowerLimit 75.000W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Off, PwrInd On, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=WRR32
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Kernel driver in use: pcieport

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] HyperTransport Technology Configuration
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Capabilities: [80] HyperTransport: Host or Secondary Interface
         Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- 
<EOCErr- DUL-
         Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- 
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
         Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit 
DwFcInEn- LWO=16bit DwFcOutEn-
         Revision ID: 1.02
         Link Frequency: 1.0GHz
         Link Error: <Prot- <Ovfl- <EOC- CTLTm-
         Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
         Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- 
ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] Address Map
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] DRAM Controller
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] Miscellaneous Control
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Capabilities: [f0] Secure device <?>
     Kernel driver in use: k8temp

02:00.0 VGA compatible controller: NVIDIA Corporation GT218 [GeForce 
210] (rev a2) (prog-if 00 [VGA controller])
     Subsystem: ASUSTeK Computer Inc. EN210 SILENT
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
     Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
     Region 3: Memory at de000000 (64-bit, prefetchable) [size=32M]
     Region 5: I/O ports at ac00 [size=128]
     [virtual] Expansion ROM at d0000000 [disabled] [size=512K]
     Capabilities: [60] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [78] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 <64us
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <512ns, L1 <4us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [b4] Vendor Specific Information: Len=14 <?>
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [128 v1] Power Budgeting <?>
     Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=024 <?>
     Kernel driver in use: nvidia

02:00.1 Audio device: NVIDIA Corporation High Definition Audio 
Controller (rev a1)
     Subsystem: ASUSTeK Computer Inc. Device 8334
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 4 bytes
     Interrupt: pin B routed to IRQ 16
     Region 0: Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: [60] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [78] Express (v2) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <512ns, L1 <1us
             ClockPM+ Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM L0s L1 Enabled; RCB 128 bytes Disabled- 
Retrain- CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-, Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Kernel driver in use: snd_hda_intel

****************************************************************
watchtv@teevee:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD20EARS-00M Rev: 51.0
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: ATAPI    Model: iHOS104          Rev: WL0F
   Type:   CD-ROM                           ANSI  SCSI revision: 05
watchtv@teevee:~$

****************************************************************
watchtv@teevee:~$ ls /proc
1      11     1235  154  24    34    3774  3825  39    3996  48 624  
811  9174       dma          kmsg           pagetypeinfo timer_list
10     11088  1258  155  25    3442  3782  3828  3906  40    487 625  
82   923        driver       kpagecount     partitions timer_stats
1054   11288  129   156  26    3447  3786  383   3908  4010  49 63   
828  acpi       execdomains  kpageflags     sched_debug    tty
10641  11310  13    16   27    35    3788  3834  3919  4021  490 643  
83   asound     fb           latency_stats  schedstat uptime
10653  11376  130   17   2799  36    3790  3837  3937  41    492 7    
838  buddyinfo  filesystems  loadavg        scsi version
10657  11380  135   18   283   3660  38    3847  3939  424   5 744  841  
bus        fs           locks          self vmallocinfo
10663  11397  136   19   29    37    3800  3848  3949  426   50 772  
860  cgroups    interrupts   mdstat         slabinfo vmstat
10718  11398  138   2    293   3701  3808  3851  3955  428   575 773  
875  cmdline    iomem        meminfo        softirqs zoneinfo
10752  11418  14    20   3     3703  3810  3853  3969  429   587 782  
890  consoles   ioports      misc           stat
10834  11421  140   21   30    3752  3813  3856  3974  44    606 792  
899  cpuinfo    irq          modules        swaps
10835  1166   1443  218  31    3755  3814  3859  3976  45    609 793  
9    crypto     kallsyms     mounts         sys
1084   1199   15    22   32    3756  3821  3870  3982  46    61 796  
914  devices    kcore        mtrr           sysrq-trigger
10981  12     153   23   33    3771  3822  3878  3987  47    617 8    
916  diskstats  key-users    net            sysvipc
watchtv@teevee:~$

