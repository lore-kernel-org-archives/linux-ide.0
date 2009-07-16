From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/3] libata: Flag some SATA devices as non-hotpluggable
Date: Thu, 16 Jul 2009 20:58:09 +0100
Message-ID: <1247774290-4194-3-git-send-email-mjg@redhat.com>
References: <1247774290-4194-1-git-send-email-mjg@redhat.com>
 <1247774290-4194-2-git-send-email-mjg@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34057 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933145AbZGPT6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jul 2009 15:58:19 -0400
In-Reply-To: <1247774290-4194-2-git-send-email-mjg@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

SATA is generally hotpluggable, though some controllers don't expose
enough information to make it possible. Flag those controllers
appropriately.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/ata/ata_piix.c |    3 ++-
 drivers/ata/sata_sx4.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index d0a14cf..58340ea 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -110,7 +110,8 @@ enum {
 	PIIX_FLAG_SIDPR		= (1 << 29), /* SATA idx/data pair regs */
 
 	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
-	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
+	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_SATA_HOTPLUG |
+				  PIIX_FLAG_CHECKINTR,
 
 	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index bbcf970..8cb53b4 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -274,7 +274,8 @@ static const struct ata_port_info pdc_port_info[] = {
 	{
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING |
+				  ATA_FLAG_NO_SATA_HOTPLUG,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA6,
-- 
1.6.2.5

