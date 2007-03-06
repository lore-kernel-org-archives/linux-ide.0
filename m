From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH, RFT, v2] sata_mv: convert to new EH
Date: Tue, 06 Mar 2007 01:01:02 -0500
Message-ID: <45ED039E.20608@garzik.org>
References: <20070225233454.GA31282@havoc.gtf.org> <1173158201.3416.8.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000401040800030002060002"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50770 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965792AbXCFGBE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 01:01:04 -0500
In-Reply-To: <1173158201.3416.8.camel@obelisk.thedillows.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Dillow <dave@thedillows.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000401040800030002060002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dave Dillow wrote:
> BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> BUG: at drivers/ata/sata_mv.c:1291 mv_get_crpb_status()

Well, all these seem to be WARN_ON() statements that will fire if NCQ 
queueing is enabled, which it should not be.

I also note that my test disk is not NCQ-capable, but the testers like 
you getting the BUG: output are attaching NCQ-capable disks.

So it sounds like something changes for the worst in NCQ land, which is 
area I did not touch for the new-EH work.  However, I do remember 
cleaning up the EDMA configuration in a patch (also sent upstream).

Does the attached patch fix things?  It should apply on top of 
linux-2.6.git upstream, or libata-dev.git#mv-eh.  This patch merely 
reverts commit e728eabea110da90e69c05855e3a11174edb77ef.

	Jeff



--------------000401040800030002060002
Content-Type: text/plain;
 name="patch.sata_mv-edma-cfg-revert"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.sata_mv-edma-cfg-revert"

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 89ffe07..96cba99 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -871,27 +871,23 @@ static void mv_edma_cfg(struct mv_host_priv *hpriv, void __iomem *port_mmio)
 	u32 cfg = readl(port_mmio + EDMA_CFG_OFS);
 
 	/* set up non-NCQ EDMA configuration */
+	cfg &= ~0x1f;		/* clear queue depth */
+	cfg &= ~EDMA_CFG_NCQ;	/* clear NCQ mode */
 	cfg &= ~(1 << 9);	/* disable equeue */
 
-	if (IS_GEN_I(hpriv)) {
-		cfg &= ~0x1f;		/* clear queue depth */
+	if (IS_GEN_I(hpriv))
 		cfg |= (1 << 8);	/* enab config burst size mask */
-	}
 
-	else if (IS_GEN_II(hpriv)) {
-		cfg &= ~0x1f;		/* clear queue depth */
+	else if (IS_GEN_II(hpriv))
 		cfg |= EDMA_CFG_RD_BRST_EXT | EDMA_CFG_WR_BUFF_LEN;
-		cfg &= ~(EDMA_CFG_NCQ | EDMA_CFG_NCQ_GO_ON_ERR); /* clear NCQ */
-	}
 
 	else if (IS_GEN_IIE(hpriv)) {
-		cfg |= (1 << 23);	/* do not mask PM field in rx'd FIS */
-		cfg |= (1 << 22);	/* enab 4-entry host queue cache */
+		cfg |= (1 << 23);	/* dis RX PM port mask */
+		cfg &= ~(1 << 16);	/* dis FIS-based switching (for now) */
 		cfg &= ~(1 << 19);	/* dis 128-entry queue (for now?) */
 		cfg |= (1 << 18);	/* enab early completion */
-		cfg |= (1 << 17);	/* enab cut-through (dis stor&forwrd) */
-		cfg &= ~(1 << 16);	/* dis FIS-based switching (for now) */
-		cfg &= ~(EDMA_CFG_NCQ | EDMA_CFG_NCQ_GO_ON_ERR); /* clear NCQ */
+		cfg |= (1 << 17);	/* enab host q cache */
+		cfg |= (1 << 22);	/* enab cutthrough */
 	}
 
 	writelfl(cfg, port_mmio + EDMA_CFG_OFS);

--------------000401040800030002060002--
