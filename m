From: Tejun Heo <htejun@gmail.com>
Subject: Re: State of Port Multiplier Support in libata?
Date: Mon, 02 Jul 2007 18:36:00 +0900
Message-ID: <4688C700.6070901@gmail.com>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk> <4688AE9D.7060008@gmail.com> <4688C3AF.2060100@enhance-it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:40431 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXGBJgG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 05:36:06 -0400
Received: by qb-out-0506.google.com with SMTP id e11so2271055qbe
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 02:36:05 -0700 (PDT)
In-Reply-To: <4688C3AF.2060100@enhance-it.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Skotte <sfs@enhance-it.dk>
Cc: linux-ide@vger.kernel.org

Stefan Skotte wrote:
> I've just compiled, and I'm now running the kernel with the patches applied.
> 
> It seems to work, however I'm not sure why the SATA Link is 1.5gb/s ?
> Both my disks are SATA-II 300.

I dunno either.  Does it come up as 3Gbps if you connect it directly to
the controller?

> ========== dmesg ==========
> [   90.256606] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
> frozen
> [   90.256615] ata1: irq_stat 0x00b40090 <PHY RDY changed>
> [   90.256625] ata1: hard resetting link
> [   92.449372] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> [   92.593106] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
> feat 0x9/0x9
> [   92.720891] ata1.00: hard resetting link
> [   93.204061] ata1.00: softreset failed (SRST command error)
> [   93.204068] ata1.00: reset failed (errno=-5), retrying in 10 secs

I suppose you powered up the array @90sec, right?

> [  102.703482] ata1.00: hard resetting link
> [  103.314425] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  103.330386] ata1.01: hard resetting link
> [  103.893414] ata1.01: SATA link down (SStatus 0 SControl 300)
> [  103.909388] ata1.02: hard resetting link
> [  104.472403] ata1.02: SATA link down (SStatus 0 SControl 300)
> [  104.488388] ata1.03: hard resetting link
> [  105.051395] ata1.03: SATA link down (SStatus 0 SControl 300)
> [  105.067367] ata1.04: hard resetting link
> [  105.662330] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  105.662336] ata1.05: hard resetting link
> [  106.225347] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  106.260017] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
> [  106.260023] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [  106.318220] ata1.00: configured for UDMA/100
> [  106.333611] ata1.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
> [  106.333617] ata1.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [  106.334621] ata1.04: configured for UDMA/100
> [  106.349138] ata1: EH complete

Everything looks pretty good.  Care to try some hotplug / power on, off
testings?

> Still my controller is not identified (PCI id?); dont know if thats
> something you want to change for the final patch:
> 
> 01:00.0 Mass storage controller: Silicon Image, Inc. Unknown device 3531
> (rev 01)

Oh well, this has nothing to do with the kernel or the driver.  You
should ask the pciutils maintainer.

-- 
tejun
