From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 07/07] sata_mv: optimize use of mv_edma_cfg
Date: Fri, 30 Jan 2009 18:52:58 -0500
Message-ID: <498392DA.4030109@rtr.ca>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca> <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca> <49839209.9010602@rtr.ca> <49839256.7090402@rtr.ca> <4983929A.7010501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57884 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbZA3Xw7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 18:52:59 -0500
In-Reply-To: <4983929A.7010501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Try and avoid unnecessary reconfiguration of the EDMA config register
on every single non-EDMA I/O operation, by moving the call to
mv_edma_cfg() into mv_stop_edma().  It must then also be invoked
from mv_hardreset() and from mv_port_start().

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-30 18:33:04.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-30 18:34:05.000000000 -0500
@@ -979,6 +979,7 @@
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
+	int err = 0;
 
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))
 		return 0;
@@ -986,9 +987,10 @@
 	mv_wait_for_edma_empty_idle(ap);
 	if (mv_stop_edma_engine(port_mmio)) {
 		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
-		return -EIO;
+		err = -EIO;
 	}
-	return 0;
+	mv_edma_cfg(ap, 0, 0);
+	return err;
 }
 
 #ifdef ATA_DEBUG
@@ -1337,6 +1339,7 @@
 			pp->sg_tbl_dma[tag] = pp->sg_tbl_dma[0];
 		}
 	}
+	mv_edma_cfg(ap, 0, 0);
 	return 0;
 
 out_port_free_dma_mem:
@@ -1797,7 +1800,6 @@
 		 * shadow block, etc registers.
 		 */
 		mv_stop_edma(ap);
-		mv_edma_cfg(ap, 0, 0);
 		mv_clear_and_enable_port_irqs(ap, mv_ap_base(ap), port_irqs);
 		mv_pmp_select(ap, qc->dev->link->pmp);
 		return ata_sff_qc_issue(qc);
@@ -2996,6 +2998,7 @@
 				extra = HZ; /* only extend it once, max */
 		}
 	} while (sstatus != 0x0 && sstatus != 0x113 && sstatus != 0x123);
+	mv_edma_cfg(ap, 0, 0);
 
 	return rc;
 }
