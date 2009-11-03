From: Mark Nelson <mdnelson8@gmail.com>
Subject: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum v2
Date: Tue, 3 Nov 2009 20:06:48 +1100
Message-ID: <65a6ef750911030106o2d6a6391o60fac0f2b75cbcc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:34567 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075AbZKCJGp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2009 04:06:45 -0500
Received: by ewy3 with SMTP id 3so1744677ewy.37
        for <linux-ide@vger.kernel.org>; Tue, 03 Nov 2009 01:06:48 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Like the Asus M2A-VM, MSI's K9A2 Platinum (MS-7376) can also support 64bit
DMA. It is a new enough board that all the BIOS releases work correctly with
64bit DMA enabled.

Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
---
 drivers/ata/ahci.c |   40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/ata/ahci.c
===================================================================
--- linux-2.6.orig/drivers/ata/ahci.c
+++ linux-2.6/drivers/ata/ahci.c
@@ -2726,6 +2726,30 @@ static bool ahci_sb600_enable_64bit(stru
 			},
 			.driver_data = "20071026",	/* yyyymmdd */
 		},
+		/*
+		 * All BIOS versions for the MSI K9A2 Platinum (MS-7376)
+		 * support 64bit DMA.
+		 *
+		 * BIOS versions earlier than 1.5 had the Manufacturer DMI
+		 * fields as "MICRO-STAR INTERANTIONAL CO.,LTD".
+		 * This spelling mistake was fixed in BIOS version 1.5, so
+		 * 1.5 and later have the Manufacturer as
+		 * "MICRO-STAR INTERNATIONAL CO.,LTD".
+		 * So try to match on DMI_BOARD_VENDOR of "MICRO-STAR INTER".
+		 *
+		 * BIOS versions earlier than 1.9 had a Board Product Name
+		 * DMI field of "MS-7376". This was changed to be
+		 * "K9A2 Platinum (MS-7376)" in version 1.9, but we can still
+		 * match on DMI_BOARD_NAME of "MS-7376".
+		 */
+		{
+			.ident = "MSI K9A2 Platinum",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "MICRO-STAR INTER"),
+				DMI_MATCH(DMI_BOARD_NAME, "MS-7376"),
+			},
+		},
 		{ }
 	};
 	const struct dmi_system_id *match;
@@ -2737,18 +2761,24 @@ static bool ahci_sb600_enable_64bit(stru
 	    !match)
 		return false;

+	if (!match->driver_data)
+		goto enable_64bit;
+
 	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
 	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);

-	if (strcmp(buf, match->driver_data) >= 0) {
-		dev_printk(KERN_WARNING, &pdev->dev, "%s: enabling 64bit DMA\n",
-			   match->ident);
-		return true;
-	} else {
+	if (strcmp(buf, match->driver_data) >= 0)
+		goto enable_64bit;
+	else {
 		dev_printk(KERN_WARNING, &pdev->dev, "%s: BIOS too old, "
 			   "forcing 32bit DMA, update BIOS\n", match->ident);
 		return false;
 	}
+
+enable_64bit:
+	dev_printk(KERN_WARNING, &pdev->dev, "%s: enabling 64bit DMA\n",
+		   match->ident);
+	return true;
 }

 static bool ahci_broken_system_poweroff(struct pci_dev *pdev)
