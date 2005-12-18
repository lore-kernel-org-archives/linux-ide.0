From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/14] sata_sil: convert to new reset mechanism
Date: Sun, 18 Dec 2005 22:42:24 +0900
Message-ID: <20051218134224.GF31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:48502 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932708AbVLRNm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:42:29 -0500
Received: by zproxy.gmail.com with SMTP id 14so1715304nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:42:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Convert sata_sil to use new reset mechanism.  sata_sil is fairly
generic and can directly use all std routines.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/sata_sil.c
===================================================================
--- work.orig/drivers/scsi/sata_sil.c	2005-12-18 16:32:04.000000000 +0900
+++ work/drivers/scsi/sata_sil.c	2005-12-18 18:10:09.000000000 +0900
@@ -158,7 +158,9 @@ static const struct ata_port_operations 
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
+	.soft_reset		= ata_std_softreset_srst,
+	.hard_reset		= ata_std_hardreset_sata,
+	.post_reset		= ata_std_postreset,
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
@@ -181,7 +183,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -190,8 +192,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  SIL_FLAG_MOD15WRITE,
+				  ATA_FLAG_MMIO | SIL_FLAG_MOD15WRITE,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -200,7 +201,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
