From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/9] sata_sil: convert to new reset mechanism
Date: Fri, 10 Feb 2006 23:58:48 +0900
Message-ID: <11395835281210-git-send-email-htejun@gmail.com>
References: <11395835282719-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:28588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751275AbWBJO6z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 09:58:55 -0500
Received: by wproxy.gmail.com with SMTP id 36so564872wra
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 06:58:55 -0800 (PST)
In-Reply-To: <11395835282719-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert sata_sil to use new reset mechanism.  sata_sil is fairly
generic and can directly use std routine.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

0ae93718b02a7763abfacd0a900b51ba27c6212d
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index f40f25e..bd28877 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -158,7 +158,7 @@ static const struct ata_port_operations 
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
+	.probe_reset		= ata_std_probe_reset,
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
@@ -181,7 +181,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -190,8 +190,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  SIL_FLAG_MOD15WRITE,
+				  ATA_FLAG_MMIO | SIL_FLAG_MOD15WRITE,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -200,7 +199,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
-- 
1.1.5


