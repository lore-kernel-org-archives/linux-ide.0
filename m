From: Mark Lord <liml@rtr.ca>
Subject: Re: Spinup command fails on WD3200JS
Date: Fri, 13 Jul 2007 21:35:49 -0400
Message-ID: <46982875.60503@rtr.ca>
References: <6.2.0.14.2.20070713000748.031a2660@linux.sysreset.com> <469775E0.2000609@rtr.ca> <6.2.0.14.2.20070713184231.02db2d20@linux.sysreset.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1849 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760283AbXGNBfx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 21:35:53 -0400
In-Reply-To: <6.2.0.14.2.20070713184231.02db2d20@linux.sysreset.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Power <rpower@sysreset.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Ryan Power wrote:
> Here's the section with the modifications you requested:
..
> The same section with "if (err_mask && id[2] != 0x738c)" in place of the 
> previous modification:
> [    2.216000] scsi0 : sata_sil
> [    2.216000] scsi1 : sata_sil
> [    2.216000] ata1: SATA max UDMA/100 cmd 0xf880c080 ctl 0xf880c08a 
> bmdma 0xf880c000 irq 16
> [    2.216000] ata2: SATA max UDMA/100 cmd 0xf880c0c0 ctl 0xf880c0ca 
> bmdma 0xf880c008 irq 16
> [    2.684000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [    2.692000] ata1.00: ATA-7: Maxtor 6L320S0, BACE1G20, max UDMA/133
> [    2.692000] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 0/32)
> [    2.708000] ata1.00: configured for UDMA/100
> [    3.176000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   10.944000] id[2]=0x37c8

Okay, above we can see the drive requires a spin-up command,
which now gets issued, and then we loop to retry the IDENTIFY.

> [   10.964000] ata2.00: ATA-7: WDC WD3200JS-57PDB0, 21.00M21, max UDMA/133
> [   10.964000] ata2.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/1)
> [   10.972000] id[2]=0x738c
> [   10.972000] ata2.00: configured for UDMA/100

There we can see that, after the spin-up command, the IDENTIFY succeeds,
and the new signature value of 0x728c indicates that full IDENTIFY data
is now present.  So we can just continue at that point.

Good!

Now.. time to get your name in lights and all that!
Would you like to package up that new if-stmt (below)
as a nice and proper kernel patch?  Just follow the advice
in the SubmittingPatches file, or model things after other
patches you've seen here, and post the result with a
proper Signed-Off-By line, and I'll ack it.

		if (err_mask && id[2] != 0x738c)

Or leave it to me, and I'll steal your fame and fortune!  :)

Cheers
Thanks Ryan!
