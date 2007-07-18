From: Pavel Mateja <pavel@netsafe.cz>
Subject: Re: ALi SATA problem
Date: Wed, 18 Jul 2007 14:23:08 +0200
Message-ID: <200707181423.08921.pavel@netsafe.cz>
References: <200707181117.41129.pavel@netsafe.cz> <200707181138.01161.pavel@netsafe.cz> <469DE14A.60101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.netsafe.cz ([213.29.17.218]:51489 "HELO netsafe.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1758515AbXGRMXL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jul 2007 08:23:11 -0400
In-Reply-To: <469DE14A.60101@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dne Wednesday 18 of July 2007 11:45:46 jste napsal(a):
> Pavel Mateja wrote:
> > Dne Wednesday 18 of July 2007 11:35:00 jste napsal(a):
> >> Pavel Mateja wrote:
> >>> ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
> >>> ata2: (irq_stat 0x00000040, connection status changed)
> >>> ata4: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
> >>> ata4: (irq_stat 0x00000040, connection status changed)
> >>> ata2: soft resetting port
> >>
> >> Please check power supply and re-cable things.
> >
> > Funny thing is there are no cables to be checked. Nothing is connected to
> > those ports. Just ata1 is occupied by disk.
>
> Sigh... The controller is telling the driver that "there's something
> going on this port (hotplug event), please take look".  Can you try
> hotplug some device at those ports and report the resulting kernel log?

Hotplug was working in cca 1 of 8 attemps.

ata4: soft resetting port
ata4: SATA link down (SStatus 1 SControl 300)
ata4: EH complete
ata4: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata4: (irq_stat 0x00000040, connection status changed)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata2: (irq_stat 0x00000040, connection status changed)
ata4: soft resetting port
ata2: soft resetting port
ata2: SATA link down (SStatus 1 SControl 300)
ata2: EH complete
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-6: ST3120026AS, 8.05, max UDMA/133
ata4.00: 234375000 sectors, multi 0: LBA48
ata4.00: configured for UDMA/133
ata4: EH complete
Device driver target3:0:0 lacks bus and class support for being resumed.
scsi 3:0:0:0: Direct-Access     ATA      ST3120026AS      8.05 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdb] 234375000 512-byte hardware sectors (120000 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 3:0:0:0: [sdb] 234375000 512-byte hardware sectors (120000 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sdb: sdb1
sd 3:0:0:0: [sdb] Attached SCSI disk
-- 
Pavel Mateja
