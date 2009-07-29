From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm-9.17 released, with experimental trim/wiper scripts for
 SSDs
Date: Wed, 29 Jul 2009 19:39:49 -0400
Message-ID: <4A70DDC5.3000607@rtr.ca>
References: <4A70DCB8.9000909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46567 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbZG2Xjt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Jul 2009 19:39:49 -0400
In-Reply-To: <4A70DCB8.9000909@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> hdparm-9.17 is now available from sourceforge.net.
> 
> New in this release:
>        - added wiper/ subdirectory with preliminary SSD-wiper (TRIM) 
..

Tejun:  on a related note, my Sil-3132 PCIe SATA controller doesn't
seem to like DSM/TRIM commands passing through it.

[ 3479.010001] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3479.010008] ata4.00: irq_stat 0x00020002, protocol mismatch
[ 3479.010019] ata4.00: cmd 06/01:01:00:00:00/00:00:00:00:00/e0 tag 0 dma 512 out
[ 3479.010021]          res dc/33:00:00:00:00/00:00:00:00:dc/00 Emask 0x2 (HSM violation)
[ 3479.010025] ata4.00: status: { Busy }
[ 3479.010029] ata4.00: error: { IDNF }
[ 3479.010041] ata4: hard resetting link
[ 3481.193102] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3481.197043] ata4.00: configured for UDMA/100
[ 3481.197082] ata4: EH complete

I haven't taken time to dig further yet, but perhaps somebody here
might know if they've hardcoded all of the ATA opcodes in silicon or
something, and now get confused by DSM/TRIM ?

I'll dig further into that later this summer.
