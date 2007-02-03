From: Fredrik Rinnestam <fredrik@obra.se>
Subject: Re: SIL3512 lockup problem using driver verion 0.9 and Linux 2.6.14
Date: Sat, 3 Feb 2007 21:14:49 +0100
Message-ID: <20070203201449.GA1222@useful.obra.se>
References: <74342.74582.qm@web52304.mail.yahoo.com> <457E040D.2020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep02.bredband.com ([195.54.107.73]:50435 "EHLO
	mxfep02.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbXBCUmL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 15:42:11 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep03.bredband.com with ESMTP
          id <20070203201533.PARG2708.mxfep03.bredband.com@ironport2.bredband.com>
          for <linux-ide@vger.kernel.org>; Sat, 3 Feb 2007 21:15:33 +0100
Content-Disposition: inline
In-Reply-To: <457E040D.2020707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> > ata1: command 0x35 timeout, stat 0xd1 host_stat 0x1
> >   ata1: status=0xd1 { Busy }
> >   sd 0:0:0:0: SCSI error: return code = 0x8000002
> >   sda: Current: sense key=0xb
> >       ASC=0x47 ASCQ=0x0
> >   end_request: I/O error, dev sda, sector 17033103
> >   ata1: Abnormal status 0xD1 on port 0xC001E087
> >   ata1: Alternate status 0xD1 on port 0xC001E08A
> >   ata1: Error 0xd1
> >   ata1: Abnormal status 0xD1 on port 0xC001E087
> >   ata1: Alternate status 0xD1 on port 0xC001E08A
> >   ata1: Error 0xd1
> >   ata1: Abnormal status 0xD1 on port 0xC001E087
> >   ata1: Alternate status 0xD1 on port 0xC001E08A
> 
> This is message from old error handling and doesn't really contain much
> useful info.  Even if you have to use previous kernel in production
> system, providing error messages from 2.6.19 will help chasing down the
> cause.
> 
> -- 
> tejun

I get very similar error-messages with my SiI 3512 controller. I just
noticed this while connecting a second drive and moving data from sdb to
sda. Copying stuff from the internal ide-controller (nvidia) to sda does
not produce any errors. I've also tried diffrent cables without any
luck. Kernel is 2.6.19.2

This is what dmesg pukes out:

EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x0
ata1.00: (BMDMA stat 0x60)
ata1.00: tag 0 cmd 0x35 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x0
ata1.00: (BMDMA stat 0x60)
ata1.00: tag 0 cmd 0x35 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x2 frozen
ata1.00: (BMDMA stat 0x61)
ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd1)
ata1: port failed to respond (30 secs, Status 0xd1)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x2 frozen
ata1.00: (BMDMA stat 0x61)
ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd1)
ata1: port failed to respond (30 secs, Status 0xd1)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x2 frozen
ata1.00: (BMDMA stat 0x61)
ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd1)
ata1: port failed to respond (30 secs, Status 0xd1)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: limiting speed to UDMA/66
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x2 frozen
ata1.00: (BMDMA stat 0x61)
ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd1)
ata1: port failed to respond (30 secs, Status 0xd1)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/66
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x0
ata1.00: (BMDMA stat 0x60)
ata1.00: tag 0 cmd 0x35 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: limiting speed to UDMA/44
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x2 frozen
ata1.00: (BMDMA stat 0x61)
ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd1)
ata1: port failed to respond (30 secs, Status 0xd1)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/44
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: limiting speed to UDMA/33
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x2 frozen
ata1.00: (BMDMA stat 0x61)
ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd1)
ata1: port failed to respond (30 secs, Status 0xd1)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/33
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

01:09.0 Mass storage controller: Silicon Image, Inc. SiI 3512
[SATALink/SATARaid] Serial ATA Controller (rev 01)
	Subsystem: Silicon Image, Inc. SiI 3512 SATALink Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c800 [size=8]
	Region 1: I/O ports at cc00 [size=4]
	Region 2: I/O ports at d000 [size=8]
	Region 3: I/O ports at d400 [size=4]
	Region 4: I/O ports at d800 [size=16]
	Region 5: Memory at e3041000 (32-bit, non-prefetchable)
[size=512]
	[virtual] Expansion ROM at 50000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

-- 
Fredrik Rinnestam
