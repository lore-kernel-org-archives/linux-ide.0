From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] libata: kill ATA_LFLAG_SKIP_D2H_BSY
Date: Thu, 24 Jan 2008 00:21:40 +0900
Message-ID: <12011017011949-git-send-email-htejun@gmail.com>
References: <12011017011072-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:27671 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYAWPVt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 10:21:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5108030wah.23
        for <linux-ide@vger.kernel.org>; Wed, 23 Jan 2008 07:21:49 -0800 (PST)
In-Reply-To: <12011017011072-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Some controllers can't reliably record the initial D2H FIS after SATA
link is brought online for whatever reason.  Advanced controllers
which don't have traditional TF register based interface often have
this problem as they don't really have the TF registers to update
while the controller and link are being initialized.

SKIP_D2H_BSY works around the problem by skipping the wait for device
readiness before issuing SRST, so for such controllers libata issues
SRST blindly and hopes for the best.

Now that libata defaults to hardreset, this workaround is no longer
necessary.  For controllers which have support for hardreset, SRST is
never issued by itself.  It is only issued as follow-up SRST for
device classification and PMP initialization, so there's no need to
wait for it from prereset.

Kill ATA_LFLAG_SKIP_D2H_BSY.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    6 ------
 drivers/ata/libata-core.c |    6 ++----
 drivers/ata/sata_fsl.c    |    2 --
 drivers/ata/sata_sil24.c  |    4 ----
 include/linux/libata.h    |    2 --
 5 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e400fc9..70a0f07 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -192,7 +192,6 @@ enum {
 					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 					  ATA_FLAG_ACPI_SATA | ATA_FLAG_AN |
 					  ATA_FLAG_IPM,
-	AHCI_LFLAG_COMMON		= ATA_LFLAG_SKIP_D2H_BSY,
 
 	ICH_MAP				= 0x90, /* ICH MAP register */
 };
@@ -398,7 +397,6 @@ static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
 		.flags		= AHCI_FLAG_COMMON,
-		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
@@ -407,7 +405,6 @@ static const struct ata_port_info ahci_port_info[] = {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
-		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_vt8251_ops,
@@ -416,7 +413,6 @@ static const struct ata_port_info ahci_port_info[] = {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		= AHCI_FLAG_COMMON,
-		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
@@ -426,7 +422,6 @@ static const struct ata_port_info ahci_port_info[] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
 				 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
-		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
@@ -437,7 +432,6 @@ static const struct ata_port_info ahci_port_info[] = {
 				 AHCI_HFLAG_MV_PATA),
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
-		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1f0acf1..d3021bf 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3691,10 +3691,8 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 					"link for reset (errno=%d)\n", rc);
 	}
 
-	/* Wait for !BSY if the controller can wait for the first D2H
-	 * Reg FIS and we don't know that no device is attached.
-	 */
-	if (!(link->flags & ATA_LFLAG_SKIP_D2H_BSY) && !ata_link_offline(link)) {
+	/* wait for !BSY if we don't know that no device is attached */
+	if (!ata_link_offline(link)) {
 		rc = ata_wait_ready(ap, deadline);
 		if (rc && rc != -ENODEV) {
 			ata_link_printk(link, KERN_WARNING, "device not ready "
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 13ff77d..b66a1f4 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -35,7 +35,6 @@ enum {
 	SATA_FSL_HOST_FLAGS	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				ATA_FLAG_NCQ),
-	SATA_FSL_HOST_LFLAGS	= ATA_LFLAG_SKIP_D2H_BSY,
 
 	SATA_FSL_MAX_CMDS	= SATA_FSL_QUEUE_DEPTH,
 	SATA_FSL_CMD_HDR_SIZE	= 16,	/* 4 DWORDS */
@@ -1252,7 +1251,6 @@ static const struct ata_port_operations sata_fsl_ops = {
 static const struct ata_port_info sata_fsl_port_info[] = {
 	{
 	 .flags = SATA_FSL_HOST_FLAGS,
-	 .link_flags = SATA_FSL_HOST_LFLAGS,
 	 .pio_mask = 0x1f,	/* pio 0-4 */
 	 .udma_mask = 0x7f,	/* udma 0-6 */
 	 .port_ops = &sata_fsl_ops,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 4855eb2..64cdde5 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -254,7 +254,6 @@ enum {
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_AN | ATA_FLAG_PMP,
-	SIL24_COMMON_LFLAGS	= ATA_LFLAG_SKIP_D2H_BSY,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -449,7 +448,6 @@ static const struct ata_port_info sil24_port_info[] = {
 	{
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4) |
 				  SIL24_FLAG_PCIX_IRQ_WOC,
-		.link_flags	= SIL24_COMMON_LFLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,		/* udma0-5 */
@@ -458,7 +456,6 @@ static const struct ata_port_info sil24_port_info[] = {
 	/* sil_3132 */
 	{
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(2),
-		.link_flags	= SIL24_COMMON_LFLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,		/* udma0-5 */
@@ -467,7 +464,6 @@ static const struct ata_port_info sil24_port_info[] = {
 	/* sil_3131/sil_3531 */
 	{
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(1),
-		.link_flags	= SIL24_COMMON_LFLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,		/* udma0-5 */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4698c27..f8d2b91 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -162,8 +162,6 @@ enum {
 	ATA_DEV_NONE		= 9,	/* no device */
 
 	/* struct ata_link flags */
-	ATA_LFLAG_SKIP_D2H_BSY	= (1 << 1), /* can't wait for the first D2H
-					     * Register FIS clearing BSY */
 	ATA_LFLAG_NO_SRST	= (1 << 2), /* avoid softreset */
 	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
 	ATA_LFLAG_ASSUME_SEMB	= (1 << 4), /* assume SEMB class */
-- 
1.5.2.4

