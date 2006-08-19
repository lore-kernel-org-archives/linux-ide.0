From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/20] libata: move ->irq_handler from port_ops to port_info
Date: Sat, 19 Aug 2006 17:59:33 +0900
Message-ID: <1155977973478-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:44805 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751664AbWHSI77 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:59 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465945pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:58 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata-core now doesn't care about irq_handler.  It's responsibility
of LLD and helpers.  The only left user is PCI legacy/native init
helpers.  Move ->irq_handler to ata_port_info.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c   |   10 ++++++++--
 drivers/ata/libata-pci.c |    2 +-
 include/linux/libata.h   |    3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index f13513c..21f19f2 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
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
 
diff --git a/drivers/ata/libata-pci.c b/drivers/ata/libata-pci.c
index cb61679..997bd14 100644
--- a/drivers/ata/libata-pci.c
+++ b/drivers/ata/libata-pci.c
@@ -494,7 +494,7 @@ int ata_pci_host_prepare(struct pci_dev 
 
 	/* request legacy IRQs */
 	for (i = 0; i < 2; i++) {
-		handler[i] = pi[i]->port_ops->irq_handler;
+		handler[i] = pi[i]->irq_handler;
 		dev_id[i] = host;
 		legacy_irq_flags[i] = 0;
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c5200c0..791fa97 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -634,7 +634,6 @@ struct ata_port_operations {
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
-	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 	void (*irq_clear) (struct ata_port *);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
@@ -659,6 +658,8 @@ struct ata_port_info {
 	unsigned long		udma_mask;
 	const struct ata_port_operations *port_ops;
 	void 			*private_data;
+	/* fields for BMDMA init */
+	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 };
 
 struct ata_timing {
-- 
1.4.1.1


