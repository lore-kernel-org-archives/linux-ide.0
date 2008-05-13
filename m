From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv on Orion: CONFIG_SATA_PMP=y needed even when no multiplier
Date: Tue, 13 May 2008 18:55:00 -0400
Message-ID: <482A1C44.5090903@rtr.ca>
References: <20080512132840.GA15711@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1471 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbYEMWzB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 18:55:01 -0400
In-Reply-To: <20080512132840.GA15711@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org

Martin Michlmayr wrote:
> With 2.6.26-rc1 I have to enable CONFIG_SATA_PMP=y otherwise sata_mv
> doesn't find a disk on my Orion based device (QNAP TS-209).  Without
> CONFIG_SATA_PMP I get:
> 
> [42949381.790000] sata_mv sata_mv.0: version 1.20
> [42949381.790000] sata_mv sata_mv.0: slots 32 ports 2
> [42949381.800000] scsi0 : sata_mv
> [42949381.800000] scsi1 : sata_mv
> [42949381.810000] ata1: SATA max UDMA/133 irq 29
> [42949381.810000] ata2: SATA max UDMA/133 irq 29
> [42949382.170000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [42949382.520000] ata2: SATA link down (SStatus 0 SControl 300)
> [and nothing else]
> 
> So obviously it sees that something is connected to ata1, but it
> doesn't actually print anything about the disk or create the device
> node.
> 
> This works correctly with 2.6.25 or when I set CONFIG_SATA_PMP=y.
> However, my device doesn't have a multiplier.
..

Okay, does this fix it for you?
Please reply after testing to let us all know,
and then I'll repost the patch for Jeff / upstream-linus.

-------------- snip ---------------

Always request a softreset after hardreset succeeds.
This fixes a regression reported by Martin Michlmayr <tbm@cyrius.com>.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-09 17:21:52.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-13 18:10:29.000000000 -0400
@@ -2728,6 +2728,7 @@
 
 		rc = sata_link_hardreset(link, timing, deadline + extra,
 					 &online, NULL);
+		rc = online ? -EAGAIN : rc;
 		if (rc)
 			return rc;
 		sata_scr_read(link, SCR_STATUS, &sstatus);
