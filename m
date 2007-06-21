From: Gabriele Tozzi <gabriele.tozzi@gmail.com>
Subject: Possible BUG in Linux's Promise TX4 drivers
Date: Thu, 21 Jun 2007 04:38:01 +0200
Message-ID: <4679E489.2020205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vsmtp2.tin.it ([212.216.176.222]:59830 "EHLO vsmtp2.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbXFUCkA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 22:40:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I got a Promise TX4 SATA 300 Controller with 3 SAMSUNG HD400LJ SATA 300 
disks (sdc, sdd, sde), the disks runs under a software raid5 with Luks 
(Cryptography layer) and Lvm2.

The disks works well and there is no data loss, but i'm continuously and 
always getting worrisome error messages and poor performance (with brief 
system jams) when i perform writing operations to disks. Reading data 
works well and seems to give no error messages.

I've checked cables and power supply and i've tryied swapping 
controller's pci slot and playing with bios irq setting. None of them 
changed the results, so i'm assuming the presence of a kernel bug. I'm 
sorry if i'm getting wrong and then wasting your time.

My kernel version:
Linux version 2.6.21.5 (root@transylvania) (gcc version 4.1.3 20070601 
(prerelease) (Debian 4.1.2-12)) #1 SMP Fri Jun 15 20:25:41 CEST 2007

This presumed bug was present on linux 2.60.20.7 too.

On kernel 2.6.18.1 the bug was present, but with different error 
messages, the messages were identical to those reported by another user 
on this mail: http://lkml.org/lkml/2006/10/25/198

I got an Asus CUV4X-D motherboard with two PIII 800Mhz CPUS, this is my 
home server :)

Here is an example of the given error messages:

**************************************************

Jun 20 14:02:54 localhost kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Jun 20 14:02:54 localhost kernel: ata4.00: cmd 25/00:40:7f:01:46/00:00:2d:00:00/e0 tag 0 cdb 0x0 data 32768 in
Jun 20 14:02:54 localhost kernel:          res 50/00:00:be:01:46/00:00:2d:00:00/e0 Emask 0x1 (device error)
Jun 20 14:02:54 localhost kernel: ata4.00: configured for UDMA/100
Jun 20 14:02:54 localhost kernel: SCSI device sde: 781422768 512-byte hdwr sectors (400088 MB)
Jun 20 14:02:54 localhost kernel: sde: Write Protect is off
Jun 20 14:02:54 localhost kernel: sde: Mode Sense: 00 3a 00 00
Jun 20 14:02:54 localhost kernel: SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 20 14:03:22 localhost kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Jun 20 14:03:22 localhost kernel: ata1.00: cmd 25/00:60:c7:38:46/00:00:2d:00:00/e0 tag 0 cdb 0x0 data 49152 in
Jun 20 14:03:22 localhost kernel:          res 50/00:00:26:39:46/00:00:2d:00:00/e0 Emask 0x1 (device error)
Jun 20 14:03:22 localhost kernel: ata1.00: configured for UDMA/100
Jun 20 14:03:22 localhost kernel: SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
Jun 20 14:03:22 localhost kernel: sdc: Write Protect is off
Jun 20 14:03:22 localhost kernel: sdc: Mode Sense: 00 3a 00 00
Jun 20 14:03:22 localhost kernel: SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 20 14:03:42 localhost kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Jun 20 14:03:42 localhost kernel: ata4.00: cmd 25/00:10:af:b2:46/00:00:2d:00:00/e0 tag 0 cdb 0x0 data 8192 in
Jun 20 14:03:42 localhost kernel:          res 50/00:00:be:b2:46/00:00:2d:00:00/e0 Emask 0x1 (device error)
Jun 20 14:03:42 localhost kernel: ata4.00: configured for UDMA/100
Jun 20 14:03:42 localhost kernel: SCSI device sde: 781422768 512-byte hdwr sectors (400088 MB)
Jun 20 14:03:42 localhost kernel: sde: Write Protect is off
Jun 20 14:03:42 localhost kernel: sde: Mode Sense: 00 3a 00 00
Jun 20 14:03:42 localhost kernel: SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 20 14:04:03 localhost kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Jun 20 14:04:03 localhost kernel: ata1.00: cmd 25/00:08:4f:dd:45/00:00:2d:00:00/e0 tag 0 cdb 0x0 data 4096 in
Jun 20 14:04:03 localhost kernel:          res 50/00:00:56:dd:45/00:00:2d:00:00/e0 Emask 0x1 (device error)
Jun 20 14:04:04 localhost kernel: ata1.00: configured for UDMA/100
Jun 20 14:04:04 localhost kernel: SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
Jun 20 14:04:04 localhost kernel: sdc: Write Protect is off
Jun 20 14:04:04 localhost kernel: sdc: Mode Sense: 00 3a 00 00
Jun 20 14:04:04 localhost kernel: SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 20 14:05:28 localhost kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Jun 20 14:05:28 localhost kernel: ata2.00: cmd 25/00:08:e7:5a:47/00:00:2d:00:00/e0 tag 0 cdb 0x0 data 4096 in
Jun 20 14:05:28 localhost kernel:          res 50/00:00:ee:5a:47/00:00:2d:00:00/e0 Emask 0x1 (device error)
Jun 20 14:05:28 localhost kernel: ata2.00: configured for UDMA/133
Jun 20 14:05:28 localhost kernel: SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
Jun 20 14:05:28 localhost kernel: sdd: Write Protect is off
Jun 20 14:05:28 localhost kernel: sdd: Mode Sense: 00 3a 00 00
Jun 20 14:05:28 localhost kernel: SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 20 14:06:59 localhost kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Jun 20 14:06:59 localhost kernel: ata4.00: cmd 25/00:58:e7:dd:48/00:00:2d:00:00/e0 tag 0 cdb 0x0 data 45056 in
Jun 20 14:06:59 localhost kernel:          res 50/00:00:3e:de:48/00:00:2d:00:00/e0 Emask 0x1 (device error)
Jun 20 14:06:59 localhost kernel: ata4.00: configured for UDMA/100
Jun 20 14:06:59 localhost kernel: SCSI device sde: 781422768 512-byte hdwr sectors (400088 MB)
Jun 20 14:06:59 localhost kernel: sde: Write Protect is off
Jun 20 14:06:59 localhost kernel: sde: Mode Sense: 00 3a 00 00
Jun 20 14:06:59 localhost kernel: SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

**************************************************

Here is my lspci output (with controller information):

**************************************************

transylvania:~# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev c4)
        Subsystem: ASUSTeK Computer Inc. Unknown device 8038
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fe000000 (32-bit, prefetchable) [size=8M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
        Subsystem: ASUSTeK Computer Inc. Unknown device 8038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: [virtual] Memory at 000001f0 (32-bit, 
non-prefetchable) [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, 
non-prefetchable) [size=1]
        Region 2: [virtual] Memory at 00000170 (32-bit, 
non-prefetchable) [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, 
non-prefetchable) [size=1]
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 61) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 61) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63) (prog-if 
20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin C routed to IRQ 19
        Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 
300 TX4) (rev 02)
        Subsystem: Promise Technology, Inc. PDC40718 (SATA 300 TX4)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (1000ns min, 4500ns max), Cache Line Size: 4 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at b000 [size=128]
        Region 2: I/O ports at a800 [size=256]
        Region 3: Memory at fa800000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fa000000 (32-bit, non-prefetchable) [size=128K]
        [virtual] Expansion ROM at 30030000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
86C326 5598/6326 (rev 0b) (prog-if 00 [VGA])
        Subsystem: Palit Microsystems Inc. SiS6326 GUI Accelerator
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min)
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at fd000000 (32-bit, prefetchable) [size=8M]
        Region 1: Memory at f9800000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at a400 [size=128]
        Expansion ROM at 30020000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f8800000-f97fffff
        Prefetchable memory behind bridge: 00000000fbf00000-00000000fcefffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 8800 [size=128]
        Region 1: Memory at f8000000 (32-bit, non-prefetchable) [size=128]
        [virtual] Expansion ROM at 30000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 Memory controller: Adaptec AIC-7815 RAID+Memory Controller IC 
(rev 02)
        Subsystem: Adaptec AIC-7815 RAID+Memory Controller IC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 500ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9800 [size=256]
        Region 1: Memory at f9000000 (32-bit, non-prefetchable) [size=4K]
        Region 2: Memory at fc000000 (32-bit, prefetchable) [size=4M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 SCSI storage controller: Adaptec 78902
        Subsystem: Adaptec AAA-131U2 Array1000 1 Channel RAID Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (9750ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 17
        BIST result: 00
        Region 0: I/O ports at 9400 [disabled] [size=256]
        Region 1: Memory at f8800000 (64-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at fbf00000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

**************************************************

here is my hdparm -iI output for sdc (all disks connected to controller 
are of same model):

**************************************************

transylvania:~# hdparm -iI /dev/sdc

/dev/sdc:

 Model=SAMSUNG HD400LJ                         , FwRev=ZZ100-15, 
SerialNo=S0H2J1FL806351
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


ATA device, with non-removable media
*        Model Number:       SAMSUNG HD400LJ*
        Serial Number:      S0H2J1FL806351
        Firmware Revision:  ZZ100-15
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 4a
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  781422768
        device size with M = 1024*1024:      381554 MBytes
        device size with M = 1000*1000:      400088 MBytes (400 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = ?
        Recommended acoustic management value: 254, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
udma6 udma7
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        228min for SECURITY ERASE UNIT. 228min for ENHANCED SECURITY 
ERASE UNIT.
Checksum: correct

**************************************************

CPUs information (SMP system):

**************************************************
transylvania:~# cat /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 803.694
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1608.90
clflush size    : 32

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 803.694
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1607.36
clflush size    : 32

**************************************************

Loadable module support is disabled (no kernel modules)

**************************************************
Loaded driver and hardware information

**************************************************
transylvania:~# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:04.1
01f0-01f7 : 0000:00:04.1
  01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : 0000:00:04.1
03c0-03df : vga+
03f2-03f5 : floppy
03f6-03f6 : 0000:00:04.1
  03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial
0cf8-0cff : PCI conf1
8800-887f : 0000:00:0d.0
9000-9fff : PCI Bus #02
  9400-94ff : 0000:02:04.0
  9800-98ff : 0000:02:00.0
a400-a47f : 0000:00:0b.0
a800-a8ff : 0000:00:0a.0
b000-b07f : 0000:00:0a.0
b400-b41f : 0000:00:09.1
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:09.0
  b800-b81f : uhci_hcd
d000-d01f : 0000:00:04.3
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:04.2
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
  d800-d807 : ide0
  d808-d80f : ide1
e400-e47f : pnp 00:03
  e400-e403 : ACPI PM1a_EVT_BLK
  e404-e405 : ACPI PM1a_CNT_BLK
  e408-e40b : ACPI PM_TMR
  e420-e423 : ACPI GPE0_BLK
e800-e80f : 0000:00:04.4
  e800-e80f : pnp 00:03
    e800-e807 : vt596_smbus

transylvania:~# cat /proc/iomem
00000000-0009b7ff : System RAM
0009b800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d0fff : Adapter ROM
000d4000-000db7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-005f8510 : Kernel code
  005f8511-00787e0b : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
30000000-3001ffff : 0000:00:0d.0
30020000-3002ffff : 0000:00:0b.0
30030000-30037fff : 0000:00:0a.0
f8000000-f800007f : 0000:00:0d.0
f8800000-f97fffff : PCI Bus #02
  f8800000-f8800fff : 0000:02:04.0
    f8800000-f8800fff : aic7xxx
  f9000000-f9000fff : 0000:02:00.0
f9800000-f980ffff : 0000:00:0b.0
fa000000-fa01ffff : 0000:00:0a.0
fa800000-fa800fff : 0000:00:0a.0
  fa800000-fa800fff : sata_promise
fb000000-fb0000ff : 0000:00:09.2
  fb000000-fb0000ff : ehci_hcd
fbf00000-fcefffff : PCI Bus #02
  fbf00000-fbf1ffff : 0000:02:04.0
  fc000000-fc3fffff : 0000:02:00.0
fd000000-fd7fffff : 0000:00:0b.0
fe000000-fe7fffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

**************************************************

SCSI information

**************************************************

Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI  SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI  SCSI revision: 03
Host: scsi0 Channel: 00 Id: 12 Lun: 00
  Vendor: HP       Model: C5683A           Rev: C305
  Type:   Sequential-Access                ANSI  SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD400LJ  Rev: ZZ10
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD400LJ  Rev: ZZ10
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD400LJ  Rev: ZZ10
  Type:   Direct-Access                    ANSI  SCSI revision: 05

**************************************************

Please ask me to gather any more information you need to better throubleshoot the problem.


Thank you very much.

Gabriele Tozzi

