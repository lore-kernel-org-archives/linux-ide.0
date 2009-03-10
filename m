From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/03] sata_mv  cosmetic preparations for IRQ coalescing
Date: Tue, 10 Mar 2009 18:51:04 -0400
Message-ID: <49B6EED8.8060205@rtr.ca>
References: <49B6EE95.1010808@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46617 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755221AbZCJWvH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 18:51:07 -0400
In-Reply-To: <49B6EE95.1010808@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Various cosmetic changes in preparation for the IRQ coalescing feature.

Note that the various MV_IRQ_COAL_* definitions are restored/renamed
in the folloup patch which adds IRQ coalescing to the driver.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

This is for libata-dev #upstream

--- old/drivers/ata/sata_mv.c	2009-03-10 18:20:20.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-03-10 18:26:54.000000000 -0400
@@ -1,10 +1,13 @@
 /*
  * sata_mv.c - Marvell SATA support
  *
- * Copyright 2008: Marvell Corporation, all rights reserved.
+ * Copyright 2008-2009: Marvell Corporation, all rights reserved.
  * Copyright 2005: EMC Corporation, all rights reserved.
  * Copyright 2005 Red Hat, Inc.  All rights reserved.
  *
+ * Originally written by Brett Russ.
+ * Extensive overhaul and enhancement by Mark Lord <mlord@pobox.com>.
+ *
  * Please ALWAYS copy linux-ide@vger.kernel.org on emails.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -25,8 +28,6 @@
 /*
  * sata_mv TODO list:
  *
- * --> Errata workaround for NCQ device errors.
- *
  * --> More errata workarounds for PCI-X.
  *
  * --> Complete a full errata audit for all chipsets to identify others.
@@ -68,6 +69,16 @@
 #define DRV_NAME	"sata_mv"
 #define DRV_VERSION	"1.26"
 
+/*
+ * module options
+ */
+
+static int msi;
+#ifdef CONFIG_PCI
+module_param(msi, int, S_IRUGO);
+MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
+#endif
+
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
 	MV_PRIMARY_BAR		= 0,	/* offset 0x10: memory space */
@@ -78,12 +89,6 @@
 	MV_MINOR_REG_AREA_SZ	= 0x2000,	/* 8KB */
 
 	MV_PCI_REG_BASE		= 0,
-	MV_IRQ_COAL_REG_BASE	= 0x18000,	/* 6xxx part only */
-	MV_IRQ_COAL_CAUSE		= (MV_IRQ_COAL_REG_BASE + 0x08),
-	MV_IRQ_COAL_CAUSE_LO		= (MV_IRQ_COAL_REG_BASE + 0x88),
-	MV_IRQ_COAL_CAUSE_HI		= (MV_IRQ_COAL_REG_BASE + 0x8c),
-	MV_IRQ_COAL_THRESHOLD		= (MV_IRQ_COAL_REG_BASE + 0xcc),
-	MV_IRQ_COAL_TIME_THRESHOLD	= (MV_IRQ_COAL_REG_BASE + 0xd0),
 
 	MV_SATAHC0_REG_BASE	= 0x20000,
 	MV_FLASH_CTL_OFS	= 0x1046c,
@@ -115,16 +120,14 @@
 
 	/* Host Flags */
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
-	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
 
 	MV_COMMON_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 
 	MV_GEN_I_FLAGS		= MV_COMMON_FLAGS | ATA_FLAG_NO_ATAPI,
 
-	MV_GEN_II_FLAGS		= MV_COMMON_FLAGS | MV_FLAG_IRQ_COALESCE |
-				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ,
+	MV_GEN_II_FLAGS		= MV_COMMON_FLAGS | ATA_FLAG_NCQ |
+				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA,
 
 	MV_GEN_IIE_FLAGS	= MV_GEN_II_FLAGS | ATA_FLAG_AN,
 
@@ -179,16 +182,16 @@
 	PCI_HC_MAIN_IRQ_MASK_OFS  = 0x1d64,
 	SOC_HC_MAIN_IRQ_CAUSE_OFS = 0x20020,
 	SOC_HC_MAIN_IRQ_MASK_OFS  = 0x20024,
-	ERR_IRQ			= (1 << 0),	/* shift by port # */
-	DONE_IRQ		= (1 << 1),	/* shift by port # */
+	ERR_IRQ			= (1 << 0),	/* shift by (2 * port #) */
+	DONE_IRQ		= (1 << 1),	/* shift by (2 * port #) */
 	HC0_IRQ_PEND		= 0x1ff,	/* bits 0-8 = HC0's ports */
 	HC_SHIFT		= 9,		/* bits 9-17 = HC1's ports */
 	PCI_ERR			= (1 << 18),
-	TRAN_LO_DONE		= (1 << 19),	/* 6xxx: IRQ coalescing */
-	TRAN_HI_DONE		= (1 << 20),	/* 6xxx: IRQ coalescing */
-	PORTS_0_3_COAL_DONE	= (1 << 8),
-	PORTS_4_7_COAL_DONE	= (1 << 17),
-	PORTS_0_7_COAL_DONE	= (1 << 21),	/* 6xxx: IRQ coalescing */
+	TRAN_COAL_LO_DONE	= (1 << 19),	/* transaction coalescing */
+	TRAN_COAL_HI_DONE	= (1 << 20),	/* transaction coalescing */
+	PORTS_0_3_COAL_DONE	= (1 << 8),	/* HC0 IRQ coalescing */
+	PORTS_4_7_COAL_DONE	= (1 << 17),	/* HC1 IRQ coalescing */
+	ALL_PORTS_COAL_DONE	= (1 << 21),	/* GEN_II(E) IRQ coalescing */
 	GPIO_INT		= (1 << 22),
 	SELF_INT		= (1 << 23),
 	TWSI_INT		= (1 << 24),
@@ -621,7 +624,7 @@
 	.softreset		= mv_softreset,
 	.error_handler		= mv_pmp_error_handler,
 
- 	.sff_check_status	= mv_sff_check_status,
+	.sff_check_status	= mv_sff_check_status,
 	.sff_irq_clear		= mv_sff_irq_clear,
 	.check_atapi_dma	= mv_check_atapi_dma,
 	.bmdma_setup		= mv_bmdma_setup,
@@ -1255,8 +1258,8 @@
 }
 
 /**
- * 	mv_bmdma_enable - set a magic bit on GEN_IIE to allow bmdma
- * 	@ap: Port being initialized
+ *	mv_bmdma_enable - set a magic bit on GEN_IIE to allow bmdma
+ *	@ap: Port being initialized
  *
  *	There are two DMA modes on these chips:  basic DMA, and EDMA.
  *
@@ -2000,7 +2003,7 @@
 		struct mv_host_priv *hpriv = ap->host->private_data;
 		/*
 		 * Workaround for 88SX60x1 FEr SATA#25 (part 2).
-		 * 
+		 *
 		 * After any NCQ error, the READ_LOG_EXT command
 		 * from libata-eh *must* use mv_qc_issue_fis().
 		 * Otherwise it might fail, due to chip errata.
@@ -3704,12 +3707,6 @@
 	.remove			= ata_pci_remove_one,
 };
 
-/*
- * module options
- */
-static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
-
-
 /* move to PCI layer or libata core? */
 static int pci_go_64(struct pci_dev *pdev)
 {
@@ -3891,10 +3888,5 @@
 MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:" DRV_NAME);
 
-#ifdef CONFIG_PCI
-module_param(msi, int, 0444);
-MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
-#endif
-
 module_init(mv_init);
 module_exit(mv_exit);
