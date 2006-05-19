From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 1/7] sata_mv: prevent unnecessary double-resets
Date: Fri, 19 May 2006 16:21:03 -0400
Message-ID: <200605191621.03598.liml@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:23220 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964814AbWESUVF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 16:21:05 -0400
In-Reply-To: <200605191614.00023.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

The mv_err_intr() function is invoked from the driver's interrupt handler,
as well as from the timeout function.  This patch prevents it from triggering
a one-after-the-other double reset of the controller when invoked
from the timeout function.

This also adds a check for a timeout race condition that has been observed
to occur with this driver in earlier kernels.  This should not be needed,
in theory, but in practice it has caught bugs.  Maybe nuke it at a later date.

Signed-off-by: Mark Lord <liml@rtr.ca>

---

--- linux/drivers/scsi/sata_mv.c	2006-05-19 15:00:20.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-19 14:58:51.000000000 -0400
@@ -1291,6 +1291,7 @@
 /**
  *      mv_err_intr - Handle error interrupts on the port
  *      @ap: ATA channel to manipulate
+ *      @reset_allowed: bool: 0 == don't trigger from reset here
  *
  *      In most cases, just clear the interrupt and move on.  However,
  *      some cases require an eDMA reset, which is done right before
@@ -1301,7 +1302,7 @@
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_err_intr(struct ata_port *ap)
+static void mv_err_intr(struct ata_port *ap, int reset_allowed)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	u32 edma_err_cause, serr = 0;
@@ -1323,9 +1324,8 @@
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	/* check for fatal here and recover if needed */
-	if (EDMA_ERR_FATAL & edma_err_cause) {
+	if (reset_allowed && (EDMA_ERR_FATAL & edma_err_cause))
 		mv_stop_and_reset(ap);
-	}
 }
 
 /**
@@ -1406,7 +1406,7 @@
 			shift++;	/* skip bit 8 in the HC Main IRQ reg */
 		}
 		if ((PORT0_ERR << shift) & relevant) {
-			mv_err_intr(ap);
+			mv_err_intr(ap, 1);
 			err_mask |= AC_ERR_OTHER;
 			handled = 1;
 		}
@@ -2033,11 +2033,14 @@
 	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
 	       &qc->scsicmd->cmnd);
 
-	mv_err_intr(ap);
+	mv_err_intr(ap, 0);
 	mv_stop_and_reset(ap);
 
-	qc->err_mask |= AC_ERR_TIMEOUT;
-	ata_eh_qc_complete(qc);
+	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
+	if (qc->flags & ATA_QCFLAG_ACTIVE) {
+		qc->err_mask |= AC_ERR_TIMEOUT;
+		ata_eh_qc_complete(qc);
+	}
 }
 
 /**
