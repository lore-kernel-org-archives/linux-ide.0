From: Yuri Kirsanov <flash@cln.ru>
Subject: Re: [PATCH] TX4000 RAID and sata_promise
Date: Mon, 29 Aug 2005 22:10:26 +0400
Message-ID: <1775043734.20050829221026@rccb.ru>
References: <00a701c5acba$4653f8d0$6f0aa8c0@rgkb.local>
Reply-To: Yuri Kirsanov <flash@cln.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.102] ([213.85.106.102]:20667 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S1751256AbVH2SK1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2005 14:10:27 -0400
In-Reply-To: <00a701c5acba$4653f8d0$6f0aa8c0@rgkb.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Wonderful, Jeff! Thanks a lot, now my TX4000 can be used under Linux
just ok! :) Without hacking libata-core.c. So, I suggest you to
include your patch for correct TX4000 work into further kernel
releases.

Now, only two small things disturbs me:
1. My hard drives are now online, but on any other free ports I see
error message like these:

libata version 1.11 loaded.
sata_promise version 1.01
PCI: Found IRQ 5 for device 0000:01:0a.0
ata1: PATA max UDMA/133 cmd 0xCC802200 ctl 0xCC802238 bmdma 0x0 irq 5
ata2: PATA max UDMA/133 cmd 0xCC802280 ctl 0xCC8022B8 bmdma 0x0 irq 5
ata3: PATA max UDMA/133 cmd 0xCC802300 ctl 0xCC802338 bmdma 0x0 irq 5
ata4: PATA max UDMA/133 cmd 0xCC802380 ctl 0xCC8023B8 bmdma 0x0 irq 5
ata1: dev 0 cfg 49:0f00 82:346b 83:5b01 84:4003 85:3469 86:1a01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 40132503 sectors:
ata1: dev 0 configured for UDMA/33
scsi0 : sata_promise
ATA: abnormal status 0x8 on port 0xCC80229C
ata2: disabling port
scsi1 : sata_promise
ATA: abnormal status 0x8 on port 0xCC80231C
ata3: disabling port
scsi2 : sata_promise
ATA: abnormal status 0x8 on port 0xCC80239C
ata4: disabling port
scsi3 : sata_promise
  Vendor: ATA       Model: MAXTOR 6L020J1    Rev: A93.
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 40132503 512-byte hdwr sectors (20548 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 40132503 512-byte hdwr sectors (20548 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

Maybe I should apply some additional patch to correct "Abnormal status
0x8 on port", or this is correct behaviour and I can just ignore it?

2. Module sata_promise only starts when I include SCSI disk support
with sata_promise as a built-in into a kernel.
(and only together, when I've tried to include SCSI disk support
WITHOUT built-in sata_promise - it doesn't work at all.)
What should I include into my /etc/modules.conf to auto-start libata
with sata_promise? Doing modprobe sata_promise works just fine, but I
prefer all TX4000 related modules to be loaded automatically at
boot-time. And why didn't my kernel automatically setup all necessary
modules into modprobe.conf?

Thanks a lot for your help!

>> Well, sata_promise definitely should not be attempting to call
>> sata_phy_reset(), since this is a PATA board.
>>
>> Maybe the attached patch will help?
>>
>> Jeff
>>
>>
>>

