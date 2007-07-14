From: Ryan Power <rpower@sysreset.com>
Subject: Re: Spinup command fails on WD3200JS
Date: Fri, 13 Jul 2007 18:55:16 -0600
Message-ID: <6.2.0.14.2.20070713184231.02db2d20@linux.sysreset.com>
References: <6.2.0.14.2.20070713000748.031a2660@linux.sysreset.com>
 <469775E0.2000609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.sysreset.com ([209.97.229.250]:31132 "EHLO sysreset"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759448AbXGNAzK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 20:55:10 -0400
In-Reply-To: <469775E0.2000609@rtr.ca>
References: <6.2.0.14.2.20070713000748.031a2660@linux.sysreset.com>
 <469775E0.2000609@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Here's the section with the modifications you requested:
[    2.212000] sata_sil 0000:01:08.0: version 2.2
[    2.216000] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[    2.216000] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 
(level, low) -> IRQ 16
[    2.216000] PCI: Setting latency timer of device 0000:01:08.0 to 64
[    2.216000] scsi0 : sata_sil
[    2.216000] scsi1 : sata_sil
[    2.216000] ata1: SATA max UDMA/100 cmd 0xf880c080 ctl 0xf880c08a bmdma 
0xf880c000 irq 16
[    2.216000] ata2: SATA max UDMA/100 cmd 0xf880c0c0 ctl 0xf880c0ca bmdma 
0xf880c008 irq 16
[    2.684000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.692000] ata1.00: ATA-7: Maxtor 6L320S0, BACE1G20, max UDMA/133
[    2.692000] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.708000] ata1.00: configured for UDMA/100
[    3.176000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   11.020000] id[2]=0x37c8
[   11.036000] ata2.00: ATA-7: WDC WD3200JS-57PDB0, 21.00M21, max UDMA/133
[   11.036000] ata2.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/1)
[   11.052000] id[2]=0x738c
[   11.052000] ata2.00: failed to IDENTIFY (SPINUP failed, err_mask=0x1)
[   11.052000] ata2.00: revalidation failed (errno=-5)
[   11.052000] ata2: failed to recover some devices, retrying in 5 secs
[   16.532000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   16.540000] id[2]=0x738c
[   16.540000] ata2.00: failed to IDENTIFY (SPINUP failed, err_mask=0x1)
[   16.540000] ata2.00: revalidation failed (errno=-5)
[   16.540000] ata2.00: limiting speed to UDMA/100:PIO3
[   16.540000] ata2: failed to recover some devices, retrying in 5 secs
[   22.020000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   22.028000] id[2]=0x738c
[   22.028000] ata2.00: failed to IDENTIFY (SPINUP failed, err_mask=0x1)
[   22.028000] ata2.00: revalidation failed (errno=-5)
[   22.028000] ata2.00: disabled
[   22.532000] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 
6L320S0   BACE PQ: 0 ANSI: 5
[   22.532000] sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors 
(320073 MB)
[   22.532000] sd 0:0:0:0: [sda] Write Protect is off
[   22.532000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00

I'm positive that it's spun up after the first command is execicuted.  I 
can hear the drive spinup, and doing a soft reboot allows it to be detected 
normally.
The same section with "if (err_mask && id[2] != 0x738c)" in place of the 
previous modification:
[    2.216000] scsi0 : sata_sil
[    2.216000] scsi1 : sata_sil
[    2.216000] ata1: SATA max UDMA/100 cmd 0xf880c080 ctl 0xf880c08a bmdma 
0xf880c000 irq 16
[    2.216000] ata2: SATA max UDMA/100 cmd 0xf880c0c0 ctl 0xf880c0ca bmdma 
0xf880c008 irq 16
[    2.684000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.692000] ata1.00: ATA-7: Maxtor 6L320S0, BACE1G20, max UDMA/133
[    2.692000] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.708000] ata1.00: configured for UDMA/100
[    3.176000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   10.944000] id[2]=0x37c8
[   10.964000] ata2.00: ATA-7: WDC WD3200JS-57PDB0, 21.00M21, max UDMA/133
[   10.964000] ata2.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/1)
[   10.972000] id[2]=0x738c
[   10.972000] ata2.00: configured for UDMA/100

I'm uncertain as to which would be better to do; ignoring the error or 
looking for the STBY_ID value.

Thanks.
-Ryan Power


At 06:53 AM 7/13/2007, Mark Lord wrote:
>>Hi.
>>I've run into a problem with the lastest kernel (2.6.22.1) and a drive 
>>set to spinup on set_features.
>..
>
>It would be handy to see those messages again with real timestamps on them.
>Ryan, could you add CONFIG_PRINTK_TIME=y into your .config and rebuild/retry ?
>
>>The interesting thing is that after displaying that, the drive has in 
>>fact spun up.
>>I'm not sure why it's getting an error returned, but chaning the err_mask 
>>line
>>to read "if (err_mask && err_mask != 0x01)" corrects the problem and the 
>>drive
>>spins up and ID's normally:
>
>Yeah, I believe that for WD drives.  Their firmware has *always* been 
>peculiar.
>In fact, the WD Raptor drives I used to have here had similar, though not 
>identical,
>problems with the "jumper-enabled" power-on-in-standby version.  I never 
>did figure
>those ones out.
>
>But yes, perhaps your suggestion of just ignoring the device's response
>may be best.  Are you sure it spins up on the very first attempt?
>Also, could you add this printk() line to just before your err_mask hack:
>
>   printk("id[2]=0x%04x\n", id[2]);
>
>If we see 0x738c reported from that, then we *know* we should just continue
>rather than err'ing out as is presently done.
>
>Thanks

