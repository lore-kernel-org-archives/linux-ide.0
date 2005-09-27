From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 4/4] libata: interrupt driven pio for LLD
Date: Tue, 27 Sep 2005 17:39:50 +0800
Message-ID: <43391366.1010409@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com> <4339116D.30908@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060903080202060902030003"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:219 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964884AbVI0Jj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Sep 2005 05:39:56 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8R9cU2C016079
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 05:38:30 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8R9eRHU551868
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 03:40:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8R9dnng010595
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 03:39:50 -0600
In-Reply-To: <4339116D.30908@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------060903080202060902030003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 4/4: interrupt driven pio patch for LLD

Changes:

libata.h:
libata-core:
  Add ATA_FLAG_PIO_POLLING flag for LLDs that expect interrupt for 
command completion only.

sata_nv.c:
sata_vsc.c:
  irq handler is wrapper around ata_host_intr(), can handle PIO interrupts.

sata_promise.c:
sata_sx4.c:
sata_qstor.c:
sata_mv.c:
  Private irq handler.
  Polling mode ATA_FLAG_PIO_POLLING used for compatibility.

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------060903080202060902030003
Content-Type: text/plain;
 name="idpio4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio4.diff"

--- id3/include/linux/libata.h	2005-09-21 16:25:26.000000000 +0800
+++ id4/include/linux/libata.h	2005-09-27 14:14:41.000000000 +0800
@@ -116,6 +116,8 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
+					     * doesn't handle PIO interrupts */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
--- id3/drivers/scsi/libata-core.c	2005-09-27 13:22:14.000000000 +0800
+++ id4/drivers/scsi/libata-core.c	2005-09-27 13:23:20.000000000 +0800
@@ -3356,6 +3356,25 @@ int ata_qc_issue_prot(struct ata_queued_
 {
 	struct ata_port *ap = qc->ap;
 
+	/* Use polling pio if the LLD doesn't handle
+	 * interrupt driven pio and atapi CDB interrupt.
+	 */
+	if (ap->flags & ATA_FLAG_PIO_POLLING) {
+		switch (qc->tf.protocol) {
+		case ATA_PROT_PIO:
+		case ATA_PROT_ATAPI:
+		case ATA_PROT_ATAPI_NODATA:
+			qc->tf.flags |= ATA_TFLAG_POLLING;
+			break;
+		case ATA_PROT_ATAPI_DMA:
+			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
+				BUG();
+			break;
+		default:
+			break;
+		}
+	}
+
 	/* select the device */
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
 
--- linux/drivers/scsi/sata_nv.c	2005-09-20 17:18:01.000000000 +0800
+++ id4/drivers/scsi/sata_nv.c	2005-09-21 17:21:02.000000000 +0800
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
 
--- linux/drivers/scsi/sata_vsc.c	2005-09-20 17:18:01.000000000 +0800
+++ id4/drivers/scsi/sata_vsc.c	2005-09-21 17:21:17.000000000 +0800
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
--- id1/drivers/scsi/sata_promise.c	2005-09-26 14:36:51.000000000 +0800
+++ id4/drivers/scsi/sata_promise.c	2005-09-27 10:33:55.000000000 +0800
@@ -162,7 +162,8 @@ static struct ata_port_info pdc_port_inf
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -173,7 +174,8 @@ static struct ata_port_info pdc_port_inf
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -184,7 +186,8 @@ static struct ata_port_info pdc_port_inf
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS,
+				  ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -493,11 +496,11 @@ static irqreturn_t pdc_interrupt (int ir
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
--- linux/drivers/scsi/sata_sx4.c	2005-09-20 17:18:01.000000000 +0800
+++ id4/drivers/scsi/sata_sx4.c	2005-09-27 10:34:52.000000000 +0800
@@ -219,7 +219,8 @@ static struct ata_port_info pdc_port_inf
 	{
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -832,11 +833,11 @@ static irqreturn_t pdc20621_interrupt (i
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
+++ id4/drivers/scsi/sata_qstor.c	2005-09-26 17:35:08.000000000 +0800
@@ -175,7 +175,7 @@ static struct ata_port_info qs_port_info
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET |
 				  //FIXME ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x7f, /* udma0-6 */
 		.port_ops	= &qs_ata_ops,
@@ -389,14 +389,13 @@ static inline unsigned int qs_intr_pkt(s
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
@@ -422,13 +421,13 @@ static inline unsigned int qs_intr_mmio(
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
+++ id4/drivers/scsi/sata_mv.c	2005-09-26 17:36:09.000000000 +0800
@@ -241,7 +241,8 @@ static struct ata_port_info mv_port_info
 	{  /* chip_504x */
 		.sht		= &mv_sht,
 		.host_flags	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO),
+				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				   ATA_FLAG_PIO_POLLING),
 		.pio_mask	= 0x1f,	/* pio4-0 */
 		.udma_mask	= 0,	/* 0x7f (udma6-0 disabled for now) */
 		.port_ops	= &mv_ops,
@@ -250,7 +251,7 @@ static struct ata_port_info mv_port_info
 		.sht		= &mv_sht,
 		.host_flags	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO | 
-				   MV_FLAG_DUAL_HC),
+				   ATA_FLAG_PIO_POLLING | MV_FLAG_DUAL_HC),
 		.pio_mask	= 0x1f,	/* pio4-0 */
 		.udma_mask	= 0,	/* 0x7f (udma6-0 disabled for now) */
 		.port_ops	= &mv_ops,
@@ -259,6 +260,7 @@ static struct ata_port_info mv_port_info
 		.sht		= &mv_sht,
 		.host_flags	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO | 
+				   ATA_FLAG_PIO_POLLING |
 				   MV_FLAG_IRQ_COALESCE | MV_FLAG_BDMA),
 		.pio_mask	= 0x1f,	/* pio4-0 */
 		.udma_mask	= 0,	/* 0x7f (udma6-0 disabled for now) */
@@ -268,6 +270,7 @@ static struct ata_port_info mv_port_info
 		.sht		= &mv_sht,
 		.host_flags	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				   ATA_FLAG_PIO_POLLING |
 				   MV_FLAG_IRQ_COALESCE | MV_FLAG_DUAL_HC |
 				   MV_FLAG_BDMA),
 		.pio_mask	= 0x1f,	/* pio4-0 */

--------------060903080202060902030003--

