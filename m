From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: hard resetting port
Date: Wed, 14 Nov 2007 10:27:18 -0500
Message-ID: <473B13D6.3080202@rtr.ca>
References: <473AC34B.8000709@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3891 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138AbXKNP1U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 10:27:20 -0500
In-Reply-To: <473AC34B.8000709@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Tomasz Chmielewski wrote:
> This are the log entries I saw as I started e2fsck on a 5-disk Linux 
> RAID-5 array; all disks connected to a sata_mv controller:
> 
> ata6.00: exception Emask 0x1 SAct 0x0 SErr 0x100000 action 0x6 frozen
> ata6.00: edma_err 0x00000084, EDMA self-disable
..

Translation:
"The port had a link CRC error, which caused it to drop out of host-queuing mode."


> ata6.00: cmd 25/00:00:bf:09:24/00:02:1c:00:00/e0 tag 0 cdb 0x0 data 262144 in
>          res 51/84:00:bf:09:24/84:02:1c:00:00/e0 Emask 0x10 (ATA bus error)
> ata6: hard resetting port
> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.00: configured for UDMA/133
> ata6: EH complete
> sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
> sd 5:0:0:0: [sde] Write Protect is off
> sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
> sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> ata6: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0x6 frozen
> ata6: edma_err 0x00000020
> ata6: hard resetting port
> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.00: configured for UDMA/133
> ata6: EH pending after completion, repeating EH (cnt=4)
> ata6: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0x7
> ata6: edma_err 0x00000010, dev connect
> ata6: hard resetting port
> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.00: configured for UDMA/133
> ata6: EH complete
> sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
> sd 5:0:0:0: [sde] Write Protect is off
> sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
> sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
> sd 5:0:0:0: [sde] Write Protect is off
> sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
> sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA 
..

Translation:
"libata reset the link, and everything appeared okay,
so it reissued the failed command and continued.
No data loss."


> That's the Marvell controller:
> 
> 01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 
> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
