From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/17] libata: move ->irq_handler from port_ops to port_info
Date: Mon, 7 Aug 2006 12:04:01 +0900
Message-ID: <11549198413534-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:15777 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750998AbWHGDf7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:35:59 -0400
Received: by py-out-1112.google.com with SMTP id z74so1898934pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:35:58 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata-core now doesn't care about irq_handler.  It's responsibility
of LLD and helpers.  The only left user is PCI legacy/native init
helpers.  Move ->irq_handler to ata_port_info.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c     |   10 ++++++++--
 drivers/scsi/libata-bmdma.c |    4 ++--
 include/linux/libata.h      |    3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

b532eb39d124c6696cc965ad96ec61e880cabbb8
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 03403cc..c472348 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -254,7 +254,6 @@ static const struct ata_port_operations 
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
@@ -283,7 +282,6 @@ static const struct ata_port_operations 
 	.error_handler		= piix_sata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
@@ -368,6 +366,7 @@ #else
 #endif
 		.udma_mask	= ATA_UDMA_MASK_40C,
 		.port_ops	= &piix_pata_ops,
+		.irq_handler	= ata_interrupt,
 	},
 
 	/* ich5_pata */
@@ -382,6 +381,7 @@ #else
 #endif
 		.udma_mask	= 0x3f, /* udma0-5 */
 		.port_ops	= &piix_pata_ops,
+		.irq_handler	= ata_interrupt,
 	},
 
 	/* ich5_sata */
@@ -392,6 +392,7 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.irq_handler	= ata_interrupt,
 	},
 
 	/* i6300esb_sata */
@@ -403,6 +404,7 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.irq_handler	= ata_interrupt,
 	},
 
 	/* ich6_sata */
@@ -414,6 +416,7 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.irq_handler	= ata_interrupt,
 	},
 
 	/* ich6_sata_ahci */
@@ -426,6 +429,7 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.irq_handler	= ata_interrupt,
 	},
 
 	/* ich6m_sata_ahci */
@@ -438,6 +442,7 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.irq_handler	= ata_interrupt,
 	},
 
 	/* ich8_sata_ahci */
@@ -450,6 +455,7 @@ #endif
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
+		.irq_handler	= ata_interrupt,
 	},
 };
 
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 75eec7a..6b7c9b4 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1281,10 +1281,10 @@ int ata_pci_host_set_prepare(struct pci_
 
 		if (host_set->flags & (ATA_HOST_LEGACY_PRI << i)) {
 			ata_pci_port_init_legacy(ap, i);
-			irq_handler[i] = ap->ops->irq_handler;
+			irq_handler[i] = pi[i]->irq_handler;
 		} else {
 			ata_pci_port_init_native(ap, i);
-			irq_handler[2] = ap->ops->irq_handler;
+			irq_handler[2] = pi[i]->irq_handler;
 		}
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 02ac266..e2305a7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -605,7 +605,6 @@ struct ata_port_operations {
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
-	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 	void (*irq_clear) (struct ata_port *);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
@@ -630,6 +629,8 @@ struct ata_port_info {
 	unsigned long		udma_mask;
 	const struct ata_port_operations *port_ops;
 	void 			*private_data;
+	/* fields for BMDMA init */
+	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 };
 
 struct ata_timing {
-- 
1.3.2


