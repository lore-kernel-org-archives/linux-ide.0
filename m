From: richard kennedy <richard@rsk.demon.co.uk>
Subject: pata_via cd/dvd timeout problems
Date: Mon, 03 Sep 2007 15:19:17 +0100
Message-ID: <1188829157.3190.29.camel@castor.rsk.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:2069 "EHLO
	anchor-post-35.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbXICO3p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 10:29:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

I have both a dvd RW drive & a cd rom drive connected the second ide
interface on my motherboard with a via chipset, using pata_via I see
timeout messages in the log & after some time both drives lockup and are
unable to mount any disks. 

This problem is present in at least 2.6.22 & 2.6.23-rc5.
This is a AMD Athlon X2 smp machine running fedora -- untainted.
sorry I didn't spot this sooner but I don't use these drives all that
often.   
Any suggestions for what is going wrong or how to get any more debug
info? 

lspci -v
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
        Region 4: I/O ports at e400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
both drives are seen ok at boot time :- 

Sep  3 13:49:27 castor kernel: scsi2 : pata_via
Sep  3 13:49:27 castor kernel: scsi3 : pata_via
Sep  3 13:49:27 castor kernel: ata3: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x000000000001e400 irq 14
Sep  3 13:49:27 castor kernel: ata4: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x000000000001e408 irq 15
Sep  3 13:49:27 castor kernel: ata3.00: ATA-7: Maxtor 6B300R0, BAH41BM0, max UDMA/133
Sep  3 13:49:27 castor kernel: ata3.00: 586114704 sectors, multi 16: LBA48 
Sep  3 13:49:28 castor kernel: ata3.00: configured for UDMA/133
Sep  3 13:49:28 castor kernel: ata4.00: ATAPI: _NEC DVD_RW ND-3520A, 1.04, max UDMA/33
Sep  3 13:49:28 castor kernel: ata4.01: ATAPI: TSSTcorpDVD-ROM TS-H352A, TS03, max UDMA/33
Sep  3 13:49:28 castor kernel: ata4.00: configured for UDMA/33
Sep  3 13:49:28 castor kernel: ata4.01: configured for UDMA/33
Sep  3 13:49:28 castor kernel: scsi 2:0:0:0: Direct-Access     ATA      Maxtor 6B300R0   BAH4 PQ: 0 ANSI: 5
Sep  3 13:49:28 castor kernel: sd 2:0:0:0: [sdb] 586114704 512-byte hardware sectors (300091 MB)
Sep  3 13:49:28 castor kernel: sd 2:0:0:0: [sdb] Write Protect is off
Sep  3 13:49:28 castor kernel: sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Sep  3 13:49:28 castor kernel: sd 2:0:0:0: [sdb] 586114704 512-byte hardware sectors (300091 MB)
Sep  3 13:49:28 castor kernel: sd 2:0:0:0: [sdb] Write Protect is off
Sep  3 13:49:28 castor kernel: sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Sep  3 13:49:28 castor kernel:  sdb: sdb1 sdb2
Sep  3 13:49:28 castor kernel: sd 2:0:0:0: [sdb] Attached SCSI disk
Sep  3 13:49:29 castor kernel: scsi 3:0:0:0: CD-ROM            _NEC     DVD_RW ND-3520A  1.04 PQ: 0 ANSI: 5
Sep  3 13:49:29 castor kernel: scsi 3:0:1:0: CD-ROM            TSSTcorp DVD-ROM TS-H352A TS03 PQ: 0 ANSI: 5


this is the first timeout message 

Sep  3 14:12:48 castor kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Sep  3 14:12:48 castor kernel: ata4.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x4a data 8 in
Sep  3 14:12:48 castor kernel:          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  3 14:12:48 castor kernel: ata4: soft resetting port
Sep  3 14:12:48 castor kernel: ata4.00: configured for UDMA/33
Sep  3 14:12:49 castor kernel: ata4.01: configured for UDMA/33
Sep  3 14:12:49 castor kernel: ata4: EH complete

this gets repeated 3 or 4 times then changes to this

Sep  3 14:16:45 castor kernel: ata4.00: limiting speed to UDMA/25:PIO4
Sep  3 14:16:45 castor kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Sep  3 14:16:45 castor kernel: ata4.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x1e data 0 
Sep  3 14:16:45 castor kernel:          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Sep  3 14:16:45 castor kernel: ata4: soft resetting port
Sep  3 14:16:45 castor kernel: ata4.00: configured for UDMA/25
Sep  3 14:16:46 castor kernel: ata4.01: configured for UDMA/33
Sep  3 14:16:46 castor kernel: ata4: EH complete

repeats multiple times then

Sep  3 14:23:27 castor kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Sep  3 14:23:27 castor kernel: ata4.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x1e data 0 
Sep  3 14:23:27 castor kernel:          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  3 14:23:27 castor kernel: ata4: soft resetting port
Sep  3 14:23:27 castor kernel: ata4.00: configured for PIO4
Sep  3 14:23:28 castor kernel: ata4.01: configured for UDMA/33
Sep  3 14:23:28 castor kernel: ata4: EH complete
Sep  3 14:23:28 castor kernel: sr 3:0:0:0: ioctl_internal_command return code = 8000002
Sep  3 14:23:28 castor kernel:    : Sense Key : Aborted Command [current] [descriptor]
Sep  3 14:23:28 castor kernel:    : Add. Sense: No additional sense information
Sep  3 14:23:58 castor kernel: ata4.01: limiting speed to UDMA/25:PIO4
Sep  3 14:23:58 castor kernel: ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Sep  3 14:23:58 castor kernel: ata4.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
Sep  3 14:23:58 castor kernel:          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  3 14:23:58 castor kernel: ata4: soft resetting port
Sep  3 14:23:58 castor kernel: ata4.00: configured for PIO4
Sep  3 14:23:58 castor kernel: ata4.01: configured for UDMA/25
Sep  3 14:23:58 castor kernel: ata4: EH complete

By this point neither drive will mount a disk.

thanks
Richard


