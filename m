From: =?UTF-8?Q?Cengiz_G=C3=BCnay?= <cgunay@emory.edu>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Sat, 16 Jan 2010 16:34:11 -0500
Message-ID: <d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu>
	<4B31C8EE.3030003@kernel.org> <d2d378040912232302u4b550dap687fcadced237935@mail.gmail.com>
	<4B331771.3090309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mr2.cc.emory.edu ([170.140.52.91]:45040 "EHLO mr2.cc.emory.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab0APVee (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Jan 2010 16:34:34 -0500
In-Reply-To: <4B331771.3090309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2009/12/24 Tejun Heo <tj@kernel.org>:
> I don't think the controller has anything to do with the issue but
> just in case can you please try it with a different controller?

I tried the iHOS BD-ROM with a VIA VT6412 SATA controller today and it worked:

snippet from dmesg:
---
sata_via 0000:06:06.0: version 2.4
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
sata_via 0000:06:06.0: PCI INT A -> Link[APC1] -> GSI 16 (level, low) -> IRQ 16
sata_via 0000:06:06.0: routed to hard irq line 5
scsi0 : sata_via
PM: Adding info for scsi:host0
PM: Adding info for No Bus:host0
scsi1 : sata_via
PM: Adding info for scsi:host1
PM: Adding info for No Bus:host1
scsi2 : sata_via
PM: Adding info for scsi:host2
PM: Adding info for No Bus:host2
ata1: SATA max UDMA/133 port i16@0x9000 bmdma 0xa000 irq 16
ata2: SATA max UDMA/133 port i16@0x9400 bmdma 0xa008 irq 16
ata3: PATA max UDMA/133 port i16@0x9800 bmdma 0xa010 irq 16
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATAPI: ATAPI   iHOS104, WL08, max UDMA/100
ata1.00: configured for UDMA/100
scsi 0:0:0:0: CD-ROM            ATAPI    iHOS104          WL08 PQ: 0 ANSI: 5
---

output of lsscsi:
---
[0:0:0:0]    cd/dvd  ATAPI    iHOS104          WL08  /dev/sr0
---

I also tried my sata_nv with a 64-bit kernel 2.6.22-3-amd64. I got
these messages where it looks like ata3 is finally reset and set at a
UDMA/66, but I don't get the drive recognized afterwards:

dmesg:
---
ata3.00: configured for UDMA/100
ata4: SATA link down (SStatus 0 SControl 300)
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/100
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/100
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/100
ata3: EH complete
ata3.00: limiting speed to UDMA/66:PIO4
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/66
ata3: EH complete
hdc: PIONEER DVD-RW DVR-111D, ATAPI CD/DVD-ROM drive
hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
---

I contacted LiteON technical support in the meantime, but they are no
help. They said they tested with one Linux system and it worked.

I will probably buy one of the above VIA cards and use it for this drive.

Thanks for helping!
-- 
Cengiz
