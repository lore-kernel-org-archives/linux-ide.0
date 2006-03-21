From: Mark Lord <lkml@rtr.ca>
Subject: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Tue, 21 Mar 2006 00:00:36 -0500
Message-ID: <200603210000.36552.lkml@rtr.ca>
References: <441F4F95.4070203@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030318AbWCUFAj@vger.kernel.org>
In-Reply-To: <441F4F95.4070203@garzik.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

This patch addresses a number of weird behaviours observed
for the sata_mv driver, by fixing an "off by one" bug in processing
of the EDMA response queue.

Basically, sata_mv was looking in the wrong place for
command results, and this produced a lot of unpredictable behaviour.

Signed-off-by: Mark Lord <mlord@pobox.com>
--- linux-2.6.16/drivers/scsi/sata_mv.c	2006-03-20 00:53:29.000000000 -0500
+++ linux/drivers/scsi/sata_mv.c	2006-03-20 23:34:32.000000000 -0500
@@ -1098,36 +1098,39 @@
  *      Inherited from caller.
  */
 static u8 mv_get_crpb_status(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
 	u32 out_ptr;
+	u8 ata_status;
 
 	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* the response consumer index should be the same as we remember it */
 	assert(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->rsp_consumer);
 
+	ata_status = pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT;
+
 	/* increment our consumer index... */
 	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
 
 	/* and, until we do NCQ, there should only be 1 CRPB waiting */
 	assert(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >>
 		 EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->rsp_consumer);
 
 	/* write out our inc'd consumer index so EDMA knows we're caught up */
 	out_ptr &= EDMA_RSP_Q_BASE_LO_MASK;
 	out_ptr |= pp->rsp_consumer << EDMA_RSP_Q_PTR_SHIFT;
 	writelfl(out_ptr, port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* Return ATA status register for completed CRPB */
-	return (pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT);
+	return ata_status;
 }
 
 /**
  *      mv_err_intr - Handle error interrupts on the port
  *      @ap: ATA channel to manipulate
  *
  *      In most cases, just clear the interrupt and move on.  However,
