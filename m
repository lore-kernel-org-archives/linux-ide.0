From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2/2] sata_promise: handle ATAPI_NODATA ourselves
Date: Sat, 13 Jan 2007 21:32:30 +0100 (MET)
Message-ID: <200701132032.l0DKWUGe010295@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38795 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422789AbXAMUck (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jan 2007 15:32:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

This patch extends sata_promise to handle ATAPI_NODATA
commands internally. However, commands destined to
ATA_DFLAG_CDB_INTR devices are excluded from this and
continue to be returned to libata.

Concrete changes:
- pdc_atapi_dma_pkt() is renamed to pdc_atapi_pkt(), and is
  extended to set up correct headers for NODATA packets
- pdc_qc_prep() calls pdc_atapi_pkt() for ATAPI_NODATA
- pdc_host_intr() handles ATAPI_NODATA
- pdc_qc_issue_prot() sends ATAPI_NODATA packets via the
  chip's packet mechanism, except for CDB_INTR devices

Tested on first- and second-generation chips, SATAPI and PATAPI,
with no observable regressions.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

---

 drivers/ata/sata_promise.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

--- linux-2.6.20-rc5/drivers/ata/sata_promise.c.~1~	2007-01-13 16:45:54.000000000 +0100
+++ linux-2.6.20-rc5/drivers/ata/sata_promise.c	2007-01-13 16:46:23.000000000 +0100
@@ -448,7 +448,7 @@ static void pdc_sata_scr_write (struct a
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void pdc_atapi_dma_pkt(struct ata_queued_cmd *qc)
+static void pdc_atapi_pkt(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	dma_addr_t sg_table = ap->prd_dma;
@@ -462,10 +462,20 @@ static void pdc_atapi_dma_pkt(struct ata
 	/* set control bits (byte 0), zero delay seq id (byte 3),
 	 * and seq id (byte 2)
 	 */
-	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
-		buf32[0] = cpu_to_le32(PDC_PKT_READ);
-	else
-		buf32[0] = 0;
+	switch (qc->tf.protocol) {
+	case ATA_PROT_ATAPI_DMA:
+		if (!(qc->tf.flags & ATA_TFLAG_WRITE))
+			buf32[0] = cpu_to_le32(PDC_PKT_READ);
+		else
+			buf32[0] = 0;
+		break;
+	case ATA_PROT_ATAPI_NODATA:
+		buf32[0] = cpu_to_le32(PDC_PKT_NODATA);
+		break;
+	default:
+		BUG();
+		break;
+	}
 	buf32[1] = cpu_to_le32(sg_table);	/* S/G table addr */
 	buf32[2] = 0;				/* no next-packet */
 
@@ -549,13 +559,14 @@ static void pdc_qc_prep(struct ata_queue
 		break;
 
 	case ATA_PROT_ATAPI:
-	case ATA_PROT_ATAPI_NODATA:
 		ata_qc_prep(qc);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
 		ata_qc_prep(qc);
-		pdc_atapi_dma_pkt(qc);
+		/*FALLTHROUGH*/
+	case ATA_PROT_ATAPI_NODATA:
+		pdc_atapi_pkt(qc);
 		break;
 
 	default:
@@ -672,6 +683,7 @@ static inline unsigned int pdc_host_intr
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 	case ATA_PROT_ATAPI_DMA:
+	case ATA_PROT_ATAPI_NODATA:
 		qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
 		ata_qc_complete(qc);
 		handled = 1;
@@ -771,6 +783,10 @@ static inline void pdc_packet_start(stru
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
+	case ATA_PROT_ATAPI_NODATA:
+		if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
+			break;
+		/*FALLTHROUGH*/
 	case ATA_PROT_ATAPI_DMA:
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
