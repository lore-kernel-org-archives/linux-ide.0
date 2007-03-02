From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: [RFT] sata_promise: intermittent errors bug hunting
Date: Fri, 2 Mar 2007 13:51:19 +0200 (EET)
Message-ID: <30669.194.237.142.21.1172836279.squirrel@ncircle.nullnet.fi>
References: <200702272225.l1RMPfSt021674@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:58638 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423038AbXCBLv0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 06:51:26 -0500
In-Reply-To: <200702272225.l1RMPfSt021674@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org


Hi,

> There have been some reports of intermittent errors
> with sata_promise, especially with newer disks.
> My theory is that the driver isn't initialisating the
> controller properly for SATAII 3Gbps transfer speeds.

I did a test run with 2.6.21-rc2-git1 & your patch and
still got similar errors as without your patch ...

My hardware consists of Promise PDC40718 (SATA 300 TX4)
4-port sata-card & 2 older 7200.7 Seagates (200GB) and
2 newer 7200.10 Seagates (500GB).

It's only the 7200.10 models which creates the following type of
complaints in the system logs:

Mar  2 11:13:40 alderan kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x0
Mar  2 11:13:40 alderan kernel: ata2.00: cmd
25/00:00:3f:6f:a1/00:02:07:00:00/e0 tag 0 cdb 0x0 data 262144 in
Mar  2 11:13:40 alderan kernel:          res
50/00:00:3e:71:a1/00:00:9e:03:76/e0 Emask 0x1 (device error)
Mar  2 11:13:40 alderan kernel: ata2.00: configured for UDMA/133
Mar  2 11:13:40 alderan kernel: ata2: EH complete
Mar  2 11:13:40 alderan kernel: SCSI device sdb: 976773168 512-byte hdwr
sectors (500108 MB)
Mar  2 11:13:40 alderan kernel: sdb: Write Protect is off
Mar  2 11:13:40 alderan kernel: SCSI device sdb: write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Mar  2 11:13:57 alderan kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x0
Mar  2 11:13:57 alderan kernel: ata2.00: cmd
c8/00:00:6f:ca:c0/00:00:00:00:00/e7 tag 0 cdb 0x0 data 131072 in
Mar  2 11:13:57 alderan kernel:          res
50/00:00:6e:cb:c0/00:00:6e:ca:c0/e7 Emask 0x1 (device error)
Mar  2 11:13:57 alderan kernel: ata2.00: configured for UDMA/133
Mar  2 11:13:57 alderan kernel: ata2: EH complete
Mar  2 11:13:57 alderan kernel: SCSI device sdb: 976773168 512-byte hdwr
sectors (500108 MB)
Mar  2 11:13:57 alderan kernel: sdb: Write Protect is off
Mar  2 11:13:57 alderan kernel: SCSI device sdb: write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Mar  2 11:13:58 alderan kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x0
Mar  2 11:13:58 alderan kernel: ata4.00: cmd
c8/00:00:8f:c6:c3/00:00:00:00:00/e7 tag 0 cdb 0x0 data 131072 in
Mar  2 11:13:58 alderan kernel:          res
50/00:00:8e:c7:c3/00:00:d6:de:b4/e7 Emask 0x1 (device error)
Mar  2 11:13:59 alderan kernel: ata4.00: configured for UDMA/133
Mar  2 11:13:59 alderan kernel: ata4: EH complete
Mar  2 11:13:59 alderan kernel: SCSI device sdd: 976773168 512-byte hdwr
sectors (500108 MB)
Mar  2 11:13:59 alderan kernel: sdd: Write Protect is off
Mar  2 11:13:59 alderan kernel: SCSI device sdd: write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Mar  2 11:13:59 alderan kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x0
Mar  2 11:13:59 alderan kernel: ata4.00: cmd
c8/00:00:3f:52:c5/00:00:00:00:00/e7 tag 0 cdb 0x0 data 131072 in
Mar  2 11:13:59 alderan kernel:          res
50/00:00:3e:53:c5/00:00:d6:de:b4/e7 Emask 0x1 (device error)
Mar  2 11:13:59 alderan kernel: ata4.00: configured for UDMA/133
Mar  2 11:13:59 alderan kernel: ata4: EH complete
Mar  2 11:13:59 alderan kernel: SCSI device sdd: 976773168 512-byte hdwr
sectors (500108 MB)
Mar  2 11:13:59 alderan kernel: sdd: Write Protect is off
Mar  2 11:13:59 alderan kernel: SCSI device sdd: write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Mar  2 11:32:04 alderan kernel: possible SYN flooding on port 52223.
Sending cookies.

The older 7200.7 disks work just fine without any complaints.
The same type of error messages are reported no matter if the 7200.10
model drives have been jumpered into 1,5GB mode or in 3,0GB mode.


Regards,
Tomi Orava


--- dmesg logs for promise ---

pdc_ata_init_one: changing pci_cache_line_size from 0x1 to 0x01
pdc_ata_init_one: changing pci config byte 0x42 from 0x5 to 0x5
pdc_port_start: port 0: Old PHY Quality: 0x10086880
pdc_port_start: port 0: New PHY Quality: 0x405500a0
ata1: SATA max UDMA/133 cmd 0xf880a200 ctl 0xf880a238 bmdma 0x00000000 irq 16
pdc_port_start: port 1: Old PHY Quality: 0x7536880
pdc_port_start: port 1: New PHY Quality: 0x405500a0
ata2: SATA max UDMA/133 cmd 0xf880a280 ctl 0xf880a2b8 bmdma 0x00000000 irq 16
pdc_port_start: port 2: Old PHY Quality: 0x156e6880
pdc_port_start: port 2: New PHY Quality: 0x405500a0
ata3: SATA max UDMA/133 cmd 0xf880a300 ctl 0xf880a338 bmdma 0x00000000 irq 16
pdc_port_start: port 3: Old PHY Quality: 0x7056880
pdc_port_start: port 3: New PHY Quality: 0x405500a0
ata4: SATA max UDMA/133 cmd 0xf880a380 ctl 0xf880a3b8 bmdma 0x00000000 irq 16
scsi0 : sata_promise
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
ata1.00: 390721968 sectors, multi 0: LBA48
ata1.00: configured for UDMA/133
scsi1 : sata_promise
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
scsi2 : sata_promise
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
ata3.00: 390721968 sectors, multi 0: LBA48
ata3.00: configured for UDMA/133
scsi3 : sata_promise
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: sdc1 sdc2
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdd: sdd1 sdd2
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0

-- 


