From: Johann-Christoph Jacob <johann-christoph.jacob@fhtw-berlin.de>
Subject: Re: sata_sil24 not configuring drive right?
Date: Wed, 20 Feb 2008 20:16:08 +0100
Message-ID: <47BC7C78.6050708@fhtw-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.rz.fhtw-berlin.de ([141.45.10.102]:65375 "EHLO
	mail2.rz.fhtw-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYBTUQD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 15:16:03 -0500
Received: from dslb-088-073-048-015.pools.arcor-ip.net ([88.73.48.15] helo=[192.168.0.4])
	by mail2.rz.fhtw-berlin.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68 (FreeBSD))
	(envelope-from <johann-christoph.jacob@fhtw-berlin.de>)
	id 1JRuRF-000Lyp-3Q
	for linux-ide@vger.kernel.org; Wed, 20 Feb 2008 20:17:12 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

i do have a NCQ queue_depth of 1 too and my /sys/block/sda/device/queue_depth is not writeable.
I thought i'd take the time to provide you with the hdparm output hoping this minor issue can be resolved.

Yours faithfully
Johann-Christoph Jacob



>From uname -a:

Linux amilo 2.6.24.2 #1 SMP PREEMPT Mon Feb 11 22:01:11 CET 2008 i686 GNU/Linux


>From lspci -vvk:

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Fujitsu Siemens Computer GmbH Unknown device 10ad
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at 1810 [size=16]
        Kernel driver in use: ata_piix

00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA AHCI Controller (rev 02) (prog-if 01 [AHCI 1.0])
        Subsystem: Fujitsu Siemens Computer GmbH Unknown device 10ad
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 220
        Region 0: I/O ports at 18d0 [size=8]
        Region 1: I/O ports at 18c4 [size=4]
        Region 2: I/O ports at 18c8 [size=8]
        Region 3: I/O ports at 18c0 [size=4]
        Region 4: I/O ports at 18b0 [size=16]
        Region 5: Memory at dc444400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
                Address: fee0100c  Data: 41e9
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ahci


>From /var/log/kern.log:

ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: nr_ports (4) and implemented port map (0x5) don't match, using nr_ports
ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444500 irq 220
ata2: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444580 irq 220
ata3: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444600 irq 220
ata4: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444680 irq 220
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: WDC WD1200BEVS-07LAT0, 01.06M01, max UDMA/133
ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 1)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      WDC WD1200BEVS-0 01.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
ata_piix 0000:00:1f.1: version 2.12
scsi4 : ata_piix
scsi5 : ata_piix
ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1810 irq 14
ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
ata5.00: ATAPI: Optiarc DVD RW AD-7540A, 1.42, max UDMA/33
ata5.00: configured for UDMA/33
ata6: port disabled. ignoring.
scsi 4:0:0:0: CD-ROM            Optiarc  DVD RW AD-7540A  1.42 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:0:0: Attached scsi CD-ROM sr0


>From hdparm -I /dev/sda:

/dev/sda:

ATA device, with non-removable media
        Model Number:       WDC WD1200BEVS-07LAT0                   
        Serial Number:      WD-WXE906801963
        Firmware Revision:  01.06M01
Standards:
        Supported: 7 6 5 4 
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  234441648
        LBA48  user addressable sectors:  234441648
        device size with M = 1024*1024:      114473 MBytes
        device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, with device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x00fe)
        Recommended acoustic management value: 128, current value: 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
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
                Advanced Power Management feature set
           *    SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    64-bit World wide name
           *    IDLE_IMMEDIATE with UNLOAD
           *    SATA-I signaling speed (1.5Gb/s)
           *    Native Command Queueing (NCQ)
           *    Phy event counters
                DMA Setup Auto-Activate optimization
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12]
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct
