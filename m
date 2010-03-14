From: Manolis Nazlidis <emnazlidis@gmail.com>
Subject: Strange behavior with jmicron controller and specific hd model
Date: Mon, 15 Mar 2010 01:27:44 +0200
Message-ID: <f67c15431003141627m77a4bce4wa5bce99476613155@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:51932 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab0CNX1q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Mar 2010 19:27:46 -0400
Received: by fxm27 with SMTP id 27so3315101fxm.28
        for <linux-ide@vger.kernel.org>; Sun, 14 Mar 2010 16:27:44 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello everyone,

	I own a SATA-II PCIe controller of jmicron which carries this stuff:

02:00.0 SATA controller [0106]: JMicron Technologies, Inc. JMicron
20360/20363 AHCI Controller [197b:2363] (rev 03) (prog-if 01 [AHCI
1.0])
	Subsystem: JMicron Technologies, Inc. JMicron 20360/20363 AHCI
Controller [197b:2363]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 5: Memory at feafe000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at feae0000 [disabled] [size=64K]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Express (v1) Legacy Endpoint, MSI 01
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr+ UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <1us, L1 <16us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
	Kernel driver in use: ahci

02:00.1 IDE interface [0101]: JMicron Technologies, Inc. JMicron
20360/20363 AHCI Controller [197b:2363] (rev 03) (prog-if 85 [Master
SecO PriO])
	Subsystem: JMicron Technologies, Inc. JMicron 20360/20363 AHCI
Controller [197b:2363]
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at dc00 [size=8]
	Region 1: I/O ports at d880 [size=4]
	Region 2: I/O ports at d800 [size=8]
	Region 3: I/O ports at d480 [size=4]
	Region 4: I/O ports at d400 [size=16]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pata_jmicron

to use it with this 1.5TB hard drive:

	WDC WD15EARS-00Z5B1, FwRev=80.00A80

in an external enclosure under e-sata.

when i try to read or write more than about 100Kb (eg, with dd) i get messages
at my system log like:

ata2.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata2.00: failed command: READ FPDMA QUEUED
ata2.00: cmd 60/00:00:e0:53:00/01:00:00:00:00/40 tag 0 ncq 131072 in
         res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2.00: failed command: READ FPDMA QUEUED
ata2.00: cmd 60/00:08:e0:52:00/01:00:00:00:00/40 tag 1 ncq 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link

and disk i/o freezes for about 30seconds.

Here is jmicron controller initialization when kernel boots:

[    5.390562] ahci 0000:02:00.0: version 3.0
[    5.390578] ahci 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    5.404533] ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3
Gbps 0x3 impl SATA mode
[    5.404587] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part
[    5.404635] ahci 0000:02:00.0: setting latency timer to 64
[    5.404762] scsi0 : ahci
[    5.404864] scsi1 : ahci
[    5.404929] ata1: SATA max UDMA/133 abar m8192@0xfeafe000 port
0xfeafe100 irq 16
[    5.404979] ata2: SATA max UDMA/133 abar m8192@0xfeafe000 port
0xfeafe180 irq 16


When kernel discovers hard drive, i get at system log:

[  201.457926] ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050000
action 0xe frozen
[  201.457930] ata2: irq_stat 0x00000040, connection status changed
[  201.457933] ata2: SError: { PHYRdyChg CommWake DevExch }
[  201.457939] ata2: hard resetting link
[  211.472012] ata2: softreset failed (device not ready)
[  211.472016] ata2: hard resetting link
[  213.704024] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  213.714268] ata2.00: ATA-8: WDC WD15EARS-00Z5B1, 80.00A80, max UDMA/133
[  213.714271] ata2.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[  213.717559] ata2.00: configured for UDMA/133
[  213.717565] ata2: EH complete
[  213.717645] scsi 1:0:0:0: Direct-Access     ATA      WDC
WD15EARS-00Z 80.0 PQ: 0 ANSI: 5
[  213.717785] sd 1:0:0:0: [sdc] 2930277168 512-byte logical blocks:
(1.50 TB/1.36 TiB)
[  213.717832] sd 1:0:0:0: [sdc] Write Protect is off
[  213.717834] sd 1:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  213.717839] sd 1:0:0:0: Attached scsi generic sg3 type 0
[  213.717854] sd 1:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  213.717975]  sdc: sdc1
[  213.726798] sd 1:0:0:0: [sdc] Attached SCSI disk

Hard drive seems to be ok, since i connected it internally on my motherboard
(intel's ICH7) and works fine. Jmicron controller and external e-sata
enclosure also seem to be ok as weel, as i 've tried other hard drives
on it and all work fine.

Problem persists with older kernel versions too.
Is this the correct place to post this? Any ideas?
In case you think it's a h/w problem, please consider this message void.
When replying, please also CC to me.

I add some output that might [hopefully] help.

$ uname -r
2.6.33

$ lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 82945G/GZ/P/PL Memory
Controller Hub [8086:2770] (rev 02)
00:02.0 VGA compatible controller [0300]: Intel Corporation 82945G/GZ
Integrated Graphics Controller [8086:2772] (rev 02)
00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family)
High Definition Audio Controller [8086:27d8] (rev 01)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 [8086:27d0] (rev 01)
00:1c.1 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 2 [8086:27d2] (rev 01)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #1 [8086:27c8] (rev 01)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #2 [8086:27c9] (rev 01)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #3 [8086:27ca] (rev 01)
00:1d.3 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #4 [8086:27cb] (rev 01)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB2 EHCI Controller [8086:27cc] (rev 01)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge
[8086:244e] (rev e1)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801GB/GR (ICH7 Family)
LPC Interface Bridge [8086:27b8] (rev 01)
00:1f.1 IDE interface [0101]: Intel Corporation 82801G (ICH7 Family)
IDE Controller [8086:27df] (rev 01)
00:1f.2 IDE interface [0101]: Intel Corporation 82801GB/GR/GH (ICH7
Family) SATA IDE Controller [8086:27c0] (rev 01)
00:1f.3 SMBus [0c05]: Intel Corporation 82801G (ICH7 Family) SMBus
Controller [8086:27da] (rev 01)
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev
01)
02:00.0 SATA controller [0106]: JMicron Technologies, Inc. JMicron
20360/20363 AHCI Controller [197b:2363] (rev 03)
02:00.1 IDE interface [0101]: JMicron Technologies, Inc. JMicron
20360/20363 AHCI Controller [197b:2363] (rev 03)
03:02.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL-8169 Gigabit Ethernet [10ec:8169] (rev 10)

$ hdparm -iI /dev/sdc # _when disk attached on ICH7_

/dev/sdc:

 Model=WDC WD15EARS-00Z5B1                     , FwRev=80.00A80,
SerialNo=     WD-WMAVU1165352
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=50
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=18446744072344861488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


ATA device, with non-removable media
	Model Number:       WDC WD15EARS-00Z5B1
	Serial Number:      WD-WMAVU1165352
	Firmware Revision:  80.00A80
	Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5
Standards:
	Supported: 8 7 6 5
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors: 2930277168
	device size with M = 1024*1024:     1430799 MBytes
	device size with M = 1000*1000:     1500301 MBytes (1500 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	    	Power-Up In Standby feature set
	   *	SET_FEATURES required to spinup after power up
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	SATA-II signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	unknown 76[12]
	    	DMA Setup Auto-Activate optimization
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[12] (vendor specific)
	    	unknown 206[13] (vendor specific)
Security:
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	324min for SECURITY ERASE UNIT. 324min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50014ee01e475da
	NAA		: 5
	IEEE OUI	: 14ee
	Unique ID	: 01e475da
Checksum: correct


$ hdparm -iI /dev/sdc # _when disk attached on Jmicron_

/dev/sdc:

 Model=WDC WD15EARS-00Z5B1                     , FwRev=80.00A80,
SerialNo=     WD-WMAVU1165352
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=50
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=18446744072344861488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


ATA device, with non-removable media
	Model Number:       WDC WD15EARS-00Z5B1
	Serial Number:      WD-WMAVU1165352
	Firmware Revision:  80.00A80
	Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5
Standards:
	Supported: 8 7 6 5
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors: 2930277168
	device size with M = 1024*1024:     1430799 MBytes
	device size with M = 1000*1000:     1500301 MBytes (1500 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	    	Power-Up In Standby feature set
	   *	SET_FEATURES required to spinup after power up
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	SATA-II signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	unknown 76[12]
	   *	DMA Setup Auto-Activate optimization
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[12] (vendor specific)
	    	unknown 206[13] (vendor specific)
Security:
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	324min for SECURITY ERASE UNIT. 324min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50014ee01e475da
	NAA		: 5
	IEEE OUI	: 14ee
	Unique ID	: 01e475da
Checksum: correct


Thx in advance for your time and support.
