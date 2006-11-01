From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3 #upstream] ahci: update ahci-vt8251 reset sequence
Date: Wed, 1 Nov 2006 18:00:24 +0900
Message-ID: <20061101090024.GR13677@htj.dyndns.org>
References: <20061101085833.GP13677@htj.dyndns.org> <20061101085953.GQ13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:19541 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423958AbWKAJAc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 04:00:32 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1664614ugm
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 01:00:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061101085953.GQ13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

ahci-vt8251

* requires hardreset after PHY status change

* doesn't clear BSY on signature FIS after hardreset

* needs SError cleared for the port to operate after hardreset

This patch implements ahci_vt8251_hardreset() and sets
ATA_FLAG_HRST_TO_RESUME to handle the above behaviors.  This fixes EH
including hotplug on vt8251.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -213,6 +213,7 @@ static u8 ahci_check_status(struct ata_p
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
+static void ahci_vt8251_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg);
 static int ahci_port_resume(struct ata_port *ap);
@@ -272,6 +273,37 @@ static const struct ata_port_operations 
 	.port_stop		= ahci_port_stop,
 };
 
+static const struct ata_port_operations ahci_vt8251_ops = {
+	.port_disable		= ata_port_disable,
+
+	.check_status		= ahci_check_status,
+	.check_altstatus	= ahci_check_status,
+	.dev_select		= ata_noop_dev_select,
+
+	.tf_read		= ahci_tf_read,
+
+	.qc_prep		= ahci_qc_prep,
+	.qc_issue		= ahci_qc_issue,
+
+	.irq_handler		= ahci_interrupt,
+	.irq_clear		= ahci_irq_clear,
+
+	.scr_read		= ahci_scr_read,
+	.scr_write		= ahci_scr_write,
+
+	.freeze			= ahci_freeze,
+	.thaw			= ahci_thaw,
+
+	.error_handler		= ahci_vt8251_error_handler,
+	.post_internal_cmd	= ahci_post_internal_cmd,
+
+	.port_suspend		= ahci_port_suspend,
+	.port_resume		= ahci_port_resume,
+
+	.port_start		= ahci_port_start,
+	.port_stop		= ahci_port_stop,
+};
+
 static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
@@ -288,10 +320,11 @@ static const struct ata_port_info ahci_p
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_NO_NCQ,
+				  ATA_FLAG_SKIP_D2H_BSY |
+				  ATA_FLAG_HRST_TO_RESUME | AHCI_FLAG_NO_NCQ,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &ahci_ops,
+		.port_ops	= &ahci_vt8251_ops,
 	},
 };
 
@@ -832,6 +865,31 @@ static int ahci_hardreset(struct ata_por
 	return rc;
 }
 
+static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class)
+{
+	void __iomem *mmio = ap->host->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	ahci_stop_engine(port_mmio);
+
+	rc = sata_port_hardreset(ap, sata_ehc_deb_timing(&ap->eh_context));
+
+	/* vt8251 needs SError cleared for the port to operate */
+	ahci_scr_write(ap, SCR_ERROR, ahci_scr_read(ap, SCR_ERROR));
+
+	ahci_start_engine(port_mmio);
+
+	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
+
+	/* vt8251 doesn't clear BSY on signature FIS reception,
+	 * request follow-up softreset.
+	 */
+	return rc ?: -EAGAIN;
+}
+
 static void ahci_postreset(struct ata_port *ap, unsigned int *class)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -1151,6 +1209,22 @@ static void ahci_error_handler(struct at
 		  ahci_postreset);
 }
 
+static void ahci_vt8251_error_handler(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+
+	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
+		/* restart engine */
+		ahci_stop_engine(port_mmio);
+		ahci_start_engine(port_mmio);
+	}
+
+	/* perform recovery */
+	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_vt8251_hardreset,
+		  ahci_postreset);
+}
+
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
