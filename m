From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 19/20] libata: kill unused ATA_FLAG_MMIO
Date: Sat, 19 Aug 2006 17:59:33 +0900
Message-ID: <11559779731357-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:37636 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751659AbWHSI76 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:58 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465939pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:58 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill unused ATA_FLAG_MMIO.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c         |    6 ++----
 drivers/ata/pdc_adma.c     |    3 +--
 drivers/ata/sata_mv.c      |    4 ++--
 drivers/ata/sata_promise.c |    3 +--
 drivers/ata/sata_qstor.c   |    2 +-
 drivers/ata/sata_sil.c     |    2 +-
 drivers/ata/sata_sil24.c   |    4 ++--
 drivers/ata/sata_svw.c     |    3 +--
 drivers/ata/sata_sx4.c     |    4 ++--
 drivers/ata/sata_vsc.c     |    3 +--
 include/linux/libata.h     |    1 -
 11 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2ecb87c..b78878b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -271,8 +271,7 @@ static const struct ata_port_info ahci_p
 	{
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY,
+				  ATA_FLAG_PIO_DMA | ATA_FLAG_SKIP_D2H_BSY,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -281,8 +280,7 @@ static const struct ata_port_info ahci_p
 	{
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY |
+				  ATA_FLAG_PIO_DMA | ATA_FLAG_SKIP_D2H_BSY |
 				  AHCI_FLAG_RESET_NEEDS_CLO | AHCI_FLAG_NO_NCQ,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 503f66a..7814261 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -187,8 +187,7 @@ static struct ata_port_info adma_port_in
 	{
 		.sht		= &adma_ata_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_NO_LEGACY | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x1f, /* udma0-4 */
 		.port_ops	= &adma_ata_ops,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 3a9aa5e..33988bd 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -92,8 +92,8 @@ enum {
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
 	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
-				   ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING),
+				   ATA_FLAG_SATA_RESET | ATA_FLAG_NO_ATAPI |
+				   ATA_FLAG_PIO_POLLING),
 	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
 
 	CRQB_FLAG_READ		= (1 << 0),
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index f3ffb05..112418a 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -83,8 +83,7 @@ enum {
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
 	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
-				  ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
 };
 
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index edcfc75..6f94988 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -176,7 +176,7 @@ static const struct ata_port_info qs_por
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET |
 				  //FIXME ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x7f, /* udma0-6 */
 		.port_ops	= &qs_ata_ops,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 90a6caa..d397cf5 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -59,7 +59,7 @@ enum {
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
 	SIL_DFL_PORT_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_HRST_TO_RESUME,
+				  ATA_FLAG_HRST_TO_RESUME,
 
 	/*
 	 * Controller IDs
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 9a7ad16..e6b23ae 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -232,8 +232,8 @@ enum {
 
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY,
+				  ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ |
+				  ATA_FLAG_SKIP_D2H_BSY,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 3b7c1de..2cedc80 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -352,8 +352,7 @@ static void k2_sata_setup_port(struct at
 
 static const struct ata_port_info k2_sata_port_info = {
 	.sht			= &k2_sata_sht,
-	.flags			= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO,
+	.flags			= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	/* We don't care much about the PIO/UDMA masks, but the core
 	 * won't like us if we don't fill these
 	 */
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 6054915..c7324a8 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -217,8 +217,8 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_sata_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_SRST | ATA_FLAG_NO_ATAPI |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index eb2887f..4add2ad 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -314,8 +314,7 @@ static const struct ata_port_operations 
 
 static const struct ata_port_info vsc_sata_port_info = {
 	.sht		= &vsc_sata_sht,
-	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-			  ATA_FLAG_MMIO,
+	.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	/* We don't care much about the PIO/UDMA masks, but the core
 	 * won't like us if we don't fill these.
 	 */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7efd84b..0341495 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -149,7 +149,6 @@ enum {
 					    /* (doesn't imply presence) */
 	ATA_FLAG_SATA		= (1 << 1),
 	ATA_FLAG_NO_LEGACY	= (1 << 2), /* no legacy mode check */
-	ATA_FLAG_MMIO		= (1 << 3), /* use MMIO, not PIO */
 	ATA_FLAG_SRST		= (1 << 4), /* (obsolete) use ATA SRST, not E.D.D. */
 	ATA_FLAG_SATA_RESET	= (1 << 5), /* (obsolete) use COMRESET */
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
-- 
1.4.1.1


