From: "Benjamin S." <sbenni@gmx.de>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Mon, 22 Feb 2010 21:25:28 +0100
Message-ID: <20100222212528.13775145@pluto-lenny.milky.way>
References: <20100220142826.62dd5989@pluto-lenny.milky.way>
	<4B802B54.1080009@gmail.com>
	<20100221022613.1096fd12@uranus>
	<51f3faa71002210922i542c37f0j9e0e4a84d0977f90@mail.gmail.com>
	<20100221225544.5a9ded51@pluto-lenny.milky.way>
	<51f3faa71002211400u2177660ei1c0dc3d9306b146e@mail.gmail.com>
	<20100222141802.2bcbf607@pluto-lenny.milky.way>
	<20100222190522.GD1025@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:59424 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754278Ab0BVU0F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Feb 2010 15:26:05 -0500
In-Reply-To: <20100222190522.GD1025@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, 22 Feb 2010 20:05:22 +0100
Jens Axboe <jens.axboe@oracle.com> wrote:

> On Mon, Feb 22 2010, Benjamin S. wrote:
> > 
> > Without that patch my SSD (Super Talent Ultradrive GX MLC 64GB)
> > reaches about 200MB/s sequentiell read. After applying the patch it
> > reaches only 70MB/s.
> 
> That's not good. Can you send me the dmesg snippet that includes the
> drive detection?

[    0.819456] libata version 3.00 loaded.
[    1.230215] ahci 0000:00:1f.2: version 3.0
[    1.230225] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.230305] ahci 0000:00:1f.2: irq 27 for MSI/MSI-X
[    1.246141] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    1.246223] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck pm led clo pio slum part ems sxs apst 
[    1.248282] ahci 0000:00:1f.2: setting latency timer to 64
[    1.286038] scsi0 : ahci
[    1.286146] scsi1 : ahci
[    1.286222] scsi2 : ahci
[    1.286301] scsi3 : ahci
[    1.286378] scsi4 : ahci
[    1.286455] scsi5 : ahci
[    1.286607] ata1: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425100 irq 27
[    1.286682] ata2: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425180 irq 27
[    1.286756] ata3: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425200 irq 27
[    1.286830] ata4: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425280 irq 27
[    1.286905] ata5: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425300 irq 27
[    1.286979] ata6: SATA max UDMA/133 abar m2048@0xfe425000 port 0xfe425380 irq 27
[    1.608041] ata3: SATA link down (SStatus 0 SControl 300)
[    1.608113] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.608180] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.608396] ata5: SATA link down (SStatus 0 SControl 300)
[    1.608400] ata6: SATA link down (SStatus 0 SControl 300)
[    1.608416] ata1.00: ATA-8: STT_FTM64GX25H, 1819, max UDMA/133
[    1.608421] ata1.00: 125045424 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    1.608429] ata4: SATA link down (SStatus 0 SControl 300)
[    1.608932] ata2.00: HPA detected: current 1250261615, native 1250263728
[    1.609058] ata2.00: ATA-8: WDC WD6400AAKS-00A7B0, 01.03B01, max UDMA/133
[    1.609117] ata2.00: 1250261615 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.610116] ata2.00: configured for UDMA/133
[    1.610342] ata1.00: configured for UDMA/133
[    1.624077] scsi 0:0:0:0: Direct-Access     ATA      STT_FTM64GX25H   1819 PQ: 0 ANSI: 5
[    1.624246] scsi 1:0:0:0: Direct-Access     ATA      WDC WD6400AAKS-0 01.0 PQ: 0 ANSI: 5
[    1.626840] sd 0:0:0:0: [sda] 125045424 512-byte logical blocks: (64.0 GB/59.6 GiB)
[    1.626905] sd 1:0:0:0: [sdb] 1250261615 512-byte logical blocks: (640 GB/596 GiB)
[    1.626929] sd 1:0:0:0: [sdb] Write Protect is off
[    1.626931] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.626941] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.627009]  sdb:
[    1.627143] sd 0:0:0:0: [sda] Write Protect is off
[    1.627229] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.627238] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.627364]  sda: sda1 sda2 < sda5 >
[    1.627978] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.642051]  sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8











