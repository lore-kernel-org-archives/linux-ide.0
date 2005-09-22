From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/3] libata: interrupt driven pio for LLD
Date: Thu, 22 Sep 2005 12:14:51 +0800
Message-ID: <43322FBB.5060403@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000107000806090808000407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:2444 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965198AbVIVEOx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2005 00:14:53 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8M4EVfh027927
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 00:14:31 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8M4EraP531050
	for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2005 22:14:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8M4EqOa020027
	for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2005 22:14:52 -0600
In-Reply-To: <43322C50.1060009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------000107000806090808000407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 3/3: interrupt driven pio patch for LLD

Changes:

sata_nv.c:
sata_vsc.c:
  irq handler is wrapper around ata_host_intr(), only minor change.

sata_promise.c:
sata_sx4.c:
sata_mv.c:
sata_qstor.c:
  Private irq handler, need modification to handle interrupt driven mode 
in the future.
  Use polling mode for the unsupported protocols for the time being.

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------000107000806090808000407
Content-Type: text/plain;
 name="idpio3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio3.diff"

--- linux/drivers/scsi/sata_promise.c	2005-09-20 17:18:01.000000000 +0800
+++ id1/drivers/scsi/sata_promise.c	2005-09-21 14:54:52.000000000 +0800
@@ -438,11 +438,11 @@ static inline unsigned int pdc_host_intr
 		break;
 
         default:
-                ap->stats.idle_irq++;
-                break;
+		ap->stats.idle_irq++;
+		break;
         }
 
-        return handled;
+	return handled;
 }
 
 static void pdc_irq_clear(struct ata_port *ap)
@@ -493,11 +493,11 @@ static irqreturn_t pdc_interrupt (int ir
 		ap = host_set->ports[i];
 		tmp = mask & (1 << (i + 1));
 		if (tmp && ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc_host_intr(ap, qc);
 		}
 	}
@@ -540,6 +540,11 @@ static int pdc_qc_issue_prot(struct ata_
 		break;
 
 	default:
+		/* FIXME: pdc_host_intr() doesn't handle
+		 * interrupt driven pio/atapi cdb intr yet.
+		 * Use polling for these protocols.
+		 */
+		qc->tf.flags |= ATA_TFLAG_POLLING;
 		break;
 	}
 
--- linux/drivers/scsi/sata_sx4.c	2005-09-20 17:18:01.000000000 +0800
+++ id1/drivers/scsi/sata_sx4.c	2005-09-21 14:55:13.000000000 +0800
@@ -691,6 +691,11 @@ static int pdc20621_qc_issue_prot(struct
 		break;
 
 	default:
+		/* FIXME: pdc20621_host_intr() doesn't handle
+		 * interrupt driven pio/atapi cdb intr yet.
+		 * Use polling for these protocols.
+		 */
+		qc->tf.flags |= ATA_TFLAG_POLLING;
 		break;
 	}
 
@@ -832,11 +837,11 @@ static irqreturn_t pdc20621_interrupt (i
 		tmp = mask & (1 << i);
 		VPRINTK("seq %u, port_no %u, ap %p, tmp %x\n", i, port_no, ap, tmp);
 		if (tmp && ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc20621_host_intr(ap, qc, (i > 4),
 							      mmio_base);
 		}
--- linux/drivers/scsi/sata_qstor.c	2005-09-20 17:18:01.000000000 +0800
+++ id1/drivers/scsi/sata_qstor.c	2005-09-21 16:14:37.000000000 +0800
@@ -356,11 +356,19 @@ static int qs_qc_issue(struct ata_queued
 		qs_packet_start(qc);
 		return 0;
 
+	case ATA_PROT_NODATA:
+		break;
+
 	case ATA_PROT_ATAPI_DMA:
 		BUG();
 		break;
 
 	default:
+		/* FIXME: qs_intr_mmio() doesn't handle
+		 * interrupt driven pio/atapi cdb intr yet.
+		 * Use polling for these protocols.
+		 */
+		qc->tf.flags |= ATA_TFLAG_POLLING;
 		break;
 	}
 
@@ -389,14 +397,13 @@ static inline unsigned int qs_intr_pkt(s
 			DPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
 					sff1, sff0, port_no, sHST, sDST);
 			handled = 1;
-			if (ap && !(ap->flags &
-				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
+			if (ap && !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 				struct ata_queued_cmd *qc;
 				struct qs_port_priv *pp = ap->private_data;
 				if (!pp || pp->state != qs_state_pkt)
 					continue;
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 					switch (sHST) {
 					case 0: /* sucessful CPB */
 					case 3: /* device error */
@@ -422,13 +429,13 @@ static inline unsigned int qs_intr_mmio(
 		struct ata_port *ap;
 		ap = host_set->ports[port_no];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 			struct ata_queued_cmd *qc;
 			struct qs_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != qs_state_mmio)
 				continue;
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
 				u8 status = ata_chk_status(ap);
--- linux/drivers/scsi/sata_mv.c	2005-09-20 17:18:01.000000000 +0800
+++ id1/drivers/scsi/sata_mv.c	2005-09-21 16:14:42.000000000 +0800
@@ -189,6 +189,7 @@ static int mv_master_reset(void __iomem 
 static irqreturn_t mv_interrupt(int irq, void *dev_instance,
 				struct pt_regs *regs);
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static int mv_qc_issue_prot(struct ata_queued_cmd *qc);
 
 static Scsi_Host_Template mv_sht = {
 	.module			= THIS_MODULE,
@@ -222,7 +223,7 @@ static struct ata_port_operations mv_ops
 	.phy_reset		= mv_phy_reset,
 
 	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= mv_qc_issue_prot,
 
 	.eng_timeout		= ata_eng_timeout,
 
@@ -448,6 +449,25 @@ static int mv_master_reset(void __iomem 
 	return rc;
 }
 
+static int mv_qc_issue_prot(struct ata_queued_cmd *qc)
+{
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+	case ATA_PROT_NODATA:
+		break;
+
+	default:
+		/* FIXME: mv_host_intr() doesn't handle
+		 * interrupt driven pio/atapi cdb intr yet.
+		 * Use polling for these protocols.
+		 */
+		qc->tf.flags |= ATA_TFLAG_POLLING;
+		break;
+	}
+
+	return ata_qc_issue_prot(qc);
+}
+
 static void mv_err_intr(struct ata_port *ap)
 {
 	void __iomem *port_mmio;
--- linux/drivers/scsi/sata_vsc.c	2005-09-20 17:18:01.000000000 +0800
+++ id1/drivers/scsi/sata_vsc.c	2005-09-21 17:21:17.000000000 +0800
@@ -193,12 +193,12 @@ static irqreturn_t vsc_sata_interrupt (i
 			struct ata_port *ap;
 
 			ap = host_set->ports[i];
-			if (ap && !(ap->flags &
-				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
+			if (ap &&
+			    !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 					handled += ata_host_intr(ap, qc);
 			}
 		}
--- linux/drivers/scsi/sata_nv.c	2005-09-20 17:18:01.000000000 +0800
+++ id1/drivers/scsi/sata_nv.c	2005-09-21 17:21:02.000000000 +0800
@@ -302,11 +302,11 @@ static irqreturn_t nv_interrupt (int irq
 
 		ap = host_set->ports[i];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += ata_host_intr(ap, qc);
 		}
 

--------------000107000806090808000407--

