From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Date: Wed, 23 May 2007 09:24:54 -0400
Message-ID: <465440A6.5080904@rtr.ca>
References: <4631CE7C.3000703@wpkg.org> <46540376.6000700@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1966 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756250AbXEWNY6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 09:24:58 -0400
In-Reply-To: <46540376.6000700@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Tomasz Chmielewski wrote:
..
> The error I mentioned before - BUG: at drivers/ata/sata_mv.c:1236 
> mv_qc_issue() - happened on /dev/sda drive.
> 
> As it appears, my /dev/sdb drive just dies (has multiple badblocks). It 
> causes similar errors when I tried to dd if=/dev/ero of=/dev/sdb.
> 
> It triggered two bugs:
> 
> BUG: at drivers/ata/sata_mv.c:657 mv_start_dma()

Heh.. that one is just the driver being way too clever for itself.
This fix (below) should take care of it.

> BUG: at drivers/ata/sata_mv.c:1201 mv_qc_issue()

That one should be harmless, and is likely a side-effect of
not completely resetting the engine & variables after an error.

This whole driver needs a lot of TLC, something I just might
be into doing shortly.    Meanwhile:


This patch removes some unhelpful paranoia from sata_mv.c,
now choosing to actually *recover* rather than simply complain.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---
--- linux/drivers/ata/sata_mv.c.orig	2007-04-26 12:02:46.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2007-05-23 09:18:42.000000000 -0400
@@ -650,11 +650,8 @@
  */
 static void mv_start_dma(void __iomem *base, struct mv_port_priv *pp)
 {
-	if (!(MV_PP_FLAG_EDMA_EN & pp->pp_flags)) {
-		writelfl(EDMA_EN, base + EDMA_CMD_OFS);
-		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
-	}
-	WARN_ON(!(EDMA_EN & readl(base + EDMA_CMD_OFS)));
+	writelfl(EDMA_EN, base + EDMA_CMD_OFS);
+	pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
 }
 
 /**
