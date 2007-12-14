From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/9] libata: use init_gtm in ata_acpi_cbl_80wire()
Date: Fri, 14 Dec 2007 15:15:37 +0900
Message-ID: <11976129423891-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60416 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbXLNGPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544771wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:52 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_acpi_cbl_80wire() is called from cable detection where transfer
spped is forced to PIO0 after resetting.  On some controllers, this
results in incorrect result or ACPI evaluation failure.  Use cached
initial _GTM value.

This is partial fix for 2.6.24.  More extensive update to ACPI mode
filtering is queued for 2.6.25.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index e4ec391..5785cac 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -396,22 +396,22 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 
 int ata_acpi_cbl_80wire(struct ata_port *ap)
 {
-	struct ata_acpi_gtm gtm;
+	const struct ata_acpi_gtm *gtm;
 	int valid = 0;
 
-	/* No _GTM data, no information */
-	if (ata_acpi_gtm(ap, &gtm) < 0)
+	gtm = ata_acpi_init_gtm(ap);
+	if (!gtm)
 		return 0;
 
 	/* Split timing, DMA enabled */
-	if ((gtm.flags & 0x11) == 0x11 && gtm.drive[0].dma < 55)
+	if ((gtm->flags & 0x11) == 0x11 && gtm->drive[0].dma < 55)
 		valid |= 1;
-	if ((gtm.flags & 0x14) == 0x14 && gtm.drive[1].dma < 55)
+	if ((gtm->flags & 0x14) == 0x14 && gtm->drive[1].dma < 55)
 		valid |= 2;
 	/* Shared timing, DMA enabled */
-	if ((gtm.flags & 0x11) == 0x01 && gtm.drive[0].dma < 55)
+	if ((gtm->flags & 0x11) == 0x01 && gtm->drive[0].dma < 55)
 		valid |= 1;
-	if ((gtm.flags & 0x14) == 0x04 && gtm.drive[0].dma < 55)
+	if ((gtm->flags & 0x14) == 0x04 && gtm->drive[0].dma < 55)
 		valid |= 2;
 
 	/* Drive check */
-- 
1.5.2.4

