From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Errors with AHCI and 10K Raptor drive
Date: Mon, 19 Mar 2007 07:53:21 -0700
Message-ID: <20070319075321.444c241e@freebird>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:36496 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932194AbXCSOxp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 10:53:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

I am getting lots of these errors under moderate load.
This is a new drive, so I suspect some driver incompatibility between the
driver (AHCI) and the hard drive (WD Raptor 10K 74G).

Lspci:
00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03) (prog-if 01 [AHCI 1.0])
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at ec00 [size=8]
	Region 1: I/O ports at e800 [size=4]
	Region 2: I/O ports at e400 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at dc00 [size=16]
	Region 5: Memory at dffffc00 (32-bit, non-prefetchable) [size=1K]

Log:

[  841.645699] ata1.00: exception Emask 0x10 SAct 0x2 SErr 0x400100 action 0x2 frozen
[  841.645708] ata1.00: (irq_stat 0x08000000, interface fatal error)
[  841.645719] ata1.00: cmd 61/00:08:17:31:f1/04:00:03:00:00/40 tag 1 cdb 0x0 data 524288 out
[  841.645721]          res 40/00:18:5f:fa:b9/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
[  841.947855] ata1: soft resetting port
[  842.447515] ata1: softreset failed (1st FIS failed)
[  842.447526] ata1: softreset failed, retrying in 5 secs
[  847.445028] ata1: hard resetting port
[  854.938851] ata1: port is slow to respond, please be patient (Status 0x80)
[  877.923808] ata1: port failed to respond (30 secs, Status 0x80)
[  877.923816] ata1: COMRESET failed (device not ready)
[  877.923822] ata1: hardreset failed, retrying in 5 secs
[  882.921328] ata1: hard resetting port
[  883.377028] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  883.391971] ata1.00: configured for UDMA/133
[  883.391992] ata1: EH complete
[  883.392186] SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
[  883.392381] sda: Write Protect is off
[  883.392387] sda: Mode Sense: 00 3a 00 00
[  883.392594] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  970.422983] ata1.00: exception Emask 0x10 SAct 0x7 SErr 0x400100 action 0x2 frozen
[  970.422993] ata1.00: (irq_stat 0x08000000, interface fatal error)
[  970.423005] ata1.00: cmd 61/a8:00:0f:1d:cb/02:00:01:00:00/40 tag 0 cdb 0x0 data 348160 out
[  970.423008]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
[  970.423018] ata1.00: cmd 61/a8:08:bf:24:cb/00:00:01:00:00/40 tag 1 cdb 0x0 data 86016 out
[  970.423021]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
[  970.423031] ata1.00: cmd 61/08:10:97:41:c5/00:00:03:00:00/40 tag 2 cdb 0x0 data 4096 out
[  970.423034]          res 40/00:08:bf:24:cb/00:00:01:00:00/40 Emask 0x10 (ATA bus error)
[  970.725166] ata1: soft resetting port
[  970.725177] ata1: softreset failed (port busy but CLO unavailable)
[  970.725184] ata1: softreset failed, retrying in 5 secs
[  975.722701] ata1: hard resetting port
[  983.214510] ata1: port is slow to respond, please be patient (Status 0x80)
[ 1006.199471] ata1: port failed to respond (30 secs, Status 0x80)
[ 1006.199478] ata1: COMRESET failed (device not ready)
[ 1006.199485] ata1: hardreset failed, retrying in 5 secs
[ 1011.196989] ata1: hard resetting port
[ 1011.652683] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1011.667748] ata1.00: configured for UDMA/133
[ 1011.667766] ata1: EH complete
[ 1011.667964] SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
[ 1011.668157] sda: Write Protect is off
[ 1011.668163] sda: Mode Sense: 00 3a 00 00
[ 1011.668370] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
