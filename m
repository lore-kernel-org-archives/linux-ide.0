From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.26-rc2 3/3] sata_promise: other cleanups
Date: Sat, 17 May 2008 18:49:09 +0200 (MEST)
Message-ID: <200805171649.m4HGn9sR015979@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48820 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbYEQQtP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 12:49:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Minor coding-style fixes for sata_promise:
- remove stray blank lines
- fix checkpatch.pl errors; warnings about long lines
  remain, but I don't intend to address those at this time
- remove two inline directives: neither is essential and
  both functions are trivially inlinable anyway by virtue
  of being static and having a single unique call site
- fix comment in pdc_interrupt(): the bits in PDC_INT_SEQMASK
  denote SEQIDs not tags, the distinction becomes important
  when NCQ gets implemented

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/sata_promise.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff -rupN linux-2.6.26-rc2.sata_promise-mmio-cleanups/drivers/ata/sata_promise.c linux-2.6.26-rc2.sata_promise-other-cleanups/drivers/ata/sata_promise.c
--- linux-2.6.26-rc2.sata_promise-mmio-cleanups/drivers/ata/sata_promise.c	2008-05-17 15:36:10.000000000 +0200
+++ linux-2.6.26-rc2.sata_promise-other-cleanups/drivers/ata/sata_promise.c	2008-05-17 16:32:06.000000000 +0200
@@ -139,7 +139,7 @@ struct pdc_port_priv {
 
 static int pdc_sata_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
 static int pdc_sata_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
-static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int pdc_ata_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int pdc_common_port_start(struct ata_port *ap);
 static int pdc_sata_port_start(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
@@ -562,31 +562,25 @@ static void pdc_qc_prep(struct ata_queue
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 		pdc_fill_sg(qc);
-		/* fall through */
-
+		/*FALLTHROUGH*/
 	case ATA_PROT_NODATA:
 		i = pdc_pkt_header(&qc->tf, qc->ap->prd_dma,
 				   qc->dev->devno, pp->pkt);
-
 		if (qc->tf.flags & ATA_TFLAG_LBA48)
 			i = pdc_prep_lba48(&qc->tf, pp->pkt, i);
 		else
 			i = pdc_prep_lba28(&qc->tf, pp->pkt, i);
-
 		pdc_pkt_footer(&qc->tf, pp->pkt, i);
 		break;
-
 	case ATAPI_PROT_PIO:
 		pdc_fill_sg(qc);
 		break;
-
 	case ATAPI_PROT_DMA:
 		pdc_fill_sg(qc);
 		/*FALLTHROUGH*/
 	case ATAPI_PROT_NODATA:
 		pdc_atapi_pkt(qc);
 		break;
-
 	default:
 		break;
 	}
@@ -616,7 +610,7 @@ static unsigned int pdc_sata_ata_port_to
 	unsigned int nr_ports = pdc_sata_nr_ports(ap);
 	unsigned int i;
 
-	for(i = 0; i < nr_ports && host->ports[i] != ap; ++i)
+	for (i = 0; i < nr_ports && host->ports[i] != ap; ++i)
 		;
 	BUG_ON(i >= nr_ports);
 	return pdc_port_no_to_ata_no(i, pdc_is_sataii_tx4(ap->flags));
@@ -748,8 +742,8 @@ static void pdc_error_intr(struct ata_po
 	ata_port_abort(ap);
 }
 
-static inline unsigned int pdc_host_intr(struct ata_port *ap,
-					 struct ata_queued_cmd *qc)
+static unsigned int pdc_host_intr(struct ata_port *ap,
+				  struct ata_queued_cmd *qc)
 {
 	unsigned int handled = 0;
 	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
@@ -775,7 +769,6 @@ static inline unsigned int pdc_host_intr
 		ata_qc_complete(qc);
 		handled = 1;
 		break;
-
 	default:
 		ap->stats.idle_irq++;
 		break;
@@ -832,7 +825,7 @@ static irqreturn_t pdc_interrupt(int irq
 		goto done_irq;
 	}
 
-	mask &= 0xffff;		/* only 16 tags possible */
+	mask &= 0xffff;		/* only 16 SEQIDs possible */
 	if (mask == 0 && hotplug_status == 0) {
 		VPRINTK("QUICK EXIT 3\n");
 		goto done_irq;
@@ -879,7 +872,7 @@ done_irq:
 	return IRQ_RETVAL(handled);
 }
 
-static inline void pdc_packet_start(struct ata_queued_cmd *qc)
+static void pdc_packet_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
@@ -914,11 +907,9 @@ static unsigned int pdc_qc_issue(struct 
 	case ATA_PROT_DMA:
 		pdc_packet_start(qc);
 		return 0;
-
 	default:
 		break;
 	}
-
 	return ata_sff_qc_issue(qc);
 }
 
