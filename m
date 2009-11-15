From: Erik Postma <e.j.postma+linux-ide@gmail.com>
Subject: PROBLEM: "lost interrupt (Status 0x50)" from DVD drive, long wait on
	2.6.31 till 2.6.32rc6
Date: Sun, 15 Nov 2009 08:35:17 -0500
Message-ID: <d4db24520911150535pc4cddbufe86713cb317d7c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48603 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbZKONfO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 08:35:14 -0500
Received: by bwz27 with SMTP id 27so4821719bwz.21
        for <linux-ide@vger.kernel.org>; Sun, 15 Nov 2009 05:35:17 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Following the template from REPORTING-BUGS:

[1.] One line summary of the problem:
Long wait on boot while scanning DVD drive

[2.] Full description of the problem/report:
The boot process hangs for a variable amount of time while scanning
"ata4.00: ATAPI: MATSHITADVD-RAM UJ-850S, 1.10, max UDMA/33". This
typically takes two minutes or so, sometimes much more (so much more
that I'm not willing to wait).

Encountered this issue on upgrading to Ubuntu9.10. Tried in stock
kernel and got the same result. All 2.6.30 versions that I tried had
no problem (latest that I tried was stock 2.6.30.9), all 2.6.31 and
later did (earliest I tried was stock 2.6.31rc1, latest stock
2.6.32rc6).

I saw from a Google search that the same symptom occurred some time in
the early 2.6.20s, but those issues all seemed to be solved by
upgrading to a (then) sufficiently recent kernel. Clearly this did not
help for me.

I decided to send to the (S)ATA maintainer and mailing list. I hope that's OK.


[3.] Keywords (i.e., modules, networking, kernel):
ata, boot, DVD

[4.] Kernel version (from /proc/version):
Linux version 2.6.31-020631-generic (root@zinc) (gcc version 4.2.3
(Ubuntu 4.2.3-2ubuntu7)) #020631 SMP Thu Sep 10 22:34:46 UTC 2009

(this is stock 2.6.31, compiled and packaged up by ubuntu as a .deb,
from http://kernel.ubuntu.com/~kernel-ppa/mainline/ -- so it's not the
regularly distributed ubuntu kernel, although it happens there as
well.)

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
n/a

[6.] A small shell script or example program which triggers the
     problem (if possible)
n/a

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
This is what ver_linux says:

Linux lappie 2.6.31-020631-generic #020631 SMP Thu Sep 10 22:34:46 UTC
2009 i686 GNU/Linux

Gnu C                  4.4.1
Gnu make               3.81
binutils               2.20
util-linux             2.16
mount                  support
module-init-tools      3.10
e2fsprogs              1.41.9
reiserfsprogs          3.6.21
pcmciautils            014
PPP                    2.4.5
Linux C Library        2.10.1
Dynamic linker (ldd)   2.10.1
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15
Sh-utils               7.4
wireless-tools         29
Modules Loaded         binfmt_misc ppdev snd_hda_codec_realtek
snd_hda_codec_si3054 snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss
snd_mixer_oss arc4 snd_pcm ecb snd_seq_dummy snd_seq_oss ath5k
iptable_filter snd_seq_midi joydev mac80211 led_class ath snd_rawmidi
snd_seq_midi_event sbp2 ip_tables snd_seq x_tables pcmcia snd_timer
snd_seq_device lp psmouse serio_raw yenta_socket i2c_piix4 shpchp
rsrc_nonstatic snd cfg80211 pcmcia_core soundcore snd_page_alloc
parport reiserfs fbcon tileblit font bitblit softcursor radeon ttm
ohci1394 usbhid ati_agp ieee1394 8139too 8139cp mii drm i2c_algo_bit
agpgart video output


However, this is not the system where this kernel was compiled. If you
need me to compile it here, let me know.

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 14
model name	: Intel(R) Celeron(R) M CPU        440  @ 1.86GHz
stepping	: 12
cpu MHz		: 1862.021
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx constant_tsc up
arch_perfmon bts pni monitor tm2 xtpr pdcm
bogomips	: 3724.04
clflush size	: 64
power management:
[7.3.] Module information (from /proc/modules):
binfmt_misc 8260 1 - Live 0xf90cd000
ppdev 6688 0 - Live 0xf90c0000
snd_hda_codec_realtek 204928 1 - Live 0xf902f000
snd_hda_codec_si3054 4636 1 - Live 0xf8fe3000
snd_hda_intel 28488 2 - Live 0xf8fcb000
snd_hda_codec 77084 3
snd_hda_codec_realtek,snd_hda_codec_si3054,snd_hda_intel, Live
0xf8fa9000
snd_hwdep 7200 1 snd_hda_codec, Live 0xf8f88000
snd_pcm_oss 40544 0 - Live 0xf8f73000
snd_mixer_oss 16924 1 snd_pcm_oss, Live 0xf8f5a000
snd_pcm 78016 4
snd_hda_codec_si3054,snd_hda_intel,snd_hda_codec,snd_pcm_oss, Live
0xf8f38000
snd_seq_dummy 2784 0 - Live 0xf8f17000
arc4 1628 2 - Live 0xf8f0d000
snd_seq_oss 29312 0 - Live 0xf8efd000
snd_seq_midi 6464 0 - Live 0xf8ee9000
ecb 2524 2 - Live 0xf8ede000
snd_rawmidi 21920 1 snd_seq_midi, Live 0xf8ecf000
snd_seq_midi_event 6876 2 snd_seq_oss,snd_seq_midi, Live 0xf8ebe000
snd_seq 49968 7
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event, Live
0xf8ea7000
snd_timer 22340 2 snd_pcm,snd_seq, Live 0xf8e89000
snd_seq_device 7016 5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq, Live
0xf8e77000
ath5k 125252 0 - Live 0xf8e3c000
mac80211 185172 1 ath5k, Live 0xf8de2000
sbp2 22952 0 - Live 0xf8d9f000
snd 59332 18 snd_hda_codec_realtek,snd_hda_codec_si3054,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,
Live 0xf8d80000
led_class 4128 1 ath5k, Live 0xf8d63000
ath 8476 1 ath5k, Live 0xf8d5a000
soundcore 7456 1 snd, Live 0xf8d4d000
iptable_filter 3100 0 - Live 0xf8d3f000
pcmcia 37192 0 - Live 0xf8d2c000
snd_page_alloc 9092 2 snd_hda_intel,snd_pcm, Live 0xf8d15000
lp 8964 0 - Live 0xf8d07000
ip_tables 12172 1 iptable_filter, Live 0xf8cf9000
cfg80211 94268 3 ath5k,mac80211,ath, Live 0xf8cd8000
yenta_socket 24200 1 - Live 0xf8cab000
x_tables 16480 1 ip_tables, Live 0xf8c99000
shpchp 32176 0 - Live 0xf8c86000
rsrc_nonstatic 11388 1 yenta_socket, Live 0xf8323000
parport 35596 2 ppdev,lp, Live 0xf8764000
psmouse 56884 0 - Live 0xf8530000
pcmcia_core 36528 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xf82d5000
i2c_piix4 9996 0 - Live 0xf82b6000
serio_raw 5472 0 - Live 0xf8283000
joydev 10624 0 - Live 0xf8276000
reiserfs 234376 1 - Live 0xf817b000
fbcon 38432 72 - Live 0xf80c7000
tileblit 2460 1 fbcon, Live 0xf803f000
font 8124 1 fbcon, Live 0xf8093000
bitblit 5244 1 fbcon, Live 0xf8086000
softcursor 1692 1 bitblit, Live 0xf8026000
8139too 22844 0 - Live 0xf8037000
usbhid 38016 0 - Live 0xf82f9000
8139cp 19516 0 - Live 0xf82df000
mii 5020 2 8139too,8139cp, Live 0xf82d1000
ohci1394 31372 0 - Live 0xf82bc000
ieee1394 89220 2 sbp2,ohci1394, Live 0xf8294000
radeon 646976 2 - Live 0xf81d3000
ttm 36596 1 radeon, Live 0xf810e000
drm 159712 3 radeon,ttm, Live 0xf80d3000
i2c_algo_bit 5792 1 radeon, Live 0xf809b000
ati_agp 6888 0 - Live 0xf808f000
agpgart 35852 3 ttm,drm,ati_agp, Live 0xf807b000
video 20148 0 - Live 0xf8041000
output 2780 1 video, Live 0xf8023000
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
% cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:14.1
  0170-0177 : pata_atiixp
01f0-01f7 : 0000:00:14.1
  01f0-01f7 : pata_atiixp
0220-022f : pnp 00:08
0280-0293 : pnp 00:08
0376-0376 : 0000:00:14.1
  0376-0376 : pata_atiixp
03c0-03df : vga+
03f6-03f6 : 0000:00:14.1
  03f6-03f6 : pata_atiixp
0400-0401 : pnp 00:08
040b-040b : pnp 00:08
04d0-04d1 : pnp 00:08
04d6-04d6 : pnp 00:08
0530-0537 : pnp 00:08
087f-087f : pnp 00:08
0c00-0c01 : pnp 00:08
0c14-0c14 : pnp 00:08
0c50-0c52 : pnp 00:08
0c6c-0c6c : pnp 00:08
0c6f-0c6f : pnp 00:08
0cd4-0cd5 : pnp 00:08
0cd6-0cd7 : pnp 00:08
0cd8-0cdf : pnp 00:08
0cf8-0cff : PCI conf1
0f40-0f47 : pnp 00:08
1080-1080 : pnp 00:08
8000-805f : pnp 00:08
  8000-8003 : ACPI PM1a_EVT_BLK
  8004-8005 : ACPI PM1a_CNT_BLK
  8008-800b : ACPI PM_TMR
  8010-8015 : ACPI CPU throttle
  8020-8027 : ACPI GPE0_BLK
8100-8100 : ACPI PM2_CNT_BLK
8104-8107 : ACPI PM1b_EVT_BLK
8210-821f : pnp 00:08
8400-840f : 0000:00:12.0
8410-8413 : 0000:00:12.0
8420-8427 : 0000:00:12.0
8430-8433 : 0000:00:12.0
8440-8447 : 0000:00:12.0
8450-845f : 0000:00:14.0
  8450-8457 : piix4_smbus
8460-846f : 0000:00:14.1
  8460-846f : pata_atiixp
9000-9fff : PCI Bus 0000:01
  9000-90ff : 0000:01:05.0
a000-afff : PCI Bus 0000:05
  a000-a0ff : 0000:05:07.0
    a000-a0ff : 8139too
  a400-a47f : 0000:05:0a.0
  a800-a8ff : PCI CardBus 0000:06
  ac00-acff : PCI CardBus 0000:06
% cat /proc/iomem
00000000-0000ffff : reserved
00010000-0009dbff : System RAM
0009dc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000cf000-000cffff : Adapter ROM
000dc000-000dffff : reserved
000e4000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-37e7ffff : System RAM
  00100000-0056c9b4 : Kernel code
  0056c9b5-0078d707 : Kernel data
  00821000-008af03f : Kernel bss
37e80000-37e91fff : ACPI Tables
37e92000-37efffff : ACPI Non-volatile Storage
37f00000-37ffffff : reserved
38000000-3bffffff : PCI Bus 0000:05
  38000000-3bffffff : PCI CardBus 0000:06
3c000000-3c07ffff : 0000:00:12.0
40000000-43ffffff : PCI CardBus 0000:06
c0000000-c00fffff : PCI Bus 0000:01
  c0000000-c000ffff : 0000:01:05.0
  c0020000-c003ffff : 0000:01:05.0
c0100000-c01fffff : PCI Bus 0000:02
  c0100000-c010ffff : 0000:02:00.0
    c0100000-c010ffff : ath5k
c0200000-c02fffff : PCI Bus 0000:05
  c0200000-c02007ff : 0000:05:0a.0
    c0200000-c02007ff : ohci1394
  c0200800-c02008ff : 0000:05:07.0
    c0200800-c02008ff : 8139too
c0500000-c0503fff : 0000:00:14.2
  c0500000-c0503fff : ICH HD audio
c0504000-c0504fff : 0000:00:13.0
  c0504000-c0504fff : ohci_hcd
c0505000-c0505fff : 0000:00:13.1
  c0505000-c0505fff : ohci_hcd
c0506000-c0506fff : 0000:00:13.2
  c0506000-c0506fff : ehci_hcd
c0507000-c05071ff : 0000:00:12.0
  c0507000-c05071ff : sata_sil
c0507400-c05077ff : 0000:00:14.0
d0000000-dfffffff : PCI Bus 0000:01
  d0000000-dfffffff : 0000:01:05.0
e0000000-efffffff : reserved
  e0000000-efffffff : pnp 00:01
    e0000000-e06fffff : PCI MMCONFIG 0 [00-06]
febfe000-febfefff : 0000:05:06.0
  febfe000-febfefff : yenta_socket
fec00000-fec0ffff : reserved
  fec00000-fec00fff : IOAPIC 0
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
fff80000-ffffffff : reserved
  fff80000-ffffffff : pnp 00:09

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: ATI Technologies Inc Device 5a31 (rev 01)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 64
        Kernel modules: ati-agp

00:01.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: c0000000-c00fffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [b0] Subsystem: ATI Technologies Inc RS480 PCI
Bridge
        Kernel modules: shpchp

00:04.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: c0100000-c01fffff
        Prefetchable memory behind bridge:
00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag+ RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <64ns, L1 <1us
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surpise-
                        Slot #  0, PowerLimit 25.000000; Interlock-
NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power-
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
                Address: fee0100c  Data: 4159
        Capabilities: [b0] Subsystem: ATI Technologies Inc Device 5a31
        Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
        Kernel driver in use: pcieport-driver
        Kernel modules: shpchp

00:12.0 IDE interface: ATI Technologies Inc IXP SB400 Serial ATA
Controller (rev 80) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at 8440 [size=8]
        Region 1: I/O ports at 8430 [size=4]
        Region 2: I/O ports at 8420 [size=8]
        Region 3: I/O ports at 8410 [size=4]
        Region 4: I/O ports at 8400 [size=16]
        Region 5: Memory at c0507000 (32-bit, non-prefetchable)
[size=512]
        [virtual] Expansion ROM at 3c000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Kernel driver in use: sata_sil

00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host
Controller (rev 80) (prog-if 10)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at c0504000 (32-bit, non-prefetchable)
[size=4K]
        Kernel driver in use: ohci_hcd

00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host
Controller (rev 80) (prog-if 10)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at c0505000 (32-bit, non-prefetchable)
[size=4K]
        Kernel driver in use: ohci_hcd

00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host
Controller (rev 80) (prog-if 20)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at c0506000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
        Kernel driver in use: ehci_hcd

00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 82)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Region 0: I/O ports at 8450 [size=16]
        Region 1: Memory at c0507400 (32-bit, non-prefetchable)
[size=1K]
        Kernel driver in use: piix4_smbus
        Kernel modules: i2c-piix4

00:14.1 IDE interface: ATI Technologies Inc IXP SB400 IDE Controller
(rev 80) (prog-if 8a [Master SecP PriP])
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at 8460 [size=16]
        Capabilities: [70] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Kernel driver in use: pata_atiixp

00:14.2 Audio device: ATI Technologies Inc IXP SB4x0 High Definition
Audio Controller (rev 01)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin ? routed to IRQ 16
        Region 0: Memory at c0500000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge (rev 80)
        Subsystem: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0

00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (rev
80) (prog-if 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Bus: primary=00, secondary=05, subordinate=07, sec-latency=64
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: c0200000-c02fffff
        Prefetchable memory behind bridge: 38000000-3bffffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

01:05.0 VGA compatible controller: ATI Technologies Inc RC410 [Radeon
Xpress 200M]
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 66 (2000ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at d0000000 (32-bit, prefetchable)
[size=256M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at c0000000 (32-bit, non-prefetchable)
[size=64K]
        [virtual] Expansion ROM at c0020000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Kernel driver in use: radeon
        Kernel modules: radeon, radeonfb

02:00.0 Ethernet controller: Atheros Communications Inc. AR5001
Wireless Network Adapter (rev 01)
        Subsystem: Askey Computer Corp. Device 7106
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at c0100000 (64-bit, non-prefetchable)
[size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [60] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<128ns, L1 <2us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [90] MSI-X: Enable- Mask- TabSize=1
                Vector table: BAR=0 offset=00000000
                PBA: BAR=0 offset=00000000
        Capabilities: [100] Advanced Error Reporting <?>
        Capabilities: [140] Virtual Channel <?>
        Kernel driver in use: ath5k
        Kernel modules: ath5k

05:06.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller (rev 01)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 168, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at febfe000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=05, secondary=06, subordinate=06, sec-latency=176
        Memory window 0: 38000000-3bfff000 (prefetchable)
        Memory window 1: 40000000-43fff000
        I/O window 0: 0000a800-0000a8ff
        I/O window 1: 0000ac00-0000acff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001
        Kernel driver in use: yenta_cardbus
        Kernel modules: yenta_socket

05:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at a000 [size=256]
        Region 1: Memory at c0200800 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: 8139too
        Kernel modules: epl, 8139too, 8139cp

05:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306 Fire II
IEEE 1394 OHCI Link Layer Controller (rev c0) (prog-if 10)
        Subsystem: Toshiba America Info Systems Device ff10
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (8000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at c0200000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at a400 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ohci1394
        Kernel modules: firewire-ohci, ohci1394


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Hitachi HTS54168 Rev: SB2O
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: DVD-RAM UJ-850S  Rev: 1.10
  Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Here's dmesg:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31-020631-generic (root@zinc) (gcc
version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #020631 SMP Thu Sep 10 22:34:46
UTC 2009
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000037e80000 (usable)
[    0.000000]  BIOS-e820: 0000000037e80000 - 0000000037e92000 (ACPI data)
[    0.000000]  BIOS-e820: 0000000037e92000 - 0000000037f00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 0000000037f00000 - 0000000038000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] DMI present.
[    0.000000] Phoenix BIOS detected: BIOS may corrupt low RAM,
working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000
(usable) ==> (reserved)
[    0.000000] last_pfn = 0x37e80 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FE0000000 write-back
[    0.000000]   1 base 020000000 mask FF0000000 write-back
[    0.000000]   2 base 030000000 mask FF8000000 write-back
[    0.000000]   3 base 037F00000 mask FFFF00000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009dc00 (usable)
[    0.000000]  modified: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000dc000 - 00000000000e0000 (reserved)
[    0.000000]  modified: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 0000000037e80000 (usable)
[    0.000000]  modified: 0000000037e80000 - 0000000037e92000 (ACPI data)
[    0.000000]  modified: 0000000037e92000 - 0000000037f00000 (ACPI NVS)
[    0.000000]  modified: 0000000037f00000 - 0000000038000000 (reserved)
[    0.000000]  modified: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  modified: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] initial memory mapped : 0 - 00c00000
[    0.000000] init_memory_mapping: 0000000000000000-00000000377fe000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037400000 page 2M
[    0.000000]  0037400000 - 00377fe000 page 4k
[    0.000000] kernel direct mapping tables up to 377fe000 @ 10000-15000
[    0.000000] RAMDISK: 376d6000 - 37e6f827
[    0.000000] Allocated new RAMDISK: 008b4000 - 0104d827
[    0.000000] Move RAMDISK from 00000000376d6000 - 0000000037e6f826
to 008b4000 - 0104d826
[    0.000000] ACPI: RSDP 000f7bb0 00014 (v00 TOSINV)
[    0.000000] ACPI: RSDT 37e8ad9e 00040 (v01 TOSINV TOSINV00 06040000
 LTP 00000000)
[    0.000000] ACPI: FACP 37e91d8a 00074 (v01 TOSINV Bonefish 06040000
ATI  000F4240)
[    0.000000] ACPI: DSDT 37e8bac8 062C2 (v01 TOSINV    SB450 06040000
MSFT 0100000E)
[    0.000000] ACPI: FACS 37e92fc0 00040
[    0.000000] ACPI: APIC 37e91dfe 00050 (v01 TOSINV 	 APIC   06040000
 LTP 00000000)
[    0.000000] ACPI: SLIC 37e91e4e 00176 (v01 TOSINV TOSINV00 06040000
 INV 00000000)
[    0.000000] ACPI: MCFG 37e91fc4 0003C (v01 TOSINV   MCFG   06040000
 LTP 00000000)
[    0.000000] ACPI: SSDT 37e8b5b0 00518 (v01  PmRef  Cpu0Cst 00003001
INTL 20050228)
[    0.000000] ACPI: SSDT 37e8b351 0025F (v01  PmRef  Cpu0Tst 00003000
INTL 20050228)
[    0.000000] ACPI: SSDT 37e8adde 00573 (v01  PmRef    CpuPm 00003000
INTL 20050228)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 6MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000]   node 0 low ram: 00000000 - 377fe000
[    0.000000]   node 0 bootmap 00011000 - 00017f00
[    0.000000] (9 early reservations) ==> bootmem [0000000000 - 00377fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==>
[0000000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==>
[0000001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==>
[0000006000 - 0000007000]
[    0.000000]   #3 [0000100000 - 00008af040]    TEXT DATA BSS ==>
[0000100000 - 00008af040]
[    0.000000]   #4 [000009dc00 - 0000100000]    BIOS reserved ==>
[000009dc00 - 0000100000]
[    0.000000]   #5 [00008b0000 - 00008b3138]              BRK ==>
[00008b0000 - 00008b3138]
[    0.000000]   #6 [0000010000 - 0000011000]          PGTABLE ==>
[0000010000 - 0000011000]
[    0.000000]   #7 [00008b4000 - 000104d827]      NEW RAMDISK ==>
[00008b4000 - 000104d827]
[    0.000000]   #8 [0000011000 - 0000018000]          BOOTMAP ==>
[0000011000 - 0000018000]
[    0.000000] found SMP MP-table at [c00f7c60] f7c60
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x00037e80
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x00037e80
[    0.000000] On node 0 totalpages: 228877
[    0.000000] free_area_init_node: node 0, pgdat c0785060,
node_mem_map c104e200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3949 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 14 pages used for memmap
[    0.000000]   HighMem zone: 1652 pages, LIFO batch:0
[    0.000000] Using APIC driver default
[    0.000000] SB4X0 revision 0x82
[    0.000000] Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] ACPI: PM-Timer IO Port: 0x8008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 38000000 (gap:
38000000:a8000000)
[    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] PERCPU: Embedded 14 pages at c1752000, static data 35004 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 227087
[    0.000000] Kernel command line:
root=UUID=798a1bc1-bd9e-4436-8723-f6469ab8af2a ro quiet splash
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] allocated 4579520 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't
want memory cgroups
[    0.000000] Initializing HighMem for node 0 (000377fe:00037e80)
[    0.000000] Memory: 887076k/915968k available (4530k kernel code,
28200k reserved, 2179k data, 568k init, 6664k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff1d000 - 0xfffff000   ( 904 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000000]       .init : 0xc078e000 - 0xc081c000   ( 568 kB)
[    0.000000]       .data : 0xc056c9b5 - 0xc078d708   (2179 kB)
[    0.000000]       .text : 0xc0100000 - 0xc056c9b5   (4530 kB)
[    0.000000] Checking if this processor honours the WP bit even in
supervisor mode...Ok.
[    0.000000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0,
CPUs=1, Nodes=1
[    0.000000] NR_IRQS:2304 nr_irqs:256
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1862.349 MHz processor.
[    0.000940] Console: colour VGA+ 80x25
[    0.000945] console [tty0] enabled
[    0.001004] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3724.69 BogoMIPS (lpj=7449396)
[    0.001027] Security Framework initialized
[    0.001038] SELinux:  Disabled at boot.
[    0.001048] Mount-cache hash table entries: 512
[    0.001202] Initializing cgroup subsys ns
[    0.001208] Initializing cgroup subsys cpuacct
[    0.001213] Initializing cgroup subsys memory
[    0.001222] Initializing cgroup subsys freezer
[    0.001225] Initializing cgroup subsys net_cls
[    0.001243] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.001246] CPU: L2 cache: 1024K
[    0.001252] using mwait in idle threads.
[    0.001261] Performance Counters: no PMU driver, software counters only.
[    0.001268] Checking 'hlt' instruction... OK.
[    0.016903] SMP alternatives: switching to UP code
[    0.024177] Freeing SMP alternatives: 19k freed
[    0.024197] ACPI: Core revision 20090521
[    0.040315]   alloc irq_desc for 21 on node 0
[    0.040319]   alloc kstat_irqs on node 0
[    0.040465] ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
[    0.081293] CPU0: Intel(R) Celeron(R) M CPU        440  @ 1.86GHz stepping 0c
[    0.084001] Brought up 1 CPUs
[    0.084001] Total of 1 processors activated (3724.69 BogoMIPS).
[    0.084001] CPU0 attaching NULL sched-domain.
[    0.084001] Booting paravirtualized kernel on bare hardware
[    0.084001] regulator: core version 0.5
[    0.084001] Time:  9:17:11  Date: 11/14/09
[    0.084001] NET: Registered protocol family 16
[    0.084001] EISA bus registered
[    0.084001] ACPI: bus type pci registered
[    0.084001] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 6
[    0.084001] PCI: MCFG area at e0000000 reserved in E820
[    0.084001] PCI: Using MMCONFIG for extended config space
[    0.084001] PCI: Using configuration type 1 for base access
[    0.086939] bio: create slab <bio-0> at 0
[    0.087839] ACPI: EC: Look up EC in DSDT
[    0.122822] ACPI: BIOS _OSI(Linux) query ignored
[    0.124016] ACPI: EC: non-query interrupt received, switching to
interrupt mode
[    0.144077] ACPI: Interpreter enabled
[    0.144083] ACPI: (supports S0 S3 S4 S5)
[    0.144108] ACPI: Using IOAPIC for interrupt routing
[    0.201251] ACPI: EC: GPE = 0x7, I/O: command/status = 0x66, data = 0x62
[    0.201255] ACPI: EC: driver started in interrupt mode
[    0.201357] ACPI: Power Resource [FN00] (off)
[    0.202348] ACPI: ACPI Dock Station Driver: 2 docks/bays found
[    0.203004] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.203208] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.203213] pci 0000:00:04.0: PME# disabled
[    0.203311] pci 0000:00:12.0: reg 10 io port: [0x8440-0x8447]
[    0.203322] pci 0000:00:12.0: reg 14 io port: [0x8430-0x8433]
[    0.203332] pci 0000:00:12.0: reg 18 io port: [0x8420-0x8427]
[    0.203342] pci 0000:00:12.0: reg 1c io port: [0x8410-0x8413]
[    0.203353] pci 0000:00:12.0: reg 20 io port: [0x8400-0x840f]
[    0.203364] pci 0000:00:12.0: reg 24 32bit mmio: [0xc0507000-0xc05071ff]
[    0.203374] pci 0000:00:12.0: reg 30 32bit mmio: [0x000000-0x07ffff]
[    0.203414] pci 0000:00:12.0: supports D1 D2
[    0.203456] pci 0000:00:13.0: reg 10 32bit mmio: [0xc0504000-0xc0504fff]
[    0.203544] pci 0000:00:13.1: reg 10 32bit mmio: [0xc0505000-0xc0505fff]
[    0.203652] pci 0000:00:13.2: reg 10 32bit mmio: [0xc0506000-0xc0506fff]
[    0.203728] pci 0000:00:13.2: supports D1 D2
[    0.203731] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.203737] pci 0000:00:13.2: PME# disabled
[    0.203782] pci 0000:00:14.0: reg 10 io port: [0x8450-0x845f]
[    0.203793] pci 0000:00:14.0: reg 14 32bit mmio: [0xc0507400-0xc05077ff]
[    0.203837] HPET not enabled in BIOS. You might try hpet=force boot option
[    0.203893] pci 0000:00:14.1: reg 10 io port: [0x1f0-0x1f7]
[    0.203903] pci 0000:00:14.1: reg 14 io port: [0x3f4-0x3f7]
[    0.203914] pci 0000:00:14.1: reg 18 io port: [0x170-0x177]
[    0.203924] pci 0000:00:14.1: reg 1c io port: [0x374-0x377]
[    0.203935] pci 0000:00:14.1: reg 20 io port: [0x8460-0x846f]
[    0.204068] pci 0000:00:14.2: reg 10 64bit mmio: [0xc0500000-0xc0503fff]
[    0.204145] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.204151] pci 0000:00:14.2: PME# disabled
[    0.204357] pci 0000:01:05.0: reg 10 32bit mmio: [0xd0000000-0xdfffffff]
[    0.204363] pci 0000:01:05.0: reg 14 io port: [0x9000-0x90ff]
[    0.204369] pci 0000:01:05.0: reg 18 32bit mmio: [0xc0000000-0xc000ffff]
[    0.204384] pci 0000:01:05.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.204401] pci 0000:01:05.0: supports D1 D2
[    0.204430] pci 0000:00:01.0: bridge io port: [0x9000-0x9fff]
[    0.204434] pci 0000:00:01.0: bridge 32bit mmio: [0xc0000000-0xc00fffff]
[    0.204439] pci 0000:00:01.0: bridge 32bit mmio pref: [0xd0000000-0xdfffffff]
[    0.204500] pci 0000:02:00.0: reg 10 64bit mmio: [0xc0100000-0xc010ffff]
[    0.204668] pci 0000:00:04.0: bridge 32bit mmio: [0xc0100000-0xc01fffff]
[    0.204752] pci 0000:05:06.0: reg 10 32bit mmio: [0xfebfe000-0xfebfefff]
[    0.204789] pci 0000:05:06.0: supports D1 D2
[    0.204791] pci 0000:05:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.204798] pci 0000:05:06.0: PME# disabled
[    0.204864] pci 0000:05:07.0: reg 10 io port: [0xa000-0xa0ff]
[    0.204876] pci 0000:05:07.0: reg 14 32bit mmio: [0xc0200800-0xc02008ff]
[    0.204958] pci 0000:05:07.0: supports D1 D2
[    0.204960] pci 0000:05:07.0: PME# supported from D1 D2 D3hot D3cold
[    0.204968] pci 0000:05:07.0: PME# disabled
[    0.205039] pci 0000:05:0a.0: reg 10 32bit mmio: [0xc0200000-0xc02007ff]
[    0.205051] pci 0000:05:0a.0: reg 14 io port: [0xa400-0xa47f]
[    0.205135] pci 0000:05:0a.0: supports D2
[    0.205138] pci 0000:05:0a.0: PME# supported from D2 D3hot D3cold
[    0.205145] pci 0000:05:0a.0: PME# disabled
[    0.205205] pci 0000:00:14.4: transparent bridge
[    0.205216] pci 0000:00:14.4: bridge io port: [0xa000-0xafff]
[    0.205222] pci 0000:00:14.4: bridge 32bit mmio: [0xc0200000-0xc02fffff]
[    0.205275] pci_bus 0000:00: on NUMA node 0
[    0.205282] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.205453] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB4_._PRT]
[    0.205559] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
[    0.205691] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[    0.208794] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
[    0.208922] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
[    0.209047] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
[    0.209172] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
[    0.209297] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[    0.209422] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[    0.209545] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
[    0.209670] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
[    0.209795] ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7) *0, disabled.
[    0.210325] SCSI subsystem initialized
[    0.210385] libata version 3.00 loaded.
[    0.210636] usbcore: registered new interface driver usbfs
[    0.210694] usbcore: registered new interface driver hub
[    0.210758] usbcore: registered new device driver usb
[    0.211222] ACPI: WMI: Mapper loaded
[    0.211225] PCI: Using ACPI for IRQ routing
[    0.211517] Bluetooth: Core ver 2.15
[    0.211583] NET: Registered protocol family 31
[    0.211585] Bluetooth: HCI device and connection manager initialized
[    0.211590] Bluetooth: HCI socket layer initialized
[    0.211592] NetLabel: Initializing
[    0.211594] NetLabel:  domain hash size = 128
[    0.211596] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.211613] NetLabel:  unlabeled traffic allowed by default
[    0.214009] pnp: PnP ACPI init
[    0.214048] ACPI: bus type pnp registered
[    0.248337] pnp 00:09: mem resource (0x0-0xfff) overlaps
0000:00:12.0 BAR 6 (0x0-0x7ffff), disabling
[    0.248349] pnp 00:09: mem resource (0x0-0xfff) overlaps
0000:01:05.0 BAR 6 (0x0-0x1ffff), disabling
[    0.248466] pnp: PnP ACPI: found 10 devices
[    0.248468] ACPI: ACPI bus type pnp unregistered
[    0.248475] PnPBIOS: Disabled by ACPI PNP
[    0.248491] system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
[    0.248501] system 00:08: ioport range 0x1080-0x1080 has been reserved
[    0.248505] system 00:08: ioport range 0x220-0x22f has been reserved
[    0.248508] system 00:08: ioport range 0x400-0x401 has been reserved
[    0.248512] system 00:08: ioport range 0x40b-0x40b has been reserved
[    0.248515] system 00:08: ioport range 0x4d0-0x4d1 has been reserved
[    0.248518] system 00:08: ioport range 0x4d6-0x4d6 has been reserved
[    0.248522] system 00:08: ioport range 0x530-0x537 has been reserved
[    0.248525] system 00:08: ioport range 0xc00-0xc01 has been reserved
[    0.248528] system 00:08: ioport range 0xc14-0xc14 has been reserved
[    0.248532] system 00:08: ioport range 0xc50-0xc52 has been reserved
[    0.248535] system 00:08: ioport range 0xc6c-0xc6c has been reserved
[    0.248539] system 00:08: ioport range 0xc6f-0xc6f has been reserved
[    0.248542] system 00:08: ioport range 0xcd4-0xcd5 has been reserved
[    0.248545] system 00:08: ioport range 0xcd6-0xcd7 has been reserved
[    0.248549] system 00:08: ioport range 0xcd8-0xcdf has been reserved
[    0.248552] system 00:08: ioport range 0x8000-0x805f has been reserved
[    0.248556] system 00:08: ioport range 0x8210-0x821f has been reserved
[    0.248559] system 00:08: ioport range 0xf40-0xf47 has been reserved
[    0.248563] system 00:08: ioport range 0x280-0x293 has been reserved
[    0.248566] system 00:08: ioport range 0x87f-0x87f has been reserved
[    0.248573] system 00:09: iomem range 0xe0000-0xfffff could not be reserved
[    0.248577] system 00:09: iomem range 0xfff80000-0xffffffff has been reserved
[    0.283706] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.283710] pci 0000:00:01.0:   IO window: 0x9000-0x9fff
[    0.283715] pci 0000:00:01.0:   MEM window: 0xc0000000-0xc00fffff
[    0.283720] pci 0000:00:01.0:   PREFETCH window: 0xd0000000-0xdfffffff
[    0.283724] pci 0000:00:04.0: PCI bridge, secondary bus 0000:02
[    0.283726] pci 0000:00:04.0:   IO window: disabled
[    0.283731] pci 0000:00:04.0:   MEM window: 0xc0100000-0xc01fffff
[    0.283735] pci 0000:00:04.0:   PREFETCH window: disabled
[    0.283742] pci 0000:05:06.0: CardBus bridge, secondary bus 0000:06
[    0.283745] pci 0000:05:06.0:   IO window: 0x00a800-0x00a8ff
[    0.283755] pci 0000:05:06.0:   IO window: 0x00ac00-0x00acff
[    0.283762] pci 0000:05:06.0:   PREFETCH window: 0x38000000-0x3bffffff
[    0.283770] pci 0000:05:06.0:   MEM window: 0x40000000-0x43ffffff
[    0.283777] pci 0000:00:14.4: PCI bridge, secondary bus 0000:05
[    0.283782] pci 0000:00:14.4:   IO window: 0xa000-0xafff
[    0.283790] pci 0000:00:14.4:   MEM window: 0xc0200000-0xc02fffff
[    0.283796] pci 0000:00:14.4:   PREFETCH window: 0x38000000-0x3bffffff
[    0.283816] pci 0000:00:04.0: setting latency timer to 64
[    0.283834] pci 0000:05:06.0: enabling device (0000 -> 0003)
[    0.283842]   alloc irq_desc for 23 on node -1
[    0.283845]   alloc kstat_irqs on node -1
[    0.283855] pci 0000:05:06.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.283867] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.283870] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.283873] pci_bus 0000:01: resource 0 io:  [0x9000-0x9fff]
[    0.283876] pci_bus 0000:01: resource 1 mem: [0xc0000000-0xc00fffff]
[    0.283879] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xdfffffff]
[    0.283883] pci_bus 0000:02: resource 1 mem: [0xc0100000-0xc01fffff]
[    0.283886] pci_bus 0000:05: resource 0 io:  [0xa000-0xafff]
[    0.283889] pci_bus 0000:05: resource 1 mem: [0xc0200000-0xc02fffff]
[    0.283892] pci_bus 0000:05: resource 2 pref mem [0x38000000-0x3bffffff]
[    0.283895] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
[    0.283898] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffff]
[    0.283901] pci_bus 0000:06: resource 0 io:  [0xa800-0xa8ff]
[    0.283904] pci_bus 0000:06: resource 1 io:  [0xac00-0xacff]
[    0.283908] pci_bus 0000:06: resource 2 pref mem [0x38000000-0x3bffffff]
[    0.283912] pci_bus 0000:06: resource 3 mem: [0x40000000-0x43ffffff]
[    0.283965] NET: Registered protocol family 2
[    0.284092] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.284567] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.286164] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.287231] TCP: Hash tables configured (established 131072 bind 65536)
[    0.287237] TCP reno registered
[    0.287424] NET: Registered protocol family 1
[    0.287538] Trying to unpack rootfs image as initramfs...
[    0.559584] Freeing initrd memory: 7782k freed
[    0.578038] cpufreq-nforce2: No nForce2 chipset.
[    0.578200] Scanning for low memory corruption every 60 seconds
[    0.578539] audit: initializing netlink socket (disabled)
[    0.578579] type=2000 audit(1258190230.575:1): initialized
[    0.591014] highmem bounce pool size: 64 pages
[    0.591023] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.594277] VFS: Disk quotas dquot_6.5.2
[    0.594386] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.595450] fuse init (API version 7.12)
[    0.595649] msgmni has been set to 1735
[    0.595923] alg: No test for stdrng (krng)
[    0.595978] io scheduler noop registered
[    0.595980] io scheduler anticipatory registered
[    0.595982] io scheduler deadline registered
[    0.596537] io scheduler cfq registered (default)
[    0.596617] pci 0000:01:05.0: Boot video device
[    0.596803]   alloc irq_desc for 24 on node -1
[    0.596806]   alloc kstat_irqs on node -1
[    0.596819] pcieport-driver 0000:00:04.0: irq 24 for MSI/MSI-X
[    0.596827] pcieport-driver 0000:00:04.0: setting latency timer to 64
[    0.597006] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.597126] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.598715] ACPI: AC Adapter [ADP0] (on-line)
[    0.598921] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.598926] ACPI: Power Button [PWRF]
[    0.599018] input: Power Button as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    0.599022] ACPI: Power Button [PWRB]
[    0.599110] input: Lid Switch as
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
[    0.599170] ACPI: Lid Switch [LID]
[    0.599378] fan PNP0C0B:00: registered as cooling_device0
[    0.599385] ACPI: Fan [FAN0] (off)
[    0.600379] Marking TSC unstable due to TSC halts in idle
[    0.600433] Switched to high resolution mode on CPU 0
[    0.600491] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    0.600550] processor LNXCPU:00: registered as cooling_device1
[    0.600554] ACPI: Processor [CPU0] (supports 8 throttling states)
[    0.636544] thermal LNXTHERM:01: registered as thermal_zone0
[    0.636553] ACPI: Thermal Zone [TZ00] (31 C)
[    0.646577] thermal LNXTHERM:02: registered as thermal_zone1
[    0.646586] ACPI: Thermal Zone [TZ01] (7 C)
[    0.646878] isapnp: Scanning for PnP cards...
[    1.004080] isapnp: No Plug & Play device found
[    1.008614] ACPI: Battery Slot [BAT0] (battery present)
[    1.011307] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.014439] brd: module loaded
[    1.015584] loop: module loaded
[    1.015823] input: Macintosh mouse button emulation as
/devices/virtual/input/input3
[    1.016812] sata_sil 0000:00:12.0: version 2.4
[    1.016877] sata_sil 0000:00:12.0: enabling device (0005 -> 0007)
[    1.016888]   alloc irq_desc for 22 on node -1
[    1.016891]   alloc kstat_irqs on node -1
[    1.016902] sata_sil 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    1.017008] scsi0 : sata_sil
[    1.017220] scsi1 : sata_sil
[    1.017545] ata1: SATA max UDMA/100 mmio m512@0xc0507000 tf 0xc0507080 irq 22
[    1.017551] ata2: SATA max UDMA/100 mmio m512@0xc0507000 tf 0xc05070c0 irq 22
[    1.018215]   alloc irq_desc for 16 on node -1
[    1.018218]   alloc kstat_irqs on node -1
[    1.018225] pata_atiixp 0000:00:14.1: PCI INT A -> GSI 16 (level,
low) -> IRQ 16
[    1.018285] pata_atiixp 0000:00:14.1: setting latency timer to 64
[    1.018358] scsi2 : pata_atiixp
[    1.018486] scsi3 : pata_atiixp
[    1.020286] ata3: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x8460 irq 14
[    1.020290] ata4: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x8468 irq 15
[    1.023519] Fixed MDIO Bus: probed
[    1.023725] PPP generic driver version 2.4.2
[    1.024072] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.024117]   alloc irq_desc for 19 on node -1
[    1.024128]   alloc kstat_irqs on node -1
[    1.024139] ehci_hcd 0000:00:13.2: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.024169] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    1.024299] ehci_hcd 0000:00:13.2: new USB bus registered, assigned
bus number 1
[    1.024374] ehci_hcd 0000:00:13.2: irq 19, io mem 0xc0506000
[    1.036026] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.036199] usb usb1: configuration #1 chosen from 1 choice
[    1.036275] hub 1-0:1.0: USB hub found
[    1.036288] hub 1-0:1.0: 8 ports detected
[    1.036425] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.036450] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.036467] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    1.036540] ohci_hcd 0000:00:13.0: new USB bus registered, assigned
bus number 2
[    1.036564] ohci_hcd 0000:00:13.0: irq 19, io mem 0xc0504000
[    1.092158] usb usb2: configuration #1 chosen from 1 choice
[    1.092222] hub 2-0:1.0: USB hub found
[    1.092237] hub 2-0:1.0: 4 ports detected
[    1.092300] ohci_hcd 0000:00:13.1: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.092313] ohci_hcd 0000:00:13.1: OHCI Host Controller
[    1.092399] ohci_hcd 0000:00:13.1: new USB bus registered, assigned
bus number 3
[    1.092421] ohci_hcd 0000:00:13.1: irq 19, io mem 0xc0505000
[    1.148160] usb usb3: configuration #1 chosen from 1 choice
[    1.148222] hub 3-0:1.0: USB hub found
[    1.148237] hub 3-0:1.0: 4 ports detected
[    1.148335] uhci_hcd: USB Universal Host Controller Interface driver
[    1.148566] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at
0x60,0x64 irq 1,12
[    1.151008] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.151015] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.151309] mice: PS/2 mouse device common for all mice
[    1.151626] rtc_cmos 00:04: RTC can wake from S4
[    1.151723] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    1.151755] rtc0: alarms up to one month, 114 bytes nvram
[    1.151996] device-mapper: uevent: version 1.0.3
[    1.152194] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01)
initialised: dm-devel@redhat.com
[    1.152256] device-mapper: multipath: version 1.1.0 loaded
[    1.152260] device-mapper: multipath round-robin: version 1.0.0 loaded
[    1.152523] EISA: Probing bus 0 at eisa.0
[    1.152534] Cannot allocate resource for EISA slot 1
[    1.152564] Cannot allocate resource for EISA slot 8
[    1.152567] EISA: Detected 0 cards.
[    1.152798] cpuidle: using governor ladder
[    1.153121] cpuidle: using governor menu
[    1.153903] TCP cubic registered
[    1.154272] NET: Registered protocol family 10
[    1.154779] lo: Disabled Privacy Extensions
[    1.155139] NET: Registered protocol family 17
[    1.155214] Bluetooth: L2CAP ver 2.13
[    1.155216] Bluetooth: L2CAP socket layer initialized
[    1.155219] Bluetooth: SCO (Voice Link) ver 0.6
[    1.155221] Bluetooth: SCO socket layer initialized
[    1.155255] Bluetooth: RFCOMM TTY layer initialized
[    1.155258] Bluetooth: RFCOMM socket layer initialized
[    1.155260] Bluetooth: RFCOMM ver 1.11
[    1.155296] Using IPI No-Shortcut mode
[    1.155513] PM: Resume from disk failed.
[    1.155532] registered taskstats version 1
[    1.155656]   Magic number: 1:754:272
[    1.155799] rtc_cmos 00:04: setting system clock to 2009-11-14
09:17:12 UTC (1258190232)
[    1.155804] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.155806] EDD information not available.
[    1.196596] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4
[    1.336084] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.344565] ata1.00: ATA-7: Hitachi HTS541680J9SA00, SB2OC7DP, max UDMA/100
[    1.344569] ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.360581] ata1.00: configured for UDMA/100
[    1.360745] scsi 0:0:0:0: Direct-Access     ATA      Hitachi
HTS54168 SB2O PQ: 0 ANSI: 5
[    1.361045] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks:
(80.0 GB/74.5 GiB)
[    1.361102] sd 0:0:0:0: [sda] Write Protect is off
[    1.361105] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.361134] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.361292]  sda:
[    1.361537] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.524046] usb 3-1: new low speed USB device using ohci_hcd and address 2
[    1.680065] ata2: SATA link down (SStatus 0 SControl 300)
[    1.731188] usb 3-1: configuration #1 chosen from 1 choice
[    1.751601]  sda1 sda2 sda3 < sda5 sda6 >
[    1.789283] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.844639] ata4.00: ATAPI: MATSHITADVD-RAM UJ-850S, 1.10, max UDMA/33
[    1.860604] ata4.00: configured for UDMA/33
[   22.816049] ata4: lost interrupt (Status 0x50)
[   43.816048] ata4: lost interrupt (Status 0x50)
[   64.816047] ata4: lost interrupt (Status 0x50)
[   85.816047] ata4: lost interrupt (Status 0x50)
[  106.816045] ata4: lost interrupt (Status 0x50)
[  127.816048] ata4: lost interrupt (Status 0x50)
[  127.816083] ata4: WARNING: synchronous SCSI scan failed without
making any progress,
[  127.816085]                   switching to async
[  127.816199] Freeing unused kernel memory: 568k freed
[  127.816732] Write protecting the kernel text: 4532k
[  127.816771] Write protecting the kernel read-only data: 1880k
[  128.019905] Linux agpgart interface v0.103
[  128.157864] <6>8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[  128.157909] 8139cp 0000:05:07.0: This (id 10ec:8139 rev 10) is not
an 8139C+ compatible chip, use 8139too
[  128.161332] 8139too Fast Ethernet driver 0.9.28
[  128.161386]   alloc irq_desc for 20 on node -1
[  128.161389]   alloc kstat_irqs on node -1
[  128.161400] 8139too 0000:05:07.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[  128.163097] eth0: RealTek RTL8139 at 0xa000, 00:a0:d1:74:0e:03, IRQ 20
[  128.185175] usbcore: registered new interface driver hiddev
[  128.190489] input: USB Optical Wheel Mouse as
/devices/pci0000:00/0000:00:13.1/usb3/3-1/3-1:1.0/input/input5
[  128.190698] generic-usb 0003:04FC:0005.0001: input,hidraw0: USB HID
v1.10 Mouse [USB Optical Wheel Mouse] on usb-0000:00:13.1-1/input0
[  128.190724] usbcore: registered new interface driver usbhid
[  128.190837] usbhid: v2.6:USB HID core driver
[  128.190936] ohci1394 0000:05:0a.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[  128.194385] [drm] Initialized drm 1.1.0 20060810
[  128.200954] acpi device:1d: registered as cooling_device2
[  128.201252] input: Video Bus as
/devices/LNXSYSTM:00/device:00/PNP0A03:00/device:1a/device:1b/input/input6
[  128.201341] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[  128.221343] [drm] radeon default to kernel modesetting.
[  128.221350] [drm] radeon kernel modesetting enabled.
[  128.221458] radeon 0000:01:05.0: power state changed by ACPI to D0
[  128.221475]   alloc irq_desc for 17 on node -1
[  128.221478]   alloc kstat_irqs on node -1
[  128.221489] radeon 0000:01:05.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  128.225498] [drm] radeon: Initializing kernel modesetting.
[  128.225554] [drm] register mmio base: 0xC0000000
[  128.225556] [drm] register mmio size: 65536
[  128.225950] [drm] GPU reset succeed (RBBM_STATUS=0x00000140)
[  128.225960] [drm] Clocks initialized !
[  128.225964] [drm:rs400_gart_adjust_size] *ERROR* Forcing to 32M
GART size (because of ASIC bug ?)
[  128.226023] [drm] Generation 2 PCI interface, using max accessible memory
[  128.227270] [drm] Detected VRAM RAM=128M, BAR=256M
[  128.227275] [drm] RAM width 128bits DDR
[  128.227498] [drm] radeon: 4 quad pipes, 1 z pipes initialized.
[  128.227505] [drm] radeon: VRAM 128M
[  128.227507] [drm] radeon: VRAM from 0x38000000 to 0x3FFFFFFF
[  128.227510] [drm] radeon: GTT 32M
[  128.227512] [drm] radeon: GTT from 0x40000000 to 0x41FFFFFF
[  128.239134] [drm] radeon: irq initialized.
[  128.239564] [TTM] TTM available graphics memory: 437 MiB
[  128.239567] [TTM] TTM available object memory: 434 MiB
[  128.239586] [drm] radeon: 128M of VRAM memory ready
[  128.239589] [drm] radeon: 32M of GTT memory ready.
[  128.239592] [drm] GART: num cpu pages 8192, num gpu pages 8192
[  128.240071] [drm] radeon: cp idle (0x10000C03)
[  128.240075] [drm] Loading R300 Microcode
[  128.240240] [drm] radeon: ring at 0x0000000040000000
[  128.240263] [drm] ring test succeeded in 2 usecs
[  128.240390] [drm] radeon: ib pool ready.
[  128.240479] [drm] ib test succeeded in 0 usecs
[  128.240508] [drm] Default TV standard: NTSC
[  128.240510] [drm] 14.318180000 MHz TV ref clk
[  128.240815] [drm] Panel ID String: SEC
[  128.240818] [drm] Panel Size 1280x800
[  128.240998] [drm] Radeon Display Connectors
[  128.241001] [drm] Connector 0:
[  128.241002] [drm]   VGA
[  128.241005] [drm]   DDC: 0x68 0x68 0x68 0x68 0x68 0x68 0x68 0x68
[  128.241007] [drm]   Encoders:
[  128.241009] [drm]     CRT1: INTERNAL_DAC2
[  128.241011] [drm] Connector 1:
[  128.241013] [drm]   LVDS
[  128.241016] [drm]   DDC: 0x1a0 0x1a0 0x1a0 0x1a0 0x1a0 0x1a0 0x1a4 0x1a4
[  128.241018] [drm]   Encoders:
[  128.241020] [drm]     LCD1: INTERNAL_LVDS
[  128.242968] i2c-adapter i2c-0: unable to read EDID block.
[  128.242972] radeon 0000:01:05.0: VGA-1: no EDID data
[  128.250052] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[22]
MMIO=[c0200000-c02007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[  128.368126] [drm] fb mappable at 0xD0040000
[  128.368129] [drm] vram apper at 0xD0000000
[  128.368131] [drm] size 4096000
[  128.368133] [drm] fb depth is 24
[  128.368135] [drm]    pitch is 5120
[  128.368264] fb0: radeondrmfb frame buffer device
[  128.368268] registered panic notifier
[  128.368270] [drm] radeon: kernel modesetting successfully initialized.
[  128.368275] [drm] Initialized radeon 2.0.0 20080528 for
0000:01:05.0 on minor 0
[  128.385258] [drm] LVDS-7: set mode 1280x800 c
[  128.407801] Console: switching to colour frame buffer device 160x50
[  128.818026] scsi 3:0:0:0: CD-ROM            MATSHITA DVD-RAM
UJ-850S  1.10 PQ: 0 ANSI: 5
[  128.822561] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw
xa/form2 cdda tray
[  128.822567] Uniform CD-ROM driver Revision: 3.20
[  128.822695] sr 3:0:0:0: Attached scsi CD-ROM sr0
[  128.822769] sr 3:0:0:0: Attached scsi generic sg1 type 5
[  129.371959] PM: Starting manual resume from disk
[  129.371965] PM: Resume from partition 8:5
[  129.371967] PM: Checking hibernation image.
[  129.372203] PM: Resume from disk failed.
[  129.386775] REISERFS (device sda6): found reiserfs format "3.6"
with standard journal
[  129.386794] REISERFS (device sda6): using ordered data mode
[  129.396137] REISERFS (device sda6): journal params: device sda6,
size 8192, journal first block 18, max trans len 1024, max batch 900,
max commit age 30, max trans age 30
[  129.396804] REISERFS (device sda6): checking transaction log (sda6)
[  129.469101] REISERFS (device sda6): Using r5 hash to sort names
[  129.524202] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00080da0d1740e03]
[  131.823921] Adding 995988k swap on /dev/sda5.  Priority:-1
extents:1 across:995988k
[  134.284313] udev: starting version 147
[  137.595969] cfg80211: Calling CRDA to update world regulatory domain
[  137.752541] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[  137.891036] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0x8450, revision 0
[  137.973514] yenta_cardbus 0000:05:06.0: CardBus bridge found [1179:ff10]
[  137.973552] yenta_cardbus 0000:05:06.0: Using CSCINT to route CSC
interrupts to PCI
[  137.973555] yenta_cardbus 0000:05:06.0: Routing CardBus interrupts to PCI
[  137.973563] yenta_cardbus 0000:05:06.0: TI: mfunc 0x01111002, devctl 0x44
[  138.204954] yenta_cardbus 0000:05:06.0: ISA IRQ mask 0x0ef8, PCI irq 23
[  138.204961] yenta_cardbus 0000:05:06.0: Socket status: 30000006
[  138.204970] yenta_cardbus 0000:05:06.0: pcmcia: parent PCI bridge
I/O window: 0xa000 - 0xafff
[  138.204975] pcmcia_socket pcmcia_socket0: cs: IO port probe
0xa000-0xafff: clean.
[  138.205253] yenta_cardbus 0000:05:06.0: pcmcia: parent PCI bridge
Memory window: 0xc0200000 - 0xc02fffff
[  138.205256] yenta_cardbus 0000:05:06.0: pcmcia: parent PCI bridge
Memory window: 0x38000000 - 0x3bffffff
[  138.514690] cfg80211: World regulatory domain updated:
[  138.514696] 	(start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[  138.514700] 	(2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[  138.514703] 	(2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[  138.514706] 	(2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[  138.514709] 	(5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[  138.514713] 	(5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[  138.784829] lp: driver loaded but no devices found
[  138.832252] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1,
caps: 0xa04713/0x0
[  138.832261] synaptics: Toshiba Satellite A100 detected, limiting
rate to 40pps.
[  138.846953] ip_tables: (C) 2000-2006 Netfilter Core Team
[  138.867318] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input7
[  139.031899] pcmcia_socket pcmcia_socket0: cs: IO port probe
0x100-0x3af: clean.
[  139.034300] pcmcia_socket pcmcia_socket0: cs: IO port probe
0x3e0-0x4ff: clean.
[  139.035307] pcmcia_socket pcmcia_socket0: cs: IO port probe
0x820-0x8ff: clean.
[  139.036168] pcmcia_socket pcmcia_socket0: cs: IO port probe
0xc00-0xcf7: clean.
[  139.037058] pcmcia_socket pcmcia_socket0: cs: IO port probe
0xa00-0xaff: clean.
[  139.680410] ath5k 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[  139.680425] ath5k 0000:02:00.0: setting latency timer to 64
[  139.680495] ath5k 0000:02:00.0: registered as 'phy0'
[  139.848034] ath: EEPROM regdomain: 0x64
[  139.848040] ath: EEPROM indicates we should expect a direct regpair map
[  139.848046] ath: Country alpha2 being used: 00
[  139.848048] ath: Regpair used: 0x64
[  140.720284] phy0: Selected rate control algorithm 'minstrel'
[  140.721062] ath5k phy0: Atheros AR5414 chip found (MAC: 0xa0, PHY: 0x61)
[  140.736725] udev: renamed network interface wlan0 to ath0
[  141.022943] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level,
low) -> IRQ 16
[  141.651222] hda_codec: Unknown model for ALC861-VD, trying
auto-probe from BIOS...
[  141.651333] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:14.2/input/input8
[  145.588510] ADDRCONF(NETDEV_UP): ath0: link is not ready
[  145.591888] eth0: link down
[  145.592756] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  151.724436] Unpin not necessary for f7111000 !
[  153.635627] ath0: authenticate with AP 00:1d:7e:34:3c:c1
[  153.637505] ath0: authenticated
[  153.637511] ath0: associate with AP 00:1d:7e:34:3c:c1
[  153.639962] ath0: RX AssocResp from 00:1d:7e:34:3c:c1 (capab=0x411
status=0 aid=1)
[  153.639967] ath0: associated
[  153.640691] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[  164.544019] ath0: no IPv6 routers present
[  167.740310] ppdev: user-space parallel port driver
[  327.836091] si3054: cannot initialize. EXT MID = f000
[  446.292044] ACPI: EC: missing confirmations, switch off interrupt mode.
[  551.156054] usb 2-1: new low speed USB device using ohci_hcd and address 2
[  551.356226] usb 2-1: configuration #1 chosen from 1 choice
[  551.367550] input: Composite USB PS2 Converter USB to PS2 Adaptor
v1.10 as /devices/pci0000:00/0000:00:13.0/usb2/2-1/2-1:1.0/input/input9
[  551.367654] generic-usb 0003:0518:0001.0002: input,hidraw1: USB HID
v1.10 Keyboard [Composite USB PS2 Converter USB to PS2 Adaptor  v1.10]
on usb-0000:00:13.0-1/input0
[  551.374837] input: Composite USB PS2 Converter USB to PS2 Adaptor
v1.10 as /devices/pci0000:00/0000:00:13.0/usb2/2-1/2-1:1.1/input/input10
[  551.374964] generic-usb 0003:0518:0001.0003: input,hidraw2: USB HID
v1.10 Mouse [Composite USB PS2 Converter USB to PS2 Adaptor  v1.10] on
usb-0000:00:13.0-1/input1


[X.] Other notes, patches, fixes, workarounds:
-
