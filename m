From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 1/2] sata_promise: issue ATAPI commands as normal packets
Date: Sat, 13 Jan 2007 21:31:05 +0100 (MET)
Message-ID: <200701132031.l0DKV5Z7010283@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38787 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422788AbXAMUbT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jan 2007 15:31:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

This patch (against libata #upstream + the ATAPI cleanup patch)
reimplements sata_promise's ATAPI support to format ATAPI DMA
commands as normal packets, and to issue them via the hardware's
normal packet machinery.

It turns out that the only reason for issuing ATAPI DMA
commands via the pdc_issue_atapi_pkt_cmd() procedure was to
perform two interrupt-fiddling steps for ATA_DFLAG_CDB_INTR
devices. But these steps aren't needed because sata_promise
sets ATA_FLAG_PIO_POLLING, which disables DMA for those devices.
The remaining steps can easily be done in ATA taskfile packets.

Concrete changes:
- pdc_atapi_dma_pkt() is extended to program all packet setup
  steps, and not just contain the CDB; the sequence of steps
  exactly mirrors what pdc_issue_atapi_pkt_cmd() did
- pdc_atapi_dma_pkt() needed more parameters: simplify it by
  just passing 'qc' and having it extract the data it needs
- pdc_issue_atai_pkt_cmd() and its two helper procedures
  pdc_wait_for_drq() and pdc_wait_on_busy() are removed

Tested on first- and second-generation chips, SATAPI and PATAPI,
with no observable regressions.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

---

 drivers/ata/sata_promise.c |  162 ++++++++++++++++-----------------------------
 1 files changed, 60 insertions(+), 102 deletions(-)

--- linux-2.6.20-rc5/drivers/ata/sata_promise.c.~1~	2007-01-13 16:45:08.000000000 +0100
+++ linux-2.6.20-rc5/drivers/ata/sata_promise.c	2007-01-13 16:45:54.000000000 +0100
@@ -448,28 +448,80 @@ static void pdc_sata_scr_write (struct a
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void pdc_atapi_dma_pkt(struct ata_taskfile *tf,
-			      dma_addr_t sg_table,
-			      unsigned int cdb_len, u8 *cdb,
-			      u8 *buf)
+static void pdc_atapi_dma_pkt(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
+	dma_addr_t sg_table = ap->prd_dma;
+	unsigned int cdb_len = qc->dev->cdb_len;
+	u8 *cdb = qc->cdb;
+	struct pdc_port_priv *pp = ap->private_data;
+	u8 *buf = pp->pkt;
 	u32 *buf32 = (u32 *) buf;
+	unsigned int dev_sel, feature, nbytes;
 
 	/* set control bits (byte 0), zero delay seq id (byte 3),
 	 * and seq id (byte 2)
 	 */
-	if (!(tf->flags & ATA_TFLAG_WRITE))
+	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
 		buf32[0] = cpu_to_le32(PDC_PKT_READ);
 	else
 		buf32[0] = 0;
 	buf32[1] = cpu_to_le32(sg_table);	/* S/G table addr */
 	buf32[2] = 0;				/* no next-packet */
 
+	/* select drive */
+	if (sata_scr_valid(ap)) {
+		dev_sel = PDC_DEVICE_SATA;
+	} else {
+		dev_sel = ATA_DEVICE_OBS;
+		if (qc->dev->devno != 0)
+			dev_sel |= ATA_DEV1;
+	}
+	buf[12] = (1 << 5) | ATA_REG_DEVICE;
+	buf[13] = dev_sel;
+	buf[14] = (1 << 5) | ATA_REG_DEVICE | PDC_PKT_CLEAR_BSY;
+	buf[15] = dev_sel; /* once more, waiting for BSY to clear */
+
+	buf[16] = (1 << 5) | ATA_REG_NSECT;
+	buf[17] = 0x00;
+	buf[18] = (1 << 5) | ATA_REG_LBAL;
+	buf[19] = 0x00;
+
+	/* set feature and byte counter registers */
+	if (qc->tf.protocol != ATA_PROT_ATAPI_DMA) {
+		feature = PDC_FEATURE_ATAPI_PIO;
+		/* set byte counter register to real transfer byte count */
+		nbytes = qc->nbytes;
+		if (!nbytes)
+			nbytes = qc->nsect << 9;
+		if (nbytes > 0xffff)
+			nbytes = 0xffff;
+	} else {
+		feature = PDC_FEATURE_ATAPI_DMA;
+		/* set byte counter register to 0 */
+		nbytes = 0;
+	}
+	buf[20] = (1 << 5) | ATA_REG_FEATURE;
+	buf[21] = feature;
+	buf[22] = (1 << 5) | ATA_REG_BYTEL;
+	buf[23] = nbytes & 0xFF;
+	buf[24] = (1 << 5) | ATA_REG_BYTEH;
+	buf[25] = (nbytes >> 8) & 0xFF;
+
+	/* send ATAPI packet command 0xA0 */
+	buf[26] = (1 << 5) | ATA_REG_CMD;
+	buf[27] = ATA_CMD_PACKET;
+
+	/* select drive and check DRQ */
+	buf[28] = (1 << 5) | ATA_REG_DEVICE | PDC_PKT_WAIT_DRDY;
+	buf[29] = dev_sel;
+
 	/* we can represent cdb lengths 2/4/6/8/10/12/14/16 */
 	BUG_ON(cdb_len & ~0x1E);
 
-	buf[12] = (((cdb_len >> 1) & 7) << 5) | ATA_REG_DATA | PDC_LAST_REG;
-	memcpy(buf+13, cdb, cdb_len);
+	/* append the CDB as the final part */
+	buf[30] = (((cdb_len >> 1) & 7) << 5) | ATA_REG_DATA | PDC_LAST_REG;
+	memcpy(buf+31, cdb, cdb_len);
 }
 
 static void pdc_qc_prep(struct ata_queued_cmd *qc)
@@ -503,7 +555,7 @@ static void pdc_qc_prep(struct ata_queue
 
 	case ATA_PROT_ATAPI_DMA:
 		ata_qc_prep(qc);
-		pdc_atapi_dma_pkt(&qc->tf, qc->ap->prd_dma, qc->dev->cdb_len, qc->cdb, pp->pkt);
+		pdc_atapi_dma_pkt(qc);
 		break;
 
 	default:
@@ -716,104 +768,10 @@ static inline void pdc_packet_start(stru
 	readl((void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
 }
 
-static unsigned int pdc_wait_for_drq(struct ata_port *ap)
-{ 
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-	unsigned int i;
-	unsigned int status;
-
-	/* Following pdc-ultra's WaitForDrq() we loop here until BSY
-	 * is clear and DRQ is set in altstatus. We could possibly call
-	 * ata_busy_wait() and loop until DRQ is set, but since we don't
-	 * know how much time a call to ata_busy_wait() took, we don't
-	 * know when to time out the outer loop.
-	 */
-	for(i = 0; i < 1000; ++i) {
-		status = readb(port_mmio + PDC_ALTSTATUS);
-		if (status == 0xFF)
-			break;
-		if (status & ATA_BUSY)
-			;
-		else if (status & (ATA_DRQ | ATA_ERR))
-			break;
-		mdelay(1);
-	}
-	if (i >= 1000)
-		ata_port_printk(ap, KERN_WARNING, "%s timed out\n", __FUNCTION__);
-	return status;
-}
-
-static unsigned int pdc_wait_on_busy(struct ata_port *ap)
-{
-	unsigned int status = ata_busy_wait(ap, ATA_BUSY, 1000);
-	if (status != 0xff && (status & ATA_BUSY))
-		ata_port_printk(ap, KERN_WARNING, "%s timed out\n", __FUNCTION__);
-	return status;
-}
-
-static void pdc_issue_atapi_pkt_cmd(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
-	void __iomem *host_mmio = ap->host->mmio_base;
-	unsigned int nbytes;
-	unsigned int tmp;
-
-	writeb(0x00, port_mmio + PDC_CTLSTAT); /* route drive INT to SEQ 0 */
-	writeb(PDC_SEQCNTRL_INT_MASK, host_mmio + 0); /* but mask SEQ 0 INT */
-
-	/* select drive */
-	if (sata_scr_valid(ap)) {
-		tmp = PDC_DEVICE_SATA;
-	} else {
-		tmp = ATA_DEVICE_OBS;
-		if (qc->dev->devno != 0)
-			tmp |= ATA_DEV1;
-	}
-	writeb(tmp, port_mmio + PDC_DEVICE);
-	pdc_wait_on_busy(ap);
-
-	writeb(0x00, port_mmio + PDC_SECTOR_COUNT);
-	writeb(0x00, port_mmio + PDC_SECTOR_NUMBER);
-
-	/* set feature and byte counter registers */
-	if (qc->tf.protocol != ATA_PROT_ATAPI_DMA) {
-		tmp = PDC_FEATURE_ATAPI_PIO;
-		/* set byte counter register to real transfer byte count */
-		nbytes = qc->nbytes;
-		if (!nbytes)
-			nbytes = qc->nsect << 9;
-		if (nbytes > 0xffff)
-			nbytes = 0xffff;
-	} else {
-		tmp = PDC_FEATURE_ATAPI_DMA;
-		/* set byte counter register to 0 */
-		nbytes = 0;
-	}
-	writeb(tmp, port_mmio + PDC_FEATURE);
-	writeb(nbytes & 0xFF, port_mmio + PDC_CYLINDER_LOW);
-	writeb((nbytes >> 8) & 0xFF, port_mmio + PDC_CYLINDER_HIGH);
-
-	/* send ATAPI packet command 0xA0 */
-	writeb(ATA_CMD_PACKET, port_mmio + PDC_COMMAND);
-
-	/* pdc_qc_issue_prot() currently sends ATAPI PIO packets back
-	 * to libata. If we start handling those packets ourselves,
-	 * then we must busy-wait for INT (CTLSTAT bit 27) at this point
-	 * if the device has ATA_DFLAG_CDB_INTR set.
-	 */
-
-	pdc_wait_for_drq(ap);
-
-	/* now the device only waits for the CDB */
-}
-
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_ATAPI_DMA:
-		pdc_issue_atapi_pkt_cmd(qc);
-		/*FALLTHROUGH*/
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		pdc_packet_start(qc);
