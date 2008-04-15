From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv & pmp support
Date: Tue, 15 Apr 2008 11:07:04 +0900
Message-ID: <48040DC8.1050907@gmail.com>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <4803C850.9010901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.246]:31170 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763649AbYDOCHK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2008 22:07:10 -0400
Received: by rv-out-0506.google.com with SMTP id k29so757957rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2008 19:07:10 -0700 (PDT)
In-Reply-To: <4803C850.9010901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, again.

Mark Lord wrote:
> Mmm... here's what the same port multiplier does when connected to
> a sata_sil24 card I have here.  This does seem to be an awful lot
> of kernel log spamming for hotplugging a 4-drive port-multiplier.  ??

Indeed.  Was it like this before the big changes?

> [34326.979383] sata_sil24 0000:0d:00.0: version 1.1
> [34326.979423] PCI: Enabling device 0000:0d:00.0 (0000 -> 0003)
> [34326.979433] ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, 
> low) -> IRQ 19
> [34326.979506] PCI: Setting latency timer of device 0000:0d:00.0 to 64
> [34326.979699] scsi2 : sata_sil24
> [34326.980312] scsi3 : sata_sil24
> [34326.980375] ata3: SATA max UDMA/100 host m128@0xefa04000 port 
> 0xefa00000 irq 19
> [34326.980381] ata4: SATA max UDMA/100 host m128@0xefa04000 port 
> 0xefa02000 irq 19
> [33875.296258] ata3: SATA link down (SStatus 0 SControl 0)
> [33877.348890] ata4: SATA link down (SStatus 0 SControl 0)
> [33891.301792] ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa 
> frozen
> [33891.301792] ata3: irq_stat 0x00b40090, PHY RDY changed
> [33891.301792] ata3: hard resetting link
> [33893.472639] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> [33893.473083] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, 
> feat 0x1/0x9

Okay, SIMG 3726.

> [33893.473581] ata3.00: hard resetting link
> [33893.896674] ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> [33893.896737] ata3.01: hard resetting link
> [33894.334126] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [33894.334126] ata3.02: hard resetting link
> [33894.753536] ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [33894.753604] ata3.03: hard resetting link
> [33895.190559] ata3.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [33895.190623] ata3.04: hard resetting link
> [33895.627372] ata3.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [33895.627383] ata3.05: hard resetting link
> [33895.945716] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> [33895.946640] ata3.00: ATA-7: ST3400832AS, 3.03, max UDMA/133
> [33895.946646] ata3.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [33895.947720] ata3.00: configured for UDMA/100
> [33895.948865] ata3.01: ATA-7: ST3400832AS, 3.03, max UDMA/133
> [33895.948871] ata3.01: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [33895.949940] ata3.01: configured for UDMA/100
> [33895.950873] ata3.02: ATA-7: ST3400832AS, 3.03, max UDMA/133
> [33895.950878] ata3.02: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [33895.952042] ata3.02: configured for UDMA/100
> [33895.952973] ata3.03: ATA-7: ST3400832AS, 3.03, max UDMA/133
> [33895.952980] ata3.03: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [33895.954049] ata3.03: configured for UDMA/100
> [33895.955011] ata3.04: ATA-7: ST3400832AS, 3.03, max UDMA/133
> [33895.955017] ata3.04: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [33895.955913] ata3.04: configured for UDMA/100
> [33895.955927] ata3: EH complete
> [33895.955927] scsi 2:0:0:0: Direct-Access     ATA      ST3400832AS      
> 3.03 PQ: 0 ANSI: 5
> [33895.955927] sd 2:0:0:0: [sdb] 781422768 512-byte hardware sectors 
> (400088 MB)
> [33895.955927] sd 2:0:0:0: [sdb] Write Protect is off
> [33895.955927] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [33895.955927] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [33895.955927] sd 2:0:0:0: [sdb] 781422768 512-byte hardware sectors 
> (400088 MB)
> [33895.955927] sd 2:0:0:0: [sdb] Write Protect is off
> [33895.955927] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [33895.955927] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [33895.955927]  sdb: unknown partition table
> [33895.971367] sd 2:0:0:0: [sdb] Attached SCSI disk
> [33895.971443] sd 2:0:0:0: Attached scsi generic sg2 type 0
> [33895.971617] scsi 2:1:0:0: Direct-Access     ATA      ST3400832AS      
> 3.03 PQ: 0 ANSI: 5
> [33895.971762] sd 2:1:0:0: [sdc] 781422768 512-byte hardware sectors 
> (400088 MB)
> [33895.971789] sd 2:1:0:0: [sdc] Write Protect is off
> [33895.971795] sd 2:1:0:0: [sdc] Mode Sense: 00 3a 00 00
> [33895.971842] sd 2:1:0:0: [sdc] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [33895.971933] sd 2:1:0:0: [sdc] 781422768 512-byte hardware sectors 
> (400088 MB)
> [33895.971960] sd 2:1:0:0: [sdc] Write Protect is off
> [33895.971965] sd 2:1:0:0: [sdc] Mode Sense: 00 3a 00 00
> [33895.972011] sd 2:1:0:0: [sdc] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA

Everything seems dandy till this point.

> [33895.972016]  sdc:<3>ata3.01: failed to read log page 10h (errno=-5)
> [33896.280329] ata3.01: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
> [33896.280340] ata3.01: irq_stat 0x00060002, device error via D2H FIS
> [33896.280351] ata3.01: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 
> ncq 4096 in
> [33896.280353]          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 
> 0x1 (device error)
> [33896.280358] ata3.01: status: { DRDY }
> [33896.282456] ata3.01: configured for UDMA/100

 From this point, all the errors are device errors from ata3.01.  What 
happens if you move the drive to different port.

Can you also post the log from sata_mv reset failures?

-- 
tejun
