From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: kill ATA_LFLAG_HRST_TO_RESUME
Date: Tue, 11 Mar 2008 12:41:40 +0900
Message-ID: <12052069033698-git-send-email-htejun@gmail.com>
References: <12052069033338-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:36603 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbYCKDlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 23:41:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2611787wah.23
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 20:41:49 -0700 (PDT)
In-Reply-To: <12052069033338-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: mikpe@it.uu.se, Tejun Heo <htejun@gmail.com>

Now that hardreset is the preferred method of resetting, there's no
need for ATA_LFLAG_HRST_TO_RESUME flag.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c       |    2 +-
 drivers/ata/libata-pmp.c |   16 ----------------
 drivers/ata/sata_nv.c    |    5 -----
 drivers/ata/sata_sil.c   |    5 -----
 include/linux/libata.h   |    1 -
 5 files changed, 1 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 032b3f6..087efc6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -407,7 +407,7 @@ static const struct ata_port_info ahci_port_info[] = {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
-		.link_flags	= AHCI_LFLAG_COMMON | ATA_LFLAG_HRST_TO_RESUME,
+		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_vt8251_ops,
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 133246b..9d17158 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -453,9 +453,6 @@ static void sata_pmp_quirks(struct ata_port *ap)
 	if (vendor == 0x1095 && devid == 0x3726) {
 		/* sil3726 quirks */
 		ata_port_for_each_link(link, ap) {
-			/* SError.N need a kick in the ass to get working */
-			link->flags |= ATA_LFLAG_HRST_TO_RESUME;
-
 			/* class code report is unreliable */
 			if (link->pmp < 5)
 				link->flags |= ATA_LFLAG_ASSUME_ATA;
@@ -468,9 +465,6 @@ static void sata_pmp_quirks(struct ata_port *ap)
 	} else if (vendor == 0x1095 && devid == 0x4723) {
 		/* sil4723 quirks */
 		ata_port_for_each_link(link, ap) {
-			/* SError.N need a kick in the ass to get working */
-			link->flags |= ATA_LFLAG_HRST_TO_RESUME;
-
 			/* class code report is unreliable */
 			if (link->pmp < 2)
 				link->flags |= ATA_LFLAG_ASSUME_ATA;
@@ -483,9 +477,6 @@ static void sata_pmp_quirks(struct ata_port *ap)
 	} else if (vendor == 0x1095 && devid == 0x4726) {
 		/* sil4726 quirks */
 		ata_port_for_each_link(link, ap) {
-			/* SError.N need a kick in the ass to get working */
-			link->flags |= ATA_LFLAG_HRST_TO_RESUME;
-
 			/* Class code report is unreliable and SRST
 			 * times out under certain configurations.
 			 * Config device can be at port 0 or 5 and
@@ -513,13 +504,6 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |= ATA_LFLAG_NO_RETRY;
-	} else if (vendor == 0x11ab && devid == 0x4140) {
-		/* Marvell 88SM4140 quirks.  Fan-out ports require PHY
-		 * reset to work; other than that, it behaves very
-		 * nicely.
-		 */
-		ata_port_for_each_link(link, ap)
-			link->flags |= ATA_LFLAG_HRST_TO_RESUME;
 	}
 }
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index ce02e15..75b7653 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -579,7 +579,6 @@ static const struct ata_port_info nv_port_info[] = {
 	{
 		.sht		= &nv_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -590,7 +589,6 @@ static const struct ata_port_info nv_port_info[] = {
 	{
 		.sht		= &nv_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -601,7 +599,6 @@ static const struct ata_port_info nv_port_info[] = {
 	{
 		.sht		= &nv_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -613,7 +610,6 @@ static const struct ata_port_info nv_port_info[] = {
 		.sht		= &nv_adma_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NCQ,
-		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -625,7 +621,6 @@ static const struct ata_port_info nv_port_info[] = {
 		.sht		= &nv_swncq_sht,
 		.flags	        = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_NCQ,
-		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 0b8191b..7052915 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -60,7 +60,6 @@ enum {
 
 	SIL_DFL_PORT_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
-	SIL_DFL_LINK_FLAGS	= ATA_LFLAG_HRST_TO_RESUME,
 
 	/*
 	 * Controller IDs
@@ -215,7 +214,6 @@ static const struct ata_port_info sil_port_info[] = {
 	/* sil_3112 */
 	{
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE,
-		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,
@@ -225,7 +223,6 @@ static const struct ata_port_info sil_port_info[] = {
 	{
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE |
 				  SIL_FLAG_NO_SATA_IRQ,
-		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,
@@ -234,7 +231,6 @@ static const struct ata_port_info sil_port_info[] = {
 	/* sil_3512 */
 	{
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
-		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,
@@ -243,7 +239,6 @@ static const struct ata_port_info sil_port_info[] = {
 	/* sil_3114 */
 	{
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
-		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 25e6fb3..abb0fba 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -162,7 +162,6 @@ enum {
 	ATA_DEV_NONE		= 9,	/* no device */
 
 	/* struct ata_link flags */
-	ATA_LFLAG_HRST_TO_RESUME = (1 << 0), /* hardreset to resume link */
 	ATA_LFLAG_SKIP_D2H_BSY	= (1 << 1), /* can't wait for the first D2H
 					     * Register FIS clearing BSY */
 	ATA_LFLAG_NO_SRST	= (1 << 2), /* avoid softreset */
-- 
1.5.2.4

