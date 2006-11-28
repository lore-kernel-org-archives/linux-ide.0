From: Linus Torvalds <torvalds@osdl.org>
Subject: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 09:31:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>
References: <20061114150454.GA11900@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:60091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935930AbWK1RcR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 12:32:17 -0500
In-Reply-To: <20061114150454.GA11900@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org


[ You may or may not have gotten my previous email. The kernel stayed 
  working, but due to the IO errors the filesystem got re-mounted 
  read-only, and I'm not sure that the email I sent out in that state 
  actually ever made it out. I suspect it didn't. ]

Jeff,
 I just had a scary thing on my nice new Intel i965 box (all Intel 
chipsets apart from some strange Marvell IDE interface that I'm not using 
and that no driver even detected, and a TI firewire thing that I'm 
similarly not using).

The machine basically froze for about a minute or so (well, things worked 
surprisingly well, considering that apparently no disk IO happened - I 
initially thought it was just firefox that had frozen up, since my mail 
session seemed to be fine), and after it came back the filesystem was 
mounted read-only and nothing really worked any more..

I have no idea what status 0xD0 means: it looks like ATA_BUSY + ATA_DRDY + 
"bit#4", but what is bit#4?

And clearly, the soft-reset isn't doing squat.

Ideas?

		Linus

----
Boot-time messages:

	libata version 2.00 loaded.
	..
	Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
	ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
	Probing IDE interface ide0...
	Probing IDE interface ide1...
	ide-floppy driver 0.99.newide
	ata_piix 0000:00:1f.2: version 2.00ac6
	ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
	ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
	PCI: Setting latency timer of device 0000:00:1f.2 to 64
	ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
	ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
	scsi0 : ata_piix
	ata1.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
	ata1.00: ata1: dev 0 multi count 16
	ata1.00: configured for UDMA/133
	scsi1 : ata_piix
	ata2.00: ATAPI, max UDMA/66
	ata2.00: configured for UDMA/66
	scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000YS-01M 07.0 PQ: 0 ANSI: 5
	SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
	sda: Write Protect is off
	sda: Mode Sense: 00 3a 00 00
	SCSI device sda: drive cache: write back
	SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
	sda: Write Protect is off
	sda: Mode Sense: 00 3a 00 00
	SCSI device sda: drive cache: write back
	 sda: sda1 sda2
	sd 0:0:0:0: Attached scsi disk sda
	sd 0:0:0:0: Attached scsi generic sg0 type 0
	scsi 1:0:0:0: CD-ROM            PLEXTOR  DVDR   PX-755A   1.04 PQ: 0 ANSI: 5
	sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
	Uniform CD-ROM driver Revision: 3.20
	sr 1:0:0:0: Attached scsi CD-ROM sr0
	sr 1:0:0:0: Attached scsi generic sg1 type 5
	ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]
	ACPI: PCI Interrupt 0000:00:1f.5[A] -> GSI 19 (level, low) -> IRQ 19
	PCI: Setting latency timer of device 0000:00:1f.5 to 64
	ata3: SATA max UDMA/133 cmd 0x2138 ctl 0x2176 bmdma 0x20F0 irq 19
	ata4: SATA max UDMA/133 cmd 0x2130 ctl 0x2172 bmdma 0x20F8 irq 19
	scsi2 : ata_piix
	ATA: abnormal status 0x7F on port 0x213F
	scsi3 : ata_piix
	ATA: abnormal status 0x7F on port 0x2137

Problem starts:

	ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
	ata1.00: (BMDMA stat 0x21)
	ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
	ata1: port is slow to respond, please be patient (Status 0xd0)
	ata1: port failed to respond (30 secs, Status 0xd0)
	ata1: soft resetting port
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ata1.00: qc timeout (cmd 0xec)
	ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
	ata1.00: revalidation failed (errno=-5)
	ata1: failed to recover some devices, retrying in 5 secs
	ata1: port is slow to respond, please be patient (Status 0xd0)
	ata1: port failed to respond (30 secs, Status 0xd0)
	ata1: soft resetting port
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ata1.00: qc timeout (cmd 0xec)
	ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
	ata1.00: revalidation failed (errno=-5)
	ata1: failed to recover some devices, retrying in 5 secs
	ata1: port is slow to respond, please be patient (Status 0xd0)
	ata1: port failed to respond (30 secs, Status 0xd0)
	ata1: soft resetting port
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ata1.00: qc timeout (cmd 0xec)
	ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
	ata1.00: revalidation failed (errno=-5)
	ata1.00: disabled
	ata1: EH complete

And then it goes all downhill from there - the machine is toast:

	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 335093
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 896217445
	Buffer I/O error on device dm-0, logical block 112001027
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221400325
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221400325
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221400325
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 421212525
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52625475, block=52625412
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 896217485
	Buffer I/O error on device dm-0, logical block 112001032
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 896217501
	Buffer I/O error on device dm-0, logical block 112001034
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 209229
	Buffer I/O error on device dm-0, logical block 0
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 335117
	Buffer I/O error on device dm-0, logical block 15736
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437255077
	Buffer I/O error on device dm-0, logical block 54630731
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437255085
	Buffer I/O error on device dm-0, logical block 54630732
	lost page write due to I/O error on dm-0
	Buffer I/O error on device dm-0, logical block 54630733
	lost page write due to I/O error on dm-0
	Buffer I/O error on device dm-0, logical block 54630734
	lost page write due to I/O error on dm-0
	Buffer I/O error on device dm-0, logical block 54630735
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437255157
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437255221
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437255381
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437269949
	Aborting journal on device dm-0.
	EXT3-fs error (device dm-0) in ext3_reserve_inode_write: Journal has aborted
	ext3_abort called.
	EXT3-fs error (device dm-0): ext3_journal_start_sb: Detected aborted journal
	Remounting filesystem read-only
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437270109
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437270229
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437270245
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437496517
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438170837
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438170941
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438235885
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438235981
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438236021
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438236045
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438236077
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438236141
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438242893
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438246285
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438249165
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438250517
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438286605
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438286861
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438286885
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438286917
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438286933
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438289381
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438290421
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438290653
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438290685
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438290717
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438290765
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438291717
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438291773
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438291797
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438296973
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438709949
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 640245117
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 209229
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 247935325
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=30965782, block=30965762
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 208613733
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=26050605, block=26050563
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 422785389
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52822081, block=52822020
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 424358245
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=53018686, block=53018627
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 421212525
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52625477, block=52625412
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 247935325
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=30965784, block=30965762
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 208613733
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=26050607, block=26050563
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223968533
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 422785389
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52822083, block=52822020
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 424358245
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=53018688, block=53018627
	EXT3-fs error (device dm-0) in ext3_reserve_inode_write: Journal has aborted
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 435077853
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438236021
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438249165
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438296973
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223968533
	__journal_remove_journal_head: freeing b_committed_data
	__journal_remove_journal_head: freeing b_committed_data
	__journal_remove_journal_head: freeing b_committed_data
	__journal_remove_journal_head: freeing b_committed_data
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223968533
	journal commit I/O error
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 421212525
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52625479, block=52625412
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 208613733
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=26050608, block=26050563
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 422785389
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52822085, block=52822020
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 424358253
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=53018690, block=53018628
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 232730981
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=29065261, block=29065219
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 193409381
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=24150055, block=24150019
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 421212525
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52625481, block=52625412
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 247935325
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=30965785, block=30965762
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 208613733
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=26050610, block=26050563
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 422785389
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52822087, block=52822020
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 424358253
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=53018692, block=53018628
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221082957
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221082957
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221082957
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 421212525
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52625482, block=52625412
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 247935325
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=30965786, block=30965762
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 208613733
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=26050611, block=26050563
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 422785389
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52822088, block=52822020
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 424358253
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=53018693, block=53018628
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 232730981
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=29065262, block=29065219
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 193409381
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=24150056, block=24150019
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 421212525
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52625484, block=52625412
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 247935325
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=30965787, block=30965762
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 208613733
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=26050613, block=26050563
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 422785389
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52822090, block=52822020
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 424358253
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=53018695, block=53018628
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 421212525
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52625485, block=52625412
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 208613733
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=26050614, block=26050563
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 422785389
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=52822091, block=52822020
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 424358253
	EXT3-fs error (device dm-0): ext3_get_inode_loc: unable to read inode block - inode=53018696, block=53018628
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 222476325
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 222476325
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 222476325
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220006069
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220006069
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220006069
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218847341
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218847341
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223939293
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223939293
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223939293
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223968533
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223968533
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223968533
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223968533
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 209229
	printk: 141 messages suppressed.
	Buffer I/O error on device dm-0, logical block 0
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 209341
	Buffer I/O error on device dm-0, logical block 14
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 209429
	Buffer I/O error on device dm-0, logical block 25
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218838829
	Buffer I/O error on device dm-0, logical block 27328700
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218838957
	Buffer I/O error on device dm-0, logical block 27328716
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218839021
	Buffer I/O error on device dm-0, logical block 27328724
	lost page write due to I/O error on dm-0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218839133
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218839173
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218839229
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218839261
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218839317
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218839341
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218839365
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218840301
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218840349
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218840453
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218840501
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218841173
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218842141
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218842877
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218842901
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218843021
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218843045
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218844933
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218844949
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218844965
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218844997
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218845045
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 218845141
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 219624301
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 219624381
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 219625901
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 219625957
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 219626005
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 219626421
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 219626485
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220149909
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220673461
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220673485
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220673525
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220673733
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221196965
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221722813
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221722845
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 222245285
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 222247365
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223818765
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 223818965
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 434844005
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 434844397
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 436680901
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437203277
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437203437
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437203477
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437236053
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437255213
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437270237
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437727581
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 437989709
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438170933
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438235669
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438251925
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 438939997
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 454766925
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 553070941
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 553070973
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 553071005
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 640102773
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 640102965
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 640102997
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 830681421
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 830927181
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 896217437
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 896217597
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 896217645
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 896217885
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220252173
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220252253
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220252277
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220252173
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 220252173
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 830927181
	EXT3-fs error (device dm-0): ext3_find_entry: reading directory #103809025 offset 0
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221816517
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221816589
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221816629
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221816653
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221816677
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221816629
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 221816629
