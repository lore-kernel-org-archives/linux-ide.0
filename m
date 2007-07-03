From: Tejun Heo <htejun@gmail.com>
Subject: Re: State of Port Multiplier Support in libata?
Date: Tue, 03 Jul 2007 12:06:00 +0900
Message-ID: <4689BD18.6030202@gmail.com>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk> <4688AE9D.7060008@gmail.com> <4688C3AF.2060100@enhance-it.dk> <4688C700.6070901@gmail.com> <4688FC96.7040604@enhance-it.dk> <4689149E.5030704@gmail.com> <46896824.2030507@enhance-it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:64509 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbXGCDGH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 23:06:07 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1087848nze
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 20:06:06 -0700 (PDT)
In-Reply-To: <46896824.2030507@enhance-it.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Skotte <sfs@enhance-it.dk>
Cc: linux-ide@vger.kernel.org

Stefan Skotte wrote:
> Here's the full log from trying to reproduce error in powering array on/off:
> 
> =====================
> ********* power off array......
> [27685.211956] ata4.15: failed to read PMP product ID
> [27685.211962] ata4.15: retrying hardreset
> [27685.211969] ata4.15: hard resetting link
> [27690.299444] ata4.15: SATA link down (SStatus 1 SControl 0)
> [27690.555072] ata4.15: failed to read PMP GSCR[0] (errno=-5)
> [27690.555077] ata4.15: PMP revalidation failed (errno=-5)
> [27690.555084] ata4.15: limiting SATA link speed to 1.5 Gbps
> [27690.555089] ata4.15: retrying hardreset in 5 secs
> [27695.550667] ata4.15: hard resetting link
> [27700.638173] ata4.15: SATA link down (SStatus 1 SControl 10)
> [27700.893759] ata4.15: failed to read PMP GSCR[0] (errno=-5)
> [27700.893765] ata4.15: PMP revalidation failed (errno=-5)
> [27700.893771] ata4.15: retrying hardreset in 5 secs
> [27705.889391] ata4.15: hard resetting link
> [27710.976901] ata4.15: SATA link down (SStatus 1 SControl 10)
> [27711.232487] ata4.15: failed to read PMP GSCR[0] (errno=-5)
> [27711.232493] ata4.15: PMP revalidation failed (errno=-5)
> [27711.232499] ata4.15: retrying hardreset in 5 secs
> [27716.228121] ata4.15: hard resetting link
> [27721.315629] ata4.15: SATA link down (SStatus 1 SControl 10)
> [27721.571215] ata4.15: failed to read PMP GSCR[0] (errno=-5)
> [27721.571221] ata4.15: PMP revalidation failed (errno=-5)
> [27721.571226] ata4.15: failed to recover PMP after 3 tries, giving up
> [27721.571230] ata4.15: Port Multiplier detaching
> [27721.571257] ata4.00: disabled
> [27721.571264] ata4.04: disabled
> [27721.571268] ata4.00: disabled

This is okay.  PMP is detached after five tries.

> ******' power on array....
> [27778.077300] ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
> frozen
> [27778.077308] ata4: irq_stat 0x00b40090 <PHY RDY changed>
> [27778.077318] ata4: hard resetting link
> [27780.273144] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> [27780.416888] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
> feat 0x9/0x9
> [27780.544683] ata4.00: hard resetting link
> [27781.027888] ata4.00: softreset failed (SRST command error)
> [27781.027895] ata4.00: reset failed (errno=-5), retrying in 10 secs
> [27790.527995] ata4.00: hard resetting link
> [27791.138984] ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [27791.154959] ata4.01: hard resetting link
> [27791.718016] ata4.01: SATA link down (SStatus 0 SControl 300)
> [27791.733992] ata4.02: hard resetting link
> [27792.297049] ata4.02: SATA link down (SStatus 0 SControl 300)
> [27792.313025] ata4.03: hard resetting link
> [27792.876081] ata4.03: SATA link down (SStatus 0 SControl 300)
> [27792.892056] ata4.04: hard resetting link
> [27793.487061] ata4.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [27793.487068] ata4.05: hard resetting link
> [27794.050120] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [27794.090537] ata4.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
> [27794.090543] ata4.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [27794.148733] ata4.00: configured for UDMA/100
> [27794.160917] ata4.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
> [27794.160923] ata4.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [27794.161914] ata4.04: configured for UDMA/100

And probed correctly when powered back on.  What I was worried about was
when you power it off briefly and back on (or disconnect the cable
briefly) while EH is still retrying.  libata is supposed to recover
without detaching devices.

> =======================
> 
> Unfortunately there isn't any firmware available for the PMP on my PCIe
> board, if thats what you mean (?), it doesn't even have RAID capability.

http://www.siliconimage.com/support/supportsearchresults.aspx?pid=26&cid=23&ctid=2&osid=0&

This is what I meant but the latest one is dated 3/30/2006, so yours
might as well have the latest one already.

-- 
tejun
