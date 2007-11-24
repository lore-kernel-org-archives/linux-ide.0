From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: separate controller IDs into separate enum
Date: Sat, 24 Nov 2007 21:16:07 +0900
Message-ID: <47481607.4040001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:57855 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbXKXMQO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Nov 2007 07:16:14 -0500
Received: by rv-out-0910.google.com with SMTP id k20so90201rvb
        for <linux-ide@vger.kernel.org>; Sat, 24 Nov 2007 04:16:13 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Separate controller IDs into a separate enum as Jeff requested.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 483269d..72a63b5 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -118,21 +118,6 @@ enum {
 	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
 
-	/* controller IDs */
-	piix_pata_mwdma		= 0,	/* PIIX3 MWDMA only */
-	piix_pata_33,			/* PIIX4 at 33Mhz */
-	ich_pata_33,			/* ICH up to UDMA 33 only */
-	ich_pata_66,			/* ICH up to 66 Mhz */
-	ich_pata_100,			/* ICH up to UDMA 100 */
-	ich5_sata,
-	ich6_sata,
-	ich6_sata_ahci,
-	ich6m_sata_ahci,
-	ich8_sata_ahci,
-	ich8_2port_sata,
-	ich8m_apple_sata_ahci,		/* locks up on second port enable */
-	tolapai_sata_ahci,
-
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
 	P1			= 1,  /* port 1 */
@@ -148,6 +133,23 @@ enum {
 	PIIX_HOST_BROKEN_SUSPEND = (1 << 24),
 };
 
+enum piix_controller_ids {
+	/* controller IDs */
+	piix_pata_mwdma,	/* PIIX3 MWDMA only */
+	piix_pata_33,		/* PIIX4 at 33Mhz */
+	ich_pata_33,		/* ICH up to UDMA 33 only */
+	ich_pata_66,		/* ICH up to 66 Mhz */
+	ich_pata_100,		/* ICH up to UDMA 100 */
+	ich5_sata,
+	ich6_sata,
+	ich6_sata_ahci,
+	ich6m_sata_ahci,
+	ich8_sata_ahci,
+	ich8_2port_sata,
+	ich8m_apple_sata_ahci,	/* locks up on second port enable */
+	tolapai_sata_ahci,
+};
+
 struct piix_map_db {
 	const u32 mask;
 	const u16 port_enable;
