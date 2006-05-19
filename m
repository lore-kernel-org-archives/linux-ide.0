From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 4/7] sata_mv: spurious interrupt workaround
Date: Fri, 19 May 2006 16:33:03 -0400
Message-ID: <200605191633.03670.liml@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:43209 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964826AbWESUdE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 16:33:04 -0400
In-Reply-To: <200605191614.00023.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

The 60xx chips, and possibly others, incorrectly assert DEV_IRQ interrupts
on a regular basis.  The cause of this is under investigation (by me and
in theory by Marvell also), but regardless we do need to deal with these events.

This patch tidies up some interrupt handler code, and ensures that we ignore
DEV_IRQ interrupts when the drive still  has ATA_BUSY asserted.

Signed-off-by: Mark Lord <liml@rtr.ca>

---
--- linux/drivers/scsi/sata_mv.c	2006-05-19 15:39:27.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-19 15:40:46.000000000 -0400
@@ -1380,12 +1380,12 @@
 		struct ata_port *ap = host_set->ports[port];
 		struct mv_port_priv *pp = ap->private_data;
 
-		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
+		hard_port = mv_hardport_from_port(port); /* range 0..3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */
 
 		/* Note that DEV_IRQ might happen spuriously during EDMA,
-		 * and should be ignored in such cases.  We could mask it,
-		 * but it's pretty rare and may not be worth the overhead.
+		 * and should be ignored in such cases.
+		 * The cause of this is still under investigation.
 		 */ 
 		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
 			/* EDMA: check for response queue interrupt */
@@ -1399,6 +1399,11 @@
 				ata_status = readb((void __iomem *)
 					   ap->ioaddr.status_addr);
 				handled = 1;
+				/* ignore spurious intr if drive still BUSY */
+				if (ata_status & ATA_BUSY) {
+					ata_status = 0;
+					handled = 0;
+				}
 			}
 		}
 
