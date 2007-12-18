From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: Questions about SATA hotplug in linux 2.6
Date: Tue, 18 Dec 2007 18:52:45 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E50087A77@sshaexmb1.amd.com>
References: <20071025.011445.80152909.davem@davemloft.net>
 <472052C1.2050302@garzik.org>
 <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com>
 <472153D3.2020102@garzik.org> <4721575B.70706@gmail.com>
 <B90463BC30D2E446BA423D888DC85E500677BF@sshaexmb1.amd.com>
 <47679074.9000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:21506 "EHLO
	outbound4-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752725AbXLRKwl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 05:52:41 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47679074.9000400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

Hi Tejun:


> > Do you guys think it's normal? It not, how to make SATA hotplug work
on
> > different SATA port? Should it be supported by BIOS or hardware?
> 
> If you connect it to a different port, the original device will die
and
> new device will appear.  That's the expected behavior.  In the log, I
> only see ata3.00 is dying.  Isn't there any log from different port?

There is no other log from the different port such as the enablement of
ata2,
it's strange. I forgot to say that this case appear when the "OnChip
SATA Type"
is "Native IDE"(SATA device ID is 4390) in BIOS.

But when I set "OnChip SATA type" into "AHCI" mode(SATA device ID 4391),
the hotplug can work, and the device name will be changed from "scd0" to
"scd1"
during the hotplug. The log messages are attached at the end of this
mail.

But I need the reasonable explanation to the failure under "Native IDE"
mode.

Thanks
Shane

====== plug SATA ODD to a different SATA port under AHCI mode, can work
========
Dec 18 18:40:07 linux-i276 kernel: ata3: exception Emask 0x10 SAct 0x0
SErr 0x90200 action 0xe frozen
Dec 18 18:40:07 linux-i276 kernel: ata3: irq_stat 0x00400000 , <PHY RDY
changed> 
Dec 18 18:40:07 linux-i276 kernel: ata3: hard resetting link
Dec 18 18:40:08 linux-i276 kernel: ata3: SATA link down (SStatus 0
SControl 310)
Dec 18 18:40:08 linux-i276 kernel: ata3: failed to recover some devices,
retrying in 5 secs
Dec 18 18:40:13 linux-i276 kernel: ata3: hard resetting link
Dec 18 18:40:13 linux-i276 kernel: ata3: SATA link down (SStatus 0
SControl 310)
Dec 18 18:40:13 linux-i276 kernel: ata3.00: limiting speed to
UDMA/33:PIO2
Dec 18 18:40:13 linux-i276 kernel: ata3: failed to recover some devices,
retrying in 5 secs
Dec 18 18:40:15 linux-i276 kernel: ata2: exception Emask 0x10 SAct 0x0
SErr 0x40c0000 action 0xa frozen
Dec 18 18:40:15 linux-i276 kernel: ata2: irq_stat 0x00000040 ,
<connection status changed> 
Dec 18 18:40:16 linux-i276 kernel: ata2: soft resetting link
Dec 18 18:40:16 linux-i276 kernel: ata2: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Dec 18 18:40:16 linux-i276 kernel: ata2.00: ATAPI: TSSTcorp CDDVDW
TS-H653B, CM01, max UDMA/33
Dec 18 18:40:16 linux-i276 kernel: ata2.00: configured for UDMA/33
Dec 18 18:40:16 linux-i276 kernel: ata2: EH complete
Dec 18 18:40:16 linux-i276 kernel: scsi 1:0:0:0: CD-ROM
TSSTcorp CDDVDW TS-H653B  CM01 PQ: 0 ANSI: 5
Dec 18 18:40:16 linux-i276 kernel: sr1: scsi3-mmc drive: 40x/40x writer
dvd-ram cd/rw xa/form2 cdda tray
Dec 18 18:40:16 linux-i276 kernel: sr 1:0:0:0: Attached scsi CD-ROM sr1
Dec 18 18:40:16 linux-i276 kernel: sr 1:0:0:0: Attached scsi generic sg2
type 5
Dec 18 18:40:18 linux-i276 kernel: ata3: hard resetting link
Dec 18 18:40:19 linux-i276 kernel: ata3: SATA link down (SStatus 0
SControl 310)
Dec 18 18:40:19 linux-i276 kernel: ata3.00: disabled
Dec 18 18:40:19 linux-i276 kernel: ata3: EH complete
Dec 18 18:40:19 linux-i276 kernel: ata3.00: detaching (SCSI 2:0:0:0)
Dec 18 18:40:19 linux-i276 kernel: scsi 2:0:0:0: rejecting I/O to dead
device
Dec 18 18:40:43 linux-i276 syslog-ng[2291]: last message repeated 6
times




