From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2/2] sata_sil: disable DMA engine in ->freeze
Date: Tue, 7 Apr 2009 19:23:31 -0400
Message-ID: <20090407232331.GA16190@havoc.gtf.org>
References: <20090407232247.GA16086@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:39270 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbZDGXXc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 19:23:32 -0400
Content-Disposition: inline
In-Reply-To: <20090407232247.GA16086@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, d.harrison@sutus.com, sagar.borikar@gmail.com


Dustin, please see if these two patches solve your problem?


commit a6a2da59f2a4ba834a6e20e2d2a4d030bb9371ea
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Apr 7 19:18:32 2009 -0400

    [libata] sata_sil: disable DMA engine in sil_freeze()
    
    We must disable the DMA engine before accessing taskfile registers.
    
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index e67ce8e..896975f 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -565,6 +565,19 @@ static void sil_freeze(struct ata_port *ap)
 	tmp |= SIL_MASK_IDE0_INT << ap->port_no;
 	writel(tmp, mmio_base + SIL_SYSCFG);
 	readl(mmio_base + SIL_SYSCFG);	/* flush */
+
+	/* Ensure DMA_ENABLE is off.
+	 *
+	 * This is because the controller will not give us access to the
+	 * taskfile registers while a DMA is in progress
+	 */
+	iowrite8(ioread8(ap->ioaddr.bmdma_addr) & ~SIL_DMA_ENABLE,
+		 ap->ioaddr.bmdma_addr);
+
+	/* According to ata_bmdma_stop, an HDMA transition requires
+	 * on PIO cycle. But we can't read a taskfile register.
+	 */
+	ioread8(ap->ioaddr.bmdma_addr);
 }
 
 static void sil_thaw(struct ata_port *ap)
